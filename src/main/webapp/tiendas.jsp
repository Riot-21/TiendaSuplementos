<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <c:forEach var="t" items="${shop}">
            <!-- Tienda 1 -->
            <div class="col-lg-4 col-md-6">
                <div class="store-card bg-white">
                    <img src="${t.foto}" class="store-img" alt="Tienda 1">
                    <div class="store-info">
                        <h5 class="text-primary">Tienda - ${t.distrito}</h5>
                        <p><i class="fa fa-map-marker me-2"></i>${t.direccion}</p>
                        <p><i class="fa fa-phone me-2"></i>+51 ${t.telefono}</p>
                        <p><i class="fa fa-clock me-2"></i>Horario: ${t.horario}</p>
                    </div>
                </div>
            </div>
            </c:forEach>

        </div>
    </div>

    <%@include file="components/footer.jsp"%>
    
    <script src="assets/script/cart-shopping.js"></script>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>