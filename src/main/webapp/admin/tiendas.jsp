<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />
<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador de Tiendas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .sidebar {
                height: 100vh;
            }

            .profile-img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                margin-bottom: 10px;
            }

            .sidebar-heading {
                text-align: center;
                color: #ffffff;
                font-weight: bold;
                font-size: 1.2rem;
                margin-top: 10px;
            }

            .nav-link:hover {
                background-color: #343a40;
            }
        </style>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row">
                <%@include file="../components/adminheader.jsp" %>
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-1">

                    <h2>Tiendas</h2>
                    <c:if test="${empty tiendas}">
                        <h4 class="text-danger">No hay tiendas registradas</h4>
                    </c:if>
                    <c:if test="${not empty tiendas}">
                        <p>Lista de tiendas.</p>
                        <table class="table table-striped table-bordered" id="tabla-tiendas">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Distrito</th>
                                    <th>Dirección</th>
                                    <th>Teléfono</th>
                                    <th>Horario</th>
                                    <th>Foto</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tienda" items="${tiendas}">
                                    <tr>
                                        <td>${tienda.idTienda}</td>
                                        <td>${tienda.distrito}</td>
                                        <td>${tienda.direccion}</td>
                                        <td>${tienda.telefono}</td>
                                        <td>${tienda.horario}</td>
                                        <td>
                                            <img src="${tienda.foto}" alt="Foto de Tienda" width="100" height="100" />
                                        </td>
                                        <td>
                                            <div class="d-flex justify-content-between">
                                                <form action="${pageContext.request.contextPath}/SvEliminar" method="POST">
                                                    <input type="hidden" name="idShop" value="${tienda.idTienda}" />
                                                    <button type="submit" class="btn btn-danger btn-sm" name="action" value="shop">Eliminar</button>
                                                </form>
                                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                                        data-bs-target="#EditarTiendaModal" onclick="cargarDatosTienda(${tienda.idTienda})">Editar</button>
                                                        
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>

                    <!-- Modal Editar Tienda -->
                    <div class="modal fade" id="EditarTiendaModal" tabindex="-1" aria-labelledby="EditarTiendaLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <form id="editarTiendaForm" action="${pageContext.request.contextPath}/shop" method="POST">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="EditarTiendaLabel">Editar Tienda</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="id-tienda" id="id-tienda">
                                        <div class="form-group">
                                            <label for="distrito-tienda">Distrito</label>
                                            <input type="text" class="form-control" id="distrito-tienda" name="distrito-tienda" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="direccion-tienda">Dirección</label>
                                            <input type="text" class="form-control" id="direccion-tienda" name="direccion-tienda" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="telefono-tienda">Teléfono</label>
                                            <input type="number" class="form-control" id="telefono-tienda" name="telefono-tienda"  maxlength="9" pattern="^\d{9}$" title="Debe contener exactamente 9 dígitos" required oninput="validarNumero(this)">
                                        </div>
                                        <div class="form-group">
                                            <label for="horario-tienda">Horario</label>
                                            <input type="text" class="form-control" id="horario-tienda" name="horario-tienda" required>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" name="action" value="update" class="btn btn-success" id="confirmar-editar">Confirmar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Modal Agregar Tienda -->
                    <div class="modal fade" id="AgregarTiendaModal" tabindex="-1" aria-labelledby="AgregarTiendaLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <form id="agregarTiendaForm" action="${pageContext.request.contextPath}/shop" method="POST" enctype="multipart/form-data">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="AgregarTiendaLabel">Agregar Tienda</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label for="distrito-tienda">Distrito</label>
                                            <input type="text" class="form-control" id="distrito-tienda" name="distrito-tienda" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="direccion-tienda">Dirección</label>
                                            <input type="text" class="form-control" id="direccion-tienda" name="direccion-tienda" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="telefono-tienda">Teléfono</label>
                                            <input type="number" class="form-control" id="telefono-tienda" name="telefono-tienda" maxlength="9" pattern="^\d{9}$" title="Debe contener exactamente 9 dígitos" required oninput="validarNumero(this)"> 
                                        </div>
                                        <div class="form-group">
                                            <label for="horario-tienda">Horario</label>
                                            <input type="text" class="form-control" id="horario-tienda" name="horario-tienda" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="product-photos">Foto de la tienda</label>
                                            <input type="file" accept="image/*" class="form-control" id="tienda-foto" name="tienda-foto" required onchange="validarImagenes()">
                                            <p id="error" style="color:red; display:none;">Solo puedes seleccionar 1 imagen.</p>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit"  class="btn btn-success" id="confirmar-agregar" name="action" value="add">Agregar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mb-3">
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#AgregarTiendaModal">Agregar Tienda</button>
                    </div>

                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <script>
                                        function validarImagenes() {
                                            const archivoInput = document.getElementById('tienda-foto');
                                            const errorMsg = document.getElementById('error');

                                            if (archivoInput.files.length > 3) {
                                                errorMsg.style.display = 'block';
                                                archivoInput.setCustomValidity('Solo puedes seleccionar 1 imagen.');
                                                archivoInput.value = '';
                                            } else {
                                                errorMsg.style.display = 'none';
                                                archivoInput.setCustomValidity('');
                                            }
                                        }

                                        // Función para validar que solo se ingresen números
                                        function validarNumero(input) {
                                            input.value = input.value.replace(/[^0-9]/g, ''); // Reemplaza cualquier carácter que no sea un número
                                        }
                                        
                                        // Definimos una función llamada cargarDatosProducto que recibe un ID de producto.
                                                        function cargarDatosTienda(id) {
                                                            fetch(`shop?action=edit&id=` + id)
                                                                    .then(response => {
                                                                        if (!response.ok) {
                                                                            throw new Error(`Error: ${response.status}`);
                                                                        }
                                                                        return response.json(); // Procesar como JSON
                                                                    })
                                                                    .then(tienda => {
                                                                        // Rellenar los campos del formulario con los datos
                                                                        document.getElementById('id-tienda').value = id;
                                                                        document.getElementById('distrito-tienda').value = tienda.distrito;
                                                                        document.getElementById('direccion-tienda').value = tienda.direccion;
                                                                        document.getElementById('telefono-tienda').value = tienda.telefono;
                                                                        document.getElementById('horario-tienda').value = tienda.horario;
                                                                      
                                                                    })
                                                                    .catch(error => {
                                                                        console.error('Error:', error);
                                                                    });
                                                        }


        </script>
    </body>
</html>


