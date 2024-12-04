package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.AdminDao;
import modelo.dao.ProductoDao;
import modelo.dao.TiendasDao;
import modelo.dao.UsuarioDao;

@WebServlet(name = "SvEliminar", urlPatterns = {"/SvEliminar"})
public class SvEliminar extends HttpServlet {

    private UsuarioDao userdao;
    private ProductoDao proddao;
    private AdminDao admindao;
    private TiendasDao tdao;

    @Override
    public void init() {
        userdao = new UsuarioDao();
        proddao = new ProductoDao();
        admindao = new AdminDao();
        tdao = new TiendasDao();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("user".equals(action)) {
            deleteUser(request, response);
        } else if ("product".equals(action)) {
            deleteProd(request, response);
        } else if ("admin".equals(action)) {
            deleteAdmin(request, response);
        } else if ("shop".equals(action)) {
            deleteShop(request, response);
        } else {
            response.sendRedirect("index");
        }

    }

    private void deleteShop(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("idShop"));
        try {
            tdao.eliminarTienda(id);
                response.sendRedirect("shop?action=admin");
        } catch (SQLException ex) {
            Logger.getLogger(SvEliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("idAdmin"));
        try {
            boolean elm = admindao.eliminarAdmin(id);
            if (elm) {
                response.sendRedirect("AdminController?action=list");
            } else {
                response.sendRedirect("index");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SvEliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteProd(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("idProd"));
        try {
            boolean elm = proddao.eliminarProducto(id);
            if (elm) {
                response.sendRedirect("ProductController?action=cargartodo");
            } else {
                response.sendRedirect("index");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SvEliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("idUsuario"));
        try {
            boolean elm = userdao.eliminarUsuario(id);
            if (elm) {
                response.sendRedirect("UserController?action=show");
            } else {
                response.sendRedirect("index");
            }
        } catch (SQLException ex) {
            Logger.getLogger(SvEliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
