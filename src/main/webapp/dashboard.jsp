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
                <span class="navbar-brand mb-0 h1 text-light ms-3">DashBoard</span>
                <div class="d-flex ms-auto">
                    <a href="index2.jsp" class="btn btn-outline-light me-2">Inicio</a>
                    <button class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#SalirModal">Salir</button>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="SalirModal" tabindex="-1" aria-labelledby="SalirModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="SalirModalLabel">¿Seguro de salir?</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                            <a href="inicio.jsp" class="btn btn-primary">Salir</a>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-overview-list"
                        data-bs-toggle="list" href="#list-overview" role="tab" aria-controls="overview">Información</a>
                    <a class="list-group-item list-group-item-action" id="list-reports-list" data-bs-toggle="list"
                        href="#list-reports" role="tab" aria-controls="reports">Reportes</a>
                    <a class="list-group-item list-group-item-action" id="list-analytics-list" data-bs-toggle="list"
                        href="#list-analytics" role="tab" aria-controls="analytics">Analíticas</a>
                    <a class="list-group-item list-group-item-action" id="list-export-list" data-bs-toggle="list"
                        href="#list-export" role="tab" aria-controls="export">Exportar</a>
                </div>
            </div>
            <div class="col-md-9">
                <div class="tab-content" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="list-overview" role="tabpanel"
                        aria-labelledby="list-overview-list">
                        <div class="card">
                            <div class="card-header">
                                Información General
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Bienvenido a la Información de NutriPoint</h5>
                                <p class="card-text">Aquí puedes ver un resumen de la empresa.</p>
                                <hr>
                                <p><strong>Nombre:</strong> NutriPoint</p>
                                <p><strong>RUC:</strong> 1716537341001</p>
                                <p><strong>Sede Principal:</strong> Magdalena del Mar, Lima</p>
                                <p><strong>Sector:</strong> Servicios de bienestar y mantenimiento físico</p>
                                <p><strong>Número de empleados:</strong> 235</p>
                                <p><strong>Número telefónico:</strong> 945796624</p>
                                <hr>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="list-reports" role="tabpanel" aria-labelledby="list-reports-list">
                        <div class="card">
                            <div class="card-header">
                                Reportes
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Tus reportes</h5>
                                <p class="card-text">Aquí puedes ver y gestionar tus reportes.</p>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <a href="#" class="btn btn-primary">Ver Reportes</a>
                                    <a href="#" class="btn btn-primary">Crear Reporte</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="list-analytics" role="tabpanel"
                        aria-labelledby="list-analytics-list">
                        <div class="card">
                            <div class="card-header">
                                Analíticas
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Tus analíticas</h5>
                                <p class="card-text">Aquí puedes ver y analizar tus datos.</p>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <a href="#" class="btn btn-primary">Ver Analíticas</a>
                                    <a href="#" class="btn btn-primary">Crear Analítica</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="list-export" role="tabpanel" aria-labelledby="list-export-list">
                        <div class="card">
                            <div class="card-header">
                                Exportar
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Exportar datos</h5>
                                <p class="card-text">Aquí puedes exportar tus datos.</p>
                                <hr>
                                <div class="d-flex justify-content-between">
                                    <a href="#" class="btn btn-primary">Exportar Datos</a>
                                    <a href="#" class="btn btn-primary">Exportar Reportes</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>
