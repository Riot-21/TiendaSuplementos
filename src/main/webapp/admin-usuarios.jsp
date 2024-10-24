<%@page import="java.util.List"%>
<%@page import="modelo.dto.Usuario"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>

    <body>

        <header>
            <nav class="navbar navbar-light navbar-expand-lg bg-primary shadow-sm">
                <div class="container-fluid">
                    <span class="navbar-brand mb-0 h1 text-light ms-3">Usuarios</span>
                    <div class="d-flex ms-auto">
                        <a href="admin.jsp" class="btn btn-outline-light me-2">Inicio</a>
                        <a href="#" class="btn btn-outline-light" data-bs-toggle="modal"
                           data-bs-target="#SalirModal">Salir</a>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="SalirModal" tabindex="-1" aria-labelledby="SalirModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="SalirModalLabel">¿Seguro de salir?</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                <button type="button" class="btn btn-primary">Salir</button>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <div class="container mt-4">
            <h2>Usuarios</h2>
            <p>Lista de usuarios en la plataforma.</p>
            <!-- Simulación de lista de usuarios -->
            <table class="table table-striped table-bordered">
                <thead class="thead-dark"></thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>DNI</th>
                    <th>Telefono</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>

                    <%
                        List<Usuario> listaUsuarios = (List) request.getSession().getAttribute("listaUsuarios");
                        for (Usuario usu : listaUsuarios) {
                    %>
                    <tr>
                        <td><%=usu.getIdUsuario()%></td>
                        <td><%=usu.getNombres()%></td>
                        <td><%=usu.getApellidos()%></td>
                        <td><%=usu.getEmail()%></td>
                        <td><%=usu.getDni()%></td>
                        <td><%=usu.getTelefono()%></td>
                        <td><button class="btn btn-danger btn-sm" onclick="" data-bs-toggle="modal"
                                    data-bs-target="#EliminarUsuarioModal">Eliminar</button>
                        </td>
                    </tr>
                    <%}%>


                </tbody>
            </table>
            <!-- Modal Confirmación de eliminación -->
            <div class="modal fade" id="EliminarUsuarioModal" tabindex="-1" aria-labelledby="#EliminarUsuarioLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="#EliminarUsuarioLabel">¿Seguro de eliminar el usuario ...?</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-danger">Eliminar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
                integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
    </body>

</html>
