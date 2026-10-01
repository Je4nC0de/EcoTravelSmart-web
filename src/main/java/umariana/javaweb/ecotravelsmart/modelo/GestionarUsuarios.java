package umariana.javaweb.ecotravelsmart.modelo;

import java.util.ArrayList;

/**
 * Clase de lógica de negocio encargada de administrar (CRUD) la
 * lista de Usuarios del sistema EcoTravelSmart.
 */
public class GestionarUsuarios {

    private ArrayList<Usuario> listaUsuarios;

    public GestionarUsuarios() {
        this.listaUsuarios = new ArrayList<>();
    }

    public ArrayList<Usuario> getListaUsuarios() {
        return listaUsuarios;
    }

    public void setListaUsuarios(ArrayList<Usuario> listaUsuarios) {
        this.listaUsuarios = listaUsuarios;
    }

    public void agregarUsuario(Usuario usuario) {
        listaUsuarios.add(usuario);
    }

    public boolean eliminarUsuario(int idPersona) {
        return listaUsuarios.removeIf(u -> u.getIdPersona() == idPersona);
    }

    public boolean actualizarUsuario(Usuario usuarioActualizado) {
        for (int i = 0; i < listaUsuarios.size(); i++) {
            if (listaUsuarios.get(i).getIdPersona() == usuarioActualizado.getIdPersona()) {
                listaUsuarios.set(i, usuarioActualizado);
                return true;
            }
        }
        return false;
    }

    public Usuario buscarUsuarioPorId(int idPersona) {
        for (Usuario u : listaUsuarios) {
            if (u.getIdPersona() == idPersona) {
                return u;
            }
        }
        return null;
    }

    public ArrayList<Usuario> listarUsuarios() {
        return listaUsuarios;
    }
}
