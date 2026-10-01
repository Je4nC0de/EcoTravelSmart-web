package umariana.javaweb.ecotravelsmart.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

/**
 * Recurso REST de prueba para EcoTravelSmart.
 * Disponible en: /EcoTravelSmart/resources/ecotravelsmart
 */
@Path("ecotravelsmart")
public class EcoTravelSmartResource {

    @GET
    public Response ping() {
        return Response
                .ok("ping EcoTravelSmart - Jakarta EE 10")
                .build();
    }
}
