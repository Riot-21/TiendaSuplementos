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

                <%@include file="../components/adminheader.jsp" %>
                
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-1">
                    <div class="container mt-4">
                        <h2>Pedidos</h2>
                        <p>Lista de pedidos.</p>
                        <table class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Fecha</th>
                                    <th>Cliente</th>
                                    <th>Estado</th>
                                    <th>Productos</th>
                                    <th>Total (S/.)</th>
                                    <th>Opciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>2021-12-01</td>
                                    <td>Juan Pérez</td>
                                    <td>Enviado</td>
                                    <td>Producto 1, Producto 2</td>
                                    <td>100.00</td>
                                    <td>
                                        <a href="#" class="btn btn-primary">Ver</a>
                                        <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editarModal" onclick="cargarDatos(1, '2021-12-01', 'Juan Pérez', 'Enviado', 'Producto 1, Producto 2', 100.00)">Editar</a>
                                        <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#eliminarModal" onclick="confirmarEliminacion(1)">Eliminar</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>2021-12-02</td>
                                    <td>Maria López</td>
                                    <td>Enviado</td>
                                    <td>Producto 3, Producto 4</td>
                                    <td>200.00</td>
                                    <td>
                                        <a href="#" class="btn btn-primary">Ver</a>
                                        <a href="#" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editarModal" onclick="cargarDatos(2, '2021-12-02', 'Maria López', 'Enviado', 'Producto 3, Producto 4', 200.00)">Editar</a>
                                        <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#eliminarModal" onclick="confirmarEliminacion(2)">Eliminar</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </main>

                <!-- Modal de Editar Pedido -->
                <div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="editarModalLabel">Editar Pedido</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="formEditarPedido">
                                    <input type="hidden" id="editarId">
                                    <div class="mb-3">
                                        <label for="editarFecha" class="form-label">Fecha</label>
                                        <input type="date" class="form-control" id="editarFecha" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editarCliente" class="form-label">Cliente</label>
                                        <input type="text" class="form-control" id="editarCliente" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editarEstado" class="form-label">Estado</label>
                                        <input type="text" class="form-control" id="editarEstado" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editarProductos" class="form-label">Productos</label>
                                        <input type="text" class="form-control" id="editarProductos" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="editarTotal" class="form-label">Total (S/.)</label>
                                        <input type="number" step="0.01" class="form-control" id="editarTotal" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Guardar cambios</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal de Confirmación de Eliminación -->
                <div class="modal fade" id="eliminarModal" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="eliminarModalLabel">Confirmar Eliminación</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>¿Estás seguro de que deseas eliminar este pedido?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-danger" onclick="eliminarPedido()">Eliminar</button>
                            </div>
                        </div>
                    </div>
                </div>
                </main>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <script>
                                    let pedidoIdAEliminar;

                                    function cargarDatos(id, fecha, cliente, estado, productos, total) {
                                        document.getElementById('editarId').value = id;
                                        document.getElementById('editarFecha').value = fecha;
                                        document.getElementById('editarCliente').value = cliente;
                                        document.getElementById('editarEstado').value = estado;
                                        document.getElementById('editarProductos').value = productos;
                                        document.getElementById('editarTotal').value = total;
                                    }

                                    function confirmarEliminacion(id) {
                                        pedidoIdAEliminar = id;
                                    }

                                    function eliminarPedido() {
                                        console.log(`Pedido eliminado: ID=${pedidoIdAEliminar}`);
                                        // Aquí puedes agregar el código para eliminar el pedido en tu sistema.

                                        // Cerrar el modal de eliminación
                                        const eliminarModal = document.getElementById('eliminarModal');
                                        const modal = bootstrap.Modal.getInstance(eliminarModal);
                                        modal.hide();
                                    }
        </script>
    </body>

</html>

