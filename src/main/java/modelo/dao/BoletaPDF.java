
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
import java.util.List;
import modelo.dto.Carrito;
import modelo.dto.Compra;
import modelo.dto.Producto;
import modelo.dto.Usuario;

public class BoletaPDF {
        
    public void generarPDFBoleta(List<Carrito> productos, Usuario cliente, Compra venta, int codigo) {
    try {
        // Ruta donde se almacenará el PDF // Método que retorna el código de la venta
        File file = new File("C:\\Users\\uset\\Documents\\NetBeansProjects\\TiendaSuplementos\\src\\main\\webapp\\pdf/" + codigo + ".pdf");
        
        FileOutputStream archivo = new FileOutputStream(file);

        // Crear el documento
        Document documento = new Document();
        PdfWriter.getInstance(documento, archivo);
        documento.open();

        // Agregar logo de la empresa
        Image logo = Image.getInstance("C:\\Users\\uset\\Documents\\NetBeansProjects\\TiendaSuplementos\\src\\main\\webapp\\assets\\img\\Tienda.jpg"); // Ruta del logo
        logo.scaleToFit(100, 100);
        logo.setAlignment(Element.ALIGN_LEFT);
        documento.add(logo);

        // Agregar encabezado con datos de la empresa
        Paragraph datosEmpresa = new Paragraph();
        datosEmpresa.setAlignment(Element.ALIGN_LEFT);
        datosEmpresa.add(new Phrase("Nutripooint\n", new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD)));
        datosEmpresa.add(new Phrase("RUC: 123456789\n", new Font(Font.FontFamily.HELVETICA, 12)));
        datosEmpresa.add(new Phrase("Dirección: Calle Ejemplo 123\nTeléfono: +51 987654321\n\n", new Font(Font.FontFamily.HELVETICA, 12)));
        documento.add(datosEmpresa);

        // Agregar datos del cliente
        Paragraph datosCliente = new Paragraph();
        datosCliente.setAlignment(Element.ALIGN_LEFT);
        datosCliente.add(new Phrase("Cliente:\n", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
        datosCliente.add(new Phrase("DNI: " + cliente.getDni() + "\n", new Font(Font.FontFamily.HELVETICA, 12)));
        datosCliente.add(new Phrase("Nombre: " + cliente.getNombres()+ " " + cliente.getApellidos() + "\n\n", new Font(Font.FontFamily.HELVETICA, 12)));
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
        resumenVenta.add(new Phrase("Total: S/ " + String.format("%.2f", venta.getTotal()) + "\n\n", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD)));
        documento.add(resumenVenta);

        // Agregar mensaje de agradecimiento
        Paragraph mensaje = new Paragraph("Gracias por su compra", new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC));
        mensaje.setAlignment(Element.ALIGN_CENTER);
        documento.add(mensaje);

        // Cerrar el documento
        documento.close();
        archivo.close();

        // Abrir el PDF automáticamente
        Desktop.getDesktop().open(file);
    } catch (Exception e) {
        System.err.println("Error al generar el PDF: " + e.getMessage());
        e.printStackTrace();
    }

    }
}
