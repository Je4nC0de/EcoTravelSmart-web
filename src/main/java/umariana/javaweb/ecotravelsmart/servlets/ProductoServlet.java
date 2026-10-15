package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import umariana.javaweb.ecotravelsmart.modelo.GestionarProductos;
import umariana.javaweb.ecotravelsmart.modelo.Producto;

/**
 * Procesa registroProductos.jsp (registrar) y los enlaces de
 * "Eliminar" de adminProductos.jsp (eliminar).
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GestionarProductos gestionarProductos =
                (GestionarProductos) request.getServletContext().getAttribute("gestionarProductos");

        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        double precio = Double.parseDouble(request.getParameter("precio"));
        String categoria = request.getParameter("categoria");
        String ubicacion = request.getParameter("ubicacion");
        boolean disponible = Boolean.parseBoolean(request.getParameter("disponible"));
        String idParam = request.getParameter("id"); // viene del campo oculto del formulario

        if (idParam != null && !idParam.trim().isEmpty()) {
            // --- ACTUALIZAR: ya existe un id, es una edición ---
            int id = Integer.parseInt(idParam);
            Producto actualizado = new Producto(id, nombre, descripcion, precio, categoria, ubicacion, disponible);
            gestionarProductos.actualizarProducto(actualizado);
        } else {
            // --- CREAR: no venía id, es un producto nuevo ---
            int nuevoId = (Integer) request.getServletContext().getAttribute("contadorProductos");
            Producto nuevo = new Producto(nuevoId, nombre, descripcion, precio, categoria, ubicacion, disponible);
            gestionarProductos.agregarProducto(nuevo);
            request.getServletContext().setAttribute("contadorProductos", nuevoId + 1);
        }

        response.sendRedirect(request.getContextPath() + "/adminProductos.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            GestionarProductos gestionarProductos =
                    (GestionarProductos) request.getServletContext().getAttribute("gestionarProductos");
            int id = Integer.parseInt(request.getParameter("id"));
            gestionarProductos.eliminarProducto(id);
        }

        response.sendRedirect(request.getContextPath() + "/adminProductos.jsp");
    }
}
