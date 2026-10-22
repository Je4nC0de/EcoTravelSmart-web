package umariana.javaweb.ecotravelsmart.util;

import jakarta.servlet.http.HttpSession;
import java.text.Normalizer;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

/** Utilidades compartidas por servlets y JSP. */
public final class Util {

    private Util() {
    }

    /** {código, etiqueta, ícono de Bootstrap Icons} */
    public static final String[][] CATEGORIAS = {
        {"Ecoturismo", "Ecoturismo", "bi-tree-fill"},
        {"Hospedaje", "Hospedaje sostenible", "bi-house-heart-fill"},
        {"Transporte", "Transporte verde", "bi-bicycle"},
        {"Gastronomia", "Gastronomía local", "bi-cup-hot-fill"}
    };

    public static String catLabel(String codigo) {
        for (String[] c : CATEGORIAS) {
            if (c[0].equals(codigo)) {
                return c[1];
            }
        }
        return codigo == null ? "" : codigo;
    }

    public static String catIcon(String codigo) {
        for (String[] c : CATEGORIAS) {
            if (c[0].equals(codigo)) {
                return c[2];
            }
        }
        return "bi-compass";
    }

    public static boolean categoriaValida(String codigo) {
        for (String[] c : CATEGORIAS) {
            if (c[0].equals(codigo)) {
                return true;
            }
        }
        return false;
    }

    /** Escapa HTML para evitar que el texto del usuario rompa la página (XSS). */
    public static String esc(Object o) {
        if (o == null) {
            return "";
        }
        String s = String.valueOf(o);
        StringBuilder sb = new StringBuilder(s.length() + 16);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '&': sb.append("&amp;"); break;
                case '<': sb.append("&lt;"); break;
                case '>': sb.append("&gt;"); break;
                case '"': sb.append("&quot;"); break;
                case '\'': sb.append("&#39;"); break;
                default: sb.append(c);
            }
        }
        return sb.toString();
    }

    /** 85000 -> $85.000 */
    public static String precio(double v) {
        return String.format(Locale.forLanguageTag("es-CO"), "$%,.0f", v);
    }

    /** 2026-11-05 -> 05 nov 2026 */
    public static String fecha(LocalDate d) {
        if (d == null) {
            return "";
        }
        return d.format(DateTimeFormatter.ofPattern("dd MMM yyyy", Locale.forLanguageTag("es-CO")));
    }

    public static String recortar(String s, int max) {
        if (s == null) {
            return "";
        }
        return s.length() <= max ? s : s.substring(0, max).trim() + "...";
    }

    /** Minúsculas y sin tildes, para búsquedas que ignoran acentos. */
    public static String sinTildes(String s) {
        if (s == null) {
            return "";
        }
        return Normalizer.normalize(s, Normalizer.Form.NFD)
                .replaceAll("\\p{M}", "").toLowerCase(Locale.ROOT);
    }

    public static String limpiar(String s) {
        return s == null ? "" : s.trim();
    }

    /** Clase CSS del badge según el estado de una reserva. */
    public static String badgeEstado(String estado) {
        if ("Confirmada".equals(estado)) {
            return "badge-soft-success";
        }
        if ("Cancelada".equals(estado)) {
            return "badge-soft-danger";
        }
        return "badge-soft-warning";
    }

    /** Guarda un mensaje que se mostrará UNA vez en la siguiente página. */
    public static void flash(HttpSession s, String tipo, String mensaje) {
        String t = ("success".equals(tipo) || "danger".equals(tipo)
                || "warning".equals(tipo)) ? tipo : "info";
        s.setAttribute("flashTipo", t);
        s.setAttribute("flashMsg", mensaje);
    }
}
