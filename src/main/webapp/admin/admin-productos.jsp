<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <a href="admin/administrador.jsp" class="btn btn-outline-light me-2">Inicio</a>
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

        <div class="container mt-4">


            <h2>Productos</h2>
            <p>Lista de productos.</p>
            <table class="table table-striped table-bordered" id="tabla-productos">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Stock</th>
                        <th>Marca</th>
                        <th>Precio U. (S/.)</th>
                        <th>Modo Empleo</th>
                        <th>Advertencia</th>
                        <th>Opciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>${producto.idProducto}</td>
                            <td>${producto.nombre}</td>
                            <td>${producto.descripcion}</td>
                            <td>${producto.stock}</td>
                            <td>${producto.marca}</td>
                            <td>${producto.preciounit}</td>
                            <td>${producto.mod_empleo}</td>
                            <td>${producto.advert}</td>
                            <td>
                                <div class="d-flex justify-content-between">
                                    <button class="btn btn-danger btn-sm me-2" onclick="" data-bs-toggle="modal"
                                            data-bs-target="#EliminarProductoModal">Eliminar</button>
                                    <button class="btn btn-warning btn-sm" onclick="cargarDatosProducto(${producto.idProducto})" data-bs-toggle="modal"
                                            data-bs-target="#EditarProductoModal">Editar</button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="d-flex justify-content-end mb-3">
    <form action="${pageContext.request.contextPath}/ProductController" method="GET">
        <button type="submit" class="btn btn-success" name="action" value="exportarExcel">
            Exportar a Excel
        </button>
    </form>
</div>


            <!-- Modal Editar Producto -->
            <div class="modal fade" id="EditarProductoModal" tabindex="-1" aria-labelledby="EditarProductoLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="EditarProductoLabel">Editar Producto</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editarProductoForm">
                                <div class="form-group">
                                    <label for="nombre-producto">Nombre del Producto</label>
                                    <input type="text" class="form-control" id="nombre-producto" name="nombre-producto">
                                </div>
                                <div class="form-group">
                                    <label for="descripcion-producto">Descripción del Producto</label>
                                    <textarea class="form-control" id="descripcion-producto" name="descripcion-producto"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="stock-producto">Stock del Producto</label>
                                    <input type="number" class="form-control" id="stock-producto" name="stock-producto">
                                </div>
                                <div class="form-group">
                                    <label for="marca-producto">Marca del Producto</label>
                                    <input type="text" class="form-control" id="marca-producto" name="marca-producto">
                                </div>
                                <div class="form-group">
                                    <label for="precio-producto">Precio del Producto (S/.)</label>
                                    <input type="number" class="form-control" id="precio-producto" name="precio-producto">
                                </div>
                                <div class="form-group">
                                    <label for="empleo-producto">Modo de Empleo del Producto</label>
                                    <input type="text" class="form-control" id="empleo-producto" name="empleo-producto">
                                </div>
                                <div class="form-group">
                                    <label for="advertencia-producto">Advertencia del Producto</label>
                                    <textarea class="form-control" id="advertencia-producto" name="advertencia-producto"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="imagen-producto">Imagen del Producto</label>
                                    <input type="file" class="form-control" id="imagen-producto" name="imagen-producto" accept="image/*">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-success" id="confirmar-editar">Confirmar</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

            <script>
            // Definimos una función llamada cargarDatosProducto que recibe un ID de producto.
            function cargarDatosProducto(id) {
                fetch(`ProductController?action=cargarid&id=`+id)
                        .then(response => {
                            if (!response.ok) {
                                // Maneja errores basados en el código de estado HTTP
                                throw new Error(`Error: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(producto => {
                            document.getElementById('nombre-producto').value = producto.nombre;
                            document.getElementById('descripcion-producto').value = producto.descripcion;
                            document.getElementById('stock-producto').value = producto.stock;
                            document.getElementById('marca-producto').value = producto.marca;
                            document.getElementById('precio-producto').value = producto.preciounit;
                            document.getElementById('empleo-producto').value = producto.mod_empleo;
                            document.getElementById('advertencia-producto').value = producto.advert;
                        })
                        .catch(error => {
                            console.error('Error:', error);
                        });
            }
            </script>
            


            </body>

            </html>

