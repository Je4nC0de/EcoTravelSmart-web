<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Panel de control");
    request.setAttribute("navActivo", "dashboard");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    GestionarReservas gr = (GestionarReservas) application.getAttribute("gestionarReservas");
    int totalProd = gp.listarProductos().size();
    ArrayList<Reserva> todas = gr.listarReservas();
%>

<section class="page-hero">
    <div class="container">
        <h1>Hola, <%= Util.esc(sesionUsuario.getNombre()) %></h1>
        <p>Resumen de la actividad de EcoTravelSmart.</p>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3"><div class="card-eco stat-card"><div class="ico ico-green"><i class="bi bi-people"></i></div><div><div class="num"><%= gu.listarUsuarios().size() %></div><div class="lbl">Usuarios</div></div></div></div>
        <div class="col-6 col-lg-3"><div class="card-eco stat-card"><div class="ico ico-blue"><i class="bi bi-box-seam"></i></div><div><div class="num"><%= totalProd %></div><div class="lbl">Servicios (<%= gp.contarDisponibles() %> activos)</div></div></div></div>
        <div class="col-6 col-lg-3"><div class="card-eco stat-card"><div class="ico ico-sand"><i class="bi bi-calendar-check"></i></div><div><div class="num"><%= todas.size() %></div><div class="lbl">Reservas</div></div></div></div>
        <div class="col-6 col-lg-3"><div class="card-eco stat-card"><div class="ico ico-rose"><i class="bi bi-cash-coin"></i></div><div><div class="num fs-5"><%= Util.precio(gr.ingresosConfirmados()) %></div><div class="lbl">Ingresos confirmados</div></div></div></div>
    </div>

    <div class="row g-4">
        <div class="col-lg-6">
            <div class="card-eco p-4 h-100">
                <h2 class="h6 fw-bold mb-4">Servicios por categoría</h2>
                <% for (String[] c : Util.CATEGORIAS) {
                    int n = gp.contarPorCategoria(c[0]);
                    int pct = totalProd == 0 ? 0 : (int) Math.round(n * 100.0 / totalProd);
                %>
                <div class="mb-3">
                    <div class="d-flex justify-content-between small mb-1"><span><i class="bi <%= c[2] %> me-1 text-success"></i><%= c[1] %></span><strong><%= n %></strong></div>
                    <div class="bar-track"><div class="bar-fill" style="width:<%= pct %>%"></div></div>
                </div>
                <% } %>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card-eco p-4 h-100">
                <h2 class="h6 fw-bold mb-4">Reservas por estado</h2>
                <div class="row text-center g-2 mb-4">
                    <div class="col-4"><div class="fs-3 fw-bold" style="font-family:Poppins"><%= gr.contarPorEstado("Pendiente") %></div><span class="badge-soft badge-soft-warning">Pendientes</span></div>
                    <div class="col-4"><div class="fs-3 fw-bold" style="font-family:Poppins"><%= gr.contarPorEstado("Confirmada") %></div><span class="badge-soft badge-soft-success">Confirmadas</span></div>
                    <div class="col-4"><div class="fs-3 fw-bold" style="font-family:Poppins"><%= gr.contarPorEstado("Cancelada") %></div><span class="badge-soft badge-soft-danger">Canceladas</span></div>
                </div>
                <h2 class="h6 fw-bold mb-3">Accesos rápidos</h2>
                <div class="d-flex flex-wrap gap-2">
                    <a class="btn btn-primary" href="<%= ctx %>/registroProductos.jsp"><i class="bi bi-plus-lg me-1"></i>Nuevo producto</a>
                    <a class="btn btn-outline-primary" href="<%= ctx %>/registroUsuarios.jsp"><i class="bi bi-person-plus me-1"></i>Nuevo usuario</a>
                    <a class="btn btn-outline-primary" href="<%= ctx %>/misReservas.jsp"><i class="bi bi-calendar-check me-1"></i>Ver reservas</a>
                </div>
            </div>
        </div>

        <div class="col-12">
            <div class="card-eco">
                <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
                    <h2 class="h6 fw-bold mb-0">Últimas reservas</h2>
                    <a href="<%= ctx %>/misReservas.jsp" class="small fw-semibold">Ver todas</a>
                </div>
                <div class="table-responsive">
                    <table class="table table-eco">
                        <thead><tr><th>#</th><th>Cliente</th><th>Servicio</th><th>Viaje</th><th>Total</th><th>Estado</th></tr></thead>
                        <tbody>
                        <% int mostradas = 0;
                           for (int i = todas.size() - 1; i >= 0 && mostradas < 5; i--, mostradas++) {
                               Reserva r = todas.get(i);
                               Usuario cli = gu.buscarUsuarioPorId(r.getIdUsuario());
                               Producto pr = gp.buscarProductoPorId(r.getIdProducto());
                        %>
                            <tr>
                                <td>#<%= r.getIdReserva() %></td>
                                <td><%= cli != null ? Util.esc(cli.getNombre() + " " + cli.getApellido()) : "(usuario eliminado)" %></td>
                                <td><%= pr != null ? Util.esc(pr.getNombre()) : "(servicio eliminado)" %></td>
                                <td><%= Util.fecha(r.getFechaViaje()) %></td>
                                <td class="fw-semibold"><%= Util.precio(r.getTotal()) %></td>
                                <td><span class="badge-soft <%= Util.badgeEstado(r.getEstado()) %>"><%= Util.esc(r.getEstado()) %></span></td>
                            </tr>
                        <% } %>
                        <% if (todas.isEmpty()) { %>
                            <tr><td colspan="6" class="empty-state">Aún no hay reservas.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
