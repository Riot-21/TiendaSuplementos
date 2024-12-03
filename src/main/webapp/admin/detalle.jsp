<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />
<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .sidebar {
                height: 100vh;
            }

            .profile-img {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                margin-bottom: 10px;
            }

            .sidebar-heading {
                text-align: center;
                color: #ffffff;
                font-weight: bold;
                font-size: 1.2rem;
                margin-top: 10px;
            }

            .nav-link:hover {
                background-color: #343a40;
            }
        </style>
    </head>

    <body>
        <div class="container mt-5">
            <c:if test="${not empty deta}">
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
                        <c:forEach var="producto" items="${deta}">
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
            <c:if test="${empty deta}">
                <h2>No se encontró este producto</h2>
            </c:if>

            <div class="d-flex justify-content-end">
                <a href="${pageContext.request.contextPath}/AdminController?action=pedidos" class="btn btn-dark">Volver al Historial</a>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
