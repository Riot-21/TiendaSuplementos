package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.Authenticator;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
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
import javax.mail.*;
import javax.mail.internet.*;

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        List<Usuario> listaUsuarios = new ArrayList<>();
        try {
            listaUsuarios = userdao.listarUsuarios();
            HttpSession misesion = request.getSession();
            misesion.setAttribute("listaUsuarios", listaUsuarios);
            response.sendRedirect("admin/admin-usuarios.jsp");
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
        } else if ("sendRecoveryCode".equals(action)) {
            forgotPassword(request, response);
        } else if ("verifyCode".equals(action)) {
            verificarCodigo(request, response);
        }else if ("changePass".equals(action)) {
            cambiarPsw(request, response);
        }
    }
    
    private void cambiarPsw(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            String nuevaContraseña = request.getParameter("nuevaContrasena");
    String confirmarContraseña = request.getParameter("confirmarContrasena");
    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));  // El ID del usuario viene como parámetro
    
    // Verificar que las contraseñas coincidan
    if (!nuevaContraseña.equals(confirmarContraseña)) {
        request.setAttribute("error", "Las contraseñas no coinciden.");
        request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
        return;
    }
    
    try {
        // Actualizar la contraseña en la base de datos
        boolean exito = userdao.actualizarContraseña(idUsuario, nuevaContraseña);
        
        if (exito) {
            // Si la actualización fue exitosa
            request.setAttribute("mensaje", "Tu contraseña ha sido actualizada exitosamente.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Si ocurrió un error o el usuario no existe
            request.setAttribute("error", "No se pudo actualizar la contraseña. Intenta nuevamente.");
            request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        System.out.println("Error al cambiar la contraseña: " + e);
        request.setAttribute("error", "Hubo un error al actualizar la contraseña. Intenta nuevamente.");
        request.getRequestDispatcher("cambiar_contrasena.jsp").forward(request, response);
    }
    }
    
    private void verificarCodigo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String codigoIngresado = request.getParameter("codigo");
    int idUsuario = Integer.parseInt(request.getParameter("idUsuario")); // Supón que el idUsuario es enviado junto al formulario

    try {
        String codigoAlmacenado = userdao.obtenerCodigoVerificacion(idUsuario);

        if (codigoIngresado.equals(codigoAlmacenado)) {
            // Verificar si el código ha expirado
            boolean haExpirado = userdao.verificarExpiracionCodigo(idUsuario);
            if (haExpirado) {
                request.setAttribute("error", "El código ha expirado. Solicita uno nuevo.");
                request.getRequestDispatcher("recuperar_contraseña.jsp").forward(request, response);
            } else {
                // Código correcto, permitir que el usuario cambie la contraseña
                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "El código ingresado es incorrecto.");
            request.getRequestDispatcher("verificar-codigo.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        throw new ServletException("Error al verificar el código", e);
    }
    }

    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            // Verificar si el email existe en la base de datos
            Usuario user = userdao.validarUsuarioEmail(email);

            if (user != null) {
                // Si el usuario existe, generar el código temporal
                String codigoVerificacion = generarCodigoVerificacion();

                // Guardar el código temporal en la base de datos (asegurarse de que tenga fecha de caducidad)
                userdao.guardarCodigoTemporal(user.getIdUsuario(), codigoVerificacion);

                try {
                    // Enviar el código al correo electrónico del usuario
                    enviarCodigoEmail(email, codigoVerificacion);
                } catch (MessagingException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }

                // Redirigir al formulario para ingresar el código de verificación
                request.setAttribute("mensaje", "Se ha enviado un código de verificación a tu correo.");
                request.getRequestDispatcher("verificar-codigo.jsp").forward(request, response);
            } else {
                // Si el usuario no existe, mostrar mensaje de error
                request.setAttribute("error", "El correo electrónico no está registrado.");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("Error en la base de datos: " + e);
            throw new ServletException("Error al recuperar la contraseña", e);
        }
    }
    // Método para generar un código de verificación aleatorio

    private String generarCodigoVerificacion() {
        Random rand = new Random();
        int codigo = rand.nextInt(999999);
        return String.format("%06d", codigo);  // Código de 6 dígitos
    }

//         Método para enviar el código de verificación al correo electrónico del usuario
    private void enviarCodigoEmail(String destinatario, String codigo) throws MessagingException {
        String de = "nutripoint41@gmail.com";  // Correo desde el cual se enviará
        String pass = "bzts hrgi pfdv tjao";        // Contraseña de la cuenta de correo

        Properties propiedades = new Properties();
        propiedades.put("mail.smtp.host", "smtp.gmail.com"); // Servidor SMTP
        propiedades.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        propiedades.put("mail.smtp.port", "587");              // Puerto SMTP
        propiedades.put("mail.smtp.auth", "true");
        propiedades.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(propiedades, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(de, pass);
            }
        });

        Message mensaje = new MimeMessage(session);
        mensaje.setFrom(new InternetAddress(de));
        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
        mensaje.setSubject("Código de Verificación para Recuperación de Contraseña");
        mensaje.setText("Tu código de verificación es: " + codigo);

        Transport.send(mensaje);
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
                response.sendRedirect("index");
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
        System.out.println("nombre antes del dao: " + nombres);
        Usuario newuser = new Usuario();
        newuser.setNombres(nombres);
        newuser.setApellidos(apellidos);
        newuser.setEmail(email);
        newuser.setContraseña(contraseña);
        newuser.setDni(dni);
        newuser.setTelefono(telefono);
        System.out.println(newuser.getApellidos());

        try {
            //Verificar si hay email o DNI duplicados
            if (userdao.existeUsuario(email, dni)) {
                request.setAttribute("error", "El email o DNI ya están registrados");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
                return;
            }

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
        response.sendRedirect("index");

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
