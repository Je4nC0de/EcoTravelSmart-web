<%@page import="umariana.javaweb.ecotravelsmart.modelo.Usuario" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios" %>
<%@include file="lib/header.jsp" %>

<%
    // Si la URL trae ?id=X, significa que venimos del botón "Editar":
    // buscamos ese usuario para precargar el formulario con sus datos.
    Usuario usuarioEditar = null;
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.trim().isEmpty()) {
        GestionarUsuarios gestionarUsuarios =
                (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
        usuarioEditar = gestionarUsuarios.buscarUsuarioPorId(Integer.parseInt(idParam));
    }
%>

<div class="contenedor">
    <!-- Formulario basado en los atributos de Usuario.java -->
    <form class="formulario" action="${pageContext.request.contextPath}/UsuarioServlet" method="post">
        <h2><%= (usuarioEditar != null) ? "Editar Usuario" : "Registro de Usuario" %></h2>

        <!-- Campo oculto: vacío = crear nuevo, con valor = actualizar ese id -->
        <input type="hidden" name="id" value="<%= (usuarioEditar != null) ? usuarioEditar.getIdPersona() : "" %>">

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getNombre() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" id="apellido" name="apellido" class="form-control" placeholder="Apellido"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getApellido() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="correo" class="form-label">Correo electronico</label>
            <input type="email" id="correo" name="correo" class="form-control" placeholder="ejemplo@correo.com"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getCorreo() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="telefono" class="form-label">Telefono</label>
            <input type="text" id="telefono" name="telefono" class="form-control" placeholder="Número de contacto"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getTelefono() : "" %>">
        </div>

        <div class="mb-3">
            <label for="username" class="form-label">Nombre de usuario</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Nombre de usuario"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getUsername() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Contrase�a</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Contraseña"
                   value="<%= (usuarioEditar != null) ? usuarioEditar.getPassword() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="rol" class="form-label">Rol</label>
            <select id="rol" name="rol" class="form-control">
                <option value="Cliente" <%= (usuarioEditar != null && "Cliente".equals(usuarioEditar.getRol())) ? "selected" : "" %>>Cliente</option>
                <option value="Administrador" <%= (usuarioEditar != null && "Administrador".equals(usuarioEditar.getRol())) ? "selected" : "" %>>Administrador</option>
            </select>
        </div>

        <div class="acciones-form">
            <button type="submit" class="btn btn-primary"><%= (usuarioEditar != null) ? "Guardar cambios" : "Registrar" %></button>
            <a href="${pageContext.request.contextPath}/adminUsuarios.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@include file="lib/footer.jsp" %>
