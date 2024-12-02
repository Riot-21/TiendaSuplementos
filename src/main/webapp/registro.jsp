<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/registro.css">
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

    <!--Registrar-->
    <div class="register-container">
        <div class="register-box">
            <h3 class="text-center">Registro</h3>
            <c:if test="${not empty error}">
                <h6 class="text-danger">${error}</h6>
            </c:if>
            <form action="UserController" method="POST">
                <div class="form-group">
                    <label for="username">Nombres</label>
                    <input type="text" class="form-control" id="username" name="nombres" placeholder="Ingresa tu nombre" required>
                </div>
                <div class="form-group">
                    <label for="lastname">Apellido</label>
                    <input type="text" class="form-control" id="lastname" name="apellidos" placeholder="Ingresa tu nombre de usuario" required>
                </div>
                <div class="form-group">
                    <label for="email">Correo Electrónico</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Ingresa tu correo" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" id="password" name="pass" placeholder="Crea una contraseña" required>
                </div>
                <div class="form-group">
                    <label for="dni">Dni</label>
                    <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingresa tu numero de DNI" maxlength="8" pattern="^\d{8}$" title="Debe contener exactamente 8 dígitos" required oninput="validarNumero(this)">
                </div>
                <div class="form-group">
                    <label for="phone">Teléfono</label>
                    <input type="text" class="form-control" id="phoone" name="telefono" placeholder="Ingresa tu teléfono" maxlength="9" pattern="^\d{9}$" title="Debe contener exactamente 9 dígitos" required oninput="validarNumero(this)">
                </div>
                <button type="submit" name="action" value="register" class="btn btn-dark btn-block">Crear Cuenta</button>
            </form>
            <div class="text-center mt-3">
                <p>¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí­</a></p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    // Función para validar que solo se ingresen números
    function validarNumero(input) {
        input.value = input.value.replace(/[^0-9]/g, ''); // Reemplaza cualquier carácter que no sea un número
    }
    </script>
</body>

</html>