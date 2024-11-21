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
                        <c:forEach var="img" items="${producto.imagenes}">
                            <img src="${img.imagen}" alt="Imagen Producto" onclick="changeMainImage(this.src)">
                        </c:forEach>
                    </div>
                    <img src="${producto.imagenes[0].imagen}" alt="Imagen Principal" id="mainImage" class="product-main-image mt-3">
                </div>

                <div class="col-md-8">
                    <h2 id="productoNombre">${producto.nombre}</h2>
                    <p><strong>SKU:</strong> <span id="productoSKU">${producto.idProducto}</span></p>
                    <h3 class="text-primary" id="productoPrecio">S/. ${producto.preciounit}</h3>
                    <!-- Verificar stock -->
                    <p class="text-${producto.stock > 0 ? 'success' : 'danger'}" id="productoStock">
                        <c:if test="${producto.stock > 0}">
                            <i class="fa fa-check-circle"></i><span id="stk">${producto.stock}</span> unidad(es) disponibles 
                        </c:if>
                        <c:if test="${producto.stock <= 0}">
                            <i class="fa fa-times-circle"></i> Agotado
                        </c:if>
                    </p>
                    <form action="ProductController" method="POST">
    <input type="hidden" name="action" value="addToCart">
    <input type="hidden" name="id" value="${producto.idProducto}">

                    <!-- Cantidad y Agregar al carrito -->
                    <div class="input-group mb-3" style="max-width: 150px;">
                        <button class="btn btn-outline-secondary" type="button" id="button-minus">-</button>
                        <input name="cantidad" type="text" class="form-control text-center" value="1" id="productQuantity">
                        <button class="btn btn-outline-secondary" type="button" id="button-plus">+</button>
                    </div>

                    <c:if test="${not empty sessionScope.usuario}">
                        <!-- Agregar al carrito -->
                        <c:if test="${producto.stock > 0}">
                                <button type="submit" class="btn btn-dark mb-3"><i class="fa fa-cart-plus"></i>Agregar al carrito</button>
                        </c:if>
                            <button type="submit" class="btn btn-primary">Agregar al carrito</button>
</form>

                        <!-- Mensaje si no hay stock -->
                        <c:if test="${producto.stock <= 0}">
                            <a class="btn btn-dark mb-3" href="javascript:void(0);" disabled>
                                <i class="fa fa-cart-plus"></i> Agregar al carrito
                            </a>
                        </c:if>
                    </c:if>

                    <c:if test="${empty sessionScope.usuario}">
                        <a class="btn btn-dark mb-3" href="login.jsp">Inicia sesión para agregar productos al carrito</a>
                    </c:if>

                    <!-- Descripción del producto -->
                    <h5>Descripción</h5>
                    <p id="productoDescripcion">${producto.descripcion}</p>
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
                                // Cambiar imagen principal cuando se haga clic en una imagen de la galería
                                function changeMainImage(imageSrc) {
                                    document.getElementById('mainImage').src = imageSrc;
                                }
        </script>

    </script>
    <script src="assets/script/producto-esp.js" type="text/javascript"></script>
    <script src="assets/script/cart-shopping.js" type="text/javascript"></script>
</body>

</html>