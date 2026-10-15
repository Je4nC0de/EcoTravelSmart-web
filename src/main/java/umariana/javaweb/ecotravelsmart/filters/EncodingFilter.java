package umariana.javaweb.ecotravelsmart.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import java.io.IOException;

/**
 * Filtro que fuerza UTF-8 tanto en la petición (request) como en la
 * respuesta (response) para TODAS las páginas de EcoTravelSmart.
 *
 * Esto es necesario porque el filtro interno de Tomcat
 * (SetCharacterEncodingFilter) solo corrige el encoding de ENTRADA
 * (formularios), no el de SALIDA (el HTML que ve el navegador), que
 * era la causa real de los acentos y emojis rotos.
 */
public class EncodingFilter implements Filter {

    private static final String ENCODING = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nada que inicializar
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        request.setCharacterEncoding(ENCODING);
        response.setCharacterEncoding(ENCODING);
        response.setContentType("text/html; charset=" + ENCODING);

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Nada que liberar
    }
}
