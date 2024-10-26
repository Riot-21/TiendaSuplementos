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

    <div class="container mt-4">
        <h2>Productos</h2>
        <p>Lista de productos.</p>
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Stock</th>
                    <th>Marca</th>
                    <th>Precio U. (S/.)</th>
                    <th>Modo Empleo</th>
                    <th>Advertencia</th>
                    <th>Opciones</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Mutant Mass - 5LB</td>
                    <td>MUTANT MASS es un excelente ganador de peso muy energético ideal para desarrollar y ganar masa
                        muscular</td>
                    <td>15</td>
                    <td>Mutant</td>
                    <td>189</td>
                    <td>Oral</td>
                    <td>Consumir una vez al día</td>
                    <td>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-danger btn-sm me-2" onclick="" data-bs-toggle="modal"
                                data-bs-target="#EliminarProductoModal">Eliminar</button>
                            <button class="btn btn-warning btn-sm" onclick="cargarDatosProducto(1, 'Mutant Mass - 5LB', 'MUTANT MASS es un excelente ganador de peso muy energético ideal para desarrollar y ganar masa muscular', 15, 'Mutant', 189, 'Oral', 'Consumir una vez al día')" data-bs-toggle="modal"
                                data-bs-target="#EditarProductoModal">Editar</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Modal Editar Producto -->
        <div class="modal fade" id="EditarProductoModal" tabindex="-1" aria-labelledby="#EditarProductoLabel"
            aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="#EditarProductoLabel">Editar Producto</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editarProductoForm">
                            <div class="form-group">
                                <label for="nombre-producto">Nombre del Producto</label>
                                <input type="text" class="form-control" id="nombre-producto" name="nombre-producto">
                            </div>
                            <div class="form-group">
                                <label for="descripcion-producto">Descripcion del Producto</label>
                                <textarea class="form-control" id="descripcion-producto"
                                    name="descripcion-producto"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="stock-producto">Stock del Producto</label>
                                <input type="number" class="form-control" id="stock-producto" name="stock-producto">
                            </div>
                            <div class="form-group">
                                <label for="marca-producto">Marca del Producto</label>
                                <input type="text" class="form-control" id="marca-producto" name="marca-producto">
                            </div>
                            <div class="form-group">
                                <label for="precio-producto">Precio del Producto (S/.)</label>
                                <input type="number" class="form-control" id="precio-producto" name="precio-producto">
                            </div>
                            <div class="form-group">
                                <label for="empleo-producto">Modo del Empleo del Producto</label>
                                <input type="text" class="form-control" id="empleo-producto" name="empleo-producto">
                            </div>
                            <div class="form-group">
                                <label for="advertencia-producto">Advertencia del Producto</label>
                                <textarea class="form-control" id="advertencia-producto"
                                    name="advertencia-producto"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="imagen-producto">Imagen del Producto</label>
                                <input type="file" class="form-control" id="imagen-producto" name="imagen-producto"
                                    accept="image/*">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-success">Confirmar</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    <script>
        function cargarDatosProducto(id, nombre, descripcion, stock, marca, precio, empleo, advertencia) {
            document.getElementById('nombre-producto').value = nombre;
            document.getElementById('descripcion-producto').value = descripcion;
            document.getElementById('stock-producto').value = stock;
            document.getElementById('marca-producto').value = marca;
            document.getElementById('precio-producto').value = precio;
            document.getElementById('empleo-producto').value = empleo;
            document.getElementById('advertencia-producto').value = advertencia;
        }
    </script>
</body>

</html>

