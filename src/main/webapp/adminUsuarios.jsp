<%@include file="lib/header.jsp" %>

<div class="contenedor">
    <div class="barra-admin">
        <h2>Administración de Usuarios</h2>
        <a href="${pageContext.request.contextPath}/registroUsuarios.jsp" class="btn btn-primary">+ Nuevo Usuario</a>
    </div>

    <!-- Tabla con datos de ejemplo, aún no funcional / no conectada a datos reales -->
    <table class="table table-striped tabla-admin">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Correo</th>
                <th>Usuario</th>
                <th>Rol</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td>Laura</td>
                <td>Martínez</td>
                <td>laura.martinez@ecotravel.com</td>
                <td>lmartinez</td>
                <td>Administrador</td>
                <td>
                    <a href="registroUsuarios.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
            <tr>
                <td>2</td>
                <td>Carlos</td>
                <td>Rodríguez</td>
                <td>carlos.rodriguez@ecotravel.com</td>
                <td>crodriguez</td>
                <td>Cliente</td>
                <td>
                    <a href="registroUsuarios.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
            <tr>
                <td>3</td>
                <td>Andrea</td>
                <td>Pérez</td>
                <td>andrea.perez@ecotravel.com</td>
                <td>aperez</td>
                <td>Cliente</td>
                <td>
                    <a href="registroUsuarios.jsp" class="btn btn-sm btn-primary">Editar</a>
                    <a href="#" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<%@include file="lib/footer.jsp" %>
