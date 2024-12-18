<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />
<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador</title>
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

                    <h2>Productos</h2>
                    <c:if test="${empty productos}">
                        <h4 class="text-danger">No hay productos registrados</h4>
                    </c:if>
                    <c:if test="${not empty productos}">
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
                                <th>Fecha Vencimiento</th>
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
                                    <fmt:formatNumber value="${producto.preciounit}" minFractionDigits="2" maxFractionDigits="2" var="precio"></fmt:formatNumber>
                                    <td>${precio}</td>
                                    <td>${producto.mod_empleo}</td>
                                    <td>${producto.advert}</td>
                                    <td>${producto.fechav}

                                        <c:if test="${not empty producto.mensajeProximoAVencer}">
                                            <span class="alert alert-warning">${producto.mensajeProximoAVencer}</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-between">
                                            <form action="${pageContext.request.contextPath}/SvEliminar" method="POST">
                                                    <input type="hidden" name="idProd" value="${producto.idProducto}" />
                                                    <button type="submit" class="btn btn-danger btn-sm btn-confirmar-eliminar" name="action" value="product">Eliminar</button> 
                                                </form>
                                            <button class="btn btn-warning btn-sm"  data-bs-toggle="modal"
                                                    data-bs-target="#EditarProductoModal" onclick="cargarDatosProducto(${producto.idProducto})">Editar</button>
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



                        <!-- Modal Editar Producto -->
                        <div class="modal fade" id="EditarProductoModal" tabindex="-1" aria-labelledby="EditarProductoLabel"
                             aria-hidden="true">
                            <div class="modal-dialog">
                                <form id="editarProductoForm" action="${pageContext.request.contextPath}/ProductController" method="POST">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="EditarProductoLabel">Editar Producto</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <input type="hidden" name="id-producto" id="id-producto">
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
                                                <input type="number" class="form-control" id="stock-producto" name="stock-producto" value=12>
                                            </div>
                                            <div class="form-group">
                                                <label for="marca-producto">Marca del Producto</label>
                                                <input type="text" class="form-control" id="marca-producto" name="marca-producto">
                                            </div>
                                            <div class="form-group">
                                                <label for="precio-producto">Precio del Producto (S/.)</label>
                                                <input type="number" class="form-control" id="precio-producto" name="precio-producto" step="0.01" min="0" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="empleo-producto">Modo de Empleo del Producto</label>
                                                <input type="text" class="form-control" id="empleo-producto" name="empleo-producto">
                                            </div>
                                            <div class="form-group">
                                                <label for="advertencia-producto">Advertencia del Producto</label>
                                                <textarea class="form-control" id="advertencia-producto" name="advertencia-producto"></textarea>
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


                    </div>
                                    </c:if>
                    

                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

        <script>
                                                        // Definimos una función llamada cargarDatosProducto que recibe un ID de producto.
                                                        function cargarDatosProducto(id) {
                                                            fetch(`ProductController?action=editar&id=` + id)
                                                                    .then(response => {
                                                                        if (!response.ok) {
                                                                            throw new Error(`Error: ${response.status}`);
                                                                        }
                                                                        return response.json(); // Procesar como JSON
                                                                    })
                                                                    .then(producto => {
                                                                        // Rellenar los campos del formulario con los datos
                                                                        document.getElementById('id-producto').value = id;
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

