package umariana.javaweb.ecotravelsmart.modelo;

import java.time.LocalDate;

/** Reserva que un usuario hace de un producto/servicio turístico. */
public class Reserva {

    private int idReserva;
    private int idUsuario;
    private int idProducto;
    private LocalDate fechaViaje;
    private int personas;
    private double total;
    private String estado; // Pendiente | Confirmada | Cancelada
    private LocalDate fechaCreacion;

    public Reserva() {
    }

    public Reserva(int idReserva, int idUsuario, int idProducto, LocalDate fechaViaje,
            int personas, double total, String estado, LocalDate fechaCreacion) {
        this.idReserva = idReserva;
        this.idUsuario = idUsuario;
        this.idProducto = idProducto;
        this.fechaViaje = fechaViaje;
        this.personas = personas;
        this.total = total;
        this.estado = estado;
        this.fechaCreacion = fechaCreacion;
    }

    public int getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(int idReserva) {
        this.idReserva = idReserva;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public LocalDate getFechaViaje() {
        return fechaViaje;
    }

    public void setFechaViaje(LocalDate fechaViaje) {
        this.fechaViaje = fechaViaje;
    }

    public int getPersonas() {
        return personas;
    }

    public void setPersonas(int personas) {
        this.personas = personas;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public LocalDate getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(LocalDate fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
}
