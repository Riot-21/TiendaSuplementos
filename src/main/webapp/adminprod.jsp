<%@page import="modelo.dto.Categoria"%>
<%@page import="java.util.List"%>
<%@page import="modelo.dao.CategoriaDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form id="agregarProductoForm" enctype="multipart/form-data" action="ProductController" method="POST">
            <div class="form-group">
                <label for="product-name">Nombre del Producto:</label>
                <input type="text" class="form-control" id="product-name" name="nombrep">
            </div>
            <div class="form-group">
                <label for="product-description">Descripción del Producto:</label>
                <textarea class="form-control" id="product-description" name="descp"></textarea>
            </div>

            <div class="form-group">
                <label for="product-photos">Fotos del Producto:</label>
                <input type="file" multiple accept="image/*" class="form-control" id="product-photos" name="photos">
            </div>

            <div class="form-group">
                <label for="product-stock">Stock del producto</label>
                <input type="number" class="form-control" id="product-stock" name="stkp">
            </div>
            <div class="form-group">
                <label for="product-brand">Marca del Producto:</label>
                <input type="text" class="form-control" id="product-brand" name="marcap">
            </div>
            <div class="form-group">
                <label for="product-price">Precio del producto</label>
                <input type="number" class="form-control" id="product-price" name="preciop">
            </div>
            <div class="form-group">
                <label for="product-modeUse">Modo de empleo del producto:</label>
                <textarea class="form-control" id="product-modeUse" name="modp"></textarea>
            </div>
            <div class="form-group">
                <label for="product-warning">Advertencia:</label>
                <textarea class="form-control" id="product-warning" name="advp"></textarea>
            </div>
            <div class="form-group">
                <label for="product-cat">Categoria del Producto:</label>
                <select class="form-control" id="product-cat" name="catp" >
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

            <button type="submit" class="btn btn-primary" name="action" value="guardar">Agregar Producto</button>
        </form>
    </body>
</html>
