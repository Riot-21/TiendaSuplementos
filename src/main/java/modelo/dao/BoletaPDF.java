package modelo.dao;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.awt.Desktop;
import java.io.File;
import java.io.FileOutputStream;
import java.net.http.HttpRequest;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import modelo.dto.Empresa;
import modelo.dto.Producto;
import modelo.dto.Usuario;

public class BoletaPDF {

    public void generarPDFBoleta(Empresa emp, HttpServletResponse response, List<Carrito> productos, Usuario cliente, Compra venta, int codigo, HttpServletRequest request) {

        try {
            // Configurar el contenido para la descarga
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=boleta_" + codigo + "_"+venta.getFecha()+".pdf");

            // Crear el documento
            Document documento = new Document();
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

// Obtener la ruta de la imagen desde el contexto del servlet
            String logoPath = request.getServletContext().getRealPath("/assets/img/Tienda.jpg");
            
            // Agregar logo de la empresa
            Image logo = Image.getInstance(logoPath);
            // Agregar logo de la empresa
//            Image logo = Image.getInstance("C:\\Users\\uset\\Documents\\NetBeansProjects\\TiendaSuplementos\\src\\main\\webapp\\assets\\img\\Tienda.jpg");
            logo.scaleToFit(100, 100);
            logo.setAlignment(Element.ALIGN_LEFT);
            documento.add(logo);

            // Agregar encabezado con datos de la empresa
            Paragraph datosEmpresa = new Paragraph();
            datosEmpresa.setAlignment(Element.ALIGN_LEFT);
            datosEmpresa.add(new Phrase(emp.getNombre() + "\n", new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD)));
            datosEmpresa.add(new Phrase("RUC: " + emp.getRuc() + "\n", new Font(Font.FontFamily.HELVETICA, 12)));
            datosEmpresa.add(new Phrase("Metodo envío: " + venta.getTipopago() + "\n", new Font(Font.FontFamily.HELVETICA, 12)));
            if (venta.getTipopago().equals("delivery")) {
                datosEmpresa.add(new Phrase("Direccion de envío: " + venta.getDireccion() + ", " + venta.getDistrito(), new Font(Font.FontFamily.HELVETICA, 12)));
            } else if (venta.getTipopago().equals("recojo")) {
                datosEmpresa.add(new Phrase("Sede de Recojo: Tienda- " + venta.getDistrito() + "\nDireccion: " + venta.getDireccion() + "\n\n", new Font(Font.FontFamily.HELVETICA, 12)));
            }
            documento.add(datosEmpresa);

            // Agregar datos del cliente
            Paragraph datosCliente = new Paragraph();
            datosCliente.setAlignment(Element.ALIGN_LEFT);
            datosCliente.add(new Phrase("Cliente:\n", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
            datosCliente.add(new Phrase("DNI: " + cliente.getDni() + "\n", new Font(Font.FontFamily.HELVETICA, 12)));
            datosCliente.add(new Phrase("Nombre: " + cliente.getNombres() + " " + cliente.getApellidos() + "\n", new Font(Font.FontFamily.HELVETICA, 12)));
            datosCliente.add(new Phrase("Fecha de compra: " + venta.getFecha() + "\n\n", new Font(Font.FontFamily.HELVETICA, 12)));
            documento.add(datosCliente);

            // Agregar tabla de productos
            PdfPTable tablaProductos = new PdfPTable(4);
            tablaProductos.setWidthPercentage(100);
            tablaProductos.setWidths(new float[]{10f, 50f, 20f, 20f});
            tablaProductos.addCell(new PdfPCell(new Phrase("Cant.", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD))));
            tablaProductos.addCell(new PdfPCell(new Phrase("Descripción", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD))));
            tablaProductos.addCell(new PdfPCell(new Phrase("P. Unit.", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD))));
            tablaProductos.addCell(new PdfPCell(new Phrase("Importe", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD))));

            for (Carrito producto : productos) {
                tablaProductos.addCell(String.valueOf(producto.getCantidad()));
                tablaProductos.addCell(producto.getNombres());
                tablaProductos.addCell(String.format("%.2f", producto.getPrecio()));
                tablaProductos.addCell(String.format("%.2f", producto.getCantidad() * producto.getPrecio()));
            }
            documento.add(tablaProductos);

            // Agregar resumen de la venta
            Paragraph resumenVenta = new Paragraph();
            resumenVenta.setAlignment(Element.ALIGN_RIGHT);
            if (venta.getTipopago().equals("delivery")) {
                resumenVenta.add(new Phrase("Coste envío: S/10.00 \n", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
            }
            resumenVenta.add(new Phrase("Total: S/ " + String.format("%.2f", venta.getTotal()) + "\n\n", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
            documento.add(resumenVenta);

            // Agregar mensaje de agradecimiento
            Paragraph mensaje = new Paragraph("Gracias por su compra", new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC));
            mensaje.setAlignment(Element.ALIGN_CENTER);
            documento.add(mensaje);

            // Cerrar el documento
            documento.close();
        } catch (Exception e) {
            System.err.println("Error al generar el PDF: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
