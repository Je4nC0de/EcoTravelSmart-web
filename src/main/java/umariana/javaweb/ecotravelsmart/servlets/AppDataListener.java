package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.time.LocalDate;
import umariana.javaweb.ecotravelsmart.modelo.GestionarProductos;
import umariana.javaweb.ecotravelsmart.modelo.GestionarReservas;
import umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios;
import umariana.javaweb.ecotravelsmart.modelo.Producto;
import umariana.javaweb.ecotravelsmart.modelo.Reserva;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;

/**
 * Se ejecuta UNA vez al arrancar la aplicación: crea las listas en memoria
 * (compartidas vía ServletContext) y las llena con datos de ejemplo.
 */
@WebListener
public class AppDataListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        GestionarUsuarios usuarios = new GestionarUsuarios();
        usuarios.agregarUsuario(new Usuario(1, "Laura", "Martínez",
                "laura.martinez@ecotravel.com", "3001112233", "lmartinez", "1234", "Administrador"));
        usuarios.agregarUsuario(new Usuario(2, "Carlos", "Rodríguez",
                "carlos.rodriguez@ecotravel.com", "3002223344", "crodriguez", "1234", "Cliente"));
        usuarios.agregarUsuario(new Usuario(3, "Andrea", "Pérez",
                "andrea.perez@ecotravel.com", "3003334455", "aperez", "1234", "Cliente"));

        GestionarProductos productos = new GestionarProductos();
        productos.agregarProducto(new Producto(1, "Tour ecológico Laguna de La Cocha",
                "Recorrido en lancha y senderos guiados por el humedal más grande de Nariño, con avistamiento de fauna local.",
                85000, "Ecoturismo", "Pasto, Nariño", true));
        productos.agregarProducto(new Producto(2, "Cabañas Bosque Nativo",
                "Hospedaje sostenible con energía solar y recolección de agua lluvia, rodeado de bosque andino.",
                150000, "Hospedaje", "Sibundoy, Putumayo", true));
        productos.agregarProducto(new Producto(3, "Bicicleta eléctrica urbana",
                "Recorridos por el centro histórico y miradores de la ciudad sin emisiones.",
                30000, "Transporte", "Pasto, Nariño", false));
        productos.agregarProducto(new Producto(4, "Ruta del café sostenible",
                "Visita a una finca cafetera de pequeños productores: cosecha, tostión y cata incluida.",
                95000, "Gastronomia", "La Unión, Nariño", true));
        productos.agregarProducto(new Producto(5, "Avistamiento de aves en Galeras",
                "Caminata de amanecer por el Santuario de Flora y Fauna Galeras con guía biólogo.",
                70000, "Ecoturismo", "Santuario Galeras, Nariño", true));
        productos.agregarProducto(new Producto(6, "Ecohostal Volcán Galeras",
                "Habitaciones compartidas y privadas con desayuno orgánico y vista al volcán.",
                110000, "Hospedaje", "Genoy, Nariño", true));
        productos.agregarProducto(new Producto(7, "Shuttle eléctrico al aeropuerto",
                "Traslado aeropuerto - ciudad en vehículo eléctrico, con reserva anticipada.",
                45000, "Transporte", "Pasto, Nariño", true));
        productos.agregarProducto(new Producto(8, "Taller de cocina nariñense",
                "Aprende a preparar platos típicos con ingredientes locales y de temporada.",
                60000, "Gastronomia", "Pasto, Nariño", true));

        GestionarReservas reservas = new GestionarReservas();
        LocalDate hoy = LocalDate.now();
        reservas.agregarReserva(new Reserva(1, 2, 1, hoy.plusDays(10), 2, 170000, "Confirmada", hoy.minusDays(2)));
        reservas.agregarReserva(new Reserva(2, 3, 5, hoy.plusDays(20), 3, 210000, "Pendiente", hoy.minusDays(1)));
        reservas.agregarReserva(new Reserva(3, 2, 8, hoy.plusDays(5), 1, 60000, "Pendiente", hoy));

        sce.getServletContext().setAttribute("gestionarUsuarios", usuarios);
        sce.getServletContext().setAttribute("gestionarProductos", productos);
        sce.getServletContext().setAttribute("gestionarReservas", reservas);
    }
}
