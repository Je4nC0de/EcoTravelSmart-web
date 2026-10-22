<%@ page import="umariana.javaweb.ecotravelsmart.modelo.Usuario" %>
<%@ page import="umariana.javaweb.ecotravelsmart.util.Util" %>
<%
    /* Variables disponibles para TODAS las páginas que incluyan este header:
       sesionUsuario, sesionAdmin, ctx. Cada página puede definir antes del include:
       request.setAttribute("tituloPagina", "...") y request.setAttribute("navActivo", "...") */
    Usuario sesionUsuario = (Usuario) session.getAttribute("usuarioLogueado");
    boolean sesionAdmin = sesionUsuario != null && "Administrador".equals(sesionUsuario.getRol());
    String tituloPagina = request.getAttribute("tituloPagina") != null ? (String) request.getAttribute("tituloPagina") : "Inicio";
    String navActivo = request.getAttribute("navActivo") != null ? (String) request.getAttribute("navActivo") : "";
    String ctx = request.getContextPath();
    String flashMsg = (String) session.getAttribute("flashMsg");
    String flashTipo = (String) session.getAttribute("flashTipo");
    if (flashMsg != null) {
        session.removeAttribute("flashMsg");
        session.removeAttribute("flashTipo");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= Util.esc(tituloPagina) %> | EcoTravelSmart</title>
    <link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'%3E%3Crect width='32' height='32' rx='8' fill='%232d6a4f'/%3E%3Cpath d='M9 22c0-8 6-13 14-13 0 8-5 14-13 14z' fill='%23d8f3dc'/%3E%3C/svg%3E">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<%= ctx %>/styles/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-eco sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="<%= ctx %>/index.jsp">
            <span class="brand-mark"><i class="bi bi-leaf-fill"></i></span>EcoTravel<span class="accent">Smart</span>
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navMain" aria-label="Menú">
            <i class="bi bi-list fs-2"></i>
        </button>
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="navbar-nav me-auto ms-lg-4 gap-lg-1">
                <li class="nav-item"><a class="nav-link <%= "inicio".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link <%= "catalogo".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/productos.jsp">Catálogo</a></li>
                <% if (sesionUsuario != null) { %>
                <li class="nav-item"><a class="nav-link <%= "reservas".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/misReservas.jsp"><%= sesionAdmin ? "Reservas" : "Mis reservas" %></a></li>
                <% } %>
                <% if (sesionAdmin) { %>
                <li class="nav-item"><a class="nav-link <%= "dashboard".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/dashboard.jsp">Panel</a></li>
                <li class="nav-item"><a class="nav-link <%= "adminProductos".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/adminProductos.jsp">Productos</a></li>
                <li class="nav-item"><a class="nav-link <%= "adminUsuarios".equals(navActivo) ? "active" : "" %>" href="<%= ctx %>/adminUsuarios.jsp">Usuarios</a></li>
                <% } %>
            </ul>
            <div class="d-flex align-items-center gap-2 mt-3 mt-lg-0">
                <% if (sesionUsuario == null) { %>
                <a href="<%= ctx %>/login.jsp" class="btn btn-outline-primary btn-sm">Ingresar</a>
                <a href="<%= ctx %>/registroUsuarios.jsp" class="btn btn-primary btn-sm">Crear cuenta</a>
                <% } else { %>
                <div class="dropdown">
                    <a class="d-flex align-items-center gap-2 text-decoration-none dropdown-toggle text-dark" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                        <span class="avatar"><%= Util.esc(sesionUsuario.getNombre().substring(0, 1).toUpperCase()) %></span>
                        <span class="fw-semibold small"><%= Util.esc(sesionUsuario.getNombre()) %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><span class="dropdown-item-text small text-muted"><%= Util.esc(sesionUsuario.getRol()) %></span></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="<%= ctx %>/misReservas.jsp"><i class="bi bi-calendar-check me-2"></i>Reservas</a></li>
                        <li><a class="dropdown-item text-danger" href="<%= ctx %>/LogoutServlet"><i class="bi bi-box-arrow-right me-2"></i>Cerrar sesión</a></li>
                    </ul>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<main>
<% if (flashMsg != null) { %>
<div class="container pt-3">
    <div class="alert alert-<%= flashTipo %> alert-dismissible fade show mb-0" role="alert" data-autoclose>
        <%= Util.esc(flashMsg) %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Cerrar"></button>
    </div>
</div>
<% } %>
