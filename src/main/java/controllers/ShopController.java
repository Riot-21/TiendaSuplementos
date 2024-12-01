
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.TiendasDao;
import modelo.dto.Tiendas;

@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {
    TiendasDao tdao = new TiendasDao();
    
    @Override
        public void init() {
        tdao = new TiendasDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try{
            
            List<Tiendas>lista=tdao.listarTiendas();
            request.setAttribute("shop", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("tiendas.jsp");
        dispatcher.forward(request, response);
            System.out.println();
        }catch(Exception e){
            e.printStackTrace();
        }
//        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
