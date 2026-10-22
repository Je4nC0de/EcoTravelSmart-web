<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%
    request.setAttribute("tituloPagina", "Página no disponible");
    Object codigo = request.getAttribute("jakarta.servlet.error.status_code");
    boolean noEncontrada = codigo != null && "404".equals(String.valueOf(codigo));
%>
<%@ include file="lib/header.jsp" %>
<div class="container section text-center">
    <div class="empty-state">
        <i class="bi <%= noEncontrada ? "bi-compass" : "bi-exclamation-triangle" %>"></i>
        <h1 class="h2 fw-bold mt-3"><%= noEncontrada ? "No encontramos esa página" : "Algo salió mal" %></h1>
        <p class="mb-4"><%= noEncontrada ? "El enlace puede estar roto o la página ya no existe." : "Ocurrió un error inesperado. Inténtalo de nuevo en unos segundos." %></p>
        <a href="<%= ctx %>/index.jsp" class="btn btn-primary btn-lg">Volver al inicio</a>
    </div>
</div>
<%@ include file="lib/footer.jsp" %>
