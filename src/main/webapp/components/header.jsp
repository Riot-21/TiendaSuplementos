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
                    <li class="nav-item"></li>
                    <a class="nav-link text-white" href="productos.jsp">Tienda</a>
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
                    <button class="btn btn-outline-light" type="submit"><i class="fa fa-search"></i></button>
                </form>
                <!-- Icono de Usuario -->
                <a class="nav-icon text-white ms-3" href="login.jsp">
                    <i class="fa fa-user fa-lg"></i>
                </a>
                <!-- Icono Carrito -->
                <button class="btn nav-icon text-white ms-3" id="cart-icon" onclick="toggleCart()">
                    <i class="fa fa-cart-shopping fa-lg"></i>
                </button>
                <!-- Carrito de compras (Oculto al inicio) -->
                <div id="cart" class="cart-container">
                    <div class="cart-header">
                        <h5>Carrito de Compras</h5>
                        <button class="close-cart" onclick="toggleCart()">&#10006;</button>
                    </div>
                    <div class="cart-footer">
                        <h5>Total: S/.<span id="cart-total"> 0.00</span></h5>
                        <button class="btn btn-dark">Finalizar Compra</button>
                    </div>
                </div>
            </div>
        </div>
    </nav>