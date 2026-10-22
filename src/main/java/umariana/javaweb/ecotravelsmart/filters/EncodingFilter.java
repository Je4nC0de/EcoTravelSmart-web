package umariana.javaweb.ecotravelsmart.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import java.io.IOException;

/**
 * Fuerza UTF-8 al LEER los formularios y al ESCRIBIR las respuestas.
 *
 * IMPORTANTE: solo fija el juego de caracteres. NO cambia el Content-Type,
 * porque si se forzara "text/html" también se aplicaría a style.css,
 * app.js e imágenes, y el navegador rechazaría esos archivos (la página
 * se vería sin estilos).
 */
public class EncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }
}
