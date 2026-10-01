<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>EcoTravelSmart</title>

    <%-- Bootstrap --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

    <%-- Estilos personalizados EcoTravelSmart --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

<header class="main-header">
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/index.jsp" class="logo">🌿 EcoTravelSmart</a>
        <nav>
            <a href="${pageContext.request.contextPath}/index.jsp">Inicio</a>
            <a href="${pageContext.request.contextPath}/adminProductos.jsp">Productos/Servicios</a>
            <a href="${pageContext.request.contextPath}/adminUsuarios.jsp">Usuarios</a>
            <a href="${pageContext.request.contextPath}/login.jsp">Ingresar</a>
        </nav>
    </div>
</header>
