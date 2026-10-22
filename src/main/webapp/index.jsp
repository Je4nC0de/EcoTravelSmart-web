<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Turismo sostenible");
    request.setAttribute("navActivo", "inicio");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    GestionarReservas gr = (GestionarReservas) application.getAttribute("gestionarReservas");

    ArrayList<Producto> destacados = new ArrayList<>();
    for (Producto x : gp.listarProductos()) {
        if (x.isDisponible() && destacados.size() < 3) {
            destacados.add(x);
        }
    }
%>

<!-- HERO -->
<section class="hero">
    <div class="container">
        <div class="col-lg-8">
            <span class="hero-badge mb-4 fade-up"><i class="bi bi-stars"></i> Turismo inteligente y sostenible</span>
            <h1 class="fade-up d1">Viaja más lejos,<br><span class="accent">deja menos huella</span></h1>
            <p class="lead my-4 fade-up d2">Descubre ecoturismo, hospedajes responsables, transporte limpio y sabores locales. Reserva en minutos y apoya a las comunidades que cuidan el territorio.</p>

            <form class="hero-search d-flex flex-column flex-md-row gap-1 fade-up d3" action="<%= ctx %>/productos.jsp" method="get">
                <div class="input-group flex-grow-1">
                    <span class="input-group-text border-0 bg-transparent"><i class="bi bi-search"></i></span>
                    <input type="text" name="q" class="form-control" placeholder="¿Qué quieres vivir? Ej: café, aves, cabañas">
                </div>
                <select name="categoria" class="form-select" style="max-width:220px" aria-label="Categoría">
                    <option value="">Todas las categorías</option>
                    <% for (String[] c : Util.CATEGORIAS) { %>
                    <option value="<%= c[0] %>"><%= c[1] %></option>
                    <% } %>
                </select>
                <button class="btn btn-primary px-4" type="submit">Buscar</button>
            </form>

            <div class="hero-stats">
                <div><div class="num" data-count="<%= gp.listarProductos().size() %>">0</div><div class="lbl">Servicios</div></div>
                <div><div class="num" data-count="<%= gu.listarUsuarios().size() %>">0</div><div class="lbl">Viajeros y gestores</div></div>
                <div><div class="num" data-count="<%= gr.listarReservas().size() %>">0</div><div class="lbl">Reservas</div></div>
            </div>
        </div>
    </div>
</section>

<!-- CATEGORIAS -->
<section class="section">
    <div class="container">
        <span class="eyebrow">Explora por categoría</span>
        <h2 class="section-title mb-4">Todo lo que necesitas para un viaje consciente</h2>
        <div class="row g-4">
            <% for (String[] c : Util.CATEGORIAS) { %>
            <div class="col-sm-6 col-lg-3">
                <a class="card-eco hoverable cat-tile" href="<%= ctx %>/productos.jsp?categoria=<%= c[0] %>">
                    <div class="ico cat-<%= c[0] %>"><i class="bi <%= c[2] %>"></i></div>
                    <h3><%= c[1] %></h3>
                    <small><%= gp.contarPorCategoria(c[0]) %> servicios</small>
                </a>
            </div>
            <% } %>
        </div>
    </div>
</section>

<!-- DESTACADOS -->
<section class="section pt-0">
    <div class="container">
        <div class="d-flex flex-wrap justify-content-between align-items-end gap-2 mb-4">
            <div>
                <span class="eyebrow">Disponibles ahora</span>
                <h2 class="section-title mb-0">Experiencias destacadas</h2>
            </div>
            <a href="<%= ctx %>/productos.jsp" class="btn btn-outline-primary">Ver todo el catálogo <i class="bi bi-arrow-right ms-1"></i></a>
        </div>
        <div class="row g-4">
            <% for (Producto p : destacados) { %>
            <%@ include file="lib/tarjetaProducto.jsp" %>
            <% } %>
        </div>
    </div>
</section>

<!-- COMO FUNCIONA -->
<section class="section pt-0">
    <div class="container">
        <div class="text-center mb-5">
            <span class="eyebrow">Así de simple</span>
            <h2 class="section-title">Cómo funciona</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4"><div class="card-eco p-4 h-100 text-center">
                <div class="step-num mx-auto mb-3">1</div><h3 class="h5 fw-bold">Explora</h3>
                <p class="text-muted mb-0">Filtra por categoría, precio o ubicación y encuentra el plan perfecto.</p></div></div>
            <div class="col-md-4"><div class="card-eco p-4 h-100 text-center">
                <div class="step-num mx-auto mb-3">2</div><h3 class="h5 fw-bold">Reserva</h3>
                <p class="text-muted mb-0">Elige fecha y número de personas. Ves el total antes de confirmar.</p></div></div>
            <div class="col-md-4"><div class="card-eco p-4 h-100 text-center">
                <div class="step-num mx-auto mb-3">3</div><h3 class="h5 fw-bold">Viaja consciente</h3>
                <p class="text-muted mb-0">Disfruta y apoya a la economía local con un turismo responsable.</p></div></div>
        </div>
    </div>
</section>

<!-- CTA -->
<% if (sesionUsuario == null) { %>
<section class="container pb-4">
    <div class="cta-band text-center">
        <h2 class="fw-bold mb-2">Empieza tu próxima aventura sostenible</h2>
        <p class="mb-4 opacity-75">Crea tu cuenta gratis y reserva en minutos.</p>
        <a href="<%= ctx %>/registroUsuarios.jsp" class="btn btn-sand btn-lg me-2">Crear cuenta</a>
        <a href="<%= ctx %>/login.jsp" class="btn btn-outline-light btn-lg">Ya tengo cuenta</a>
    </div>
</section>
<% } %>

<%@ include file="lib/footer.jsp" %>
