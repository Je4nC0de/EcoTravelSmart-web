<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Registro de usuario");
    request.setAttribute("navActivo", "adminUsuarios");
%>
<%@ include file="lib/header.jsp" %>
<%
    // 1) Si el servlet devolvió el formulario con un error, se reutilizan los datos escritos.
    // 2) Si no, y un administrador llegó con ?id=X, se carga ese usuario para EDITAR.
    Usuario uf = (Usuario) request.getAttribute("usuarioForm");
    String errorForm = (String) request.getAttribute("error");
    String idParam = Util.limpiar(request.getParameter("id"));
    boolean esEdicion = sesionAdmin && !idParam.isEmpty();

    if (uf == null && esEdicion) {
        try {
            GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
            uf = gu.buscarUsuarioPorId(Integer.parseInt(idParam));
        } catch (NumberFormatException e) {
            uf = null;
        }
        if (uf == null) {
            esEdicion = false;
        }
    }
    String vNombre = uf != null ? uf.getNombre() : "";
    String vApellido = uf != null ? uf.getApellido() : "";
    String vCorreo = uf != null ? uf.getCorreo() : "";
    String vTelefono = uf != null ? uf.getTelefono() : "";
    String vUsername = uf != null ? uf.getUsername() : "";
    String vRol = uf != null ? uf.getRol() : "Cliente";
    String volver = sesionAdmin ? ctx + "/adminUsuarios.jsp" : ctx + "/login.jsp";
%>

<section class="page-hero">
    <div class="container">
        <h1><%= esEdicion ? "Editar usuario" : (sesionAdmin ? "Nuevo usuario" : "Crea tu cuenta") %></h1>
        <p><%= esEdicion ? "Actualiza los datos y guarda los cambios." : "Completa el formulario. Solo te tomará un minuto." %></p>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="card-eco form-card">

        <% if (errorForm != null) { %>
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i><%= Util.esc(errorForm) %></div>
        <% } %>

        <form action="<%= ctx %>/UsuarioServlet" method="post" class="needs-validation" novalidate>
            <!-- vacío = crear; con número = actualizar ese usuario -->
            <input type="hidden" name="id" value="<%= esEdicion && uf != null ? uf.getIdPersona() : "" %>">

            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label" for="nombre">Nombre</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" value="<%= Util.esc(vNombre) %>" required>
                    <div class="invalid-feedback">Escribe tu nombre.</div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="apellido">Apellido</label>
                    <input type="text" id="apellido" name="apellido" class="form-control" value="<%= Util.esc(vApellido) %>" required>
                    <div class="invalid-feedback">Escribe tu apellido.</div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="correo">Correo electrónico</label>
                    <input type="email" id="correo" name="correo" class="form-control" placeholder="nombre@correo.com" value="<%= Util.esc(vCorreo) %>" required>
                    <div class="invalid-feedback">Ingresa un correo válido.</div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="telefono">Teléfono</label>
                    <input type="tel" id="telefono" name="telefono" class="form-control" placeholder="300 000 0000" value="<%= Util.esc(vTelefono) %>">
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="username">Nombre de usuario</label>
                    <div class="input-group">
                        <span class="input-group-text">@</span>
                        <input type="text" id="username" name="username" class="form-control" minlength="3" value="<%= Util.esc(vUsername) %>" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="password">Contraseña <%= esEdicion ? "(déjala en blanco para no cambiarla)" : "" %></label>
                    <div class="input-group">
                        <input type="password" id="password" name="password" class="form-control" minlength="4" <%= esEdicion ? "" : "required" %>>
                        <button class="btn btn-outline-secondary" type="button" data-toggle-pass="#password" aria-label="Mostrar contraseña"><i class="bi bi-eye"></i></button>
                    </div>
                </div>

                <% if (sesionAdmin) { %>
                <div class="col-md-6">
                    <label class="form-label" for="rol">Rol</label>
                    <select id="rol" name="rol" class="form-select">
                        <option value="Cliente" <%= "Cliente".equals(vRol) ? "selected" : "" %>>Cliente</option>
                        <option value="Administrador" <%= "Administrador".equals(vRol) ? "selected" : "" %>>Administrador</option>
                    </select>
                </div>
                <% } %>
            </div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-primary btn-lg"><%= esEdicion ? "Guardar cambios" : (sesionAdmin ? "Crear usuario" : "Crear cuenta") %></button>
                <a href="<%= volver %>" class="btn btn-light btn-lg">Cancelar</a>
            </div>
            <% if (!sesionAdmin) { %>
            <p class="small text-muted mt-3 mb-0">¿Ya tienes cuenta? <a href="<%= ctx %>/login.jsp" class="fw-semibold">Inicia sesión</a></p>
            <% } %>
        </form>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
