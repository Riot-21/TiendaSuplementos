package controllers;

import modelo.dao.*;
import modelo.dto.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet{
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            Usuario user=new Usuario();
            UsuarioDao userdao=new UsuarioDao();
            int rspta=0;
            if(request.getParameter("btn-login")!=null){
            String usuario=request.getParameter("txtusuario");
            String clave=request.getParameter("txtclave");
            user.setNombreUsuario(usuario);
            user.setContraseña(clave);
                try {
                    rspta=userdao.validarLogin(user);
                } catch (Exception ex) {
                    Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
                }
              if(rspta!=0){
                  response.sendRedirect("/TiendaSuplementos/index.jsp");
              }else{
                  response.sendRedirect("/TiendaSuplementos/index.jsp?rspta="+rspta);
              } 
            }
        }
    }
    
}
