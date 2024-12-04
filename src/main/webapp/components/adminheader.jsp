<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="col-md-3 col-lg-2 d-md-block bg-dark sidebar p-3">
    <div class="position-sticky d-flex flex-column align-items-center">
        <img src="${pageContext.request.contextPath}/assets/img/usuario.avif" alt="Admin" class="profile-img">
        <div class="sidebar-heading">Administrador</div>
        <ul class="nav flex-column mt-3 w-100">
            <li class="nav-item p-2">
                <a class="nav-link active text-white" href="${pageContext.request.contextPath}/AdminController?action=dashboard">
                    <i class="fa-solid fa-house me-2"></i>Dashboard
                </a>
            </li>
            <li class="nav-item p-2">
                <form action="${pageContext.request.contextPath}/UserController" method="GET">
                    <button type="submit" class="nav-link text-white" name="action" value="show">
                        <i class="fas fa-users me-2"></i>Usuarios</button>
                </form>
            </li>
            <li class="nav-item p-2">
                <form action="${pageContext.request.contextPath}/ProductController" method="GET">
                    <button type="submit" class="nav-link text-white" name="action" value="cargartodo">
                        <i class="fas fa-boxes me-2"></i>Productos</button>
                </form>
            </li>
            <li class="nav-item p-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/admin/admin-nuevoprod.jsp">
                    <i class="fa-solid fa-plus me-2"></i>Nuevo Producto
                </a>
            </li>
            <li class="nav-item p-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminController?action=pedidos">
                    <i class="fa-solid fa-cart-shopping me-2"></i>Pedidos
                </a>
            </li>
            <li class="nav-item p-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/shop?action=admin">
                    <i class="fa-solid fa-cart-shopping me-2"></i>Tiendas
                </a>
            </li>
            <li class="nav-item p-2">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/empresa">
                    <i class="fa-solid fa-cart-shopping me-2"></i>Empresa
                </a>
            </li>
            <li class="nav-item p-2">
                <form action="${pageContext.request.contextPath}/AdminController" method="GET">
                    <button type="submit" class="nav-link text-white" name="action" value="list">
                        <i class="fas fa-user me-2" ></i>Administradores</button>
                </form>
            </li>
            <li class="nav-item p-2">
                <form action="${pageContext.request.contextPath}/AdminController" method="POST">
                    <button type="submit" class="nav-link text-white" name="action" value="logout"><i class="fas fa-sign-out-alt me-2"></i>Salir</button>
                </form>
            </li>
        </ul>
    </div>
</nav>
