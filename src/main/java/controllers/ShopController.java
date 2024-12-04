package controllers;

import com.google.gson.Gson;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modelo.dao.TiendasDao;
import modelo.dto.Producto;
import modelo.dto.Tiendas;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
@MultipartConfig
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
        String action = request.getParameter("action");
        if ("all".equals(action)) {
            listarVistaUser(request, response);
        } else if ("admin".equals(action)) {
            list(request, response);
        } else if ("edit".equals(action)) {
            editar(request, response);
        }else if ("about".equals(action)) {
            listAbout(request, response);
        }

    }
    private void listAbout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                response.setContentType("text/html;charset=UTF-8");
        try {

            List<Tiendas> lista = tdao.listarTiendas();
            request.setAttribute("shop", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("nosotros.jsp");
            dispatcher.forward(request, response);
            System.out.println();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void editar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Tiendas t = tdao.GetTiendaById(id);
                if (t != null) {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();
                    out.write(new Gson().toJson(t));
                    out.flush();
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            List<Tiendas> lista = tdao.listarTiendas();
            request.setAttribute("tiendas", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/tiendas.jsp");
            dispatcher.forward(request, response);
            System.out.println();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listarVistaUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            List<Tiendas> lista = tdao.listarTiendas();
            request.setAttribute("shop", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("tiendas.jsp");
            dispatcher.forward(request, response);
            System.out.println();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            agregarTienda(request, response);
        } else if ("update".equals(action)) {
            actualizar(request, response);
        }
    }

    private void actualizar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener los parámetros del formulario
        int id = Integer.parseInt(request.getParameter("id-tienda"));
        String distrito = request.getParameter("distrito-tienda");
        String direccion = request.getParameter("direccion-tienda");
        int telefono = Integer.parseInt(request.getParameter("telefono-tienda"));
        String horario = request.getParameter("horario-tienda");

        // Crear un objeto Tienda con los nuevos valores
        Tiendas tienda = new Tiendas();
        tienda.setIdTienda(id);
        tienda.setDistrito(distrito);
        tienda.setDireccion(direccion);
        tienda.setTelefono(telefono);
        tienda.setHorario(horario);

        // Llamar al método DAO para actualizar la tienda
        TiendasDao tiendaDao = new TiendasDao();

        try {
            tiendaDao.actualizarTienda(tienda);
            // Redirigir a la lista de tiendas después de la actualización
            response.sendRedirect("shop?action=admin"); // Ajusta la URL según tu estructura
        } catch (SQLException e) {
            // En caso de error, redirigir a una página de error
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar la tienda: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void agregarTienda(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Procesar los parámetros del formulario
        String distritoTienda = request.getParameter("distrito-tienda");
        String direccionTienda = request.getParameter("direccion-tienda");
        int telefonoTienda = Integer.parseInt(request.getParameter("telefono-tienda"));
        String horarioTienda = request.getParameter("horario-tienda");

//    // Crear un objeto Tienda
        Tiendas tienda = new Tiendas();
        tienda.setDistrito(distritoTienda);
        tienda.setDireccion(direccionTienda);
        tienda.setTelefono(telefonoTienda);
        tienda.setHorario(horarioTienda);

        // Manejar la imagen subida
        try {
            // Obtener la imagen del formulario
            Part part = request.getPart("tienda-foto");
            String fileName = part.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {
                // Obtener la ruta real de la carpeta img en el servidor
                String uploadPath = getServletContext().getRealPath("/img");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir(); // Crear la carpeta si no existe
                }

                // Ruta completa para guardar el archivo
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath); // Guardar el archivo en el servidor
                System.out.println("Archivo guardado en: " + filePath);

                // Guardar la ruta relativa de la imagen en la base de datos
                tienda.setFoto("img/" + fileName); // Ruta relativa
            }

            // Guardar la tienda en la base de datos
            TiendasDao tiendaDao = new TiendasDao();
            tiendaDao.agregarTienda(tienda);

            // Redirigir al listado de tiendas tras la adición
            response.sendRedirect("shop?action=admin");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al subir la imagen: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
