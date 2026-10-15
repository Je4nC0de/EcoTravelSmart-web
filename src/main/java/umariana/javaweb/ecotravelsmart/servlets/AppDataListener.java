package umariana.javaweb.ecotravelsmart.servlets;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import umariana.javaweb.ecotravelsmart.modelo.GestionarProductos;
import umariana.javaweb.ecotravelsmart.modelo.GestionarUsuarios;
import umariana.javaweb.ecotravelsmart.modelo.Producto;
import umariana.javaweb.ecotravelsmart.modelo.Usuario;

/**
 * Se ejecuta UNA sola vez, cuando la aplicación arranca en Tomcat.
 * Crea las listas de Usuarios y Productos en memoria (compartidas por
 * toda la aplicación, vía ServletContext) y las llena con datos de
 * ejemplo, para que los Servlets y los JSP de administración tengan
 * algo que mostrar desde el primer momento.
 */
@WebListener
public class AppDataListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        GestionarUsuarios gestionarUsuarios = new GestionarUsuarios();
        gestionarUsuarios.agregarUsuario(new Usuario(1, "Laura", "Martínez",
                "laura.martinez@ecotravel.com", "3001112233", "lmartinez", "1234", "Administrador"));
        gestionarUsuarios.agregarUsuario(new Usuario(2, "Carlos", "Rodríguez",
                "carlos.rodriguez@ecotravel.com", "3002223344", "crodriguez", "1234", "Cliente"));
        gestionarUsuarios.agregarUsuario(new Usuario(3, "Andrea", "Pérez",
                "andrea.perez@ecotravel.com", "3003334455", "aperez", "1234", "Cliente"));

        GestionarProductos gestionarProductos = new GestionarProductos();
        gestionarProductos.agregarProducto(new Producto(1, "Tour ecológico Laguna Verde",
                "Recorrido guiado por senderos ecológicos.", 85000, "Ecoturismo", "Nariño", true));
        gestionarProductos.agregarProducto(new Producto(2, "Cabañas Bosque Nativo",
                "Hospedaje sostenible en medio del bosque.", 150000, "Hospedaje", "Putumayo", true));
        gestionarProductos.agregarProducto(new Producto(3, "Transporte en bicicleta eléctrica",
                "Recorridos urbanos en bicicleta eléctrica.", 30000, "Transporte", "Pasto", false));

        sce.getServletContext().setAttribute("gestionarUsuarios", gestionarUsuarios);
        sce.getServletContext().setAttribute("gestionarProductos", gestionarProductos);
        sce.getServletContext().setAttribute("contadorUsuarios", 4);
        sce.getServletContext().setAttribute("contadorProductos", 4);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nada que liberar
    }
}
