package umariana.javaweb.ecotravelsmart;

import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;

/**
 * Configura los servicios REST (Jakarta RESTful Web Services) para
 * la aplicación EcoTravelSmart. Todos los recursos REST quedarán
 * disponibles bajo el prefijo /resources/...
 */
@ApplicationPath("resources")
public class EcoTravelSmartRestConfiguration extends Application {

}
