<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nutripoint - Login Administrador</title>
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

    <!--Login Administrador-->
    <div class="login-container">
        <div class="login-box">
            <h3 class="text-center">Administrador - Iniciar Sesión</h3>
            <form action="AdminController" method="POST">
                <div class="form-group">
                    <label for="admin-email">Correo Electrónico de Administrador</label>
                    <input type="email" class="form-control" name="email" id="admin-email" placeholder="Ingresa tu correo de administrador">
                </div>
                <div class="form-group">
                    <label for="admin-password">Contraseña</label>
                    <input type="password" class="form-control" name="passw" id="admin-password" placeholder="Ingresa tu contraseña">
                </div>
                <button type="submit" class="btn btn-danger btn-block" name="action" value="login">Iniciar Sesión</button>
            </form>
            <div class="text-center mt-3">
                <p><a href="index.jsp">Volver a la página principal</a></p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
