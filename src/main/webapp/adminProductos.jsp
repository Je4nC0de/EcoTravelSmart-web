<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Administrar productos");
    request.setAttribute("navActivo", "adminProductos");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    ArrayList<Producto> lista = gp.listarProductos();
%>

<section class="page-hero">
    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">
        <div>
            <h1>Productos y servicios</h1>
            <p>Crea, edita y publica los servicios del catálogo.</p>
        </div>
        <a href="<%= ctx %>/registroProductos.jsp" class="btn btn-sand btn-lg"><i class="bi bi-plus-lg me-1"></i>Nuevo producto</a>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-3"><div class="card-eco stat-card"><div class="ico ico-green"><i class="bi bi-box-seam"></i></div><div><div class="num"><%= lista.size() %></div><div class="lbl">Servicios</div></div></div></div>
        <div class="col-6 col-md-3"><div class="card-eco stat-card"><div class="ico ico-blue"><i class="bi bi-check-circle"></i></div><div><div class="num"><%= gp.contarDisponibles() %></div><div class="lbl">Disponibles</div></div></div></div>
        <div class="col-6 col-md-3"><div class="card-eco stat-card"><div class="ico ico-rose"><i class="bi bi-x-circle"></i></div><div><div class="num"><%= lista.size() - gp.contarDisponibles() %></div><div class="lbl">No disponibles</div></div></div></div>
        <div class="col-6 col-md-3"><div class="card-eco stat-card"><div class="ico ico-sand"><i class="bi bi-cash-coin"></i></div><div><div class="num fs-5"><%= Util.precio(gp.precioPromedio()) %></div><div class="lbl">Precio promedio</div></div></div></div>
    </div>

    <div class="card-eco">
        <div class="p-3 d-flex flex-wrap gap-2 align-items-center border-bottom">
            <div class="input-group" style="max-width:320px">
                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input type="text" id="filtroTexto" class="form-control" placeholder="Buscar servicio, lugar...">
            </div>
            <select class="form-select" style="max-width:210px" data-filtro="categoria" aria-label="Categoría">
                <option value="">Todas las categorías</option>
                <% for (String[] c : Util.CATEGORIAS) { %><option value="<%= c[0] %>"><%= c[1] %></option><% } %>
            </select>
            <select class="form-select" style="max-width:190px" data-filtro="disponible" aria-label="Disponibilidad">
                <option value="">Cualquier estado</option>
                <option value="1">Disponibles</option>
                <option value="0">No disponibles</option>
            </select>
            <button type="button" class="btn btn-light" id="limpiarFiltros">Limpiar</button>
            <span class="ms-auto small text-muted">Mostrando <strong id="contadorFilas"><%= lista.size() %></strong> de <%= lista.size() %></span>
        </div>

        <div class="table-responsive">
            <table class="table table-eco" id="tablaDatos">
                <thead>
                    <tr><th>Servicio</th><th>Categoría</th><th>Precio</th><th>Ubicación</th><th>Estado</th><th class="text-end">Acciones</th></tr>
                </thead>
                <tbody>
                    <% for (Producto p : lista) { %>
                    <tr data-fila data-categoria="<%= Util.esc(p.getCategoria()) %>" data-disponible="<%= p.isDisponible() ? "1" : "0" %>">
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <span class="ico cat-<%= Util.esc(p.getCategoria()) %> text-white d-inline-grid" style="width:38px;height:38px;border-radius:11px;display:inline-grid;place-items:center"><i class="bi <%= Util.catIcon(p.getCategoria()) %>"></i></span>
                                <div>
                                    <div class="fw-semibold"><%= Util.esc(p.getNombre()) %></div>
                                    <div class="small text-muted">ID <%= p.getIdProducto() %></div>
                                </div>
                            </div>
                        </td>
                        <td><span class="badge-soft badge-soft-dark"><%= Util.esc(Util.catLabel(p.getCategoria())) %></span></td>
                        <td class="fw-semibold"><%= Util.precio(p.getPrecio()) %></td>
                        <td><%= Util.esc(p.getUbicacion()) %></td>
                        <td>
                            <a href="<%= ctx %>/ProductoServlet?accion=alternar&id=<%= p.getIdProducto() %>" title="Clic para cambiar el estado"
                               class="badge-soft text-decoration-none <%= p.isDisponible() ? "badge-soft-success" : "badge-soft-danger" %>">
                                <%= p.isDisponible() ? "Disponible" : "No disponible" %></a>
                        </td>
                        <td class="text-end text-nowrap">
                            <a href="<%= ctx %>/detalleProducto.jsp?id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-secondary" title="Ver"><i class="bi bi-eye"></i></a>
                            <a href="<%= ctx %>/registroProductos.jsp?id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-primary" title="Editar"><i class="bi bi-pencil-square"></i></a>
                            <a href="<%= ctx %>/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>" class="btn btn-sm btn-outline-danger" title="Eliminar"
                               data-confirm="¿Eliminar &quot;<%= Util.esc(p.getNombre()) %>&quot;? Esta acción no se puede deshacer."><i class="bi bi-trash"></i></a>
                        </td>
                    </tr>
                    <% } %>
                    <tr id="filaVacia" style="display:none"><td colspan="6" class="empty-state"><i class="bi bi-search"></i><div class="mt-2">No hay servicios que coincidan.</div></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
