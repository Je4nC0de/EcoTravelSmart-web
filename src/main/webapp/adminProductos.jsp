<%@page import="java.util.ArrayList" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.Producto" %>
<%@page import="umariana.javaweb.ecotravelsmart.modelo.GestionarProductos" %>
<%@include file="lib/header.jsp" %>

<%
    GestionarProductos gestionarProductos =
            (GestionarProductos) application.getAttribute("gestionarProductos");
    ArrayList<Producto> listaProductos = gestionarProductos.listarProductos();
%>

<div class="contenedor">
    <div class="barra-admin">
        <h2>Administración de Productos / Servicios</h2>
        <a href="${pageContext.request.contextPath}/registroProductos.jsp" class="btn btn-primary">+ Nuevo Producto</a>
    </div>

    <!-- Tabla conectada a la lista real en memoria (GestionarProductos) a través del ServletContext -->
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
            <% for (Producto p : listaProductos) { %>
            <tr>
                <td><%= p.getIdProducto() %></td>
                <td><%= p.getNombre() %></td>
                <td><%= p.getCategoria() %></td>
                <td>$<%= String.format("%,.0f", p.getPrecio()) %></td>
                <td><%= p.getUbicacion() %></td>
                <td><%= p.isDisponible() ? "Sí" : "No" %></td>
                <td>
                    <a href="registroProductos.jsp?id=<%= p.getIdProducto() %>" class="btn btn-sm btn-primary">Editar</a>
                    <a href="${pageContext.request.contextPath}/ProductoServlet?accion=eliminar&id=<%= p.getIdProducto() %>"
                       class="btn btn-sm btn-danger"
                       onclick="return confirm('¿Eliminar este producto?');">Eliminar</a>
                </td>
            </tr>
            <% } %>
            <% if (listaProductos.isEmpty()) { %>
            <tr>
                <td colspan="7" style="text-align:center;">No hay productos registrados todavía.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>

<%@include file="lib/footer.jsp" %>
