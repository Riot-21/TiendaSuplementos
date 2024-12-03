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
        <!-- Encabezado con saludo -->
        <div class="row mb-4">
            <div class="col-12">
                <h2>¡Hola, ${sessionScope.usuario.nombres}!</h2>
                <p>Bienvenido a tu perfil.</p>
            </div>
        </div>

        <!-- Datos del usuario -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Información Personal</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Nombre: </strong>${sessionScope.usuario.nombres} ${sessionScope.usuario.apellidos}</p>
                        <p><strong>Correo Electrónico: </strong>${sessionScope.usuario.email}</p>
                        <p><strong>Teléfono: </strong>${sessionScope.usuario.telefono}</p>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
