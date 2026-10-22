package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import umariana.javaweb.ecotravelsmart.modelo.GestionarProductos;
import umariana.javaweb.ecotravelsmart.modelo.GestionarReservas;
import umariana.javaweb.ecotravelsmart.modelo.Producto;
import umariana.javaweb.ecotravelsmart.modelo.Reserva;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;
import umariana.javaweb.ecotravelsmart.util.Util;

/**
 * Reservas (requiere sesión; lo garantiza AuthFilter).
 *  - POST: crear una reserva de un producto
 *  - GET ?accion=cancelar|confirmar|eliminar&id=X
 */
@WebServlet("/ReservaServlet")
public class ReservaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        GestionarProductos gp = (GestionarProductos) getServletContext().getAttribute("gestionarProductos");
        GestionarReservas gr = (GestionarReservas) getServletContext().getAttribute("gestionarReservas");
        String ctx = request.getContextPath();

        String idProd = Util.limpiar(request.getParameter("idProducto"));
        String volver = ctx + "/detalleProducto.jsp?id=" + idProd;

        try {
            Producto p = gp.buscarProductoPorId(Integer.parseInt(idProd));
            int personas = Integer.parseInt(Util.limpiar(request.getParameter("personas")));
            LocalDate fecha = LocalDate.parse(Util.limpiar(request.getParameter("fecha")));

            if (p == null) {
                Util.flash(session, "danger", "El servicio ya no existe.");
                response.sendRedirect(ctx + "/productos.jsp");
                return;
            }
            if (!p.isDisponible()) {
                Util.flash(session, "warning", "Ese servicio no está disponible por ahora.");
            } else if (personas < 1 || personas > 20) {
                Util.flash(session, "warning", "El número de personas debe estar entre 1 y 20.");
            } else if (fecha.isBefore(LocalDate.now())) {
                Util.flash(session, "warning", "La fecha del viaje no puede estar en el pasado.");
            } else {
                gr.agregarReserva(new Reserva(gr.siguienteId(), usuario.getIdPersona(), p.getIdProducto(),
                        fecha, personas, p.getPrecio() * personas, "Pendiente", LocalDate.now()));
                Util.flash(session, "success", "¡Reserva creada! Quedó en estado Pendiente hasta que sea confirmada.");
                response.sendRedirect(ctx + "/misReservas.jsp");
                return;
            }
        } catch (NumberFormatException | DateTimeParseException e) {
            Util.flash(session, "danger", "Revisa los datos de la reserva e inténtalo de nuevo.");
        }
        response.sendRedirect(volver);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        boolean admin = "Administrador".equals(usuario.getRol());
        GestionarReservas gr = (GestionarReservas) getServletContext().getAttribute("gestionarReservas");
        String accion = request.getParameter("accion");

        try {
            Reserva r = gr.buscarReservaPorId(Integer.parseInt(request.getParameter("id")));
            if (r == null) {
                Util.flash(session, "danger", "La reserva no existe.");
            } else if ("cancelar".equals(accion) && (admin || r.getIdUsuario() == usuario.getIdPersona())) {
                r.setEstado("Cancelada");
                Util.flash(session, "success", "Reserva #" + r.getIdReserva() + " cancelada.");
            } else if ("confirmar".equals(accion) && admin) {
                r.setEstado("Confirmada");
                Util.flash(session, "success", "Reserva #" + r.getIdReserva() + " confirmada.");
            } else if ("eliminar".equals(accion) && admin) {
                gr.eliminarReserva(r.getIdReserva());
                Util.flash(session, "success", "Reserva eliminada.");
            } else {
                Util.flash(session, "danger", "No tienes permisos para esa acción.");
            }
        } catch (NumberFormatException e) {
            Util.flash(session, "danger", "Identificador inválido.");
        }
        response.sendRedirect(request.getContextPath() + "/misReservas.jsp");
    }
}
