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
                <!-- Olvidaste la Contraseña -->
                <div class="forgot-password-container">
                    <div class="forgot-password-box">
                        <h3 class="text-center">Recuperar Contraseña</h3>
                        <c:if test="${not empty error}">
                            <h6 class="text-danger">${error}</h6>
                        </c:if>
                        <form action="UserController" method="POST">
                            <div class="form-group">
                                <label for="email">Correo Electrónico</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Ingresa tu correo" required>
                            </div>
                            <button type="submit" name="action" value="sendRecoveryCode" class="btn btn-dark btn-block">Enviar Código de Verificación</button>
                        </form>
                        <div class="text-center mt-3">
                            <p>¿Recuperaste tu contraseña? <a href="login.jsp">Inicia sesión aquí­</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
