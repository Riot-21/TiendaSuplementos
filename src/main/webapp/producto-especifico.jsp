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
                    <!-- Imágenes -->
                    <div class="product-images">
                        <img src="" alt="Imagen 1" onclick="changeMainImage(this.src)">
                        <img src="" alt="Imagen 2" onclick="changeMainImage(this.src)">
                        <img src="" alt="Imagen 3" onclick="changeMainImage(this.src)">
                    </div>
                    <img src="" alt="Imagen Principal" id="mainImage" class="product-main-image mt-3">
                </div>

                <div class="col-md-8">
                    <h2 id="productoNombre">Producto Cargando...</h2>
                    <p><strong>SKU:</strong> <span id="productoSKU">Cargando...</span></p>
                    <h3 class="text-primary" id="productoPrecio">S/. 0.00</h3>
                    <p class="text-success" id="productoStock"><i class="fa fa-check-circle"></i> Cargando...</p>

                    <!-- Cantidad y Agregar al carrito -->
                    <div class="input-group mb-3" style="max-width: 150px;">
                        <button class="btn btn-outline-secondary" type="button" id="button-minus">-</button>
                        <input type="text" class="form-control text-center" value="1" id="productQuantity">
                        <button class="btn btn-outline-secondary" type="button" id="button-plus">+</button>
                    </div>
                    <button class="btn btn-dark mb-3" type="button" id="addToCartButton"><i class="fa fa-cart-plus"></i> Agregar al carrito</button>

                    <!-- Descripción del producto -->
                    <h5>Descripción</h5>
                    <p id="productoDescripcion">Cargando...</p>
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


        <script>
            // Al cargar la página, obtener el ID del producto desde la URL
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const idProducto = urlParams.get('id');
                if (idProducto) {
                    obtenerDetalles(idProducto);
                }
            };

            // Función para obtener los detalles del producto desde el servidor
            function obtenerDetalles(id) {
                fetch(`ProductController?action=cargarid&id=` + id)  // Asegúrate de que la URL coincida con tu servlet
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Producto no encontrado');
                            }
                            return response.json();  // Convierte la respuesta JSON a un objeto JavaScript
                        })
                        .then(data => {
                            mostrarDetallesProducto(data);
                        })
                        .catch(error => {
                            alert('Error al cargar los datos del producto');
                            console.error(error);
                        });
            }

            // Función para mostrar los detalles del producto en la página
            function mostrarDetallesProducto(producto) {
                document.getElementById('productoNombre').innerText = producto.nombre;
                document.getElementById('productoSKU').innerText = producto.idProducto;  // O el SKU si lo tienes en los datos
                document.getElementById('productoPrecio').innerText = 'S/.' + producto.preciounit.toFixed(2);
                document.getElementById('productoDescripcion').innerText = producto.descripcion;

                // Mostrar stock
                const stockText = producto.stock > 0 ? producto.stock +' unidades disponibles' : 'Sin stock';
                document.getElementById('productoStock').innerHTML = stockText;

                // Cambiar las imágenes
                const imagesContainer = document.querySelectorAll('.product-images img');
                for (let i = 0; i < imagesContainer.length; i++) {
                    if (producto.imagenes[i]) {
                        imagesContainer[i].src = producto.imagenes[i].imagen;
                    }
                }
                document.getElementById('mainImage').src = producto.imagenes[0]?.imagen || 'default-image.jpg';  // Primera imagen como principal
            }

            // Cambiar imagen principal cuando se haga clic en una imagen de la galería
            function changeMainImage(imageSrc) {
                document.getElementById('mainImage').src = imageSrc;
            }
        </script>
    </body>

</html>