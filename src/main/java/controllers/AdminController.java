package controllers;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.AdminDao;
import modelo.dao.CategoriaDao;
import modelo.dao.CompraDao;
import modelo.dao.ProductoDao;
import modelo.dao.TiendasDao;
import modelo.dto.Administrador;
import modelo.dto.Carrito;
import modelo.dto.Categoria;
import modelo.dto.Compra;
import modelo.dto.Producto;
import modelo.dto.Tiendas;

@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    private AdminDao admindao;
    private CategoriaDao catdao;
    TiendasDao tdao = new TiendasDao();
    List<Tiendas> listaTiendas = new ArrayList<>();
    CompraDao cdao = new CompraDao();
    ProductoDao pdao = new ProductoDao();

    @Override
    public void init() {
        admindao = new AdminDao();
        catdao = new CategoriaDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if ("list".equals(action)) {
            listarAdmin(request, response);
        } else if ("pedidos".equals(action)) {
            pedidos(request,response);
        } else if ("detail".equals(action)) {
            detalle(request,response);
        }else if ("dashboard".equals(action)) {
            dash(request,response);
        }else {
            response.sendRedirect("index");
        }
        System.out.println("action: " + action);
    }
    
    private void dash(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            List<Producto> listP=pdao.obtenerProductosMasVendidos();
            request.setAttribute("pvendidos", listP);
            request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
                    
        }catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
    }
    
    private void detalle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                List<Carrito> car = cdao.obtenerDetalleCompra(id);
                Compra com=cdao.obtenerCompraId(id);
            request.setAttribute("compra", com);
                request.setAttribute("deta", car);
                request.getRequestDispatcher("admin/detalle.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }else{
            response.sendRedirect("index");
        }
    }
    
    private void pedidos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            List<Compra> listaCompra=cdao.listarCompras();
            HttpSession misesion = request.getSession();
            misesion.setAttribute("pedidos", listaCompra);
            response.sendRedirect("admin/pedidos.jsp");
            
        }catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    private void listarAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Administrador> listaAdmin = new ArrayList<>();
        try {
            listaAdmin = admindao.listarAdmin();
            HttpSession misesion = request.getSession();
            misesion.setAttribute("listaAdmin", listaAdmin);
            response.sendRedirect("admin/administradores.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            login(request, response);
        } else if ("register".equals(action)) {
            register(request, response);
        } else if ("logout".equals(action)) {
            logout(request, response);
        }else if ("update".equals(action)) {
            actualizarestado(request, response);
        }
    }
    
    private void actualizarestado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String newest = request.getParameter("estado-pedido");
        try{
            boolean e=cdao.actualizarEstadoPedido(id, newest);
            if(e){
                response.sendRedirect("AdminController?action=pedidos");
            }else{
                System.out.println("fallo actualizar");
            }
        }catch (SQLException e) {
            System.out.println("error" + e);
            throw new ServletException("Error", e);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contraseña = request.getParameter("passw");

        try {
            Administrador admin = admindao.validarAdmin(email, contraseña);

            if (admin != null) {
                List<Categoria> categorias = catdao.getAllCategorias();

                // Si el admin es válido, crear o obtener la sesión y redirigir a index.jsp
                HttpSession session = request.getSession(true);  // No usar false aquí, ya que necesitamos una sesión
                session.setAttribute("administrador", admin);
                session.setAttribute("cat", categorias);
                response.sendRedirect("AdminController?action=dashboard");
            } else {
                // Si los datos son incorrectos, mostrar mensaje de error y redirigir a login.jsp
                request.setAttribute("error", "Aministrador o contraseña incorrectos");
                request.getRequestDispatcher("admin-login.jsp").forward(request, response);  // Mantén la solicitud actual
            }
        } catch (SQLException e) {
            System.out.println("error" + e);
            throw new ServletException("Error", e);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombres = request.getParameter("name");
        String apellidos = request.getParameter("lastname");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("passw");
        int dni = Integer.parseInt(request.getParameter("dni"));
        int telefono = Integer.parseInt(request.getParameter("tel"));
        System.out.println("nombre antes del dao: " + nombres);
        Administrador newadmin = new Administrador();
        newadmin.setNombres(nombres);
        newadmin.setApellidos(apellidos);
        newadmin.setEmail(email);
        newadmin.setContraseña(contraseña);
        newadmin.setDni(dni);
        newadmin.setTelefono(telefono);

        try {
            boolean resultado = admindao.registroAdmin(newadmin);
            System.out.println(newadmin.getApellidos() + "+" + newadmin.getContraseña());
            if (resultado) {
                response.sendRedirect("admin/administradores.jsp");
            } else {
                request.setAttribute("error", "No se puedo registrar el administrador");
                request.getRequestDispatcher("admin/administradores.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Error", e);
        }

    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("Intentado cerrar sesion...");
        if (session != null) {
            session.invalidate();
            System.out.println("Sesion cerrada");
        } else {
            System.out.println("no hay sesion");
        }
        response.sendRedirect("index");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
