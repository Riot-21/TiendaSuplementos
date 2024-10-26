package controllers;

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
import modelo.dao.UsuarioDao;
import modelo.dto.Usuario;

@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

    private UsuarioDao userdao;

    @Override
    public void init() {
        userdao = new UsuarioDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> listaUsuarios = new ArrayList<>();
        try {
            listaUsuarios = userdao.listarUsuarios();
            HttpSession misesion = request.getSession();
            misesion.setAttribute("listaUsuarios", listaUsuarios);
            response.sendRedirect("admin-usuarios.jsp");
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
        } else if ("list".equals(action)) {
            listarUsuarios(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contraseña = request.getParameter("pass");

        try {
            Usuario user = userdao.validarUsuario(email, contraseña);

            if (user != null) {
                // Si el usuario es válido, crear o obtener la sesión y redirigir a index.jsp
                HttpSession session = request.getSession(true);  // No usar false aquí, ya que necesitamos una sesión
                session.setAttribute("usuario", user);
                response.sendRedirect("index.jsp");
            } else {
                // Si los datos son incorrectos, mostrar mensaje de error y redirigir a login.jsp

                request.setAttribute("error", "Usuario o contraseña incorrectos");
                request.getRequestDispatcher("login.jsp").forward(request, response);  // Mantén la solicitud actual
            }
        } catch (SQLException e) {
            System.out.println("error" + e);
            throw new ServletException("Error", e);
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("pass");
        int dni = Integer.parseInt(request.getParameter("dni"));
        int telefono = Integer.parseInt(request.getParameter("telefono"));
        System.out.println("nombre antes del dao: "+nombres);
        Usuario newuser = new Usuario();
        newuser.setNombres(nombres);
        newuser.setApellidos(apellidos);
        newuser.setEmail(email);
        newuser.setContraseña(contraseña);
        newuser.setDni(dni);
        newuser.setTelefono(telefono);
        System.out.println(newuser.getApellidos());

        try {
            boolean resultado = userdao.registroUsuario(newuser);
            System.out.println(newuser.getApellidos() + "+" + newuser.getContraseña());
            if (resultado) {
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "No se puedo registrar el usuario");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
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
        response.sendRedirect("index.jsp");

    }

    private void listarUsuarios(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Usuario> usuarios = userdao.listarUsuarios();
            request.setAttribute("listaUsuarios", usuarios);
            request.getRequestDispatcher("admin/listarUsuarios.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Error", e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
