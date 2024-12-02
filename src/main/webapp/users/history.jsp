<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Historial de Compras</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="${pageContext.request.contextPath}/assets/css/inicio.css" rel="stylesheet" type="text/css"/>
        <link href="${pageContext.request.contextPath}/assets/css/shop-cart.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <%@include file="../components/header.jsp" %>

        <div class="container mt-5">
            <h3 class="mb-4">Historial de Compras</h3>
            <c:if test="${not empty historial}">

            <table class="table table-striped shadow">
                <thead class="table-dark">
                    <tr>
                        <th>ID Compra</th>
                        <th>Fecha</th>
                        <th>Total (S/.)</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="compra" items="${historial}">
                        <tr>
                            <td>${compra.idCompra}</td>
                            <td>${compra.fecha}</td>
                            <td>${compra.total}</td>
                            <td>${compra.estado}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/PurchaseController?action=detail&id=${compra.idCompra}" class="btn btn-dark btn-sm">
                                    Ver Detalle
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
                </c:if>
            <c:if test="${empty historial}">
                <h2>Aún no ha realizado una compra</h2>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
