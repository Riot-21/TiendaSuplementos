<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Carrito</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="../assets/css/inicio.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/shop-cart.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <%@include file="../components/header.jsp" %>

        <div class="container mt-5">
            <h3 class="mb-4">Carrito: ${contador} producto(s)</h3>
            <div class="container mb-4 bg-dark p-2 rounded shadow">
                <h5 class="text-center text-light">¡Paga de forma segura en nuestra tienda!</h5>
            </div>

            <div class="row align-items-start">
                <!-- Sección de productos -->
                <div class="col-md-8">
                    <!-- Producto 1 -->
                    <c:forEach var="c" items="${carrito}">
                        <div class="container mb-3 shadow">
                            <div class="row border rounded p-3 align-items-center">

                                <div class="col-md-3">
                                    <img src="../${c.imagen}" alt="${c.nombres}" class="img-fluid rounded">
                                </div>
                                <div class="col-md-8">
                                    <div class="card h-100 border-0">
                                        <div class="card-body d-flex flex-column justify-content-center">
                                            <h5 class="card-title">${c.nombres}</h5>
                                            <p class="card-text">${c.descripcion}</p>
                                            <p class="card-text"><strong>Precio:</strong> S/. ${c.precio}</p>
                                            <p class="card-text"><strong>Cantidad:</strong> ${c.cantidad}</p>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <form action="${pageContext.request.contextPath}/ProductController" method="POST">
                                                        <input type="hidden" name="id" value="${c.idProducto}">
                                                        <button name="action" value="deleteFromCart" class="btn btn-danger mt-auto" >Eliminar</button>
                                                    </form>
                                                </div>                         
                                                <div class="col-md-6">
                                                    <a href="${pageContext.request.contextPath}/ProductController?action=cargarid&id=${c.idProducto}" class="btn btn-dark mt-auto">Ver Producto</a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>

                <!-- Sección de detalles de la compra -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title text-center mb-4">Detalles de la Compra</h5>
                            <p class="card-text"><strong>Subtotal: ${contador} producto(s)</strong> S/. ${total}</p>
                            <p class="card-text"><strong>Envío:</strong> S/. 15.00</p>
                            <hr>
                            <p class="card-text fs-5"><strong>Total:</strong> S/. ${total+15}</p>
                            <!-- Método de pago -->
                            <form action="${pageContext.request.contextPath}/PurchaseController" method="POST">
                                <div class="mb-3">
                                    <label for="metodoPago" class="form-label"><strong>Método de Entrega:</strong></label>

                                    <select id="metodoPago" class="form-select" name="metodo">                                          <option value="delivery" selected>Envío a domicilio</option>
                                        <option value="recojo">Recojo en Tienda</option>
                                    </select>

                                </div>
                                <button name="action" value="payment" class="btn btn-dark w-100">Proceder al Pago</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>

</html>
