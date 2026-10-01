<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <div class="barra-admin">
        <h2>Administración de Productos / Servicios</h2>
        <a href="${pageContext.request.contextPath}/registroProductos.jsp" class="btn btn-primary">+ Nuevo Producto</a>
    </div>

    <!-- Tabla con datos de ejemplo, aún no funcional / no conectada a datos reales -->
    <table class="table table-striped tabla-admin">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Categoría</th>
                <th>Precio</th>
                <th>Ubicación</th>
                <th>Disponible</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Tour ecológico Laguna Verde</td>
                <td>Ecoturismo</td>
                <td>$85.000</td>
                <td>Nariño</td>
                <td>Sí</td>
                <td>
                    <a href="registroProductos.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Cabañas Bosque Nativo</td>
                <td>Hospedaje sostenible</td>
                <td>$150.000</td>
                <td>Putumayo</td>
                <td>Sí</td>
                <td>
                    <a href="registroProductos.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>Transporte en bicicleta eléctrica</td>
                <td>Transporte verde</td>
                <td>$30.000</td>
                <td>Pasto</td>
                <td>No</td>
                <td>
                    <a href="registroProductos.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<%@include file="lib/footer.jsp" %>
