package controllers;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.dao.BoletaPDF;
import modelo.dao.CompraDao;
import modelo.dao.EmpresaDao;
import modelo.dao.TiendasDao;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import modelo.dto.Empresa;
import modelo.dto.Producto;
import modelo.dto.Tiendas;
import modelo.dto.Usuario;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "PurchaseController", urlPatterns = {"/PurchaseController"})
public class PurchaseController extends HttpServlet {
    TiendasDao tdao= new TiendasDao();
    List<Tiendas> listaTiendas= new ArrayList<>();
    CompraDao cdao= new CompraDao();
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action =request.getParameter("action");
        if ("history".equals(action)) {
            historialCompra(request, response);
        } else if("detail".equals(action)){
            DetalleCompra(request, response);
        }else if("exportxl".equals(action)){
            exportarExcel(request, response);
        }else{
            System.out.println("action: "+action);
        }
    }
        private void exportarExcel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
            LocalDate fecha= LocalDate.now();
    try {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Reporte de pedidos");

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
        titleCell.setCellValue("Reporte de Compras - Nutripooint - "+fecha);
        titleCell.setCellStyle(titleStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 5)); // Ajustar el rango según el número de columnas

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
            anchor.setAnchorType(ClientAnchor.AnchorType.DONT_MOVE_AND_RESIZE);
            Picture logoPicture = drawing.createPicture(anchor, logoIndex);
            logoPicture.resize(1.15, 1.15); // Ajustar tamaño según sea necesario
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Encabezados de las columnas
        String[] headers = {"ID", "Fecha", "Recojo/Envío", "Direccion", "Estado", "Id Usuario"};
        Row headerRow = sheet.createRow(4);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        // Obtener productos de la base de datos
        List<Compra> compra = cdao.listarCompras();
        int rowNum = 5;  // Fila de inicio para los datos

        for (Compra c : compra) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(c.getIdCompra());
            row.createCell(1).setCellValue(c.getFecha());
            row.createCell(2).setCellValue(c.getTipopago());
            row.createCell(3).setCellValue(c.getDireccion()+", "+c.getDistrito());
            row.createCell(4).setCellValue(c.getEstado());
            row.createCell(5).setCellValue(c.getIdUsuario());

        }

        // Ajustar el tamaño de las columnas
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Configurar respuesta HTTP
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=ReporteVentas.xlsx");

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
    
    private void historialCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        try{  
            List<Compra> listaCompra=cdao.obtenerComprasPorUsuario(usuario.getIdUsuario());

            session.setAttribute("historial", listaCompra);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/history.jsp");
            dispatcher.forward(request, response);
            
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        }
    }
    private void DetalleCompra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idCompra=Integer.parseInt(request.getParameter("id"));
        System.out.println("id compra: "+idCompra);
        try{
            Compra com=cdao.obtenerCompraId(idCompra);
            List<Carrito> detalle =cdao.obtenerDetalleCompra(idCompra);
            request.setAttribute("compra", com);
            System.out.println("compra: "+com.getTotal());
            request.setAttribute("detalle", detalle);
            RequestDispatcher dispatcher = request.getRequestDispatcher("users/detail.jsp");
            dispatcher.forward(request, response);
        }catch(Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Error al subir el archivo: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("productos.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        if ("buy".equals(action)) {
            generarCompra(request, response);
        } else if("payment".equals(action)){
            metodoPago(request, response);
        }else{
            System.out.println("action: "+action);
        }
    }
    
    private void metodoPago(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        String metodo = request.getParameter("metodo");
        if(metodo.equals("delivery")){
            session.setAttribute("metodo", metodo);
        }else if(metodo.equals("recojo")){
            try{
            listaTiendas=tdao.listarTiendas();
            session.setAttribute("tiendas", listaTiendas);
            }catch(Exception e){
                request.setAttribute("error", e);
            }
            session.setAttribute("metodo", metodo);
        }else{
            System.out.println("metodo no reconocido: "+metodo);
        }
        response.sendRedirect("users/payment.jsp");
    }
                private void generarCompra(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        String metodo = (String) session.getAttribute("metodo");
        String direccion=null;
        String distrito=null;
        double envio=0;
        if(metodo.equals("delivery")){
            envio=10.00;
            direccion=request.getParameter("direccion");
            distrito=request.getParameter("distrito");
        }else if(metodo.equals("recojo")){
            try{
            Tiendas t =tdao.GetTiendaById(Integer.parseInt(request.getParameter("distrito")));
            direccion=t.getDireccion();
            distrito=t.getDistrito();
            }catch(Exception exc){
                System.out.println("error: "+exc);
            }
        }
        if(usuario == null){
            response.sendRedirect("login.jsp");
            return;
        }
        
        try{
            List<Carrito> listaCarrito = (List<Carrito>) session.getAttribute("carrito");
            double total = (double) session.getAttribute("total");
            
            Compra c = new Compra();
            c.setFecha(LocalDate.now());
            c.setTotal(total+envio);
            c.setTipopago(metodo);
            c.setDireccion(direccion);
            c.setDistrito(distrito);
            c.setIdUsuario(usuario.getIdUsuario());
            
            CompraDao compradao = new CompraDao();
            EmpresaDao empdao = new EmpresaDao();
            Empresa e= empdao.datosEmpresa();
            int codigo = compradao.generarCompra(c, listaCarrito);
            BoletaPDF pdf = new BoletaPDF();
            pdf.generarPDFBoleta(e,response,listaCarrito, usuario, c, codigo,request);
            System.out.println("id compra: "+c.getIdCompra());
            for(Carrito carrito : listaCarrito){
                compradao.actualizarStock(carrito.getIdProducto(), carrito.getCantidad());
            }
            
            listaCarrito.clear();
            request.removeAttribute("cant");
            session.removeAttribute("carrito");
            session.removeAttribute("total");
            session.removeAttribute("contador");
            response.sendRedirect("index");
            
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
