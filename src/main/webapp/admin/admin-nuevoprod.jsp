<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="modelo.dto.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dao.CategoriaDao"%>

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
                    <div class="container mt-2 col-md-5">
                        <h2>Agregar Producto</h2>
                        <form id="editarProductoForm mt-4" enctype="multipart/form-data" action="${pageContext.request.contextPath}/ProductController" method="POST">
                            <!--Nombre-->
                            <div class="form-group">
                                <label for="product-name">Nombre del Producto</label>
                                <input type="text" class="form-control" id="product-name" name="nombrep" required>
                            </div>
                            <!--Descripcion-->
                            <div class="form-group">
                                <label for="product-description">Descripcion del Producto</label>
                                <textarea class="form-control" id="product-description" name="descp" required></textarea>
                            </div>
                            <!--Stock-->
                            <div class="form-group">
                                <label for="product-stock">Stock del Producto</label>
                                <input type="number" class="form-control" id="product-stock" name="stkp" min="0" required>
                            </div>
                            <!--Marca-->
                            <div class="form-group">
                                <label for="product-brand">Marca del Producto</label>
                                <input type="text" class="form-control" id="product-brand" name="marcap" required>
                            </div>
                            <!--Precio-->
                            <div class="form-group">
                                <label for="product-price">Precio del Producto (S/.)</label>
                                <input type="number" class="form-control" id="product-price" name="preciop" step="0.01" min="0" required>
                            </div>
                            <!--Modo de Empleo-->
                            <div class="form-group">
                                <label for="product-modeUse">Modo del Empleo del Producto</label>
                                <textarea class="form-control" id="product-modeUse" name="modp" required></textarea>
                            </div>
                            <!--Advertencia-->
                            <div class="form-group">
                                <label for="product-warning">Advertencia del Producto</label>
                                <textarea class="form-control" id="product-warning" name="advp" required></textarea>
                            </div>
                            <!--Fecha de Vencimiento-->
                            <div class="form-group">
                                <label for="product-expiration-date">Fecha de Vencimiento del Producto</label>
                                <input type="date" class="form-control" id="product-expiration-date" name="fechaVencimiento" required onchange="validarFecha()">
                                <p id="errorFecha" style="color:red; display:none;">La fecha de vencimiento debe ser posterior a la fecha actual.</p>
                            </div>
                            <!-- Imagen -->
                            <div class="form-group">
                                <label for="product-photos">Imagen del Producto</label>
                                <input type="file" multiple accept="image/*" class="form-control" id="product-photos" name="photos" required onchange="validarImagenes()">
                                <p id="error" style="color:red; display:none;">Solo puedes seleccionar hasta 3 imágenes.</p>
                            </div>
                            <!-- Categorias -->
                            <div class="form-group">
                                <label for="product-cat">Categoria del Producto:</label>
                                <select class="form-control" id="product-cat" name="catp[]" multiple required>
                                    <c:forEach var="cat" items="${cat}">                                 
                                        <option value="${cat.idCategoria}">${cat.categoria}</option>
                                    </c:forEach> 
                                </select>
                            </div>
                            <div class="container mt-2 col-md-5 mx-auto">
                                <button type="submit" class="btn btn-success" name="action" value="guardar">Agregar</button>
                            </div>
                        </form>

                    </div>
                             <!-- Botón para abrir el modal de agregar categoría -->
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    Agregar Categoría
                </button>

                <!-- Modal de agregar categoría -->
                <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addCategoryModalLabel">Agregar Categoría</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${pageContext.request.contextPath}/CategoryController" method="POST">
                                    <div class="form-group">
                                        <label for="category-name">Nombre de la Categoría</label>
                                        <input type="text" class="form-control" name="categoria-nombre" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="category-objective">Objetivo de la Categoría</label>
                                        <input type="text" class="form-control" name="categoria-obj" required>
                                    </div>
                                    <button type="submit" class="btn btn-success mt-2">Agregar Categoría</button>
                                </form>
                            </div>
                        </div>
                    </div>
</div>
                </main>
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

        <script>
            function validarImagenes() {
                const archivoInput = document.getElementById('product-photos');
                const errorMsg = document.getElementById('error');

                if (archivoInput.files.length > 3) {
                    errorMsg.style.display = 'block';
                    archivoInput.setCustomValidity('Solo puedes seleccionar hasta 3 imágenes.');
                    archivoInput.value = '';
                } else {
                    errorMsg.style.display = 'none';
                    archivoInput.setCustomValidity('');
                }
            }
                                    
                                        function validarFecha() {
        const fechaInput = document.getElementById('product-expiration-date');
        const errorFecha = document.getElementById('errorFecha');

        const fechaSeleccionada = new Date(fechaInput.value);
        const fechaActual = new Date();

        // Eliminar la hora para comparar solo la fecha
        fechaActual.setHours(0, 0, 0, 0);

        if (fechaSeleccionada <= fechaActual) {
            errorFecha.style.display = 'block';
            fechaInput.setCustomValidity('La fecha debe ser posterior a la actual.');
            fechaInput.value='';
        } else {
            errorFecha.style.display = 'none';
            fechaInput.setCustomValidity('');
        }
    }
        </script>
    </body>

</html>