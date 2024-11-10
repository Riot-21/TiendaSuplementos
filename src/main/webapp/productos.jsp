<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutripoint - Tienda</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="assets/css/productos.css">
        <link rel="stylesheet" href="assets/css/shop-cart.css"/>
    </head>

    <body>

        <%@include file="components/header.jsp" %>
        <!-- Productos -->
        <div class="container mt-4">
            <div class="row">
                <!-- Filtros -->
                <div class="col-lg-3">
                    <div class="filter-section">
                        <h3>Filtrar por</h3>
                        <!-- Filtro de categorías -->
                        <h6>Categorí­as</h6>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="proteinas">
                            <label class="form-check-label" for="proteinas">
                                Proteí­nas
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="vitaminas">
                            <label class="form-check-label" for="vitaminas">
                                Vitaminas
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="" id="aminoacidos">
                            <label class="form-check-label" for="aminoacidos">
                                Aminoácidos
                            </label>
                        </div>
                        <!-- Filtro de precios -->
                        <h6 class="mt-4">Precio</h6>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="price" id="price1" value="option1">
                            <label class="form-check-label" for="price1">
                                Menos de S/.50,00
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="price" id="price2" value="option2">
                            <label class="form-check-label" for="price2">
                                S/.50,00 - S/.100,00
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="price" id="price3" value="option3">
                            <label class="form-check-label" for="price3">
                                Más de S/.100,00
                            </label>
                        </div>
                    </div>
                    <!--Ordenar Productos-->
                    <div class="container mt-4 order-section">
                        <h3>Ordenar Productos</h3>
                        <label for="orderOptions" class="form-label">Selecciona una opción de ordenación:</label>
                        <select id="orderOptions" class="form-select">
                            <option value="default">Selecciona...</option>
                            <option value="price-asc">Ordenar por Precio: Menor a Mayor</option>
                            <option value="price-desc">Ordenar por Precio: Mayor a Menor</option>
                            <option value="popularity">Ordenar por Popularidad</option>
                            <option value="name-asc">Ordenar por Nombre: A-Z</option>
                            <option value="name-desc">Ordenar por Nombre: Z-A</option>
                        </select>
                    </div>
                </div>
                <!-- Productos -->
                <div class="col-lg-9">
                    <h2 class="text-start mb-4 title-products">Productos</h2>
                    <div class="row">
                        <c:forEach var="producto" items="${tienda}">
                            <div class="col-md-4 mb-4">
                                <div class="card product-card">
                                    <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}"style="width: 100%; height: 200px; object-fit: contain;">
                                    <div class="card-body">
                                        <h5 class="card-title">${producto.nombre}</h5>
                                        <p class="card-price fw-bold text-price">S/. ${producto.preciounit}</p>
                                        <c:choose>
                                            <c:when test="${producto.stock > 0}">
                                                <p class="stock-status text-muted">Stock disponible: 
                                                    <span class="text-dark fw-bold">${producto.stock} unidades</span>
                                                </p>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="stock-status text-danger">Sin stock</p>
                                            </c:otherwise>
                                        </c:choose>
                                        <a href="producto-especifico.jsp?id=${producto.idProducto}" class="btn fw-bold rounded-pill button-action">Seleccionar Opciones</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                    <!-- Paginación -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">Anterior</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">1</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">2</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">3</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="#">Siguiente</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>

        <%@include file="components/footer.jsp" %>

        <script src="assets/script/cart-shopping.js"></script>

        <!-- Bootstrap JS (opcional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    </body>

</html>