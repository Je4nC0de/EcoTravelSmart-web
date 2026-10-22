<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%
    request.setAttribute("tituloPagina", "Registro de producto");
    request.setAttribute("navActivo", "adminProductos");
%>
<%@ include file="lib/header.jsp" %>
<%
    // Datos devueltos por el servlet tras un error, o producto a editar (?id=X)
    Producto pf = (Producto) request.getAttribute("productoForm");
    String errorForm = (String) request.getAttribute("error");
    String idParam = Util.limpiar(request.getParameter("id"));
    boolean esEdicion = !idParam.isEmpty();

    if (pf == null && esEdicion) {
        try {
            GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
            pf = gp.buscarProductoPorId(Integer.parseInt(idParam));
        } catch (NumberFormatException e) {
            pf = null;
        }
        if (pf == null) {
            esEdicion = false;
        }
    }
    String vNombre = pf != null ? pf.getNombre() : "";
    String vDesc = pf != null ? pf.getDescripcion() : "";
    String vPrecio = pf != null && pf.getPrecio() >= 0 ? String.valueOf((long) pf.getPrecio()) : "";
    String vCat = pf != null ? pf.getCategoria() : "Ecoturismo";
    String vUbic = pf != null ? pf.getUbicacion() : "";
    boolean vDisp = pf == null || pf.isDisponible();
%>

<section class="page-hero">
    <div class="container">
        <h1><%= esEdicion ? "Editar producto / servicio" : "Nuevo producto / servicio" %></h1>
        <p>Lo que registres aparecerá en el catálogo público.</p>
    </div>
</section>

<div class="container page-body pb-4">
    <div class="card-eco form-card">

        <% if (errorForm != null) { %>
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle me-1"></i><%= Util.esc(errorForm) %></div>
        <% } %>

        <form action="<%= ctx %>/ProductoServlet" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="id" value="<%= esEdicion && pf != null ? pf.getIdProducto() : "" %>">

            <div class="row g-3">
                <div class="col-12">
                    <label class="form-label" for="nombre">Nombre del producto / servicio</label>
                    <input type="text" id="nombre" name="nombre" class="form-control" minlength="3" placeholder="Ej: Tour ecológico Laguna de La Cocha" value="<%= Util.esc(vNombre) %>" required>
                    <div class="invalid-feedback">Escribe un nombre (mínimo 3 caracteres).</div>
                </div>
                <div class="col-12">
                    <label class="form-label" for="descripcion">Descripción</label>
                    <textarea id="descripcion" name="descripcion" rows="4" class="form-control" placeholder="Describe la experiencia..."><%= Util.esc(vDesc) %></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="precio">Precio por persona (COP)</label>
                    <div class="input-group">
                        <span class="input-group-text">$</span>
                        <input type="number" id="precio" name="precio" class="form-control" min="0" step="1000" value="<%= vPrecio %>" required>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="categoria">Categoría</label>
                    <select id="categoria" name="categoria" class="form-select">
                        <% for (String[] c : Util.CATEGORIAS) { %>
                        <option value="<%= c[0] %>" <%= c[0].equals(vCat) ? "selected" : "" %>><%= c[1] %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="ubicacion">Ubicación</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                        <input type="text" id="ubicacion" name="ubicacion" class="form-control" placeholder="Ciudad, región" value="<%= Util.esc(vUbic) %>">
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label" for="disponible">Disponibilidad</label>
                    <select id="disponible" name="disponible" class="form-select">
                        <option value="true" <%= vDisp ? "selected" : "" %>>Disponible</option>
                        <option value="false" <%= !vDisp ? "selected" : "" %>>No disponible</option>
                    </select>
                </div>
            </div>

            <div class="d-flex gap-2 mt-4">
                <button type="submit" class="btn btn-primary btn-lg"><%= esEdicion ? "Guardar cambios" : "Crear producto" %></button>
                <a href="<%= ctx %>/adminProductos.jsp" class="btn btn-light btn-lg">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<%@ include file="lib/footer.jsp" %>
