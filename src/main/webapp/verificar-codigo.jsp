
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutripoint - Login</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/login.css">
    </head>

    <body>   

        <!--Header-->
        <nav class="navbar navbar-light navbar-expand-lg custom-header">
            <div class="container">
                <!-- Logo -->
                <a class="navbar-brand" href="index">
                    <img src="assets/img/logo_blanco.png" alt="Logo" height="50">
                </a>
            </div>
        </nav>
        <div class="login-container">
            <div class="login-box">
                <c:if test="${not empty error}">
                    <h6 class="text-danger">${error}</h6>
                </c:if>
                <form action="UserController" method="POST">
                    <div class="form-group">
                        <label for="codigo">Código de Verificación</label>
                        <input type="text" class="form-control" id="codigo" name="codigo" placeholder="Ingresa el código que te enviamos" required>
                    </div>
                    <button type="submit" name="action" value="verifyCode" class="btn btn-dark btn-block">Verificar Código</button>
                </form>
            </div>
        </div>
    </body>
</html>
