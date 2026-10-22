<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Reservas");
    request.setAttribute("navActivo", "reservas");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    GestionarReservas gr = (GestionarReservas) application.getAttribute("gestionarReservas");

    // El administrador ve todas las reservas; el cliente solo las suyas.
    ArrayList<Reserva> lista = sesionAdmin ? gr.listarReservas() : gr.porUsuario(sesionUsuario.getIdPersona());
    int columnas = sesionAdmin ? 8 : 7;
%>

<section class="page-hero">
    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">
        <div>
            <h1><%= sesionAdmin ? "Todas las reservas" : "Mis reservas" %></h1>
            <p><%= sesionAdmin ? "Confirma, cancela o elimina las reservas de los clientes." : "Consulta y administra tus próximos viajes." %></p>
        </div>
        <a href="<%= ctx %>/productos.jsp" class="btn btn-sand btn-lg"><i class="bi bi-compass me-1"></i>Explorar servicios</a>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="card-eco">
        <div class="p-3 d-flex flex-wrap gap-2 align-items-center border-bottom">
            <div class="input-group" style="max-width:320px">
                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input type="text" id="filtroTexto" class="form-control" placeholder="Buscar reserva...">
            </div>
            <select class="form-select" style="max-width:190px" data-filtro="estado" aria-label="Estado">
                <option value="">Todos los estados</option>
                <option value="Pendiente">Pendientes</option>
                <option value="Confirmada">Confirmadas</option>
                <option value="Cancelada">Canceladas</option>
            </select>
            <button type="button" class="btn btn-light" id="limpiarFiltros">Limpiar</button>
            <span class="ms-auto small text-muted">Mostrando <strong id="contadorFilas"><%= lista.size() %></strong> de <%= lista.size() %></span>
        </div>

        <div class="table-responsive">
            <table class="table table-eco" id="tablaDatos">
                <thead>
                    <tr>
                        <th>#</th>
                        <% if (sesionAdmin) { %><th>Cliente</th><% } %>
                        <th>Servicio</th><th>Fecha de viaje</th><th>Personas</th><th>Total</th><th>Estado</th><th class="text-end">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = lista.size() - 1; i >= 0; i--) {
                           Reserva r = lista.get(i);
                           Producto pr = gp.buscarProductoPorId(r.getIdProducto());
                           Usuario cli = gu.buscarUsuarioPorId(r.getIdUsuario());
                    %>
                    <tr data-fila data-estado="<%= Util.esc(r.getEstado()) %>">
                        <td class="fw-semibold">#<%= r.getIdReserva() %></td>
                        <% if (sesionAdmin) { %><td><%= cli != null ? Util.esc(cli.getNombre() + " " + cli.getApellido()) : "(usuario eliminado)" %></td><% } %>
                        <td>
                            <% if (pr != null) { %>
                            <a class="fw-semibold text-decoration-none" href="<%= ctx %>/detalleProducto.jsp?id=<%= pr.getIdProducto() %>"><%= Util.esc(pr.getNombre()) %></a>
                            <% } else { %><span class="text-muted">(servicio eliminado)</span><% } %>
                        </td>
                        <td><%= Util.fecha(r.getFechaViaje()) %></td>
                        <td><%= r.getPersonas() %></td>
                        <td class="fw-semibold"><%= Util.precio(r.getTotal()) %></td>
                        <td><span class="badge-soft <%= Util.badgeEstado(r.getEstado()) %>"><%= Util.esc(r.getEstado()) %></span></td>
                        <td class="text-end text-nowrap">
                            <% if (sesionAdmin && "Pendiente".equals(r.getEstado())) { %>
                            <a href="<%= ctx %>/ReservaServlet?accion=confirmar&id=<%= r.getIdReserva() %>" class="btn btn-sm btn-outline-success" title="Confirmar"><i class="bi bi-check-lg"></i></a>
                            <% } %>
                            <% if (!"Cancelada".equals(r.getEstado())) { %>
                            <a href="<%= ctx %>/ReservaServlet?accion=cancelar&id=<%= r.getIdReserva() %>" class="btn btn-sm btn-outline-warning" title="Cancelar"
                               data-confirm="¿Cancelar la reserva #<%= r.getIdReserva() %>?"><i class="bi bi-x-lg"></i></a>
                            <% } %>
                            <% if (sesionAdmin) { %>
                            <a href="<%= ctx %>/ReservaServlet?accion=eliminar&id=<%= r.getIdReserva() %>" class="btn btn-sm btn-outline-danger" title="Eliminar"
                               data-confirm="¿Eliminar definitivamente la reserva #<%= r.getIdReserva() %>?"><i class="bi bi-trash"></i></a>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <tr id="filaVacia" style="display:none">
                        <td colspan="<%= columnas %>" class="empty-state"><i class="bi bi-calendar-x"></i>
                            <div class="mt-2">No hay reservas para mostrar.</div>
                            <a href="<%= ctx %>/productos.jsp" class="btn btn-primary btn-sm mt-3">Explorar servicios</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
