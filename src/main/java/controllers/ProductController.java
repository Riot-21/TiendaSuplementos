package controllers;

import com.google.gson.Gson;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.dao.CategoriaDao;
import modelo.dao.ImagenProdDao;
import modelo.dao.ProductoDao;
import modelo.dto.Categoria;
import modelo.dto.ImgProd;
import modelo.dto.Producto;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
@MultipartConfig
public class ProductController extends HttpServlet {

    private ProductoDao producdao;
    private CategoriaDao catdao;
    private ImagenProdDao imgdao;

    @Override
    public void init() {
        producdao = new ProductoDao();
        catdao = new CategoriaDao();
        imgdao = new ImagenProdDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        // Procesar los campos no relacionados con archivos
        String action = request.getParameter("action");
        if ("cargartodo".equals(action)) {
            cargarProductos(request, response);
        } else if ("cargarid".equals(action)) {
            cargarPorId(request, response);
        }
        System.out.println("Action: " + action);
    }

    private void cargarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Cargando productos..."); // Para depuración
        try {
            List<Producto> productos = producdao.obtenerTodosLosProductos();
            request.setAttribute("productos", productos);
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin/admin-productos.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            request.setAttribute("error", "Error al cargar los productos: " + ex.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void cargarPorId(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idProducto = Integer.parseInt(request.getParameter("id"));
        response.setContentType("application/json"); // Asegura el formato JSON

        try {
            Producto producto = producdao.obtenerProductoPorId(idProducto);

            if (producto != null) {
                Gson gson = new Gson();
                String json = gson.toJson(producto);
                response.getWriter().write(json); // Escribe el JSON en la respuesta
                response.setStatus(HttpServletResponse.SC_OK); // Indica que la respuesta fue exitosa
            } else {
                response.getWriter().write("{}"); // Responde un JSON vacío si no se encuentra el producto
                response.setStatus(HttpServletResponse.SC_NOT_FOUND); // Código 404 si no se encuentra el producto
            }
        } catch (SQLException ex) {
            response.setContentType("application/json");
            response.getWriter().write("{\"error\":\"Error al cargar el producto: " + ex.getMessage() + "\"}");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Indica error en el servidor
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Procesar los campos no relacionados con archivos
        String action = request.getParameter("action");

        if ("guardar".equals(action)) {
            guardarProducto(request, response);
        } else {
            response.sendRedirect("index.jsp");
        }
        System.out.println("Action: " + action);
    }

    private void guardarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Procesar los parámetros del formulario
        String nombreProducto = request.getParameter("nombrep");
        String descripcionProducto = request.getParameter("descp");
        int stockProducto = Integer.parseInt(request.getParameter("stkp"));
        String marcaProducto = request.getParameter("marcap");
        double precioProducto = Double.parseDouble(request.getParameter("preciop"));
        String modoUsoProducto = request.getParameter("modp");
        String advertenciaProducto = request.getParameter("advp");
        //int categoriaProducto = Integer.parseInt(request.getParameter("catp"));

        // Crear un objeto Producto
        Producto producto = new Producto();
        producto.setNombre(nombreProducto);
        producto.setDescripcion(descripcionProducto);
        producto.setStock(stockProducto);
        producto.setMarca(marcaProducto);
        producto.setPreciounit(precioProducto);
        producto.setMod_empleo(modoUsoProducto);
        producto.setAdvert(advertenciaProducto);

        // Obtener las categorías seleccionadas como un arreglo de String
        String[] categoriasSeleccionadas = request.getParameterValues("catp[]");
        if (categoriasSeleccionadas != null) {
            // Crear una lista para almacenar las categorías seleccionadas
            List<Categoria> listaCategorias = new ArrayList<>();
            for (String categoriaId : categoriasSeleccionadas) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(Integer.parseInt(categoriaId));
                listaCategorias.add(categoria);
            }
            producto.setCategorias(listaCategorias); // Añadir la lista de categorías al producto
        }

        // Lista para almacenar imágenes
        List<ImgProd> imagenes = new ArrayList<>();

        // Manejar las imágenes subidas
        try {
            // Obtener múltiples partes del formulario
            for (Part part : request.getParts()) {
                if (part.getName().equals("photos")) {
                    // Verificar que haya contenido en el archivo
                    String fileName = part.getSubmittedFileName();
                    if (fileName != null && !fileName.isEmpty()) {
                        // Obtener la ruta real de la carpeta `img` en el servidor
                        //String uploadPath = "C:/Users/RIOT/Documents/NetBeansProjects/TiendaSuplementos/src/main/webapp/img";
                        String uploadPath = getServletContext().getRealPath("/img");

                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir(); // Crear la carpeta si no existe
                        }

                        // Ruta completa para guardar el archivo
                        String filePath = uploadPath + File.separator + fileName;
                        part.write(filePath); // Guardar archivo en el servidor
                        System.out.println("Archivo guardado en: " + filePath);

                        // Guardar la ruta relativa de la imagen en la base de datos
                        ImgProd imgProd = new ImgProd();
                        imgProd.setImagen("img/" + fileName); // Ruta relativa
                        imagenes.add(imgProd);
                    }
                }
            }

            // Asignar las imágenes al producto
            producto.setImagenes(imagenes);

            // Guardar el producto y las imágenes en la base de datos
            producdao.agregarProducto(producto);

            response.sendRedirect("admin/administrador.jsp"); // Redirigir tras éxito

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
