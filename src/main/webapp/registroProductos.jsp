<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <!-- Formulario basado en los atributos de Producto.java (no funcional aún) -->
    <form class="formulario" action="#" method="post">
        <h2>Registro de Producto / Servicio</h2>

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre del producto/servicio</label>
            <input type="text" id="nombre" name="nombre" class="form-control" placeholder="Ej: Tour ecológico Laguna Verde" required>
        </div>

        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea id="descripcion" name="descripcion" class="form-control" placeholder="Describe el producto o servicio turístico"></textarea>
        </div>

        <div class="mb-3">
            <label for="precio" class="form-label">Precio</label>
            <input type="number" id="precio" name="precio" class="form-control" step="0.01" placeholder="0.00" required>
        </div>

        <div class="mb-3">
            <label for="categoria" class="form-label">Categoría</label>
            <select id="categoria" name="categoria" class="form-control">
                <option value="Ecoturismo">Ecoturismo</option>
                <option value="Hospedaje">Hospedaje sostenible</option>
                <option value="Transporte">Transporte verde</option>
                <option value="Gastronomia">Gastronomía local</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="ubicacion" class="form-label">Ubicación</label>
            <input type="text" id="ubicacion" name="ubicacion" class="form-control" placeholder="Ciudad / Región">
        </div>

        <div class="mb-3">
            <label for="disponible" class="form-label">Disponibilidad</label>
            <select id="disponible" name="disponible" class="form-control">
                <option value="true">Disponible</option>
                <option value="false">No disponible</option>
            </select>
        </div>

        <div class="acciones-form">
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="${pageContext.request.contextPath}/adminProductos.jsp" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<%@include file="lib/footer.jsp" %>
