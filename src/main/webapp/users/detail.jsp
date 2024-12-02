
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalle de Compra</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/inicio.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/assets/css/shop-cart.css" rel="stylesheet" type="text/css"/>
</head>

<body>

    <%@include file="../components/header.jsp" %>

    <div class="container mt-5">
        <c:if test="${not empty detalle}">
        <h3 class="mb-4">Detalle de Compra #${compra.idCompra}</h3>

        <div class="mb-4">
            <strong>Fecha de Compra:</strong> ${compra.fecha}<br>
            <strong>Total Pagado:</strong> S/. ${compra.total}<br>
            <strong>Estado:</strong> ${compra.estado}
        </div>

        <table class="table table-striped shadow">
            <thead class="table-dark">
                <tr>
                    <th>Id Producto</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario (S/.)</th>
                    <th>Subtotal (S/.)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="producto" items="${detalle}">
                    <tr>
                        <td>${producto.idProducto}</td>
                        <td>${producto.nombres}</td>
                        <td>${producto.cantidad}</td>
                        <td>${producto.precio}</td>
                        <td>${producto.subtotal}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </c:if>
        <c:if test="${ empty detalle}">
            <h2>No se encontró este producto</h2>
        </c:if>

        <a href="${pageContext.request.contextPath}/PurchaseController?action=history" class="btn btn-dark">Volver al Historial</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</body>
</html>
