<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="umariana.javaweb.ecotravelsmart.modelo.*" %>
<%@ page import="umariana.javaweb.ecotravelsmart.util.Util" %>
<%
    Usuario conectado = (Usuario) session.getAttribute("usuarioLogueado");
    if (conectado == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    int idReserva;
    try { idReserva = Integer.parseInt(request.getParameter("id")); }
    catch (NumberFormatException e) { response.sendError(400, "Número de reserva inválido"); return; }
    GestionarReservas gr = (GestionarReservas) application.getAttribute("gestionarReservas");
    GestionarUsuarios gu = (GestionarUsuarios) application.getAttribute("gestionarUsuarios");
    GestionarProductos gp = (GestionarProductos) application.getAttribute("gestionarProductos");
    Reserva reserva = gr.buscarReservaPorId(idReserva);
    if (reserva == null) { response.sendError(404, "Reserva no encontrada"); return; }
    boolean admin = "Administrador".equals(conectado.getRol());
    if (!admin && reserva.getIdUsuario() != conectado.getIdPersona()) {
        response.sendError(403, "No puedes ver el comprobante de otro cliente");
        return;
    }
    Usuario cliente = gu.buscarUsuarioPorId(reserva.getIdUsuario());
    Producto producto = gp.buscarProductoPorId(reserva.getIdProducto());
    String nombreCliente = cliente == null ? "Cliente no disponible" : cliente.getNombre()+" "+cliente.getApellido();
    String nombreProducto = producto == null ? "Servicio no disponible" : producto.getNombre();
    request.setAttribute("tituloPagina", "Comprobante de reserva");
%>
<%@ include file="lib/header.jsp" %>
<style>
.recibo {max-width:720px;margin:36px auto;background:white;border:1px solid #dce8df;border-radius:18px;overflow:hidden;box-shadow:0 12px 38px #123c2a14}
.recibo-cabecera {background:#226747;color:white;padding:30px}
.recibo-cuerpo {padding:32px}
.recibo-fila {display:flex;justify-content:space-between;gap:20px;padding:12px 0;border-bottom:1px solid #e9eeeb}
.recibo-fila span:first-child {color:#687a71}
.recibo-total {font-size:1.6rem;font-weight:800;color:#226747}
@media print {
  nav,.navbar,.recibo-acciones,footer,.alert {display:none!important}
  body {background:white!important}
  .recibo {box-shadow:none;border:1px solid #ddd;margin:0 auto}
  .recibo-cabecera {-webkit-print-color-adjust:exact;print-color-adjust:exact}
}
</style>
<div class="container">
 <div class="recibo-acciones text-center mt-4">
  <a href="<%= ctx %>/misReservas.jsp" class="btn btn-light me-2">Volver a mis reservas</a>
  <button type="button" class="btn btn-primary" onclick="window.print()"><i class="bi bi-printer me-1"></i>Imprimir / Guardar PDF</button>
 </div>
 <article class="recibo">
  <header class="recibo-cabecera">
   <h2 class="mb-1"><i class="bi bi-leaf-fill me-2"></i>EcoTravelSmart</h2>
   <div>COMPROBANTE DE RESERVA</div>
  </header>
  <div class="recibo-cuerpo">
   <div class="d-flex justify-content-between align-items-center mb-3">
    <strong>Reserva #<%= reserva.getIdReserva() %></strong>
    <span class="badge-soft <%= Util.badgeEstado(reserva.getEstado()) %>"><%= Util.esc(reserva.getEstado()) %></span>
   </div>
   <div class="recibo-fila"><span>Cliente</span><strong><%= Util.esc(nombreCliente) %></strong></div>
   <div class="recibo-fila"><span>Servicio turístico</span><strong><%= Util.esc(nombreProducto) %></strong></div>
   <div class="recibo-fila"><span>Fecha de reserva</span><strong><%= Util.fecha(reserva.getFechaCreacion()) %></strong></div>
   <div class="recibo-fila"><span>Fecha del viaje</span><strong><%= Util.fecha(reserva.getFechaViaje()) %></strong></div>
   <div class="recibo-fila"><span>Número de personas</span><strong><%= reserva.getPersonas() %></strong></div>
   <div class="recibo-fila"><span>Precio por persona</span><strong><%= Util.precio(reserva.getTotal()/reserva.getPersonas()) %></strong></div>
   <div class="recibo-fila align-items-center"><strong>TOTAL</strong><span class="recibo-total"><%= Util.precio(reserva.getTotal()) %></span></div>
   <p class="text-muted small mt-4 mb-0">Este documento confirma el registro de la reserva en EcoTravelSmart. No constituye factura electrónica ni comprobante de pago. Consulta el estado de tu reserva antes del viaje.</p>
  </div>
 </article>
</div>
<%@ include file="lib/footer.jsp" %>
