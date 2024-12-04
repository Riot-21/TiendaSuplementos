package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.dao.EmpresaDao;
import modelo.dto.Empresa;

@WebServlet(name = "CompanyController", urlPatterns = {"/empresa"})
public class CompanyController extends HttpServlet {

    private EmpresaDao edao;

    @Override
    public void init() {
        edao = new EmpresaDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            Empresa emp = new Empresa();
            emp = edao.datosEmpresa();
            request.setAttribute("datos", emp);
            request.getRequestDispatcher("admin/empresa.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Obtener los parámetros del formulario
        String nombre = request.getParameter("nombre");
        String ruc = request.getParameter("ruc");
        String razonSocial = request.getParameter("razonSocial");
        int idemp = Integer.parseInt(request.getParameter("idEmpresa"));

        // Inicializar un mensaje de error
        String mensajeError = null;

        // Validación para el campo RUC: debe ser solo números y exactamente 11 caracteres
        if (ruc != null && !ruc.matches("\\d{11}")) {
            mensajeError = "El RUC debe ser un número de exactamente 11 dígitos.";
        }

        // Si la validación del RUC pasa, proceder con la actualización
        if (mensajeError == null) {
            try {
                // Obtener el ID de la empresa de la sesión

                // Crear un objeto Empresa
                Empresa empresa = new Empresa(idemp, nombre, ruc, razonSocial);

                // Crear un DAO de Empresa para actualizar los datos
                boolean actualizado = edao.actualizarDatosEmpresa(empresa);

                if (actualizado) {
                    // Si la actualización fue exitosa, redirigir o enviar mensaje
                    response.sendRedirect("empresa");
                } else {
                    // Si hubo algún problema en la actualización
                    mensajeError = "Hubo un error al actualizar los datos de la empresa.";
                    request.setAttribute("mensajeError", mensajeError);
                    request.getRequestDispatcher("/empresa.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                mensajeError = "Hubo un error inesperado. Intenta nuevamente.";
                request.setAttribute("mensajeError", mensajeError);
                request.getRequestDispatcher("/empresa.jsp").forward(request, response);
            }
        } else {
            // Si la validación falla, mostrar el mensaje de error
            request.setAttribute("mensajeError", mensajeError);
            request.getRequestDispatcher("/empresa.jsp").forward(request, response);
        }
    
}

@Override
public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
