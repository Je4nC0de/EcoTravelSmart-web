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

/** Procesa el formulario de login.jsp e inicia la sesión. */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        GestionarUsuarios gu = (GestionarUsuarios) getServletContext().getAttribute("gestionarUsuarios");
        Usuario u = gu.autenticar(request.getParameter("username"), request.getParameter("password"));

        if (u == null) {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        HttpSession vieja = request.getSession(false);
        if (vieja != null) {
            vieja.invalidate(); // nueva sesión al iniciar (evita fijación de sesión)
        }
        HttpSession session = request.getSession(true);
        session.setAttribute("usuarioLogueado", u);
        Util.flash(session, "success", "¡Bienvenido/a, " + u.getNombre() + "!");

        String next = request.getParameter("next");
        boolean nextValido = next != null && next.startsWith("/") && !next.startsWith("//")
                && !next.contains("\\") && !next.contains("\r") && !next.contains("\n");

        if (nextValido) {
            response.sendRedirect(request.getContextPath() + next);
        } else if ("Administrador".equals(u.getRol())) {
            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/productos.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
