# EcoTravelSmart - Proyecto Java Web

## Versión Jakarta EE 10 (alineado con el ejemplo del profesor)

Este proyecto fue actualizado para seguir el mismo patrón del ejemplo visto en clase
(`Proyect-JavaWeb1`):

- `pom.xml` usa el perfil completo **jakarta.jakartaee-api 10.0.0** (en vez de solo servlet-api + JSTL).
- `web.xml` en versión **6.0** (Jakarta EE 10), con `session-timeout` configurado.
- `META-INF/context.xml` define el path de despliegue `/EcoTravelSmart`.
- `WEB-INF/beans.xml` habilita CDI (Contexts and Dependency Injection).
- `src/main/resources/META-INF/persistence.xml` deja lista la unidad de persistencia JPA
  (`EcoTravelSmartPU`), para cuando se conecte la base de datos.
- Se agregó un recurso **REST (JAX-RS)** de ejemplo:
  - `EcoTravelSmartRestConfiguration.java` → activa `/resources/*`
  - `resources/EcoTravelSmartResource.java` → responde en
    `http://localhost:8080/EcoTravelSmart/resources/ecotravelsmart`
- `lib/header.jsp` ahora incluye **Bootstrap 5.3.8** vía CDN, además del CSS propio.
- Las 6 páginas JSP ya no repiten `<html>/<head>/<body>` — ese bloque vive una sola vez
  en `header.jsp` (abre) y `footer.jsp` (cierra), igual que en el ejemplo del profesor.

## Cómo importar en NetBeans

1. File > Open Project > selecciona la carpeta `EcoTravelSmart` (contiene `pom.xml`).
2. Click derecho sobre el proyecto > Clean and Build.
3. Click derecho > Properties > Run > selecciona tu servidor Tomcat 10.1.60.
4. Click derecho > Run. Se abre en `http://localhost:8080/EcoTravelSmart/index.jsp`.
5. Prueba el endpoint REST de ejemplo en:
   `http://localhost:8080/EcoTravelSmart/resources/ecotravelsmart`

## Estructura del proyecto

```
EcoTravelSmart/
├── pom.xml
├── src/main/resources/META-INF/persistence.xml
├── src/main/java/umariana/javaweb/ecotravelsmart/
│   ├── EcoTravelSmartRestConfiguration.java   (JAX-RS @ApplicationPath)
│   ├── resources/EcoTravelSmartResource.java  (JAX-RS @Path de ejemplo)
│   ├── modelo/
│   │   ├── Persona.java
│   │   ├── Usuario.java
│   │   ├── Producto.java
│   │   ├── GestionarUsuarios.java
│   │   └── GestionarProductos.java
│   └── servlets/          (vacío, para próxima entrega)
└── src/main/webapp/        <- equivale a "Web Pages"
    ├── META-INF/context.xml
    ├── WEB-INF/web.xml, beans.xml
    ├── images/banner.jpg
    ├── lib/header.jsp (Bootstrap + navbar), footer.jsp
    ├── scripts/             (vacío, para JS futuro)
    ├── styles/style.css
    ├── index.jsp
    ├── login.jsp
    ├── adminUsuarios.jsp
    ├── registroUsuarios.jsp
    ├── adminProductos.jsp
    └── registroProductos.jsp
```

## Notas

- Todas las vistas (JSP) siguen siendo SOLO navegación y formularios (no funcional aún).
- `beans.xml` y `persistence.xml` están vacíos/listos; se completan cuando se agregue
  inyección de dependencias real y conexión a base de datos.
- El recurso REST es solo un "ping" de ejemplo, como el del profesor — se reemplaza
  por recursos reales (UsuarioResource, ProductoResource) en la siguiente entrega.
