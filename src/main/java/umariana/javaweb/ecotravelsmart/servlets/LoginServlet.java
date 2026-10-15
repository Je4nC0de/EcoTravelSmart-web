package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;

/**
 * Procesa el formulario de login.jsp.
 * Busca el usuario/contraseña en la lista en memoria (GestionarUsuarios).
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        GestionarUsuarios gestionarUsuarios =
                (GestionarUsuarios) request.getServletContext().getAttribute("gestionarUsuarios");

        Usuario encontrado = null;
        ArrayList<Usuario> lista = gestionarUsuarios.listarUsuarios();
        for (Usuario u : lista) {
            if (u.getUsername().equals(username) && u.getPassword().equals(password)) {
                encontrado = u;
                break;
            }
        }

        if (encontrado != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", encontrado);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
