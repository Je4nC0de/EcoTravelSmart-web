package umariana.javaweb.ecotravelsmart.modelo;

/**
 * Representa un producto o servicio turístico ofrecido en EcoTravelSmart
 * (por ejemplo: tour ecológico, hospedaje sostenible, transporte verde).
 */
public class Producto {

    private int idProducto;
    private String nombre;
    private String descripcion;
    private double precio;
    private String categoria;   // Ej: "Ecoturismo", "Hospedaje", "Transporte"
    private String ubicacion;
    private boolean disponible;

    public Producto() {
    }

    public Producto(int idProducto, String nombre, String descripcion, double precio,
                     String categoria, String ubicacion, boolean disponible) {
        this.idProducto = idProducto;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.categoria = categoria;
        this.ubicacion = ubicacion;
        this.disponible = disponible;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    @Override
    public String toString() {
        return "Producto{" + "idProducto=" + idProducto + ", nombre=" + nombre
                + ", precio=" + precio + ", categoria=" + categoria + '}';
    }
}
