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
            <a class="navbar-brand" href="index.jsp">
                <img src="assets/img/logo_blanco.png" alt="Logo" height="50">
            </a>
        </div>
    </nav>

    <!--Login-->
    <div class="login-container">
        <div class="login-box">
            <h3 class="text-center">Iniciar Sesión</h3>
            <form>
                <div class="form-group">
                    <label for="usuario">Correo Electrónico</label>
                    <input type="text" class="form-control" name="txtusuario" placeholder="Ingresa tu correo">
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" class="form-control" name="txtclave" placeholder="Ingresa tu contraseña">
                </div>
                <button type="submit" class="btn btn-dark btn-block" name="btn-login">Iniciar Sesión</button>
            </form>
            <div class="text-center mt-3">
                <p>¿No tienes cuenta? <a href="registro.jsp">Regí­strate aquí­</a></p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>