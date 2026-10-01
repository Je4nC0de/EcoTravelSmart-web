<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <!-- Formulario basado en los atributos de Usuario.java (no funcional aún) -->
    <form class="formulario" action="#" method="post">
        <h2>Registro de Usuario</h2>

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Nombre" required>
        </div>

        <div class="mb-3">
            <label for="apellido" class="form-label">Apellido</label>
            <input type="text" id="apellido" name="apellido" class="form-control" placeholder="Apellido" required>
        </div>

        <div class="mb-3">
            <label for="correo" class="form-label">Correo electrónico</label>
            <input type="email" id="correo" name="correo" class="form-control" placeholder="ejemplo@correo.com" required>
        </div>

        <div class="mb-3">
            <label for="telefono" class="form-label">Teléfono</label>
            <input type="text" id="telefono" name="telefono" class="form-control" placeholder="Número de contacto">
        </div>

        <div class="mb-3">
            <label for="username" class="form-label">Nombre de usuario</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Nombre de usuario" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Contraseña" required>
        </div>

        <div class="mb-3">
            <label for="rol" class="form-label">Rol</label>
            <select id="rol" name="rol" class="form-control">
                <option value="Cliente">Cliente</option>
                <option value="Administrador">Administrador</option>
            </select>
        </div>

        <div class="acciones-form">
            <button type="submit" class="btn btn-primary">Registrar</button>
            <a href="${pageContext.request.contextPath}/adminUsuarios.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@include file="lib/footer.jsp" %>
