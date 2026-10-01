package umariana.javaweb.ecotravelsmart.modelo;

import java.util.ArrayList;

/**
 * Clase de lógica de negocio encargada de administrar (CRUD) la
 * lista de Productos/Servicios turísticos de EcoTravelSmart.
 */
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
}
