package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.BoletaPDF;
import modelo.dao.CompraDao;
import modelo.dao.EmpresaDao;
import modelo.dao.TiendasDao;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import modelo.dto.Empresa;
import modelo.dto.Tiendas;
import modelo.dto.Usuario;

@WebServlet(name = "PurchaseController", urlPatterns = {"/PurchaseController"})
public class PurchaseController extends HttpServlet {
    TiendasDao tdao= new TiendasDao();
    List<Tiendas> listaTiendas= new ArrayList<>();
    CompraDao cdao= new CompraDao();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action =request.getParameter("action");
        if ("history".equals(action)) {
            historialCompra(request, response);
        } else if("detail".equals(action)){
            DetalleCompra(request, response);
        }else{
            System.out.println("action: "+action);
        }
    }
    
    private void historialCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        try{  
            List<Compra> listaCompra=cdao.obtenerComprasPorUsuario(usuario.getIdUsuario());

            session.setAttribute("historial", listaCompra);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/history.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        }
    }
    private void DetalleCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCompra=Integer.parseInt(request.getParameter("id"));
        System.out.println("id compra: "+idCompra);
        try{
            Compra com=cdao.obtenerCompraId(idCompra);
            List<Carrito> detalle =cdao.obtenerDetalleCompra(idCompra);
            request.setAttribute("compra", com);
            System.out.println("compra: "+com.getTotal());
            request.setAttribute("detalle", detalle);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/detail.jsp");
            dispatcher.forward(request, response);
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if ("buy".equals(action)) {
            generarCompra(request, response);
        } else if("payment".equals(action)){
            metodoPago(request, response);
        }else{
            System.out.println("action: "+action);
        }
    }
    
    private void metodoPago(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String metodo = request.getParameter("metodo");
        if(metodo.equals("delivery")){
            session.setAttribute("metodo", metodo);
        }else if(metodo.equals("recojo")){
            try{
            listaTiendas=tdao.listarTiendas();
            session.setAttribute("tiendas", listaTiendas);
            }catch(Exception e){
                request.setAttribute("error", e);
            }
            session.setAttribute("metodo", metodo);
        }else{
            System.out.println("metodo no reconocido: "+metodo);
        }
        response.sendRedirect("users/payment.jsp");
    }
                private void generarCompra(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String metodo = (String) session.getAttribute("metodo");
        String direccion=null;
        String distrito=null;
        double envio=0;
        if(metodo.equals("delivery")){
            envio=10.00;
            direccion=request.getParameter("direccion");
            distrito=request.getParameter("distrito");
        }else if(metodo.equals("recojo")){
            try{
            Tiendas t =tdao.GetTiendaById(Integer.parseInt(request.getParameter("distrito")));
            direccion=t.getDireccion();
            distrito=t.getDistrito();
            }catch(Exception exc){
                System.out.println("error: "+exc);
            }
        }
        if(usuario == null){
            response.sendRedirect("login.jsp");
            return;
        }
        
        try{
            List<Carrito> listaCarrito = (List<Carrito>) session.getAttribute("carrito");
            double total = (double) session.getAttribute("total");
            
            Compra c = new Compra();
            c.setFecha(LocalDate.now());
            c.setTotal(total+envio);
            c.setTipopago(metodo);
            c.setDireccion(direccion);
            c.setDistrito(distrito);
            c.setIdUsuario(usuario.getIdUsuario());
            
            CompraDao compradao = new CompraDao();
            EmpresaDao empdao = new EmpresaDao();
            Empresa e= empdao.datosEmpresa();
            int codigo = compradao.generarCompra(c, listaCarrito);
            BoletaPDF pdf = new BoletaPDF();
            pdf.generarPDFBoleta(e,response,listaCarrito, usuario, c, codigo);
            System.out.println("id compra: "+c.getIdCompra());
            for(Carrito carrito : listaCarrito){
                compradao.actualizarStock(carrito.getIdProducto(), carrito.getCantidad());
            }
            
            listaCarrito.clear();
            request.removeAttribute("cant");
            session.removeAttribute("carrito");
            session.removeAttribute("total");
            session.removeAttribute("contador");
            response.sendRedirect("index");
            
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        }
}
    

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
