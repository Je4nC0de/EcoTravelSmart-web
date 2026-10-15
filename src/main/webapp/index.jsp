<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="EcoTravelSmart" class="banner">

    <div class="hero-text">
        <h1>Bienvenido a EcoTravelSmart</h1>
        <p>Conectamos viajeros con experiencias de turismo ecologico y sostenible.</p>
    </div>

    <div class="tarjetas">
        <div class="tarjeta">
            <h3>Nuestro caso</h3>
            <p>EcoTravelSmart es una plataforma web que promueve el turismo responsable,
               conectando a los usuarios con productos y servicios turi­sticos
               amigables con el medio ambiente: ecoturismo, hospedaje sostenible
               y transporte verde.</p>
        </div>
        <div class="tarjeta">
            <h3>¿Que puedes hacer?</h3>
            <p>Explorar servicios turisticos ecologicos, registrarte como usuario
               de la plataforma y, proximamente, reservar tu proxima experiencia
               sostenible.</p>
        </div>
        <div class="tarjeta">
            <h3>¿Ya tienes cuenta?</h3>
            <p>Ingresa con tu usuario y contraseña para acceder a las funciones
               de administracionn de la plataforma.</p>
            <p style="text-align:center;">
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Iniciar sesion</a>
            </p>
        </div>
    </div>
</div>

<%@include file="lib/footer.jsp" %>
