package umariana.javaweb.ecotravelsmart.modelo;

/**
 * Representa un usuario del sistema EcoTravelSmart.
 * Hereda los datos personales de Persona y agrega los datos de acceso.
 */
public class Usuario extends Persona {

    private String username;
    private String password;
    private String rol; // Ej: "Administrador", "Cliente"

    public Usuario() {
        super();
    }

    public Usuario(int idPersona, String nombre, String apellido, String correo,
                    String telefono, String username, String password, String rol) {
        super(idPersona, nombre, apellido, correo, telefono);
        this.username = username;
        this.password = password;
        this.rol = rol;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    @Override
    public String toString() {
        return "Usuario{" + "idPersona=" + idPersona + ", nombre=" + nombre
                + " " + apellido + ", username=" + username + ", rol=" + rol + '}';
    }
}
