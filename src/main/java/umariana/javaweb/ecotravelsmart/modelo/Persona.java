package umariana.javaweb.ecotravelsmart.modelo;

/**
 * Clase base que representa una persona dentro del sistema EcoTravelSmart.
 * Sirve como superclase para Usuario.
 */
public class Persona {

    protected int idPersona;
    protected String nombre;
    protected String apellido;
    protected String correo;
    protected String telefono;

    public Persona() {
    }

    public Persona(int idPersona, String nombre, String apellido, String correo, String telefono) {
        this.idPersona = idPersona;
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.telefono = telefono;
    }

    public int getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(int idPersona) {
        this.idPersona = idPersona;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    @Override
    public String toString() {
        return nombre + " " + apellido;
    }
}
