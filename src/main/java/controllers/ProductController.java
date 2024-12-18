package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.File;
import java.io.IOException;
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
import modelo.dao.CategoriaDao;
import modelo.dao.ProductoDao;
import modelo.dto.Categoria;
import modelo.dto.ImgProd;
import modelo.dto.Producto;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import modelo.dto.Carrito;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.ss.usermodel.ClientAnchor.AnchorType;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
@MultipartConfig
public class ProductController extends HttpServlet {

    private ProductoDao producdao;
    private CategoriaDao catdao;
    Producto p = new Producto();
    List<Producto> prod = new ArrayList<>();

    List<Carrito> listaCarrito = new ArrayList<>();
    int item;
    int cantidad = 0;

    @Override
    public void init() {
        producdao = new ProductoDao();
        catdao = new CategoriaDao();
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
        } else if ("editar".equals(action)) {
            editar(request, response);
        } else if ("exportarExcel".equals(action)) {
            exportarExcel(request, response);
        } else if ("tienda".equals(action)) {
            ProdTienda(request, response);
        } else if ("sortBy".equals(action)) {
            filterProductos(request, response);
        } else if ("search".equals(action)) {
            buscarprod(request, response);
        }
        System.out.println("Action: " + action);
    }

    private void buscarprod(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("busqueda");
        try {
            List<Producto> prodbusc = producdao.buscarProductosPorNombre(nombre);
            List<Categoria> categorias = catdao.getAllCategorias();
            request.setAttribute("categorias", categorias);
            if (nombre.isEmpty() || nombre.isEmpty()) {
                request.getRequestDispatcher("ProductController?action=tienda").forward(request, response);
            } else {
                if (prodbusc != null && !prodbusc.isEmpty()) {
                    request.setAttribute("busq", prodbusc);
                    request.getRequestDispatcher("productos.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", "No se encontraron productos con ese término.");
                    request.getRequestDispatcher("productos.jsp").forward(request, response);
                }
            }

        } catch (SQLException e) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void filterProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] categoriasParam = request.getParameterValues("categorias");
        String precio = request.getParameter("precio");
        String orden = request.getParameter("orden");
        // Imprimir el valor recibido para depuración
        System.out.println("Orden recibido: " + orden);

        // Mantener los valores existentes de filtros en caso ya estén aplicados
        List<Integer> categorias = new ArrayList<>();
        if (categoriasParam != null) {
            for (String catId : categoriasParam) {
                categorias.add(Integer.valueOf(catId));
            }
        }

        try {
            // Obtener productos con los filtros acumulados
            List<Producto> productos = producdao.obtenerProductosPorFiltros(categorias, precio, orden);

            // Enviar productos filtrados a la vista
            request.setAttribute("tienda", productos);

            // Mantener categorías seleccionadas
            List<Categoria> categoriasList = catdao.getAllCategorias();
            request.setAttribute("categorias", categoriasList);
            request.setAttribute("categoriasSeleccionadas", categorias);

            // Mantener el precio y orden seleccionados
            request.setAttribute("precioSeleccionado", precio);
            request.setAttribute("ordenSeleccionado", orden);

            // Redirigir a la vista con los filtros aplicados
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException ex) {
            ex.printStackTrace();
            // Manejar error si ocurre un fallo en la consulta
        }
    }

    private void ProdTienda(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Categoria> categorias = catdao.getAllCategorias();
            List<Producto> productos = producdao.ProductosTienda();
            request.setAttribute("categorias", categorias);
            request.setAttribute("tienda", productos);
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            request.setAttribute("error", "Error al cargar los productos: " + ex.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
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
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    private void editar(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String idParam = request.getParameter("id");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);
            Producto producto = producdao.obtenerProductoPorId(id);
            if (producto != null) {
                // Usamos el Gson con el TypeAdapter registrado
                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())  // Registramos el adaptador
                        .create();

                // Convertimos el producto a JSON
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.write(gson.toJson(producto));  // Esto ahora serializa LocalDate correctamente
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


    private void cargarPorId(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        int cant = 0;
        int pos = -1;
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Producto producto = producdao.obtenerProductoPorId(id);
                if (!listaCarrito.isEmpty()) {
                    for (int i = 0; i < listaCarrito.size(); i++) {
                        if (id == listaCarrito.get(i).getIdProducto()) {
                            pos = i;
                            break; // Si encontramos el producto, salimos del ciclo
                        }
                    }
                    if (pos != -1) {
                        cant = listaCarrito.get(pos).getCantidad();
                    } else {
                        cant = 0;
                    }
                }

                if (producto != null) {
                    List<Producto> prods = producdao.obtenerProductosAleatorios();
                    prods.removeIf(p -> p.getIdProducto() == producto.getIdProducto());
                    request.setAttribute("cant", cant);
                    request.setAttribute("prodal", prods);
                    request.setAttribute("producto", producto); // Agregar producto al request
                    RequestDispatcher dispatcher = request.getRequestDispatcher("producto-especifico.jsp");
                    dispatcher.forward(request, response);
                } else {
                    // Manejar caso de producto no encontrado
                    response.sendRedirect("index");
                }
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp?mensaje=Error al obtener el producto");
            }
        } else {
            response.sendRedirect("error.jsp?mensaje=ID de producto no proporcionado");
        }
    }
    
    private void exportarExcel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        LocalDate fecha= LocalDate.now();
    try {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Lista de Productos");

        // Estilos para el título y los encabezados
        CellStyle titleStyle = workbook.createCellStyle();
        Font titleFont = workbook.createFont();
        titleFont.setBold(true);
        titleFont.setFontHeightInPoints((short) 16);
        titleStyle.setFont(titleFont);
        titleStyle.setAlignment(HorizontalAlignment.CENTER);
        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setFontHeightInPoints((short) 12);
        headerStyle.setFont(headerFont);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);

        // Título de la hoja y logo
        Row titleRow = sheet.createRow(0);
        Cell titleCell = titleRow.createCell(1);
        titleCell.setCellValue("Lista de Productos - Nutripooint - "+fecha);
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 7)); // Ajustar el rango según el número de columnas

        // Agregar el logo centrado
        String relativePath = "/img/4.png";
        try (InputStream logoStream = new FileInputStream(getServletContext().getRealPath(relativePath))) {
            BufferedImage logo = ImageIO.read(logoStream);
            ByteArrayOutputStream logoBytes = new ByteArrayOutputStream();
            ImageIO.write(logo, "png", logoBytes);
            int logoIndex = workbook.addPicture(logoBytes.toByteArray(), Workbook.PICTURE_TYPE_PNG);
            Drawing<?> drawing = sheet.createDrawingPatriarch();
            ClientAnchor anchor = new XSSFClientAnchor();
            anchor.setCol1(0);
            anchor.setRow1(1);
            anchor.setCol2(2);  // Ajustar el ancho de la celda de la imagen
            anchor.setRow2(3);  // Ajustar la altura de la celda de la imagen
            anchor.setAnchorType(AnchorType.DONT_MOVE_AND_RESIZE);
            Picture logoPicture = drawing.createPicture(anchor, logoIndex);
            logoPicture.resize(1.15, 1.15); // Ajustar tamaño según sea necesario
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Encabezados de las columnas
        String[] headers = {"ID", "Nombre", "Descripción", "Stock", "Marca", "Precio", "Modo Empleo", "Advertencia"};
        Row headerRow = sheet.createRow(4);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        // Obtener productos de la base de datos
        List<Producto> productos = producdao.obtenerTodosLosProductos();
        int rowNum = 5;  // Fila de inicio para los datos

        for (Producto producto : productos) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(producto.getIdProducto());
            row.createCell(1).setCellValue(producto.getNombre());
            row.createCell(2).setCellValue(producto.getDescripcion());
            row.createCell(3).setCellValue(producto.getStock());
            row.createCell(4).setCellValue(producto.getMarca());
            row.createCell(5).setCellValue(producto.getPreciounit());
            row.createCell(6).setCellValue(producto.getMod_empleo());
            row.createCell(7).setCellValue(producto.getAdvert());
        }

        // Ajustar el tamaño de las columnas
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Configurar respuesta HTTP
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ListaProductos.xlsx");

        // Escribir el archivo y cerrarlo
        try (OutputStream out = response.getOutputStream()) {
            workbook.write(out);
        } finally {
            workbook.close();
        }
    } catch (SQLException ex) {
        Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
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
        } else if ("addToCart".equals(action)) {
            agregarCarrito(request, response);
        } else if ("deleteFromCart".equals(action)) {
            eliminarDeCarrito(request, response);
        } else if ("update".equals(action)) {
            doPut(request, response);
        } else {
            response.sendRedirect("index");
        }
        System.out.println("Action: " + action);
    }

    private void eliminarDeCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idp = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        double total = 0.0;

        // Buscar el producto en la lista del carrito y eliminarlo
        for (int i = 0; i < listaCarrito.size(); i++) {
            if (listaCarrito.get(i).getIdProducto() == idp) {
                listaCarrito.remove(i);
                break;
            }
        }

        // Recalcular el total después de eliminar el producto
        for (Carrito car : listaCarrito) {
            total += car.getSubtotal();
        }

        // Actualizar los atributos de sesión
        session.setAttribute("total", total);
        session.setAttribute("contador", listaCarrito.size());
        session.setAttribute("carrito", listaCarrito);

        // Redirigir al carrito o página correspondiente
        response.sendRedirect(request.getHeader("Referer"));
    }

    private void agregarCarrito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idp = Integer.parseInt(request.getParameter("id"));
        cantidad = Integer.parseInt(request.getParameter("cantidad"));
        double total;

        HttpSession session = request.getSession();
