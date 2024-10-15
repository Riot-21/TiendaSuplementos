<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutripoint</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="assets/css/inicio.css">
        <link rel="stylesheet" href="assets/css/shop-cart.css">
    </head>

    <body>

        <%@include file="components/header.jsp" %>

        <div class="container mt-4">
            <c:if test="${not empty sessionScope.usuario}">
                <p>Bienvenido, ${sessionScope.usuario.nombres}!</p>
            </c:if>

        </div>

        <!-- Carrusel de Imágenes -->
        <div id="mainCarousel" class="carousel slide mt-3" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" aria-current="true"
                        aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="assets/img/Banner-1.jpg" class="d-block w-100" alt="Producto 1">
                </div>
                <div class="carousel-item">
                    <img src="assets/img/Banner-2.jpg" class="d-block w-100" alt="Producto 2">
                </div>
                <div class="carousel-item">
                    <img src="assets/img/Banner-3.jpg" class="d-block w-100" alt="Producto 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>
        </div>

        <!--Marcas -->
        <div class="brands-container text-center mt-3">
            <a class="brand ms-4 p-3" href="#"> <img src="assets/img/brand-on.png" alt="brand1" height="50"></a>
            <a class="brand ms-4 p-3" href="#"> <img src="assets/img/brand-nutrex.png" alt="brand1" height="50"></a>
            <a class="brand ms-4 p-3" href="#"> <img src="assets/img/brand-syntax.png" alt="brand1" height="50"></a>
            <a class="brand ms-4 p-3" href="#"> <img src="assets/img/brand-ultimate_nutrition.png" alt="brand1" height="50"></a>
        </div>

        <!--Lista de Productos Principales -->
        <div class="container mt-3">
            <h2 class="text-left mb-4 title-products">Productos Destacados</h2>
            <div class="row mt-3">
                <!-- Producto 1 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Proteinas.png" class="card-img-top" alt="Proteí­na">
                        <div class="card-body">
                            <h5 class="card-title">Proteí­na Whey</h5>
                            <p class="card-text">La mejor proteí­na para tus entrenamientos.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
                <!-- Producto 2 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Vitaminas.png" class="card-img-top" alt="Vitaminas">
                        <div class="card-body">
                            <h5 class="card-title">Multivitamí­nico Completo</h5>
                            <p class="card-text">Mejora tu salud con vitaminas esenciales.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
                <!-- Producto 3 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Aminoacidos.png" class="card-img-top" alt="Aminoácidos">
                        <div class="card-body">
                            <h5 class="card-title">Aminoácidos BCAA</h5>
                            <p class="card-text">Recuperación muscular garantizada.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Lista de Ofertas Semanales -->
        <div class="container mt-3">
            <h2 class="text-center mb-4 title-products">Ofertas Semanales</h2>
            <div class="row mt-3">
                <!-- Producto 1 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Proteinas.png" class="card-img-top" alt="ProteÃ­na">
                        <div class="card-body">
                            <h5 class="card-title">Proteí­na Whey</h5>
                            <p class="card-text">La mejor proteí­na para tus entrenamientos.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
                <!-- Producto 2 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Vitaminas.png" class="card-img-top" alt="Vitaminas">
                        <div class="card-body">
                            <h5 class="card-title">Multivitamí­nico Completo</h5>
                            <p class="card-text">Mejora tu salud con vitaminas esenciales.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
                <!-- Producto 3 -->
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="assets/img/Aminoacidos.png" class="card-img-top" alt="AminoÃ¡cidos">
                        <div class="card-body">
                            <h5 class="card-title">Aminoácidos BCAA</h5>
                            <p class="card-text">Recuperación muscular garantizada.</p>
                            <a href="producto-especifico.jsp" class="btn btn-dark">Comprar Ahora</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="components/footer.jsp" %>

        <script src="assets/script/cart-shopping.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>

    </body>

</html>