package umariana.javaweb.ecotravelsmart.modelo;

import java.util.ArrayList;
import umariana.javaweb.ecotravelsmart.util.Util;

/** Lógica de negocio (CRUD + búsqueda) de los Usuarios, en memoria. */
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

    /** Siguiente id libre (máximo actual + 1). */
    public int siguienteId() {
        int max = 0;
        for (Usuario u : listaUsuarios) {
            max = Math.max(max, u.getIdPersona());
        }
        return max + 1;
    }

    /** ¿Ya existe ese nombre de usuario? (se ignora el usuario con id = excluirId) */
    public boolean existeUsername(String username, int excluirId) {
        for (Usuario u : listaUsuarios) {
            if (u.getIdPersona() != excluirId && u.getUsername().equalsIgnoreCase(username)) {
                return true;
            }
        }
        return false;
    }

    /** Devuelve el usuario si usuario/contraseña son correctos; si no, null. */
    public Usuario autenticar(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        for (Usuario u : listaUsuarios) {
            if (u.getUsername().equalsIgnoreCase(username.trim()) && u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }

    /** Búsqueda por texto (nombre, apellido, correo, usuario) y rol; ignora tildes. */
    public ArrayList<Usuario> buscar(String q, String rol) {
        ArrayList<Usuario> out = new ArrayList<>();
        String nq = Util.sinTildes(q == null ? "" : q.trim());
        for (Usuario u : listaUsuarios) {
            if (rol != null && !rol.isEmpty() && !rol.equals(u.getRol())) {
                continue;
            }
            if (!nq.isEmpty()) {
                String texto = Util.sinTildes(u.getNombre() + " " + u.getApellido() + " "
                        + u.getCorreo() + " " + u.getUsername());
                if (!texto.contains(nq)) {
                    continue;
                }
            }
            out.add(u);
        }
        return out;
    }

    public int contarPorRol(String rol) {
        int n = 0;
        for (Usuario u : listaUsuarios) {
            if (rol.equals(u.getRol())) {
                n++;
            }
        }
        return n;
    }
}
