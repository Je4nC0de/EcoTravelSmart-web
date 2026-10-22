<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Catálogo");
    request.setAttribute("navActivo", "catalogo");
%>
<%@ include file="lib/header.jsp" %>
<%
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");

    String q = Util.limpiar(request.getParameter("q"));
    String categoria = Util.limpiar(request.getParameter("categoria"));
    String orden = Util.limpiar(request.getParameter("orden"));
    boolean soloDisp = "1".equals(request.getParameter("disponibles"));
    String precioMaxTxt = Util.limpiar(request.getParameter("precioMax"));
    double precioMax = 0;
    try {
        if (!precioMaxTxt.isEmpty()) {
            precioMax = Double.parseDouble(precioMaxTxt);
        }
    } catch (NumberFormatException e) {
        precioMax = 0;
    }

    ArrayList<Producto> resultados = gp.buscar(q, categoria, soloDisp, precioMax, orden);
    boolean hayFiltros = !q.isEmpty() || !categoria.isEmpty() || soloDisp || precioMax > 0 || !orden.isEmpty();
%>

<section class="page-hero">
    <div class="container">
        <h1>Catálogo de servicios</h1>
        <p>Encuentra experiencias ecológicas, hospedaje, transporte y gastronomía local.</p>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="row g-4">

        <!-- FILTROS -->
        <aside class="col-lg-3">
            <form class="card-eco filter-card" method="get" action="<%= ctx %>/productos.jsp">
                <h2 class="h6 fw-bold mb-3"><i class="bi bi-funnel me-2"></i>Filtros</h2>

                <div class="mb-3">
                    <label class="form-label" for="q">Buscar</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                        <input type="text" id="q" name="q" class="form-control" placeholder="Nombre, lugar..." value="<%= Util.esc(q) %>">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="categoria">Categoría</label>
                    <select id="categoria" name="categoria" class="form-select">
                        <option value="">Todas</option>
                        <% for (String[] c : Util.CATEGORIAS) { %>
                        <option value="<%= c[0] %>" <%= c[0].equals(categoria) ? "selected" : "" %>><%= c[1] %></option>
                        <% } %>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="precioMax">Precio máximo (por persona)</label>
                    <input type="number" id="precioMax" name="precioMax" class="form-control" min="0" step="5000"
                           placeholder="Sin límite" value="<%= precioMax > 0 ? String.valueOf((long) precioMax) : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label" for="orden">Ordenar por</label>
                    <select id="orden" name="orden" class="form-select">
                        <option value="" <%= orden.isEmpty() ? "selected" : "" %>>Relevancia</option>
                        <option value="precio_asc" <%= "precio_asc".equals(orden) ? "selected" : "" %>>Precio: menor a mayor</option>
                        <option value="precio_desc" <%= "precio_desc".equals(orden) ? "selected" : "" %>>Precio: mayor a menor</option>
                        <option value="nombre" <%= "nombre".equals(orden) ? "selected" : "" %>>Nombre (A-Z)</option>
                    </select>
                </div>

                <div class="form-check form-switch mb-4">
                    <input class="form-check-input" type="checkbox" role="switch" id="disponibles" name="disponibles" value="1" <%= soloDisp ? "checked" : "" %>>
                    <label class="form-check-label small" for="disponibles">Solo disponibles</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 mb-2">Aplicar filtros</button>
                <% if (hayFiltros) { %>
                <a href="<%= ctx %>/productos.jsp" class="btn btn-light w-100">Limpiar filtros</a>
                <% } %>
            </form>
        </aside>

        <!-- RESULTADOS -->
        <section class="col-lg-9">
            <div class="d-flex flex-wrap gap-2 mb-3">
                <a class="pill <%= categoria.isEmpty() ? "active" : "" %>" href="<%= ctx %>/productos.jsp">Todas</a>
                <% for (String[] c : Util.CATEGORIAS) { %>
                <a class="pill <%= c[0].equals(categoria) ? "active" : "" %>" href="<%= ctx %>/productos.jsp?categoria=<%= c[0] %>"><i class="bi <%= c[2] %>"></i><%= c[1] %></a>
                <% } %>
            </div>

            <p class="text-muted small mb-3">
                <strong class="text-dark"><%= resultados.size() %></strong> <%= resultados.size() == 1 ? "servicio encontrado" : "servicios encontrados" %>
                <% if (!q.isEmpty()) { %> para "<strong class="text-dark"><%= Util.esc(q) %></strong>"<% } %>
            </p>

            <% if (resultados.isEmpty()) { %>
            <div class="card-eco empty-state">
                <i class="bi bi-search"></i>
                <h3 class="h5 fw-bold mt-3">No encontramos resultados</h3>
                <p>Prueba con otras palabras o quita algunos filtros.</p>
                <a href="<%= ctx %>/productos.jsp" class="btn btn-primary">Ver todo el catálogo</a>
            </div>
            <% } else { %>
            <div class="row g-4">
                <% for (Producto p : resultados) { %>
                <%@ include file="lib/tarjetaProducto.jsp" %>
                <% } %>
            </div>
            <% } %>
        </section>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
