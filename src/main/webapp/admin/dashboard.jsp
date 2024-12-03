<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
                
                <%@include file="../components/adminheader.jsp" %>
                
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
                                            <c:forEach var="p" items="${pvendidos}">
                                            <tr>
                                                <th>${p.idProducto}</th>
                                                <td>${p.nombre}</td>
                                                <td>${p.ventas}</td>
                                                <td>S/. ${p.preciounit}</td>
                                                <td>${p.stock}</td>
                                            </tr>
                                            </c:forEach>
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
