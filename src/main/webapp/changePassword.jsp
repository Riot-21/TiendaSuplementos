<%-- 
    Document   : changePassword
    Created on : 1 dic. 2024, 17:50:58
    Author     : uset
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <form action="UserController" method="POST">
            <input type="hidden" name="idUsuario" value="3">
            <label for="nuevaContrasena">Nueva Contraseña:</label>
            <input type="password" id="nuevaContrasena" name="nuevaContrasena" required>
            <label for="confirmarContrasena">Confirmar Contraseña:</label>
            <input type="password" id="confirmarContrasena" name="confirmarContrasena" required>
            <button type="submit" name="action" value="changePass">Cambiar Contraseña</button>
        </form>
    </body>
</html>
