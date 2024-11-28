<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
                    <h1>Cantidad del producto: ${cant}</h1>
                            
                    <c:if test="${not empty sessionScope.usuario}">
                        <!-- Agregar al carrito -->
                        <c:if test="${producto.stock > 0 && cant<producto.stock}">
                                <button type="submit" class="btn btn-dark mb-3"><i class="fa fa-cart-plus"></i>Agregar al carrito</button>
                        </c:if>
</form>

                        <!-- Mensaje si no hay stock -->
                        <c:if test="${producto.stock <= 0 || cant>=producto.stock}">
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
                <c:forEach var="al" items="${prodal}" begin="0" end="2">
                <div class="col-md-4">
                    <div class="card">
                        <img src="${al.imagen}" class="card-img-top" alt="${al.nombre}" style="width: 100%; height: 200px; object-fit: contain;">
                        <div class="card-body">
                            <h5 class="card-title">${al.nombre}</h5>
                            <p class="text-primary">S/ ${al.preciounit}</p>
                            <a href="ProductController?action=cargarid&id=${al.idProducto}" class="btn btn-dark btn-sm">Ver Producto</a>
                        </div>
                    </div>
                </div>
                </c:forEach>
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