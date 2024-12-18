package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.CategoriaDao;
import modelo.dto.Categoria;

@WebServlet(name = "CategoryController", urlPatterns = {"/CategoryController"})
public class CategoryController extends HttpServlet {

    private CategoriaDao catdao;

    @Override
    public void init() throws ServletException {
        catdao = new CategoriaDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                System.out.println("antes del get");
        List<Categoria> categorias = catdao.getAllCategorias();
        System.out.println("Categorías recuperadas: " + categorias.size());
        request.setAttribute("cat", categorias);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin/admin-nuevo-prod.jsp");
        dispatcher.forward(request, response);
    
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("nombre antes del post: "+ request.getParameter("categoria-nombre"));
                HttpSession session = request.getSession();
        
        // Crear una nueva categoría
        Categoria categoria = new Categoria();
        categoria.setCategoria(request.getParameter("categoria-nombre"));
        categoria.setObjetivo(request.getParameter("categoria-obj")); // Añadir lógica si hay un objetivo

        // Guardar la categoría en la base de datos
        try {
            catdao.agregarCategoria(categoria);
            if (session.getAttribute("cat") != null) {
            session.setAttribute("cat", catdao.getAllCategorias());
        }
            response.sendRedirect("admin/admin-nuevoprod.jsp"); // Redirigir a una página de éxito
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirigir a una página de error
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
