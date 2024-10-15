package controllers;

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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Crear un nuevo producto
        Producto producto = new Producto();
        producto.setNombre(request.getParameter("product-name"));
        producto.setDescripcion(request.getParameter("product-description"));
        producto.setStock(Integer.parseInt(request.getParameter("product-stock")));
        producto.setMarca(request.getParameter("product-brand"));
        producto.setPreciounit(Double.parseDouble(request.getParameter("product-price")));
        producto.setMod_empleo(request.getParameter("product-modeUse"));
        producto.setAdvert(request.getParameter("product-warning"));

        // Obtener la categoría seleccionada
        String categoriaNombre = request.getParameter("product-cat");
        Categoria categoria = null;

        try {
            categoria = catdao.obtenerCategoriaPorNombre(categoriaNombre); // Método que debes implementar en CategoriaDao
            if (categoria == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Categoría no encontrada.");
                return; // Salir si no se encuentra la categoría
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener la categoría.");
            return;
        }
        
        producto.setCategorias(Collections.singletonList(categoria)); // Añade la categoría a la lista de categorías

        // Manejar la subida de imágenes
        if (ServletFileUpload.isMultipartContent(request)) {
            List<ImgProd> imagenes = new ArrayList<>();

            // Crear una fábrica de elementos de archivo
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            try {
                // Parsear el request para obtener los elementos de archivo
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (!item.isFormField() && "photos".equals(item.getFieldName())) {
                        // Lógica para almacenar la imagen
                        String imagenPath = "img/" + item.getName(); // Definir la ruta de almacenamiento
                        File uploadedFile = new File(imagenPath);
                        item.write(uploadedFile); // Guardar el archivo

                        ImgProd imgProd = new ImgProd();
                        imgProd.setImagen(imagenPath);
                        imagenes.add(imgProd);
                    }
                }

                // Asignar las imágenes al producto
                producto.setImagenes(imagenes);

                // Guardar el producto en la base de datos
                producdao.agregarProducto(producto);
                response.sendRedirect("nosotros.jsp"); // Redirigir a una página de éxito

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al guardar el producto.");
            } catch (FileUploadException ex) {
                ex.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la subida de archivos.");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error inesperado.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Solicitud no válida, se esperaba un archivo.");
        }
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

        }
    
