<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="es">

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
                    <span class="navbar-brand mb-0 h1 text-light ms-3">Administradores</span>
                    <div class="d-flex ms-auto">
                        <a href="administrador.jsp" class="btn btn-outline-light me-2">Inicio</a>
                        <button class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#SalirModal">Salir</button>
                    </div>
                </div>
                <div class="modal fade" id="SalirModal" tabindex="-1" aria-labelledby="SalirModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="SalirModalLabel">¿Seguro de salir?</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                <form action="${pageContext.request.contextPath}/AdminController" method="POST">
                                    <button type="submit" class="btn btn-primary" name="action" value="logout">Salir</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <div class="container mt-4">
                <div class="d-flex justify-content-between align-items-center">
                    <h2>Administradores</h2>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#agregarModal">Agregar</button>
                </div>
                <p>Lista de Administradores</p>
                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>DNI</th>
                            <th>Correo</th>                            
                            <th>Telefono</th>
                            <th>Opciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="adm" items="${sessionScope.listaAdmin}">
                            <tr>
                                <td>${adm.idAdmin}</td>
                                <td>${adm.nombres}</td>
                                <td>${adm.apellidos}</td>
                                <td>${adm.dni}</td>
                                <td>${adm.email}</td>
                                <td>${adm.telefono}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/SvEliminar" method="POST">
                                        <input type="hidden" name="idUsuario" value="${usu.idUsuario}" />
                                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button> 
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- Modal de Agregar  -->
        <div class="modal fade" id="agregarModal" tabindex="-1" aria-labelledby="agregarModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="agregarModalLabel">Agregar Administrador</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formAgregarAdmin" action="${pageContext.request.contextPath}/AdminController" method="POST">
                            <div class="mb-3">
                                <label for="agregarNombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="agregarNombre" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="agregarApellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="agregarApellido" name="lastname" required>
                            </div>
                            <div class="mb-3">
                                <label for="agregarDNI" class="form-label">DNI</label>
                                <input type="text" class="form-control" id="agregarDNI" name="dni" required maxlength="8" pattern="\d*" inputmode="numeric" oninput="this.value = this.value.replace(/[^0-9]/g, '')" title="Ingrese solo números">
                            </div>
                            <div class="mb-3">
                                <label for="agregarTelf" class="form-label">Telefono</label>
                                <input type="text" class="form-control" id="agregarCorreo" name="tel" required>
                            </div>
                            <div class="mb-3">
                                <label for="agregarCorreo" class="form-label">Correo</label>
                                <input type="email" class="form-control" id="agregarCorreo" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="agregarClave" class="form-label">Clave</label>
                                <input type="text" class="form-control" id="agregarCorreo" name="passw" required>
                            </div>
                            <button type="submit" class="btn btn-primary" name="action" value="register">Agregar Administrador</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Editar  -->
        <div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="editarModalLabel">Editar Administrador</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="formEditarAdmin">
                            <input type="hidden" id="editarId">
                            <div class="mb-3">
                                <label for="editarNombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="editarNombre" required>
                            </div>
                            <div class="mb-3">
                                <label for="editarApellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="editarApellido" required>
                            </div>
                            <div class="mb-3">
                                <label for="editarDNI" class="form-label">DNI</label>
                                <input type="text" class="form-control" id="editarDNI" required maxlength="8" pattern="\d*" inputmode="numeric" oninput="this.value = this.value.replace(/[^0-9]/g, '')" title="Ingrese solo números">
                            </div>
                            <div class="mb-3">
                                <label for="editarCorreo" class="form-label">Correo</label>
                                <input type="email" class="form-control" id="editarCorreo" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Guardar cambios</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal de Confirmación de Eliminación -->
        <div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="eliminarModalLabel">Confirmar Eliminación</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que deseas eliminar este Administrador?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" onclick="eliminarAdmin()">Eliminar</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <script>
                            function cargarDatos(id, nombre, apellido, dni, correo) {
                                document.getElementById('editarId').value = id;
                                document.getElementById('editarNombre').value = nombre;
                                document.getElementById('editarApellido').value = apellido;
                                document.getElementById('editarDNI').value = dni;
                                document.getElementById('editarCorreo').value = correo;
                            }

                            function confirmarEliminacion(id) {
                                // Aquí puedes guardar el ID para la eliminación
                                window.idEliminar = id;
                            }

                            function eliminarAdmin() {
                                // Realizar la eliminación utilizando window.idEliminar
                                console.log('Eliminar administrador con ID:', window.idEliminar);
                                // Luego, cierras el modal
                                const eliminarModal = bootstrap.Modal.getInstance(document.getElementById('eliminarModal'));
                                eliminarModal.hide();
                            }
        </script>

    </body>

</html>
