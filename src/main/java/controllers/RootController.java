/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import modelo.dao.ProductoDao;
import modelo.dto.Producto;

@WebServlet(name = "RootController", urlPatterns = {"/index"})
public class RootController extends HttpServlet {
    private ProductoDao producdao;
        @Override
    public void init() {
        producdao = new ProductoDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    try {
        // Obtener productos más vendidos
        List<Producto> productosMasVendidos = producdao.obtenerProductosMasVendidos();
        // Si faltan productos, llenar con aleatorios
        if (productosMasVendidos.size() < 3) {
            productosMasVendidos.addAll(producdao.obtenerProductosAleatorios());
        }
        request.setAttribute("proddest", productosMasVendidos);

        // Obtener productos con menor precio
        List<Producto> productosMenorPrecio = producdao.obtenerProductosConMenorPrecio();
        // Si faltan productos, llenar con aleatorios
        if (productosMenorPrecio.size() < 3) {
            productosMenorPrecio.addAll(producdao.obtenerProductosAleatorios());
        }
        request.setAttribute("ofert", productosMenorPrecio);

        // Redirigir a la vista
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar los productos.");
    }
        
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
