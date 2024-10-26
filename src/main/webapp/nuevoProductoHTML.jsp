<!doctype html>
<html lang="en">

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
                <span class="navbar-brand mb-0 h1 text-light ms-3">Administradores</span>
                <div class="d-flex ms-auto">
                    <a href="index.jsp" class="btn btn-outline-light me-2">Inicio</a>
                    <button class="btn btn-outline-light" data-bs-toggle="modal" data-bs-target="#SalirModal">Salir</button>
                </div>
            </div>
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
    <main>
        <div class="container mt-2 col-md-5">
            <h2>Agregar Producto</h2>
            <form id="editarProductoForm mt-4">
                <!--Nombre-->
                <div class="form-group">
                    <label for="nombre-producto">Nombre del Producto</label>
                    <input type="text" class="form-control" id="nombre-producto" name="nombre-producto">
                </div>
                <!--Descripcion-->
                <div class="form-group">
                    <label for="descripcion-producto">Descripcion del Producto</label>
                    <textarea class="form-control" id="descripcion-producto" name="descripcion-producto"></textarea>
                </div>
                <!--Stock-->
                <div class="form-group">
                    <label for="stock-producto">Stock del Producto</label>
                    <input type="number" class="form-control" id="stock-producto" name="stock-producto">
                </div>
                <!--Marca-->
                <div class="form-group">
                    <label for="marca-producto">Marca del Producto</label>
                    <input type="text" class="form-control" id="marca-producto" name="marca-producto">
                </div>
                <!--Precio-->
                <div class="form-group">
                    <label for="precio-producto">Precio del Producto (S/.)</label>
                    <input type="number" class="form-control" id="precio-producto" name="precio-producto">
                </div>
                <!--Modo de Empleo-->
                <div class="form-group">
                    <label for="empleo-producto">Modo del Empleo del Producto</label>
                    <input type="text" class="form-control" id="empleo-producto" name="empleo-producto">
                </div>
                <!--Advertencia-->
                <div class="form-group">
                    <label for="advertencia">Advertencia del Producto</label>
                    <textarea class="form-control" id="advertencia-producto" name="advertencia-producto"></textarea>
                </div>
                <!-- Imagen -->
                <div class="form-group">
                    <label for="imagen-producto">Imagen del Producto</label>
                    <input type="file" class="form-control" id="imagen-producto" name="imagen-producto"
                        accept="image/*">
                </div>
            </form>
            <div class="container mt-2 col-md-5 mx-auto">
                <button type="button" class="btn btn-success">Agregar</button>
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