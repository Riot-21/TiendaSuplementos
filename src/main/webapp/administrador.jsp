<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dto.Categoria"%>
<%@page import="modelo.dao.CategoriaDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Administrador - eLearning</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .content-section {
                display: none;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <div class="bg-dark text-white p-3" style="width: 200px; height: 100vh;">
                <h2 class="text-center">Admin</h2>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" onclick="showSection('dashboard')">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" onclick="showSection('usuarios')">Usuarios</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" onclick="showSection('agregar-producto')" data-toggle="modal" data-target="#agregarProductoModal">Agregar Producto</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" onclick="showSection('editar-producto')">Editar Producto</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" onclick="cerrarSesion()">Cerrar Sesión</a>
                    </li>
                </ul>
            </div>

            <div class="flex-grow-1 p-3">
                <section id="dashboard" class="content-section">
                    <h2>Dashboard</h2>
                    <p>Aquí puedes ver las métricas del sitio.</p>
                    <!-- Simulación de métricas -->
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card text-white bg-primary mb-3">
                                <div class="card-header">Prodcutos</div>
                                <div class="card-body">
                                    <h5 class="card-title">150</h5>
                                    <p class="card-text">Total de productos disponibles.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card text-white bg-success mb-3">
                                <div class="card-header">Usuarios</div>
                                <div class="card-body">
                                    <h5 class="card-title">1200</h5>
                                    <p class="card-text">Total de usuarios registrados.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card text-white bg-warning mb-3">
                                <div class="card-header">Compras</div>
                                <div class="card-body">
                                    <h5 class="card-title">3000</h5>
                                    <p class="card-text">Total de compras en el ultimo mes.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="usuarios" class="content-section">
                    <h2>Usuarios</h2>
                    <p>Lista de clientes registrados.</p>
                    <!-- Simulación de lista de usuarios -->
                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark"></thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>Telefono</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Juan Pérez</td>
                                <td>juan.perez@example.com</td>
                                <td>940576983</td>
                                <td>
                                    <button class="btn btn-danger btn-sm" onclick="eliminarUsuario(1)">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>María López</td>
                                <td>maria.lopez@example.com</td>
                                <td>987456362</td>
                                <td>
                                    <button class="btn btn-danger btn-sm" onclick="eliminarUsuario(2)">Eliminar</button>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Carlos García</td>
                                <td>carlos.garcia@example.com</td>
                                <td>987456362</td>
                                <td>
                                    <button class="btn btn-danger btn-sm" onclick="eliminarUsuario(3)">Eliminar</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <c:if test="${not empty categorias}">
                        <p>Categorías cargadas correctamente: ${categorias.size()}</p>
                    </c:if>
                    <c:if test="${empty categorias}">
                        <p>No se cargaron categorías.</p>
                    </c:if>

                </section>

                <script>
                    function eliminarUsuario(userId) {

                        alert('Usuario ' + userId + ' eliminado');
                    }
                </script>
                <section id="editar-producto" class="content-section">
                    <h2>Editar Producto</h2>
                    <p>Selecciona un producto para editar.</p>

                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Producto</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Vitaminas</td>
                                <td><button class="btn btn-primary" data-toggle="modal" data-target="#editarProductoModal">Editar</button></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Proteínas</td>
                                <td><button class="btn btn-primary" data-toggle="modal" data-target="#editarProductoModal">Editar</button></td>
                            </tr>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>

        <!-- Modal para agregar producto -->
        <div class="modal fade" id="agregarProductoModal" tabindex="-1" aria-labelledby="agregarProductoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="agregarProductoModalLabel">Agregar Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="agregarProductoForm" enctype="multipart/form-data" action="ProductController" method="POST">
                            <div class="form-group">
                                <label for="product-name">Nombre del Producto:</label>
                                <input type="text" class="form-control" id="product-name" name="product-name">
                            </div>
                            <div class="form-group">
                                <label for="product-description">Descripción del Producto:</label>
                                <textarea class="form-control" id="product-description" name="product-description"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="product-photos">Fotos del Producto:</label>
                                <input type="file" multiple accept="image/*" class="form-control" id="product-photos" name="photos">
                            </div>
                            <div class="form-group">
                                <label for="product-stock">Stock del producto</label>
                                <input type="number" class="form-control" id="product-stock" name="product-stock">
                            </div>
                            <div class="form-group">
                                <label for="product-brand">Marca del Producto:</label>
                                <input type="text" class="form-control" id="product-brand" name="product-brand">
                            </div>
                            <div class="form-group">
                                <label for="product-price">Precio del producto</label>
                                <input type="number" class="form-control" id="product-price" name="product-price">
                            </div>
                            <div class="form-group">
                                <label for="product-modeUse">Modo de empleo del producto:</label>
                                <textarea class="form-control" id="product-modeUse" name="product-modeUse"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="product-warning">Advertencia:</label>
                                <textarea class="form-control" id="product-warning" name="product-warning"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="product-cat">Categoria del Producto:</label>
                                <select class="form-control" id="product-cat" name="product-cat" multiple>
                            <%
                                CategoriaDao catedao = new CategoriaDao();
                                List<Categoria> categorias = null;
                                categorias = catedao.getAllCategorias();
                                if (categorias == null || categorias.isEmpty()) {%>
                                    <tr>
         <td colspan = "9" > No se encontraron reclamaciones con estado de respuesta.</td> </tr>
                                
                            <% }else{
for(Categoria cat: categorias){                              
                            %>
                            
                                    
                                    <option value="<%= cat.getIdCategoria() %>"><%= cat.getCategoria() %></option>
                                    
                                
                            
                            <% }} %>  
                            </select>
                            </div>

                            <button type="submit" class="btn btn-primary">Agregar Producto</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
        <!-- Botón para abrir el modal de nueva categoría -->
        <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#nuevaCategoriaModal">Nueva Categoría</button>

        <!-- Modal para nueva categoría -->
        <div class="modal fade" id="nuevaCategoriaModal" tabindex="-1" aria-labelledby="nuevaCategoriaModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="nuevaCategoriaModalLabel">Nueva Categoría</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="nuevaCategoriaForm" action="CategoryController" method="POST">
                            <div class="form-group">
                                <label for="categoria-nombre">Nombre de la Categoría:</label>
                                <input type="text" class="form-control" id="categoria-nombre" name="categoria-nombre">
                            </div>
                            <div class="form-group">
                                <label for="categoria-nombre">Objetivo de la Categoría:</label>
                                <textarea class="form-control" id="categoria-obj" name="categoria-obj"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar Categoría</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal para editar Producto -->
        <div class="modal fade" id="editarProductoModal" tabindex="-1" aria-labelledby="editarProductoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editarProductoModalLabel">Editar Producto</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="agregarProductoForm">
                            <div class="form-group">
                                <label for="edit-product-name">Nombre del Producto:</label>
                                <input type="text" class="form-control" id="edit-product-name" name="edit-product-name">
                            </div>
                            <div class="form-group">
                                <label for="edit-product-description">Descripción del Producto:</label>
                                <textarea class="form-control" id="edit-product-description" name="edit-product-description"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="edit-product-stock">Stock del producto</label>
                                <input type="number" class="form-control" id="edit-product-stock" name="edit-product-stock">
                            </div>
                            <div class="form-group">
                                <label for="edit-product-brand">Marca del Producto:</label>
                                <input type="text" class="form-control" id="edit-product-brand" name="edit-product-brand">
                            </div>
                            <div class="form-group">
                                <label for="edit-product-price">Precio del producto</label>
                                <input type="number" class="form-control" id="edit-product-price" name="edit-product-price">
                            </div>
                            <div class="form-group">
                                <label for="edit-product-modeUse">Modo de empleo del producto:</label>
                                <textarea class="form-control" id="edit-product-modeUse" name="edit-product-modeUse"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="edit-product-warning">Advertencia:</label>
                                <textarea class="form-control" id="edit-product-warning" name="edit-product-warning"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="edit-product-cat">Categoria del Producto:</label>
                                <select class="form-control" id="edit-product-cat" name="edit-product-cat">
                                    <option>Vitaminas</option>
                                    <option>Proteínas</option>
                                    <option>Energizantes</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Agregar Producto</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
                        function showSection(sectionId) {
                            document.querySelectorAll('.content-section').forEach(section => {
                                section.style.display = 'none';
                            });
                            document.getElementById(sectionId).style.display = 'block';
                        }

                        function cerrarSesion() {
                            // Aquí puedes agregar la lógica para cerrar sesión
                            alert('Sesión cerrada');
                        }

                        // Mostrar el dashboard por defecto
                        showSection('dashboard');
        </script>
    </body>
</html>