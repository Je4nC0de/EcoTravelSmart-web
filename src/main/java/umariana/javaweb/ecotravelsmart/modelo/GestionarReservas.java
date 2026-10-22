package umariana.javaweb.ecotravelsmart.modelo;

import java.util.ArrayList;

/** Lógica de negocio (CRUD) de las Reservas, en memoria. */
public class GestionarReservas {

    private final ArrayList<Reserva> listaReservas = new ArrayList<>();

    public void agregarReserva(Reserva r) {
        listaReservas.add(r);
    }

    public boolean eliminarReserva(int idReserva) {
        return listaReservas.removeIf(r -> r.getIdReserva() == idReserva);
    }

    public Reserva buscarReservaPorId(int idReserva) {
        for (Reserva r : listaReservas) {
            if (r.getIdReserva() == idReserva) {
                return r;
            }
        }
        return null;
    }

    public ArrayList<Reserva> listarReservas() {
        return listaReservas;
    }

    public ArrayList<Reserva> porUsuario(int idUsuario) {
        ArrayList<Reserva> out = new ArrayList<>();
        for (Reserva r : listaReservas) {
            if (r.getIdUsuario() == idUsuario) {
                out.add(r);
            }
        }
        return out;
    }

    public int siguienteId() {
        int max = 0;
        for (Reserva r : listaReservas) {
            max = Math.max(max, r.getIdReserva());
        }
        return max + 1;
    }

    public boolean cambiarEstado(int idReserva, String estado) {
        Reserva r = buscarReservaPorId(idReserva);
        if (r == null) {
            return false;
        }
        r.setEstado(estado);
        return true;
    }

    public int contarPorEstado(String estado) {
        int n = 0;
        for (Reserva r : listaReservas) {
            if (estado.equals(r.getEstado())) {
                n++;
            }
        }
        return n;
    }

    /** Ingresos = suma de las reservas confirmadas. */
    public double ingresosConfirmados() {
        double s = 0;
        for (Reserva r : listaReservas) {
            if ("Confirmada".equals(r.getEstado())) {
                s += r.getTotal();
            }
        }
        return s;
    }
}
