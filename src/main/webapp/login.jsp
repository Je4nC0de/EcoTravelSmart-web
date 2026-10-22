<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("tituloPagina", "Iniciar sesión");
%>
<%@ include file="lib/header.jsp" %>
<%
    String next = request.getParameter("next") == null ? "" : request.getParameter("next");
    String errorLogin = (String) request.getAttribute("error");
%>
<div class="container auth-wrap">
    <div class="auth-card fade-up">
        <div class="auth-side">
            <span class="hero-badge mb-3 align-self-start"><i class="bi bi-leaf-fill"></i> Turismo sostenible</span>
            <h2>Bienvenido de nuevo</h2>
            <p class="mb-0 opacity-75">Reserva experiencias ecológicas, administra tus viajes y descubre nuevos destinos con impacto positivo.</p>
        </div>
        <div class="auth-form">
            <h1 class="h3 fw-bold mb-1">Iniciar sesión</h1>
            <p class="text-muted mb-4">Ingresa con tu usuario y contraseña.</p>

            <% if (errorLogin != null) { %>
            <div class="alert alert-danger py-2"><i class="bi bi-exclamation-circle me-1"></i><%= Util.esc(errorLogin) %></div>
            <% } %>

            <form action="<%= ctx %>/LoginServlet" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="next" value="<%= Util.esc(next) %>">
                <div class="mb-3">
                    <label for="username" class="form-label">Usuario</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Tu usuario" required autofocus>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Tu contraseña" required>
                        <button class="btn btn-outline-secondary" type="button" data-toggle-pass="#password" aria-label="Mostrar contraseña"><i class="bi bi-eye"></i></button>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary btn-lg w-100">Ingresar</button>
            </form>

            <p class="text-center small mt-4 mb-3">¿No tienes cuenta? <a href="<%= ctx %>/registroUsuarios.jsp" class="fw-semibold">Regístrate gratis</a></p>

            <div class="demo-box">
                <strong><i class="bi bi-info-circle me-1"></i>Cuentas de prueba</strong><br>
                Administrador: <code>lmartinez</code> / <code>1234</code><br>
                Cliente: <code>crodriguez</code> / <code>1234</code>
            </div>
        </div>
    </div>
</div>
<%@ include file="lib/footer.jsp" %>
