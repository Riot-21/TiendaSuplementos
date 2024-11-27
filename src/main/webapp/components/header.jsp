<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true"%>
<!-- Header -->
<nav class="navbar navbar-light navbar-expand-lg custom-header">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand" href="index.jsp">
            <img src="assets/img/logo_blanco.png" alt="Logo" height="50">
        </a>
        <!-- Menu Responsivo -->
        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarContent" aria-controls="navbarContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- Contenido -->
        <div class="collapse navbar-collapse" id="navbarContent">
            <!-- Enlaces -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <form action="${pageContext.request.contextPath}/ProductController" method="GET">
                        <button type="submit" name="action" value="tienda" class="nav-link text-white">Tienda</button>
                    </form>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="nosotros.jsp">Nosotros</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white" href="tiendas.jsp">Locales</a>
                </li>
            </ul>
            <!-- Buscar -->
            <form class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Buscar" aria-label="Search">
                <button class="btn btn-outline-light" type="button"><i class="fa fa-search"></i></button>
            </form>


            <!-- Contenedor del ícono de usuario y el menú desplegable -->
            <c:if test="${not empty sessionScope.usuario}">
                <div class="dropdown">
                    <!-- Ícono de usuario con menú desplegable -->
                    <a class="nav-icon text-white ms-3" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false" role="button">
                        <i class="fa fa-user fa-lg"></i>
                    </a>

                    <!-- Menú desplegable -->
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuLink">
                        <li><a class="dropdown-item" href="#">Ver Perfil</a></li>
                        <li><a class="dropdown-item" href="#">Configuración</a></li>
                        <li>
                            <form action="${pageContext.request.contextPath}/UserController" method="post">
                                <button type="submit" name="action" value="logout" class="dropdown-item">Cerrar Sesión</button>
                            </form>
                        </li>
                    </ul>
                </div>
            </c:if>

            <!-- Mostrar solo el ícono de usuario para redireccionar al login si no hay sesión activa -->
            <c:if test="${empty sessionScope.usuario}">
                <a class="nav-icon text-white ms-3" href="login.jsp">
                    <i class="fa fa-user fa-lg"></i>
                </a>
            </c:if>


            <!-- Icono Carrito -->
            <button class="btn nav-icon text-white ms-3" id="cart-icon" onclick="toggleCart()">
                <i class="fa fa-cart-shopping fa-lg"><label>${contador}</label> </i>
            </button>

            <!-- Carrito de compras -->
            <div id="cart" class="cart-container">
                <div class="cart-header">
                    <h5>Carrito de Compras</h5>
                    <button class="close-cart" onclick="toggleCart()">&#10006;</button>
                </div>

                <div class="cart-body">
                    <!-- Lista de productos -->
                    <c:if test="${not empty carrito}">
                        <div id="cart-items">
                            <c:forEach var="cart" items="${carrito}">      
                                <div class="cart-item">
                                    <img src="${cart.imagen}" alt="Proteína Whey" class="cart-item-image">
                                    <div class="cart-item-details">
                                        <h6>${cart.nombres}</h6>
                                        <p>Cantidad: <span class="cart-item-quantity">${cart.cantidad}</span></p>
                                        <p>Precio: S/.<span class="cart-item-price">${cart.precio}</span></p>
                                        <p>Subtotal: S/.<span class="cart-item-price">${cart.subtotal}</span></p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="cart-footer">
                        <h5>Total: S/.<span id="cart-total"></span>${total}</h5>
                        <form action="${pageContext.request.contextPath}/PurchaseController" method="POST">
                            <input type="hidden" name="direccion" value="pruebadireccion">
                            <input type="hidden" name="distrito" value="distritoprueba">
                            <button class="btn btn-dark" name="action" value="buy">Finalizar Compra</button>
                        </form>
                    </div>
                </c:if>
                <!-- Mostrar un mensaje si el carrito está vacío -->
                <c:if test="${empty carrito}">
                    <div class="empty-cart">
                        <p>Su carrito está vacío.</p>
                    </div>
                </c:if>

            </div>
        </div>
    </div>
</div>
</nav>