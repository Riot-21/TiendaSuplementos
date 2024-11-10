<%@page import="modelo.dto.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dao.CategoriaDao"%>
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
                    <div class="container mt-2 col-md-5">
                        <h2>Agregar Producto</h2>
                        <form id="editarProductoForm mt-4" enctype="multipart/form-data" action="${pageContext.request.contextPath}/ProductController" method="POST">
                            <!--Nombre-->
                            <div class="form-group">
                                <label for="product-name">Nombre del Producto</label>
                                <input type="text" class="form-control" id="product-name" name="nombrep">
                            </div>
                            <!--Descripcion-->
                            <div class="form-group">
                                <label for="product-description">Descripcion del Producto</label>
                                <textarea class="form-control" id="product-description" name="descp"></textarea>
                            </div>
                            <!--Stock-->
                            <div class="form-group">
                                <label for="product-stock">Stock del Producto</label>
                                <input type="number" class="form-control" id="product-stock" name="stkp">
                            </div>
                            <!--Marca-->
                            <div class="form-group">
                                <label for="product-brand">Marca del Producto</label>
                                <input type="text" class="form-control" id="product-brand" name="marcap">
                            </div>
                            <!--Precio-->
                            <div class="form-group">
                                <label for="product-price">Precio del Producto (S/.)</label>
                                <input type="number" class="form-control" id="product-price" name="preciop">
                            </div>
                            <!--Modo de Empleo-->
                            <div class="form-group">
                                <label for="product-modeUse">Modo del Empleo del Producto</label>
                                <textarea class="form-control" id="product-modeUse" name="modp"></textarea>
                            </div>
                            <!--Advertencia-->
                            <div class="form-group">
                                <label for="product-warning">Advertencia del Producto</label>
                                <textarea class="form-control" id="product-warning" name="advp"></textarea>
                            </div>
                            <!-- Imagen -->
                            <div class="form-group">
                                <label for="product-photos">Imagen del Producto</label>
                                <input type="file" multiple accept="image/*" class="form-control" id="product-photos" name="photos">
                            </div>
                            <!-- Categorias -->
                            <div class="form-group">
                                <label for="product-cat">Categoria del Producto:</label>
                                <select class="form-control" id="product-cat" name="catp[]" multiple>
                                    <%
                                        CategoriaDao catedao = new CategoriaDao();
                                        List<Categoria> categorias = null;
                                        categorias = catedao.getAllCategorias();
                                        if (categorias == null || categorias.isEmpty()) {%>
                                    <tr>
                                        <td colspan = "9" > No se encontraron reclamaciones con estado de respuesta.</td> </tr>

                                    <% } else {
                                        for (Categoria cat : categorias) {
                                    %>
                                    <option value="<%= cat.getIdCategoria()%>"><%= cat.getCategoria()%></option>
                                    <% }
                                }%>  
                                </select>
                            </div>
                            <div class="container mt-2 col-md-5 mx-auto">
                                <button type="submit" class="btn btn-success" name="action" value="guardar">Agregar</button>
                            </div>
                        </form>

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