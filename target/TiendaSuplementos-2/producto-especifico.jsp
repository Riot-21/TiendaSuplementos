<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Producto - NutriPoint</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/producto-especifico.css">
    <link rel="stylesheet" href="assets/css/shop-cart.css"/>
</head>

<body>

    <%@include file="components/header.jsp" %>

    <div class="container mt-5">
        <!-- Producto Detalle -->
        <div class="row">
            <div class="col-md-4">
                <!-- Imagenes -->
                <div class="product-images">
                    <img src="assets/img/carnivor-1.jpg" alt="Imagen 1" onclick="changeMainImage('assets/img/carnivor-1.jpg')">
                    <img src="assets/img/carnivor-2.jpg" alt="Imagen 2" onclick="changeMainImage('assets/img/carnivor-2.jpg')">
                    <img src="assets/img/carnivor-3.jpg" alt="Imagen 3" onclick="changeMainImage('assets/img/carnivor-3.jpg')">
                </div>
                <img src="assets/img/carnivor-2.jpg" alt="Imagen Principal" id="mainImage" class="product-main-image mt-3">
            </div>

            <div class="col-md-8">
                <h2>Amino Carnivor Beef 300 Tabletas - MuscleMeds</h2>
                <p><strong>SKU:</strong> 97002757</p>
                <h3 class="text-primary">S/. 149.00</h3>
                <p class="text-success"><i class="fa fa-check-circle"></i> Hay existencias</p>

                <!-- Quantity and Add to Cart -->
                <div class="input-group mb-3" style="max-width: 150px;">
                    <button class="btn btn-outline-secondary" type="button" id="button-minus">-</button>
                    <input type="text" class="form-control text-center" value="1" id="productQuantity">
                    <button class="btn btn-outline-secondary" type="button" id="button-plus">+</button>
                </div>
                <button class="btn btn-dark mb-3" type="button"><i class="fa fa-cart-plus"></i> Agregar al
                    carrito</button>

                <!-- Product Description -->
                <h5>Descripción</h5>
                <p>
                    MuscleMeds CARNIVOR 100% BEEF AMINOS utiliza una tecnología de procesamiento patentada para
                    proporcionar altas concentraciones de aminoácidos de calidad. Elaborado con el mejor aislado de
                    proteína de res, albúmina de res, hígado de res desecado argentino e inmunoglobulina de res de
                    primera calidad, cada tableta ultraconcentrada proporciona un espectro completo de aminoácidos
                    esenciales.
                </p>
            </div>
        </div>

        <!-- Productos Relacionados -->
        <h4 class="mt-5">Productos Relacionados</h4>
        <div class="row related-products">
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/img/Aminoacidos.png" class="card-img-top" alt="Producto Relacionado 1">
                    <div class="card-body">
                        <h5 class="card-title">Amino Fuel Liquid 32 oz - Twinlab 100% Whey 4</h5>
                        <p class="text-primary">S/ 129.00</p>
                        <a href="#" class="btn btn-dark btn-sm">Ver Producto</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/img/Proteinas.png" class="card-img-top" alt="Producto Relacionado 2">
                    <div class="card-body">
                        <h5 class="card-title">Optimum Nutrition Gold Standard 100% Whey 5 lb</h5>
                        <p class="text-primary">S/ 289.00</p>
                        <a href="#" class="btn btn-dark btn-sm">Ver Producto</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <img src="assets/img/Vitaminas.png" class="card-img-top" alt="Producto Relacionado 3">
                    <div class="card-body">
                        <h5 class="card-title">BCAA 5000 Powder - Dymatize 100% Whey 4</h5>
                        <p class="text-primary">S/ 99.00</p>
                        <a href="#" class="btn btn-dark btn-sm">Ver Producto</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="components/footer.jsp" %>
    
    <script src="assets/script/cart-shopping.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Cambiar de imagen -->
    <script>
        function changeMainImage(imageUrl) {
            document.getElementById('mainImage').src = imageUrl;
        }
    </script>
</body>

</html>