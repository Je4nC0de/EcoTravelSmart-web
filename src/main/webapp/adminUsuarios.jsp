<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Administrar usuarios");
    request.setAttribute("navActivo", "adminUsuarios");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    ArrayList<Usuario> lista = gu.listarUsuarios();
%>

<section class="page-hero">
    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">
        <div>
            <h1>Usuarios</h1>
            <p>Administra las cuentas de la plataforma.</p>
        </div>
        <a href="<%= ctx %>/registroUsuarios.jsp" class="btn btn-sand btn-lg"><i class="bi bi-person-plus me-1"></i>Nuevo usuario</a>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="row g-3 mb-4">
        <div class="col-6 col-md-4"><div class="card-eco stat-card"><div class="ico ico-green"><i class="bi bi-people"></i></div><div><div class="num"><%= lista.size() %></div><div class="lbl">Usuarios</div></div></div></div>
        <div class="col-6 col-md-4"><div class="card-eco stat-card"><div class="ico ico-sand"><i class="bi bi-shield-check"></i></div><div><div class="num"><%= gu.contarPorRol("Administrador") %></div><div class="lbl">Administradores</div></div></div></div>
        <div class="col-12 col-md-4"><div class="card-eco stat-card"><div class="ico ico-blue"><i class="bi bi-person"></i></div><div><div class="num"><%= gu.contarPorRol("Cliente") %></div><div class="lbl">Clientes</div></div></div></div>
    </div>

    <div class="card-eco">
        <div class="p-3 d-flex flex-wrap gap-2 align-items-center border-bottom">
            <div class="input-group" style="max-width:360px">
                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input type="text" id="filtroTexto" class="form-control" placeholder="Buscar por nombre, correo o usuario...">
            </div>
            <select class="form-select" style="max-width:190px" data-filtro="rol" aria-label="Filtrar por rol">
                <option value="">Todos los roles</option>
                <option value="Administrador">Administrador</option>
                <option value="Cliente">Cliente</option>
            </select>
            <button type="button" class="btn btn-light" id="limpiarFiltros">Limpiar</button>
            <span class="ms-auto small text-muted">Mostrando <strong id="contadorFilas"><%= lista.size() %></strong> de <%= lista.size() %></span>
        </div>

        <div class="table-responsive">
            <table class="table table-eco" id="tablaDatos">
                <thead>
                    <tr><th>Usuario</th><th>Correo</th><th>Teléfono</th><th>Rol</th><th class="text-end">Acciones</th></tr>
                </thead>
                <tbody>
                    <% for (Usuario u : lista) { %>
                    <tr data-fila data-rol="<%= Util.esc(u.getRol()) %>">
                        <td>
                            <div class="d-flex align-items-center gap-2">
                                <span class="avatar"><%= Util.esc(u.getNombre().substring(0, 1).toUpperCase()) %></span>
                                <div>
                                    <div class="fw-semibold"><%= Util.esc(u.getNombre()) %> <%= Util.esc(u.getApellido()) %></div>
                                    <div class="small text-muted">@<%= Util.esc(u.getUsername()) %></div>
                                </div>
                            </div>
                        </td>
                        <td><%= Util.esc(u.getCorreo()) %></td>
                        <td><%= Util.esc(u.getTelefono()) %></td>
                        <td><span class="badge-soft <%= "Administrador".equals(u.getRol()) ? "badge-soft-warning" : "badge-soft-info" %>"><%= Util.esc(u.getRol()) %></span></td>
                        <td class="text-end text-nowrap">
                            <a href="<%= ctx %>/registroUsuarios.jsp?id=<%= u.getIdPersona() %>" class="btn btn-sm btn-outline-primary" title="Editar"><i class="bi bi-pencil-square"></i></a>
                            <% if (u.getIdPersona() != sesionUsuario.getIdPersona()) { %>
                            <a href="<%= ctx %>/UsuarioServlet?accion=eliminar&id=<%= u.getIdPersona() %>"
                               class="btn btn-sm btn-outline-danger" title="Eliminar"
                               data-confirm="¿Eliminar al usuario <%= Util.esc(u.getNombre()) %> <%= Util.esc(u.getApellido()) %>? Esta acción no se puede deshacer."><i class="bi bi-trash"></i></a>
                            <% } else { %>
                            <span class="badge-soft badge-soft-dark">Tú</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    <tr id="filaVacia" style="display:none"><td colspan="5" class="empty-state"><i class="bi bi-person-x"></i><div class="mt-2">No hay usuarios que coincidan.</div></td></tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
