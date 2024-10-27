package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.AdminDao;
import modelo.dto.Administrador;

@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {
        private AdminDao admindao;

    @Override
    public void init() {
        admindao = new AdminDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
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
        } 
    }
    
        private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String contraseña = request.getParameter("passw");

        try {
            Administrador admin = admindao.validarAdmin(email, contraseña);

            if (admin != null) {
                // Si el admin es válido, crear o obtener la sesión y redirigir a index.jsp
                HttpSession session = request.getSession(true);  // No usar false aquí, ya que necesitamos una sesión
                session.setAttribute("administrador", admin);
                response.sendRedirect("admin/administrador.jsp");
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
        response.sendRedirect("index.jsp");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
