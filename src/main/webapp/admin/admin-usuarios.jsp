<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar p-3">
                    <div class="position-sticky d-flex flex-column align-items-center">
                        <img src="assets/img/usuario.avif" alt="Admin" class="profile-img">
                        <div class="sidebar-heading">Administrador</div>
                        <ul class="nav flex-column mt-3 w-100">
                            <li class="nav-item p-2">
                                <a class="nav-link active text-white" href="dashboard.jsp">
                                    <i class="fa-solid fa-house me-2"></i>Dashboard
                                </a>
                            </li>
                            <li class="nav-item p-2">
                                <form action="${pageContext.request.contextPath}/UserController" method="GET">
                                    <button type="submit" class="nav-link text-white">
                                        <i class="fas fa-users me-2"></i>Usuarios</button>
                                </form>
                            </li>
                            <li class="nav-item p-2">
                                <form action="${pageContext.request.contextPath}/ProductController" method="GET">
                                    <button type="submit" class="nav-link text-white" name="action" value="cargartodo">
                                        <i class="fas fa-boxes me-2"></i>Productos</button>
                                </form>
                            </li>
                            <li class="nav-item p-2">
                                <a class="nav-link text-white" href="admin-nuevoprod.jsp">
                                    <i class="fa-solid fa-plus me-2"></i>Nuevo Producto
                                </a>
                            </li>
                            <li class="nav-item p-2">
                                <a class="nav-link text-white" href="pedidos.jsp">
                                    <i class="fa-solid fa-cart-shopping me-2"></i>Pedidos
                                </a>
                            </li>
                            <li class="nav-item p-2">
                                <form action="${pageContext.request.contextPath}/AdminController" method="GET">
                                    <button type="submit" class="nav-link text-white">
                                        <i class="fas fa-user me-2"></i>Administradores</button>
                                </form>
                            </li>
                            <li class="nav-item p-2">
                                <form action="${pageContext.request.contextPath}/AdminController" method="POST">
                                    <button type="submit" class="nav-link text-white" name="action" value="logout"><i class="fas fa-sign-out-alt me-2"></i>Salir</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </nav>
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-1">

                    <div class="container mt-4">
                        <h2>Usuarios</h2>
                        <p>Lista de usuarios en la plataforma.</p>
                        <form action="${pageContext.request.contextPath}/UserController" method="GET">
                            <button type="submit" class="btn btn-primary">Recargar</button>
                        </form>
                        <hr>
                        <!-- Tabla de usuarios -->
                        <table class="table table-striped table-bordered mt-3">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Apellidos</th>
                                    <th>Email</th>
                                    <th>DNI</th>
                                    <th>Telefono</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="usu" items="${sessionScope.listaUsuarios}">
                                    <tr>
                                        <td>${usu.idUsuario}</td>
                                        <td>${usu.nombres}</td>
                                        <td>${usu.apellidos}</td>
                                        <td>${usu.email}</td>
                                        <td>${usu.dni}</td>
                                        <td>${usu.telefono}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/SvEliminar" method="POST">
                                                <input type="hidden" name="idUsuario" value="${usu.idUsuario}" />
                                                <button type="submit" class="btn btn-danger btn-sm">Eliminar</button> 
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
                integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
                integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
        crossorigin="anonymous"></script>
    </body>
</html>
