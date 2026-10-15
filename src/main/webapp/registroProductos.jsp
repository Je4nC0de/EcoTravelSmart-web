<%@page import="umariana.javaweb.ecotravelsmart.modelo.Producto" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.GestionarProductos" %>
<%@include file="lib/header.jsp" %>

<%
    // Si la URL trae ?id=X, venimos del botón "Editar": buscamos ese
    // producto para precargar el formulario con sus datos actuales.
    Producto productoEditar = null;
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.trim().isEmpty()) {
        GestionarProductos gestionarProductos =
                (GestionarProductos) application.getAttribute("gestionarProductos");
        productoEditar = gestionarProductos.buscarProductoPorId(Integer.parseInt(idParam));
    }
%>

<div class="contenedor">
    <!-- Formulario basado en los atributos de Producto.java -->
    <form class="formulario" action="${pageContext.request.contextPath}/ProductoServlet" method="post">
        <h2><%= (productoEditar != null) ? "Editar Producto / Servicio" : "Registro de Producto / Servicio" %></h2>

        <!-- Campo oculto: vacío = crear nuevo, con valor = actualizar ese id -->
        <input type="hidden" name="id" value="<%= (productoEditar != null) ? productoEditar.getIdProducto() : "" %>">

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre del producto/servicio</label>
            <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ej: Tour ecológico Laguna Verde"
                   value="<%= (productoEditar != null) ? productoEditar.getNombre() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea id="descripcion" name="descripcion" class="form-control" placeholder="Describe el producto o servicio turístico"><%= (productoEditar != null) ? productoEditar.getDescripcion() : "" %></textarea>
        </div>

        <div class="mb-3">
            <label for="precio" class="form-label">Precio</label>
            <input type="number" id="precio" name="precio" class="form-control" step="0.01" placeholder="0.00"
                   value="<%= (productoEditar != null) ? productoEditar.getPrecio() : "" %>" required>
        </div>

        <div class="mb-3">
            <label for="categoria" class="form-label">Categoría</label>
            <select id="categoria" name="categoria" class="form-control">
                <option value="Ecoturismo" <%= (productoEditar != null && "Ecoturismo".equals(productoEditar.getCategoria())) ? "selected" : "" %>>Ecoturismo</option>
                <option value="Hospedaje" <%= (productoEditar != null && "Hospedaje".equals(productoEditar.getCategoria())) ? "selected" : "" %>>Hospedaje sostenible</option>
                <option value="Transporte" <%= (productoEditar != null && "Transporte".equals(productoEditar.getCategoria())) ? "selected" : "" %>>Transporte verde</option>
                <option value="Gastronomia" <%= (productoEditar != null && "Gastronomia".equals(productoEditar.getCategoria())) ? "selected" : "" %>>Gastronomía local</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="ubicacion" class="form-label">Ubicación</label>
            <input type="text" id="ubicacion" name="ubicacion" class="form-control" placeholder="Ciudad / Región"
                   value="<%= (productoEditar != null) ? productoEditar.getUbicacion() : "" %>">
        </div>

        <div class="mb-3">
            <label for="disponible" class="form-label">Disponibilidad</label>
            <select id="disponible" name="disponible" class="form-control">
                <option value="true" <%= (productoEditar != null && productoEditar.isDisponible()) ? "selected" : "" %>>Disponible</option>
                <option value="false" <%= (productoEditar != null && !productoEditar.isDisponible()) ? "selected" : "" %>>No disponible</option>
            </select>
        </div>

        <div class="acciones-form">
            <button type="submit" class="btn btn-primary"><%= (productoEditar != null) ? "Guardar cambios" : "Guardar" %></button>
            <a href="${pageContext.request.contextPath}/adminProductos.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@include file="lib/footer.jsp" %>
