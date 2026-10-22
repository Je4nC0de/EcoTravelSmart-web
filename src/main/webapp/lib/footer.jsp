</main>

<footer class="footer-eco">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-5">
                <div class="d-flex align-items-center mb-3">
                    <span class="brand-mark"><i class="bi bi-leaf-fill"></i></span>
                    <span class="text-white fw-bold fs-5">EcoTravelSmart</span>
                </div>
                <p class="mb-0" style="max-width:380px">Turismo inteligente y sostenible. Conectamos viajeros con experiencias que cuidan el territorio y a las comunidades locales.</p>
            </div>
            <div class="col-6 col-lg-3 offset-lg-1">
                <h6>Explorar</h6>
                <ul class="list-unstyled mb-0 small d-grid gap-2">
                    <li><a href="<%= ctx %>/index.jsp">Inicio</a></li>
                    <li><a href="<%= ctx %>/productos.jsp">Catálogo de servicios</a></li>
                    <li><a href="<%= ctx %>/misReservas.jsp">Mis reservas</a></li>
                </ul>
            </div>
            <div class="col-6 col-lg-3">
                <h6>Cuenta</h6>
                <ul class="list-unstyled mb-0 small d-grid gap-2">
                    <li><a href="<%= ctx %>/login.jsp">Ingresar</a></li>
                    <li><a href="<%= ctx %>/registroUsuarios.jsp">Crear cuenta</a></li>
                </ul>
            </div>
        </div>
        <div class="small-line d-flex flex-wrap justify-content-between gap-2">
            <span>&copy; 2026 EcoTravelSmart. Todos los derechos reservados.</span>
            <span>Proyecto Java Web - Jakarta EE 10</span>
        </div>
    </div>
</footer>

<!-- Ventana de confirmación reutilizable (ver scripts/app.js) -->
<div class="modal fade" id="modalConfirmar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold">Confirmar acción</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <div class="modal-body"><p id="modalConfirmarTexto" class="mb-0"></p></div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
                <a id="modalConfirmarBtn" class="btn btn-danger" href="#">Confirmar</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= ctx %>/scripts/app.js"></script>
</body>
</html>
