<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />
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

        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }

        .btn-action {
            width: 100%;
        }

        .form-control {
            min-width: 150px;
        }

        .option-btns {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .option-btns .btn {
            margin: 0 5px;
        }

        .modal-btn {
            width: 100%;
        }

        .btn-warning, .btn-info {
            width: 100%;
        }

        .form-select {
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <%@ include file="../components/adminheader.jsp" %>
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-1">
                <h2>Pedidos</h2>
                <c:if test="${empty pedidos}">
                    <h4 class="text-danger">No hay pedidos registrados</h4>
                </c:if>
                <c:if test="${not empty pedidos}">
                    <p>Lista de pedidos.</p>

                    <table class="table table-striped table-bordered" id="tabla-pedidos">
                        <thead class="thead-dark">
                            <tr>
                                <th>Id Compra</th>
                                <th>Id Cliente</th>
                                <th>Fecha</th>
                                <th>Total (S/.)</th>
                                <th>Estado</th>
                                <th>Opciones</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="pedido" items="${pedidos}">
                                <tr>
                                    <td>${pedido.idCompra}</td>
                                    <td>${pedido.idUsuario}</td>
                                    <td>${pedido.fecha}</td>
                                    <td><fmt:formatNumber value="${pedido.total}" minFractionDigits="2" maxFractionDigits="2" var="total" /> ${total}</td>
                                    <td>${pedido.estado}</td>
                                    <td>
                                        <!-- Formulario para actualizar el estado -->
                                        <form action="${pageContext.request.contextPath}/AdminController" method="POST">
                                            <input type="hidden" name="id" value="${pedido.idCompra}">
                                            <select class="form-control form-select" id="estado-pedido-${pedido.idCompra}" name="estado-pedido">
                                                <option value="Pendiente" ${pedido.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                                                <option value="Entregado" ${pedido.estado == 'Entregado' ? 'selected' : ''}>Entregado</option>
                                                <option value="Cancelado" ${pedido.estado == 'Cancelado' ? 'selected' : ''}>Cancelado</option>
                                            </select>
                                            <button type="submit" class="btn btn-warning btn-sm mt-2" name="action" value="update">Actualizar Estado</button>
                                        </form>

                                        <div class="option-btns mt-3">
                                            <a href="${pageContext.request.contextPath}/AdminController?action=detail&id=${pedido.idCompra}" class="btn btn-info btn-sm">Ver detalles</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>

                    <div class="d-flex justify-content-end mb-3">
                        <form action="${pageContext.request.contextPath}/PedidoController" method="GET">
                            <button type="submit" class="btn btn-success" name="action" value="exportarExcel">
                                <i class="fas fa-file-excel"></i> Exportar a Excel
                            </button>
                        </form>
                    </div>

                </c:if>

            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

</body>

</html>


