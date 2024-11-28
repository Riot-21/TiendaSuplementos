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
                        <form action="ProductController" method="GET" id="filterForm">
                            <!-- Filtro de categorías -->
                            <h6>Categorías</h6>

                            <c:forEach var="cat" items="${categorias}">
                                <div class="form-check">
                                    <!-- Checkbox para cada categoría -->
                                    <input class="form-check-input" type="checkbox" name="categorias" value="${cat.idCategoria}" id="${cat.categoria}">
                                    <label class="form-check-label" for="${cat.categoria}">
                                        ${cat.categoria}
                                    </label>
                                </div>
                            </c:forEach>

                            <!-- Filtro de precios -->
                            <h6 class="mt-4">Precio</h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="precio" id="price1" value="lessThan50">
                                <label class="form-check-label" for="price1">
                                    Menos de S/.50,00
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="precio" id="price2" value="50to100">
                                <label class="form-check-label" for="price2">
                                    S/.50,00 - S/.100,00
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="precio" id="price3" value="moreThan100">
                                <label class="form-check-label" for="price3">
                                    Más de S/.100,00
                                </label>
                            </div>

                            <!-- Botón de filtro -->
                            <button type="submit" class="btn btn-primary mt-3" name="action" value="sortBy">Aplicar Filtro</button>
                        </form>
                    </div>
                    <!--Ordenar Productos-->
                    <div class="container mt-4 order-section">
                        <h3>Ordenar Productos</h3>
                        <label for="orderOptions" class="form-label">Selecciona una opción de ordenación:</label>
                        <form action="ProductController" method="GET" id="orderForm">
                            <input type="hidden" name="action" value="sortBy">
                            <select id="orderOptions" class="form-select" name="orden" onchange="document.getElementById('orderForm').submit();">
                                <option value="default" ${empty ordenSeleccionado || ordenSeleccionado == 'default' ? 'selected' : ''}>Selecciona...</option>
                                <option value="price-asc" ${ordenSeleccionado == 'price-asc' ? 'selected' : ''}>Ordenar por Precio: Menor a Mayor</option>
                                <option value="price-desc" ${ordenSeleccionado == 'price-desc' ? 'selected' : ''}>Ordenar por Precio: Mayor a Menor</option>
                                <option value="name-asc" ${ordenSeleccionado == 'name-asc' ? 'selected' : ''}>Ordenar por Nombre: A-Z</option>
                                <option value="name-desc" ${ordenSeleccionado == 'name-desc' ? 'selected' : ''}>Ordenar por Nombre: Z-A</option>
                            </select>
                        </form>
                    </div>




                </div>
                <!-- Productos -->
                <div class="col-lg-9">
                    <h2 class="text-start mb-4 title-products">Productos</h2>
                    <!-- Si hay una búsqueda -->
                        <div class="row">
                            <c:if test="${not empty busq}">
                                <c:forEach var="producto" items="${busq}">
                                    <div class="col-md-4 mb-4">
                                        <div class="card product-card">
                                            <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}" style="width: 100%; height: 200px; object-fit: contain;">
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
                                                <a href="ProductController?action=cargarid&id=${producto.idProducto}" class="btn fw-bold rounded-pill button-action">Seleccionar Opciones</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>

                            <!-- Si no hay productos en la búsqueda -->
                            <c:if test="${empty busq && empty tienda}">
                                <h2>No se encontraron productos con ese término de búsqueda.</h2>
                            </c:if>
                        </div>

                    <!-- Si no hay búsqueda, mostrar todos los productos de la tienda -->
                        <div class="row">
                            <c:if test="${not empty tienda}">
                                <c:forEach var="producto" items="${tienda}">
                                    <div class="col-md-4 mb-4">
                                        <div class="card product-card">
                                            <img src="${producto.imagen}" class="card-img-top" alt="${producto.nombre}" style="width: 100%; height: 200px; object-fit: contain;">
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
                                                <a href="ProductController?action=cargarid&id=${producto.idProducto}" class="btn fw-bold rounded-pill button-action">Seleccionar Opciones</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>

                            <!-- Si no hay productos en la tienda -->
                            <c:if test="${empty tienda && empty mensaje}">
                                <h2>No hay productos disponibles</h2>
                            </c:if>
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

        <%@include file="components/footer.jsp" %>

        <script src="assets/script/cart-shopping.js"></script>
        <script>
                                // Función que se llama cuando el usuario hace clic en el botón
                                function verDetalleProducto(idProducto) {
                                    // Redirige a la página de producto específico sin mostrar el ID en la URL
                                    window.location.href = "producto-especifico.jsp?id=" + idProducto;
                                }
        </script>

        <!-- Bootstrap JS (opcional) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    </body>

</html>