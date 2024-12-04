<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />
<!doctype html>
<html lang="es">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Datos de la Empresa</title>
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
                <%@ include file="../components/adminheader.jsp" %>
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 mt-1">
                    <h1 class="text-center">Datos de la Empresa</h1>

                    <!-- Formulario de la empresa -->
                    <form action="empresa" method="POST" onsubmit="return validarFormulario()">
                        <input type="hidden" name="idEmpresa" value="${datos.idEmpresa}">
                        <div class="row">
                            <div class="col-md-6 offset-md-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" value="${datos.nombre}"
                                                   <c:if test="${administrador.idAdmin != 1}">readonly</c:if>>
                                            </div>
                                            <div class="mb-3">
                                                <label for="ruc" class="form-label">RUC</label>
                                                <input type="text" class="form-control" id="ruc" name="ruc" value="${datos.ruc}"
                                                   <c:if test="${administrador.idAdmin != 1}">readonly</c:if>>
                                                   <!-- Aquí se muestra el mensaje de error si no es válido -->
                                                   <span id="errorRuc" class="text-danger"></span>
                                            </div>
                                            <div class="mb-3">
                                                <label for="razonSocial" class="form-label">Razón Social</label>
                                                <input type="text" class="form-control" id="razonSocial" name="razonSocial" value="${datos.razonSocial}"
                                                   <c:if test="${administrador.idAdmin != 1}">readonly</c:if>>
                                            </div>

                                            <!-- Si es el administrador principal (idEmpresa == 1), el botón de enviar se habilita -->
                                        <c:if test="${administrador.idAdmin == 1}">
                                            <button type="submit" class="btn btn-primary">Actualizar Empresa</button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Si no es el administrador principal, mostramos un mensaje que los campos son solo lectura -->
                    <c:if test="${administrador.idAdmin != 1}">
                        <div class="text-center mt-4">
                            <p class="alert alert-info">Los datos de la empresa son solo lectura para este usuario.</p>
                        </div>
                    </c:if>

                </main>
            </div>
        </div>
        <script>
            // Función de validación para el formulario
            function validarFormulario() {
                // Obtener el valor del campo RUC
                var ruc = document.getElementById("ruc").value;
                var mensajeError = "";

                // Validación de RUC (debe ser un número de exactamente 11 dígitos)
                var rucRegex = /^\d{11}$/;

                if (!rucRegex.test(ruc)) {
                    mensajeError = "El RUC debe ser un número de exactamente 11 dígitos.";
                }

                // Si hay un mensaje de error, lo mostramos y prevenimos el envío del formulario
                if (mensajeError !== "") {
                    document.getElementById("errorRuc").innerText = mensajeError;
                    ruc.value = '';
                    return false; // Prevenir el envío del formulario
                } else {
                    // Si no hay errores, aseguramos que el campo de error esté vacío
                    document.getElementById("errorRuc").innerText = "";
                    return true; // Permitir el envío del formulario
                }
            }
        </script>
    </body>
</html>
