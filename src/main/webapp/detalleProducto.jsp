<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Detalle del servicio");
    request.setAttribute("navActivo", "catalogo");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    Producto prod = null;
    try {
        prod = gp.buscarProductoPorId(Integer.parseInt(request.getParameter("id")));
    } catch (NumberFormatException e) {
        prod = null;
    }
%>

<% if (prod == null) { %>
<div class="container section">
    <div class="empty-state card-eco">
        <i class="bi bi-compass"></i>
        <h1 class="h3 fw-bold mt-3">Ese servicio no existe</h1>
        <p>Puede que haya sido retirado del catálogo.</p>
        <a href="<%= ctx %>/productos.jsp" class="btn btn-primary">Volver al catálogo</a>
    </div>
</div>
<% } else {
    ArrayList<Producto> relacionados = new ArrayList<>();
    for (Producto x : gp.listarProductos()) {
        if (x.getIdProducto() != prod.getIdProducto() && x.getCategoria().equals(prod.getCategoria()) && relacionados.size() < 3) {
            relacionados.add(x);
        }
    }
%>
<section class="page-hero">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2 small">
                <li class="breadcrumb-item"><a class="text-white-50" href="<%= ctx %>/productos.jsp">Catálogo</a></li>
                <li class="breadcrumb-item"><a class="text-white-50" href="<%= ctx %>/productos.jsp?categoria=<%= Util.esc(prod.getCategoria()) %>"><%= Util.esc(Util.catLabel(prod.getCategoria())) %></a></li>
            </ol>
        </nav>
        <h1><%= Util.esc(prod.getNombre()) %></h1>
        <p><i class="bi bi-geo-alt-fill me-1"></i><%= Util.esc(prod.getUbicacion()) %></p>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="row g-4">
        <div class="col-lg-7">
            <div class="card-eco overflow-hidden">
                <div class="product-thumb cat-<%= Util.esc(prod.getCategoria()) %>" style="height:260px">
                    <span class="badge-cat"><i class="bi <%= Util.catIcon(prod.getCategoria()) %> me-1"></i><%= Util.esc(Util.catLabel(prod.getCategoria())) %></span>
                    <% if (!prod.isDisponible()) { %><span class="badge-agotado">No disponible</span><% } %>
                    <i class="bi <%= Util.catIcon(prod.getCategoria()) %> thumb-icon" style="font-size:5rem"></i>
                </div>
                <div class="p-4">
                    <h2 class="h5 fw-bold">Acerca de esta experiencia</h2>
                    <p class="text-secondary"><%= Util.esc(prod.getDescripcion()) %></p>
                    <div class="row g-3 mt-1">
                        <div class="col-sm-4"><div class="small text-muted">Categoría</div><div class="fw-semibold"><%= Util.esc(Util.catLabel(prod.getCategoria())) %></div></div>
                        <div class="col-sm-4"><div class="small text-muted">Ubicación</div><div class="fw-semibold"><%= Util.esc(prod.getUbicacion()) %></div></div>
                        <div class="col-sm-4"><div class="small text-muted">Estado</div>
                            <span class="badge-soft <%= prod.isDisponible() ? "badge-soft-success" : "badge-soft-danger" %>"><%= prod.isDisponible() ? "Disponible" : "No disponible" %></span></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card-eco detail-box" style="position:sticky; top:90px">
                <div class="mb-3"><span class="price fs-3 fw-bold" style="font-family:Poppins"><%= Util.precio(prod.getPrecio()) %></span> <span class="text-muted">/ persona</span></div>

                <% if (!prod.isDisponible()) { %>
                <div class="alert alert-warning mb-0"><i class="bi bi-exclamation-triangle me-1"></i>Este servicio no está disponible por ahora.</div>

                <% } else if (sesionUsuario == null) { %>
                <p class="text-muted">Inicia sesión para reservar este servicio.</p>
                <a class="btn btn-primary btn-lg w-100 mb-2" href="<%= ctx %>/login.jsp?next=<%= java.net.URLEncoder.encode("/detalleProducto.jsp?id=" + prod.getIdProducto(), "UTF-8") %>">Ingresar para reservar</a>
                <a class="btn btn-outline-primary w-100" href="<%= ctx %>/registroUsuarios.jsp">Crear cuenta</a>

                <% } else { %>
                <form action="<%= ctx %>/ReservaServlet" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="idProducto" value="<%= prod.getIdProducto() %>">
                    <div class="mb-3">
                        <label class="form-label" for="fecha">Fecha del viaje</label>
                        <input type="date" id="fecha" name="fecha" class="form-control" required data-min-today>
                        <div class="invalid-feedback">Elige una fecha.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="personas">Número de personas</label>
                        <input type="number" id="personas" name="personas" class="form-control" min="1" max="20" value="1"
                               required data-precio="<%= (long) prod.getPrecio() %>">
                    </div>
                    <div class="d-flex justify-content-between align-items-center p-3 rounded-3 mb-3" style="background:var(--eco-50)">
                        <span class="text-muted">Total estimado</span>
                        <strong class="fs-5" id="totalEstimado"><%= Util.precio(prod.getPrecio()) %></strong>
                    </div>
                    <button type="submit" class="btn btn-primary btn-lg w-100"><i class="bi bi-calendar-check me-1"></i>Reservar ahora</button>
                </form>
                <% } %>

                <% if (sesionAdmin) { %>
                <hr>
                <a class="btn btn-light w-100" href="<%= ctx %>/registroProductos.jsp?id=<%= prod.getIdProducto() %>"><i class="bi bi-pencil-square me-1"></i>Editar este servicio</a>
                <% } %>
            </div>
        </div>
    </div>

    <% if (!relacionados.isEmpty()) { %>
    <h2 class="h4 fw-bold mt-5 mb-3">Te puede interesar</h2>
    <div class="row g-4">
        <% for (Producto p : relacionados) { %>
        <%@ include file="lib/tarjetaProducto.jsp" %>
        <% } %>
    </div>
    <% } %>
</div>
<% } %>

<%@ include file="lib/footer.jsp" %>
