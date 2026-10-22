<%@ page import="umariana.javaweb.ecotravelsmart.util.Util" %>
<%-- Tarjeta reutilizable. Se incluye dentro de un for que define la variable "p" (Producto). --%>
<div class="col-md-6 col-lg-4">
    <article class="product-card">
        <div class="product-thumb cat-<%= Util.esc(p.getCategoria()) %>">
            <span class="badge-cat"><i class="bi <%= Util.catIcon(p.getCategoria()) %> me-1"></i><%= Util.esc(Util.catLabel(p.getCategoria())) %></span>
            <% if (!p.isDisponible()) { %><span class="badge-agotado">No disponible</span><% } %>
            <i class="bi <%= Util.catIcon(p.getCategoria()) %> thumb-icon"></i>
        </div>
        <div class="p-3 d-flex flex-column flex-grow-1">
            <h3 class="h6 fw-bold mb-1"><%= Util.esc(p.getNombre()) %></h3>
            <p class="text-muted small mb-2"><i class="bi bi-geo-alt-fill text-success me-1"></i><%= Util.esc(p.getUbicacion()) %></p>
            <p class="small text-secondary flex-grow-1"><%= Util.esc(Util.recortar(p.getDescripcion(), 95)) %></p>
            <div class="d-flex justify-content-between align-items-center mt-2">
                <div><span class="price"><%= Util.precio(p.getPrecio()) %></span> <small class="text-muted">/ persona</small></div>
                <a class="btn btn-sm btn-primary" href="<%= ctx %>/detalleProducto.jsp?id=<%= p.getIdProducto() %>">Ver detalle</a>
            </div>
        </div>
    </article>
</div>
