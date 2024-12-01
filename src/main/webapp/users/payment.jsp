<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutripoint - Pago</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="../assets/css/inicio.css" rel="stylesheet" type="text/css"/>
        <link href="../assets/css/shop-cart.css" rel="stylesheet" type="text/css"/>
        <style>
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            /* Fondo semitransparente */
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 30px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            max-width: 400px;
        }
    </style>
    </head>
    <body>
        <%@include file="../components/header.jsp" %>
                      <form action="${pageContext.request.contextPath}/PurchaseController" method="POST">  
        <div class="container mt-5">
            <div class="row">
                <!-- Columna de datos del usuario -->
                <div class="col-md-6 mb-4">
                    <div class="card shadow-sm p-4">
                        <h3 class="mb-4">Datos del Usuario</h3>

                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="nombre" value="${usuario.nombres}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="apellido" class="form-label">Apellido</label>
                                <input type="text" class="form-control" id="apellido" value="${usuario.apellidos}" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="telefono" class="form-label">Teléfono</label>
                                <input type="text" class="form-control" id="telefono" value="${usuario.telefono}" readonly>
                            </div>
                            <hr>
                            <c:if test="${metodo eq 'delivery'}">
                            <h3 class="mb-4">Datos de Envío</h3>
                            <div class="mb-3">
                                <label for="direccion" class="form-label">Dirección</label>
                                <input type="text" class="form-control" id="direccion"
                                       placeholder="Ingrese su dirección" name="direccion" required>
                            </div>
                            <div class="mb-3">
                                <label for="departamento" class="form-label">Distrito</label>
                                <input type="text" class="form-control" id="distrito"
                                       placeholder="Ingrese su distrito" name="distrito" required>
                            </div>
                            </c:if>
                        
                    </div>
                    <c:if test="${metodo eq 'recojo'}">
                    <!-- Recojo en tienda SELECCIONAR TIENDA -->
                    <div class="card shadow-sm p-4">
                        <div class="container">
                            <h3 class="mb-4">Selecciona una tienda para el recojo:</h3>
                            <div class="mb-3">
                                <label for="selectTienda" class="form-label">Selecciona una tienda</label>
                                
                                <select class="form-select" id="selectTienda" name="distrito">
                                    <c:forEach var="t" items="${tiendas}">
                                    <option value="${t.idTienda}">Tienda ${t.distrito}</option></c:forEach>
                                </select>
                                
                            </div>
                        </div>
                    </div>
                    </c:if>
                </div>
                <!-- Columna de resumen de compra -->
                <div class="col-md-6">
                    <div class="card shadow-sm p-4">
                        <h3 class="mb-4">Resumen de la Compra</h3>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between">
                                <strong>Número de Productos:</strong> <span>${contador}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <strong>Subtotal:</strong> <span>S/. ${total}</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <c:if test="${metodo eq 'recojo'}">
                                <strong>Envío:</strong> <span>No aplica</span>
                                </c:if>
                                <c:if test="${metodo eq 'delivery'}">
                                <strong>Envío:</strong> <span>S/. 10.00</span>
                                </c:if>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <c:if test="${metodo eq 'recojo'}">
                                <strong>Total:</strong> <span>S/. ${total}</span>
                                </c:if>
                                <c:if test="${metodo eq 'delivery'}">
                                <strong>Total:</strong> <span>S/. ${total+10}</span>
                                </c:if>
                            </li>
                        </ul>
                                                
                            <button class="btn btn-primary w-100 mt-4" name="action" value="buy" id="comprarBtn">Confirmar Compra</button>
                        
                    </div>
                </div>
            </div>
        </div>
                            </form>
        <!-- Modal de confirmación -->
        <div id="modalCompra" class="modal-overlay">
            <div class="modal-content">
                <h2>¡Compra realizada con éxito!</h2>
                <button  class="btn btn-primary mt-3" id="cerrarModal">Seguir Comprando</button>
            </div>
        </div>
        <%@include file="../components/footer.jsp" %>
        <!-- Script modal de confirmación -->
        <script>
            // Mostrar modal
            document.getElementById('comprarBtn').addEventListener('click', function () {
                document.getElementById('modalCompra').style.display = 'flex';
            });
            // Cerrar modal
            document.getElementById('cerrarModal').addEventListener('click', function () {
                document.getElementById('modalCompra').style.display = 'none';
                window.location.href='../index';
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
