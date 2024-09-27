<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nutripoint - Nosotros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="assets/css/nosotros.css">
    <link rel="stylesheet" href="assets/css/shop-cart.css"/>
</head>

<body>
    <%@include file="components/header.jsp"%>

    <!-- Sección Nosotros -->
    <div class="container mt-3">
        <h2 class="section-title text-title">Sobre Nosotros</h2>
        <div class="row about-section mt-3">
            <div class="col-lg-6 mb-4">
                <h4>¿Quiénes Somos?</h4>
                <p>En Nutripoint, nos dedicamos a ofrecer suplementos deportivos de alta calidad, respaldados por más de
                    10 años de experiencia en el mercado. Nuestro compromiso con la excelencia se refleja en cada uno de
                    nuestros productos, diseñados para satisfacer las necesidades de atletas, entusiastas del fitness y
                    cualquier persona que busque mejorar su rendimiento y bienestar.

                    Nos apasiona ayudar a nuestros clientes a alcanzar sus metas de salud y rendimiento deportivo. Para
                    ello, trabajamos incansablemente en la investigación y desarrollo de fórmulas innovadoras que
                    cumplen con los más altos estándares de calidad. Nuestros suplementos son elaborados con
                    ingredientes premium, cuidadosamente seleccionados y probados para garantizar su eficacia y
                    seguridad.

                    En Nutripoint, creemos que cada persona es única y, por lo tanto, necesita un enfoque personalizado
                    en su viaje hacia una vida más saludable. Por eso, ofrecemos una amplia gama de productos, desde
                    proteínas y aminoácidos hasta vitaminas y minerales, para cubrir todas las necesidades nutricionales
                    de nuestros clientes.</p>
            </div>
            <div class="col-lg-6 mb-4">
                <img src="assets/img/Tienda.jpg" alt="Nuestra Historia" class="img-fluid rounded">
            </div>
        </div>
    </div>

    <!-- Misión y Visión -->
    <div class="container mt-5">
        <h2 class="section-title text-title">Nuestra Misión y Visión</h2>
        <div class="row mission-vision">
            <div class="col-md-6">
                <h4>Visión</h4>
                <p>Nuestra visión es ser la tienda de suplementos deportivos más confiable del país, brindando productos
                    de alta calidad que permitan a nuestros clientes llevar un estilo de vida saludable y activo.</p>
            </div>
            <div class="col-md-6">
                <h4>Misión</h4>
                <p>Nuestra misión es ofrecer productos innovadores y efectivos que ayuden a las personas a mejorar su
                    rendimiento físico, su salud y bienestar general. Estamos comprometidos con la excelencia en el
                    servicio al cliente, ofreciendo asesoramiento personalizado y apoyo constante.</p>
            </div>
        </div>
    </div>

    <!-- Tiendas Disponibles -->
    <div class="container mt-5">
        <h2 class="section-title text-title">Tiendas Disponibles</h2>
        <div class="row">
            <div class="col-md-6">
                <ul class="list-group">
                    <li class="list-group-item">Nutripoint - Tienda Central (Lima)</li>
                    <li class="list-group-item">Nutripoint - Miraflores</li>
                    <li class="list-group-item">Nutripoint - San Isidro</li>
                    <li class="list-group-item">Nutripoint - Callao</li>
                    <li class="list-group-item">Nutripoint - Arequipa</li>
                    <li class="list-group-item">Nutripoint - Puente Piedra</li>
                    <li class="list-group-item">Nutripoint - Ventanilla</li>
                </ul>
            </div>
            <div class="col-md-6">
                <div class="map-responsive">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3900.9241432146077!2d-77.03512909999999!3d-12.1173427!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c83d12360cb7%3A0x2e8b098309c11421!2sEl%C3%ADas%20Aguirre%20259%2C%20Miraflores%2015074!5e0!3m2!1ses!2spe!4v1727270125457!5m2!1ses!2spe"
                        width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>
        </div>
    </div>
    <%@include file="components/footer.jsp"%>
    
    <script src="assets/script/cart-shopping.js"></script>

    <!-- Bootstrap JS (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>

</html>