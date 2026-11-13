package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import umariana.javaweb.ecotravelsmart.modelo.GestionarProductos;
import umariana.javaweb.ecotravelsmart.modelo.Producto;
import umariana.javaweb.ecotravelsmart.util.Util;

/**
 * CRUD de productos/servicios (solo administrador; lo garantiza AuthFilter).
 *  - POST sin id -> CREAR | POST con id -> ACTUALIZAR
 *  - GET ?accion=eliminar&id=X  -> ELIMINAR
 *  - GET ?accion=alternar&id=X  -> cambiar disponible / no disponible
 */
@WebServlet("/ProductoServlet")
public class ProductoServlet extends HttpServlet {

    private void guardarDatos() throws java.io.IOException {
        jakarta.servlet.ServletContext c = getServletContext();
        umariana.javaweb.ecotravelsmart.util.Persistencia.guardar(
            (umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios)c.getAttribute("gestionarUsuarios"),
            (umariana.javaweb.ecotravelsmart.modelo.GestionarProductos)c.getAttribute("gestionarProductos"),
            (umariana.javaweb.ecotravelsmart.modelo.GestionarReservas)c.getAttribute("gestionarReservas"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        GestionarProductos gp = (GestionarProductos) getServletContext().getAttribute("gestionarProductos");
        String ctx = request.getContextPath();

        String idParam = Util.limpiar(request.getParameter("id"));
        boolean edicion = !idParam.isEmpty();

        int id;
        if (edicion) {
            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                id = -1;
            }
            if (gp.buscarProductoPorId(id) == null) {
                Util.flash(session, "danger", "El producto que intentas editar no existe.");
                response.sendRedirect(ctx + "/adminProductos.jsp");
                return;
            }
        } else {
            id = gp.siguienteId();
        }

        double precio = -1;
        try {
            precio = Double.parseDouble(Util.limpiar(request.getParameter("precio")));
        } catch (NumberFormatException e) {
            // se valida abajo
        }

        String categoria = request.getParameter("categoria");
        if (!Util.categoriaValida(categoria)) {
            categoria = "Ecoturismo";
        }

        Producto form = new Producto(id,
                Util.limpiar(request.getParameter("nombre")),
                Util.limpiar(request.getParameter("descripcion")),
                precio, categoria,
                Util.limpiar(request.getParameter("ubicacion")),
                Boolean.parseBoolean(request.getParameter("disponible")));

        String error = null;
        if (form.getNombre().length() < 3) {
            error = "El nombre debe tener al menos 3 caracteres.";
        } else if (precio < 0) {
            error = "Ingresa un precio válido (0 o mayor).";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("productoForm", form);
            request.getRequestDispatcher("/registroProductos.jsp").forward(request, response);
            return;
        }

        if (edicion) {
            gp.actualizarProducto(form);
            Util.flash(session, "success", "Producto actualizado correctamente.");
        } else {
            gp.agregarProducto(form);
            Util.flash(session, "success", "Producto creado correctamente.");
        }
        guardarDatos();
        response.sendRedirect(ctx + "/adminProductos.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        GestionarProductos gp = (GestionarProductos) getServletContext().getAttribute("gestionarProductos");
        String accion = request.getParameter("accion");

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            if ("eliminar".equals(accion)) {
                if (gp.eliminarProducto(id)) {
                    guardarDatos();
                    Util.flash(session, "success", "Producto eliminado.");
                } else {
                    Util.flash(session, "danger", "El producto no existe.");
                }
            } else if ("alternar".equals(accion)) {
                Producto p = gp.buscarProductoPorId(id);
                if (p != null) {
                    p.setDisponible(!p.isDisponible());
                    guardarDatos();
                    Util.flash(session, "success", "\"" + p.getNombre() + "\" ahora está "
                            + (p.isDisponible() ? "disponible." : "no disponible."));
                }
            }
        } catch (NumberFormatException e) {
            Util.flash(session, "danger", "Identificador inválido.");
        }
        response.sendRedirect(request.getContextPath() + "/adminProductos.jsp");
    }
}
