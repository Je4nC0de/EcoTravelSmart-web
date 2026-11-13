package umariana.javaweb.ecotravelsmart.util;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import umariana.javaweb.ecotravelsmart.modelo.*;

/**
 * Persistencia de texto de usuarios, productos y reservas.
 * Carpeta configurable mediante ECOTRAVEL_DATA_DIR o -Decotravel.data.dir.
 * Formato: columnas separadas por tabulador; textos codificados en Base64 UTF-8.
 */
public final class Persistencia {
    private Persistencia() {}

    private static Path carpeta() {
        String ruta = System.getProperty("ecotravel.data.dir");
        if (ruta == null || ruta.trim().isEmpty()) ruta = System.getenv("ECOTRAVEL_DATA_DIR");
        if (ruta == null || ruta.trim().isEmpty()) ruta = System.getProperty("user.home") + "/ecotravelsmart-data";
        return Paths.get(ruta).toAbsolutePath();
    }

    private static String cod(String s) {
        return Base64.getEncoder().encodeToString((s == null ? "" : s).getBytes(StandardCharsets.UTF_8));
    }
    private static String dec(String s) {
        return new String(Base64.getDecoder().decode(s), StandardCharsets.UTF_8);
    }
    private static void escribir(String nombre, List<String> lineas) throws IOException {
        Path dir = carpeta();
        Files.createDirectories(dir);
        Path destino = dir.resolve(nombre);
        Path temp = Files.createTempFile(dir, nombre, ".tmp");
        try {
            Files.write(temp, lineas, StandardCharsets.UTF_8);
            try {
                Files.move(temp, destino, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);
            } catch (AtomicMoveNotSupportedException e) {
                Files.move(temp, destino, StandardCopyOption.REPLACE_EXISTING);
            }
        } finally {
            Files.deleteIfExists(temp);
        }
    }
    private static List<String> leer(String nombre) throws IOException {
        Path archivo = carpeta().resolve(nombre);
        return Files.exists(archivo) ? Files.readAllLines(archivo, StandardCharsets.UTF_8) : null;
    }
    public static boolean existenDatos() {
        return Files.exists(carpeta().resolve("usuarios.txt"))
                && Files.exists(carpeta().resolve("items.txt"))
                && Files.exists(carpeta().resolve("reservas.txt"));
    }

    public static synchronized void guardar(GestionarUsuarios usuarios, GestionarProductos productos,
                                             GestionarReservas reservas) throws IOException {
        List<String> lu = new ArrayList<>();
        for (Usuario u : usuarios.listarUsuarios()) {
            lu.add(u.getIdPersona()+"\t"+cod(u.getNombre())+"\t"+cod(u.getApellido())+"\t"
                +cod(u.getCorreo())+"\t"+cod(u.getTelefono())+"\t"+cod(u.getUsername())+"\t"
                +cod(u.getPassword())+"\t"+cod(u.getRol()));
        }
        List<String> lp = new ArrayList<>();
        for (Producto p : productos.listarProductos()) {
            lp.add(p.getIdProducto()+"\t"+cod(p.getNombre())+"\t"+cod(p.getDescripcion())+"\t"
                +p.getPrecio()+"\t"+cod(p.getCategoria())+"\t"+cod(p.getUbicacion())+"\t"+p.isDisponible());
        }
        List<String> lr = new ArrayList<>();
        List<String> reporte = new ArrayList<>();
        reporte.add("ECOTRAVELSMART - REPORTE DE RESERVAS");
        reporte.add("Generado: " + java.time.LocalDateTime.now());
        reporte.add("--------------------------------------------");
        for (Reserva r : reservas.listarReservas()) {
            lr.add(r.getIdReserva()+"\t"+r.getIdUsuario()+"\t"+r.getIdProducto()+"\t"
                +r.getFechaViaje()+"\t"+r.getPersonas()+"\t"+r.getTotal()+"\t"
                +cod(r.getEstado())+"\t"+r.getFechaCreacion());
            Usuario u = usuarios.buscarUsuarioPorId(r.getIdUsuario());
            Producto p = productos.buscarProductoPorId(r.getIdProducto());
            reporte.add("Reserva #"+r.getIdReserva()+" | Cliente: "+(u==null?"(eliminado)":u.getNombre()+" "+u.getApellido())
                +" | Item: "+(p==null?"(eliminado)":p.getNombre())+" | Fecha: "+r.getFechaViaje()
                +" | Personas: "+r.getPersonas()+" | Total: "+r.getTotal()+" | Estado: "+r.getEstado());
        }
        reporte.add("--------------------------------------------");
        reporte.add("Ingresos confirmados: "+reservas.ingresosConfirmados());
        escribir("usuarios.txt", lu);
        escribir("items.txt", lp);
        escribir("reservas.txt", lr);
        escribir("reporte.txt", reporte);
    }

    public static synchronized void cargar(GestionarUsuarios usuarios, GestionarProductos productos,
                                            GestionarReservas reservas) throws IOException {
        List<String> lu = leer("usuarios.txt"), lp = leer("items.txt"), lr = leer("reservas.txt");
        if (lu == null || lp == null || lr == null) throw new IOException("Archivos de datos incompletos");
        ArrayList<Usuario> nuevosUsuarios = new ArrayList<>();
        ArrayList<Producto> nuevosProductos = new ArrayList<>();
        ArrayList<Reserva> nuevasReservas = new ArrayList<>();
        try {
            for (String linea : lu) {
                if (linea.isEmpty()) continue;
                String[] a = linea.split("\t", -1);
                if (a.length != 8) throw new IllegalArgumentException("Columnas usuarios");
                nuevosUsuarios.add(new Usuario(Integer.parseInt(a[0]),dec(a[1]),dec(a[2]),dec(a[3]),
                    dec(a[4]),dec(a[5]),dec(a[6]),dec(a[7])));
            }
            for (String linea : lp) {
                if (linea.isEmpty()) continue;
                String[] a = linea.split("\t", -1);
                if (a.length != 7) throw new IllegalArgumentException("Columnas items");
                nuevosProductos.add(new Producto(Integer.parseInt(a[0]),dec(a[1]),dec(a[2]),
                    Double.parseDouble(a[3]),dec(a[4]),dec(a[5]),Boolean.parseBoolean(a[6])));
            }
            for (String linea : lr) {
                if (linea.isEmpty()) continue;
                String[] a = linea.split("\t", -1);
                if (a.length != 8) throw new IllegalArgumentException("Columnas reservas");
                nuevasReservas.add(new Reserva(Integer.parseInt(a[0]),Integer.parseInt(a[1]),
                    Integer.parseInt(a[2]),LocalDate.parse(a[3]),Integer.parseInt(a[4]),
                    Double.parseDouble(a[5]),dec(a[6]),LocalDate.parse(a[7])));
            }
        } catch (RuntimeException e) {
            throw new IOException("Error al interpretar archivos de persistencia", e);
        }
        usuarios.setListaUsuarios(nuevosUsuarios);
        productos.setListaProductos(nuevosProductos);
        reservas.listarReservas().clear();
        reservas.listarReservas().addAll(nuevasReservas);
    }
}