//        if (session.getAttribute("total") != null) {
//            total = (double) session.getAttribute("total"); // Recupera el total acumulado
//        }
        try {
            int pos = -1; // Inicializamos pos a -1 para indicar que el producto no se encuentra
            p = producdao.obtenerProductoPorId(idp);

            if (!listaCarrito.isEmpty()) {
                for (int i = 0; i < listaCarrito.size(); i++) {
                    if (idp == listaCarrito.get(i).getIdProducto()) {
                        pos = i;
                        break; // Si encontramos el producto, salimos del ciclo
                    }
                }
            }

            if (pos != -1) {
                // El producto ya está en el carrito, actualizamos la cantidad y el subtotal
                cantidad = listaCarrito.get(pos).getCantidad() + cantidad;
                double subtotal;
                if (cantidad > p.getStock()) {
                    listaCarrito.get(pos).setCantidad(p.getStock());
                } else {
                    listaCarrito.get(pos).setCantidad(cantidad);
                }
                subtotal = listaCarrito.get(pos).getPrecio() * listaCarrito.get(pos).getCantidad();
                listaCarrito.get(pos).setSubtotal(subtotal);
                // Ahora actualizamos el total: restamos el subtotal antiguo y sumamos el nuevo
                total = 0.0; // Reset total
                for (Carrito car : listaCarrito) {
                    total += car.getSubtotal(); // Suma el subtotal de cada producto
                }

            } else {
                // Producto no está en el carrito, agregamos un nuevo producto
                item = item + 1;
                Carrito car = new Carrito();
                car.setItem(item);
                car.setIdProducto(p.getIdProducto());
                car.setNombres(p.getNombre());
                car.setDescripcion(p.getDescripcion());
                car.setImagen(p.getImagen());
                car.setPrecio(p.getPreciounit());
                car.setStock(p.getStock());
                car.setCantidad(cantidad);
                car.setSubtotal(cantidad * p.getPreciounit());
//                total = total + car.getSubtotal();
                listaCarrito.add(car);

                // Actualizamos el total al agregar un nuevo producto
                total = 0.0;
                // Reset total
                for (Carrito carItem : listaCarrito) {
                    total += carItem.getSubtotal();// Suma el subtotal de cada producto
                }
            }

            // Actualizamos la sesión
            session.setAttribute("total", total);
            session.setAttribute("contador", listaCarrito.size());
            session.setAttribute("carrito", listaCarrito);
            response.sendRedirect("ProductController?action=cargarid&id=" + idp);

        } catch (SQLException ex) {
            Logger.getLogger(ProductController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        
        // Manejar la fecha de vencimiento
        String fechaStr = request.getParameter("fechaVencimiento");
        LocalDate fecha = null;
        if (fechaStr != null && !fechaStr.isEmpty()) {
            try {
                fecha = LocalDate.parse(fechaStr, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            } catch (DateTimeParseException e) {
                e.printStackTrace();
                request.setAttribute("error", "Formato de fecha inválido.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
                return; // Detener el flujo si la fecha es inválida
            }
        }

        // Crear un objeto Producto
        Producto producto = new Producto();
        producto.setNombre(nombreProducto);
        producto.setDescripcion(descripcionProducto);
        producto.setStock(stockProducto);
        producto.setMarca(marcaProducto);
        producto.setPreciounit(precioProducto);
        producto.setMod_empleo(modoUsoProducto);
        producto.setAdvert(advertenciaProducto);
        producto.setFechav(fecha);

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
                        // Obtener la ruta real de la carpeta img en el servidor
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

            response.sendRedirect("admin/dashboard.jsp"); // Redirigir tras éxito

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Leer los parámetros enviados en la solicitud
            int idProducto = Integer.parseInt(request.getParameter("id-producto"));
            String nombre = request.getParameter("nombre-producto");
            String descripcion = request.getParameter("descripcion-producto");
            int stock = Integer.parseInt(request.getParameter("stock-producto"));
            String marca = request.getParameter("marca-producto");
            double preciounit = Double.parseDouble(request.getParameter("precio-producto"));
            String modEmpleo = request.getParameter("empleo-producto");
            String advert = request.getParameter("advertencia-producto");

            Producto p = new Producto();
            p.setIdProducto(idProducto);
            p.setNombre(nombre);
            p.setDescripcion(descripcion);
            p.setStock(stock);
            p.setMarca(marca);
            p.setPreciounit(preciounit);
            p.setMod_empleo(modEmpleo);
            p.setAdvert(advert);

            boolean actualizado = producdao.actualizarProducto(p);

            // Responder según el resultado
            if (actualizado) {
                out.write("{\"message\": \"Producto actualizado exitosamente.\"}");
                response.sendRedirect("ProductController?action=cargartodo");
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"message\": \"No se pudo actualizar el producto.\"}");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
