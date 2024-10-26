<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Administrador</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>

    <body>

        <header>
            <nav class="navbar navbar-light navbar-expand-lg bg-primary shadow-sm">
                <div class="container-fluid">
                    <span class="navbar-brand mb-0 h1 text-light ms-3">Administrador</span>
                    <div class="d-flex ms-auto">
                        <a href="#" class="btn btn-outline-light" data-bs-toggle="modal"
                           data-bs-target="#SalirModal">Salir</a>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="SalirModal" tabindex="-1" aria-labelledby="SalirModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="SalirModalLabel">¿Seguro de salir?</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                <button type="button" class="btn btn-primary">Salir</button>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>

        <main>
            <div class="container mt-5">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Usuarios</h5>
                                <p class="card-text">Gestiona los usuarios del sistema.</p>
                                <form action="UserController" method="GET">
                                    <button type="submit" class="btn btn-primary">Mostrar Usuarios</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Productos</h5>
                                <p class="card-text">Gestiona los productos disponibles.</p>
                                <a href="admin-productos.jsp" class="btn btn-primary">Ir a Productos</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Añadir Productos</h5>
                                <p class="card-text">Añade nuevos productos</p>
                                <a href="admin-nuevoprod.jsp" class="btn btn-primary">Añadir Productos</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">DashBoard</h5>
                                <p class="card-text">Observa las métricas clave.</p>
                                <a href="dashboard.jsp" class="btn btn-primary">Ir a DashBoard</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Pedidos</h5>
                                <p class="card-text">Gestiona los pedidos realizados.</p>
                                <a href="pedidos.jsp" class="btn btn-primary">Ir a Pedidos</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card text-center">
                            <div class="card-body">
                                <h5 class="card-title">Administradores</h5>
                                <p class="card-text">Gestiona los usuarios administradores.</p>
                                <a href="administradores.jsp" class="btn btn-primary">Ir a Administradores</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



        </main>



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