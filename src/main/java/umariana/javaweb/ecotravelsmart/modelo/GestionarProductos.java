package umariana.javaweb.ecotravelsmart.modelo;

import java.util.ArrayList;
import java.util.Comparator;
import umariana.javaweb.ecotravelsmart.util.Util;

/** Lógica de negocio (CRUD + filtros de búsqueda) de los Productos/Servicios. */
public class GestionarProductos {

    private ArrayList<Producto> listaProductos;

    public GestionarProductos() {
        this.listaProductos = new ArrayList<>();
    }

    public ArrayList<Producto> getListaProductos() {
        return listaProductos;
    }

    public void setListaProductos(ArrayList<Producto> listaProductos) {
        this.listaProductos = listaProductos;
    }

    public void agregarProducto(Producto producto) {
        listaProductos.add(producto);
    }

    public boolean eliminarProducto(int idProducto) {
        return listaProductos.removeIf(p -> p.getIdProducto() == idProducto);
    }

    public boolean actualizarProducto(Producto productoActualizado) {
        for (int i = 0; i < listaProductos.size(); i++) {
            if (listaProductos.get(i).getIdProducto() == productoActualizado.getIdProducto()) {
                listaProductos.set(i, productoActualizado);
                return true;
            }
        }
        return false;
    }

    public Producto buscarProductoPorId(int idProducto) {
        for (Producto p : listaProductos) {
            if (p.getIdProducto() == idProducto) {
                return p;
            }
        }
        return null;
    }

    public ArrayList<Producto> listarProductos() {
        return listaProductos;
    }

    public int siguienteId() {
        int max = 0;
        for (Producto p : listaProductos) {
            max = Math.max(max, p.getIdProducto());
        }
        return max + 1;
    }

    /**
     * Filtro principal del catálogo.
     *
     * @param q texto libre (nombre, descripción, ubicación, categoría); ignora tildes
     * @param categoria código de categoría o vacío para todas
     * @param soloDisponibles true = oculta los no disponibles
     * @param precioMax precio máximo (0 o menos = sin límite)
     * @param orden precio_asc | precio_desc | nombre | (vacío = orden original)
     */
    public ArrayList<Producto> buscar(String q, String categoria, boolean soloDisponibles,
            double precioMax, String orden) {
        ArrayList<Producto> out = new ArrayList<>();
        String nq = Util.sinTildes(q == null ? "" : q.trim());

        for (Producto p : listaProductos) {
            if (categoria != null && !categoria.isEmpty() && !categoria.equals(p.getCategoria())) {
                continue;
            }
            if (soloDisponibles && !p.isDisponible()) {
                continue;
            }
            if (precioMax > 0 && p.getPrecio() > precioMax) {
                continue;
            }
            if (!nq.isEmpty()) {
                String texto = Util.sinTildes(p.getNombre() + " " + nz(p.getDescripcion()) + " "
                        + nz(p.getUbicacion()) + " " + Util.catLabel(p.getCategoria()));
                if (!texto.contains(nq)) {
                    continue;
                }
            }
            out.add(p);
        }

        if ("precio_asc".equals(orden)) {
            out.sort(Comparator.comparingDouble(Producto::getPrecio));
        } else if ("precio_desc".equals(orden)) {
            out.sort(Comparator.comparingDouble(Producto::getPrecio).reversed());
        } else if ("nombre".equals(orden)) {
            out.sort(Comparator.comparing((Producto p) -> Util.sinTildes(p.getNombre())));
        }
        return out;
    }

    private static String nz(String s) {
        return s == null ? "" : s;
    }

    public int contarDisponibles() {
        int n = 0;
        for (Producto p : listaProductos) {
            if (p.isDisponible()) {
                n++;
            }
        }
        return n;
    }

    public int contarPorCategoria(String categoria) {
        int n = 0;
        for (Producto p : listaProductos) {
            if (categoria.equals(p.getCategoria())) {
                n++;
            }
        }
        return n;
    }

    public double precioPromedio() {
        if (listaProductos.isEmpty()) {
            return 0;
        }
        double suma = 0;
        for (Producto p : listaProductos) {
            suma += p.getPrecio();
        }
        return suma / listaProductos.size();
    }
}
