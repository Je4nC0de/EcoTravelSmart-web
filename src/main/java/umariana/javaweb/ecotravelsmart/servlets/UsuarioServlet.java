package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;
import umariana.javaweb.ecotravelsmart.util.Util;

/**
 * CRUD de usuarios.
 *  - POST sin id  -> CREAR  (público: registro de cuenta; admin: nuevo usuario)
 *  - POST con id  -> ACTUALIZAR (solo administrador)
 *  - GET ?accion=eliminar&id=X -> ELIMINAR (solo administrador)
 */
@WebServlet("/UsuarioServlet")
public class UsuarioServlet extends HttpServlet {

    private static boolean esAdmin(Usuario u) {
        return u != null && "Administrador".equals(u.getRol());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario actual = (Usuario) session.getAttribute("usuarioLogueado");
        boolean admin = esAdmin(actual);
        GestionarUsuarios gu = (GestionarUsuarios) getServletContext().getAttribute("gestionarUsuarios");
        String ctx = request.getContextPath();

        String idParam = Util.limpiar(request.getParameter("id"));
        boolean edicion = !idParam.isEmpty();

        if (edicion && !admin) {
            Util.flash(session, "danger", "No tienes permisos para editar usuarios.");
            response.sendRedirect(ctx + "/index.jsp");
            return;
        }

        int id;
        Usuario existente = null;
        if (edicion) {
            try {
                id = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                id = -1;
            }
            existente = gu.buscarUsuarioPorId(id);
            if (existente == null) {
                Util.flash(session, "danger", "El usuario que intentas editar no existe.");
                response.sendRedirect(ctx + "/adminUsuarios.jsp");
                return;
            }
        } else {
            id = gu.siguienteId();
        }

        String password = request.getParameter("password") == null ? "" : request.getParameter("password");
        if (edicion && password.isEmpty()) {
            password = existente.getPassword(); // en blanco = conservar la actual
        }
        // Solo un administrador puede asignar rol; el registro público siempre es Cliente.
        String rol = admin && "Administrador".equals(request.getParameter("rol")) ? "Administrador" : "Cliente";

        Usuario form = new Usuario(id,
                Util.limpiar(request.getParameter("nombre")),
                Util.limpiar(request.getParameter("apellido")),
                Util.limpiar(request.getParameter("correo")),
                Util.limpiar(request.getParameter("telefono")),
                Util.limpiar(request.getParameter("username")),
                password, rol);

        String error = validar(form, gu, edicion);
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("usuarioForm", form);
            request.getRequestDispatcher("/registroUsuarios.jsp").forward(request, response);
            return;
        }

        if (edicion) {
            gu.actualizarUsuario(form);
            if (actual != null && actual.getIdPersona() == id) {
                session.setAttribute("usuarioLogueado", form);
            }
            Util.flash(session, "success", "Usuario actualizado correctamente.");
            response.sendRedirect(ctx + "/adminUsuarios.jsp");
        } else {
            gu.agregarUsuario(form);
            if (admin) {
                Util.flash(session, "success", "Usuario creado correctamente.");
                response.sendRedirect(ctx + "/adminUsuarios.jsp");
            } else {
                Util.flash(session, "success", "Cuenta creada. Ya puedes iniciar sesión.");
                response.sendRedirect(ctx + "/login.jsp");
            }
        }
    }

    private String validar(Usuario u, GestionarUsuarios gu, boolean edicion) {
        if (u.getNombre().isEmpty() || u.getApellido().isEmpty()) {
            return "El nombre y el apellido son obligatorios.";
        }
        if (!u.getCorreo().matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            return "Ingresa un correo electrónico válido.";
        }
        if (u.getUsername().length() < 3) {
            return "El nombre de usuario debe tener al menos 3 caracteres.";
        }
        if (u.getPassword().length() < 4) {
            return "La contraseña debe tener al menos 4 caracteres.";
        }
        if (gu.existeUsername(u.getUsername(), edicion ? u.getIdPersona() : -1)) {
            return "Ese nombre de usuario ya está en uso. Elige otro.";
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario actual = (Usuario) session.getAttribute("usuarioLogueado");
        String ctx = request.getContextPath();

        if ("eliminar".equals(request.getParameter("accion"))) {
            if (!esAdmin(actual)) {
                Util.flash(session, "danger", "No tienes permisos para eliminar usuarios.");
                response.sendRedirect(ctx + "/index.jsp");
                return;
            }
            GestionarUsuarios gu = (GestionarUsuarios) getServletContext().getAttribute("gestionarUsuarios");
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (id == actual.getIdPersona()) {
                    Util.flash(session, "warning", "No puedes eliminar tu propia cuenta mientras estás conectado.");
                } else if (gu.eliminarUsuario(id)) {
                    Util.flash(session, "success", "Usuario eliminado.");
                } else {
                    Util.flash(session, "danger", "El usuario no existe.");
                }
            } catch (NumberFormatException e) {
                Util.flash(session, "danger", "Identificador inválido.");
            }
            response.sendRedirect(ctx + "/adminUsuarios.jsp");
            return;
        }
        response.sendRedirect(ctx + "/index.jsp");
    }
}
