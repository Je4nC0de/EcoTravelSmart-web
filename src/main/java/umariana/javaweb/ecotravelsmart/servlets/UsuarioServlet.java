package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;

/**
 * Procesa registroUsuarios.jsp (registrar) y los enlaces de
 * "Eliminar" de adminUsuarios.jsp (eliminar), usando el parámetro
 * "accion" para distinguir qué operación hacer.
 */
@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GestionarUsuarios gestionarUsuarios =
                (GestionarUsuarios) request.getServletContext().getAttribute("gestionarUsuarios");

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");
        String idParam = request.getParameter("id"); // viene del campo oculto del formulario

        if (idParam != null && !idParam.trim().isEmpty()) {
            // --- ACTUALIZAR: ya existe un id, es una edición ---
            int id = Integer.parseInt(idParam);
            Usuario actualizado = new Usuario(id, nombre, apellido, correo, telefono, username, password, rol);
            gestionarUsuarios.actualizarUsuario(actualizado);
        } else {
            // --- CREAR: no venía id, es un usuario nuevo ---
            int nuevoId = (Integer) request.getServletContext().getAttribute("contadorUsuarios");
            Usuario nuevo = new Usuario(nuevoId, nombre, apellido, correo, telefono, username, password, rol);
            gestionarUsuarios.agregarUsuario(nuevo);
            request.getServletContext().setAttribute("contadorUsuarios", nuevoId + 1);
        }

        response.sendRedirect(request.getContextPath() + "/adminUsuarios.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            GestionarUsuarios gestionarUsuarios =
                    (GestionarUsuarios) request.getServletContext().getAttribute("gestionarUsuarios");
            int id = Integer.parseInt(request.getParameter("id"));
            gestionarUsuarios.eliminarUsuario(id);
        }

        response.sendRedirect(request.getContextPath() + "/adminUsuarios.jsp");
    }
}
