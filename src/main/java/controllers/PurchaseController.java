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
import modelo.dto.Carrito;
import modelo.dto.Compra;
import modelo.dto.Usuario;

@WebServlet(name = "PurchaseController", urlPatterns = {"/PurchaseController"})
public class PurchaseController extends HttpServlet {

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
        if ("buy".equals(action)) {
            generarCompra(request, response);
        } else{
            System.out.println("action: "+action);
        }
    }
                private void generarCompra(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        if(usuario == null){
            response.sendRedirect("login.jsp");
            return;
        }
        
        try{
            List<Carrito> listaCarrito = (List<Carrito>) session.getAttribute("carrito");
            double total = (double) session.getAttribute("total");
            
            Compra c = new Compra();
            c.setFecha(LocalDate.now());
            c.setTotal(total);
            c.setDireccion(request.getParameter("direccion"));
            c.setDistrito(request.getParameter("distrito"));
            c.setIdUsuario(usuario.getIdUsuario());
            
            CompraDao compradao = new CompraDao();
            compradao.generarCompra(c, listaCarrito);
            int codigo = compradao.generarCompra(c, listaCarrito);
            BoletaPDF pdf = new BoletaPDF();
            pdf.generarPDFBoleta(listaCarrito, usuario, c, codigo);
            System.out.println("id compra: "+c.getIdCompra());
            for(Carrito carrito : listaCarrito){
                compradao.actualizarStock(carrito.getIdProducto(), carrito.getCantidad());
            }
            
            
            session.removeAttribute("carrito");
            session.removeAttribute("total");
            session.removeAttribute("contador");
            
            response.sendRedirect("index.jsp");
            
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
