<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nutripoint - Tienda de Suplementos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/tiendas.css">
    <link rel="stylesheet" href="assets/css/shop-cart.css"/>
</head>

<body>

    <%@include file="components/header.jsp"%>

    <!-- Contenido de Tiendas -->
    <div class="container mt-3">
        <h1 class="text-center mb-4 title-store">Nuestras Tiendas</h1>
        <div class="row g-4">
            <!-- Tienda 1 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-1.jpg" class="store-img" alt="Tienda 1">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Central</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 123, Lima, Perú</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 321</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 9:00 AM - 7:00 PM</p>
                    </div>
                </div>
            </div>

            <!-- Tienda 2 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-2.jpg" class="store-img" alt="Tienda 2">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Surco</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 456, Surco, Lima</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 322</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 10:00 AM - 8:00 PM</p>
                    </div>
                </div>
            </div>

            <!-- Tienda 3 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-3.jpg" class="store-img" alt="Tienda 3">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Miraflores</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 789, Miraflores, Lima</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 323</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 8:00 AM - 9:00 PM</p>
                    </div>
                </div>
            </div>

            <!-- Tienda 4 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-4.jpg" class="store-img" alt="Tienda 3">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Miraflores</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 789, Miraflores, Lima</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 323</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 8:00 AM - 9:00 PM</p>
                    </div>
                </div>
            </div>

            <!-- Tienda 5 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-5.jpg" class="store-img" alt="Tienda 3">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Miraflores</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 789, Miraflores, Lima</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 323</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 8:00 AM - 9:00 PM</p>
                    </div>
                </div>
            </div>

            <!-- Tienda 6 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="assets/img/Store-6.jpg" class="store-img" alt="Tienda 3">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda Miraflores</h5>
                        <p><i class="fa fa-map-marker me-2"></i>Av. Peru 789, Miraflores, Lima</p>
                        <p><i class="fa fa-phone me-2"></i>+51 987 654 323</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: 8:00 AM - 9:00 PM</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="components/footer.jsp"%>
    
    <script src="assets/script/cart-shopping.js"></script>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>