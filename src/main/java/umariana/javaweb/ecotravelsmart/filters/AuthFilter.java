package umariana.javaweb.ecotravelsmart.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;
import umariana.javaweb.ecotravelsmart.util.Util;

/**
 * Protege las páginas privadas:
 *  - misReservas.jsp y ReservaServlet: cualquier usuario con sesión iniciada.
 *  - Paneles de administración: solo rol "Administrador".
 */
@WebFilter(urlPatterns = {
    "/adminUsuarios.jsp", "/adminProductos.jsp", "/registroProductos.jsp",
    "/dashboard.jsp", "/misReservas.jsp", "/ReservaServlet", "/ProductoServlet"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        String path = req.getServletPath();
        boolean soloLogin = path.equals("/misReservas.jsp") || path.equals("/ReservaServlet");

        if (usuario == null) {
            String destino = path + (req.getQueryString() != null ? "?" + req.getQueryString() : "");
            Util.flash(session, "warning", "Inicia sesión para continuar.");
            resp.sendRedirect(req.getContextPath() + "/login.jsp?next="
                    + URLEncoder.encode(destino, StandardCharsets.UTF_8));
            return;
        }

        if (!soloLogin && !"Administrador".equals(usuario.getRol())) {
            Util.flash(session, "danger", "No tienes permisos para acceder a esa sección.");
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
