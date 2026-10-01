<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <!-- Formulario no funcional por el momento, solo estructura y navegación -->
    <form class="formulario" action="#" method="post">
        <h2>Iniciar sesión</h2>

        <div class="mb-3">
            <label for="username" class="form-label">Usuario</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Ingresa tu usuario" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Ingresa tu contraseña" required>
        </div>

        <div class="acciones-form">
            <button type="submit" class="btn btn-primary">Ingresar</button>
        </div>

        <p style="text-align:center; margin-top:15px; font-size:14px;">
            ¿No tienes cuenta?
            <a href="${pageContext.request.contextPath}/registroUsuarios.jsp">Regístrate aquí</a>
        </p>
    </form>
</div>

<%@include file="lib/footer.jsp" %>
