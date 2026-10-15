<%@page import="java.util.ArrayList" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.Usuario" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios" %>
<%@include file="lib/header.jsp" %>

<%
    GestionarUsuarios gestionarUsuarios =
            (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    ArrayList<Usuario> listaUsuarios = gestionarUsuarios.listarUsuarios();
%>

<div class="contenedor">
    <div class="barra-admin">
        <h2>Administración de Usuarios</h2>
        <a href="${pageContext.request.contextPath}/registroUsuarios.jsp" class="btn btn-primary">+ Nuevo Usuario</a>
    </div>

    <!-- Tabla conectada a la lista real en memoria (GestionarUsuarios) a través del ServletContext -->
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
            <% for (Usuario u : listaUsuarios) { %>
            <tr>
                <td><%= u.getIdPersona() %></td>
                <td><%= u.getNombre() %></td>
                <td><%= u.getApellido() %></td>
                <td><%= u.getCorreo() %></td>
                <td><%= u.getUsername() %></td>
                <td><%= u.getRol() %></td>
                <td>
                    <a href="registroUsuarios.jsp?id=<%= u.getIdPersona() %>" class="btn btn-sm btn-primary">Editar</a>
                    <a href="${pageContext.request.contextPath}/UsuarioServlet?accion=eliminar&id=<%= u.getIdPersona() %>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('¿Eliminar este usuario?');">Eliminar</a>
                </td>
            </tr>
            <% } %>
            <% if (listaUsuarios.isEmpty()) { %>
            <tr>
                <td colspan="7" style="text-align:center;">No hay usuarios registrados todavía.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="lib/footer.jsp" %>
