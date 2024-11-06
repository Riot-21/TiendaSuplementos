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
                    <h1>DASHBOARD</h1>
                    <p>Aquí puedes ver las estadísticas principales de NutriPoint.</p>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title text-primary">Usuario Registrados</h5>
                                    <p><strong>145 usuarios registrados</strong></p>
                                    <small>+18 en la última semana</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title text-primary">Productos Disponibles</h5>
                                    <p><strong>234 prodcutos disponibles</strong></p>
                                    <small>+36 en la última semana</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title text-primary">Ventas</h5>
                                    <p><strong>2500 ventas registradas</strong></p>
                                    <small>+78 en la última semana</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-primary card-title">Productos más vendidos</h5>
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Producto</th>
                                                <th>Ventas</th>
                                                <th>Precio</th>
                                                <th>Stock</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>00167</th>
                                                <td>Proteína de suero</td>
                                                <td>1200</td>
                                                <td>$120.00</td>
                                                <td>134</td>
                                            </tr>
                                            <tr>
                                                <th>00357</th>
                                                <td>Vitaminas b12</td>
                                                <td>980</td>
                                                <td>$98.00</td>
                                                <td>198</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="text-primary card-title">Usuarios más activos</h5>
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Nombre</th>
                                                <th>DNI</th>
                                                <th>Compras</th>
                                                <th>Valor Prom.</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Jhoan Muñoz</td>
                                                <td>74640816</td>
                                                <td>65</td>
                                                <td>S/. 124</td>
                                            </tr>
                                            <tr>
                                                <td>Miguel Ruiz</td>
                                                <td>74688816</td>
                                                <td>54</td>
                                                <td>S/. 114</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>

</html>
