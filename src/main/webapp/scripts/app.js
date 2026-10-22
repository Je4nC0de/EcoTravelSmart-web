/* EcoTravelSmart - comportamiento del lado del cliente */
(function () {
    'use strict';

    // Minúsculas y sin tildes, para que "cafe" encuentre "café".
    function norm(s) {
        return (s || '').normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();
    }

    // 1. Ventana de confirmación para acciones peligrosas (eliminar, cancelar...)
    var modalEl = document.getElementById('modalConfirmar');
    if (modalEl && window.bootstrap) {
        var modal = new bootstrap.Modal(modalEl);
        document.querySelectorAll('[data-confirm]').forEach(function (el) {
            el.addEventListener('click', function (e) {
                e.preventDefault();
                document.getElementById('modalConfirmarTexto').textContent = el.getAttribute('data-confirm');
                document.getElementById('modalConfirmarBtn').setAttribute('href', el.getAttribute('href'));
                modal.show();
            });
        });
    }

    // 2. Filtro en vivo de tablas: escribe y filtra al instante, sin recargar.
    //    <input id="filtroTexto">  <select data-filtro="categoria">  <table id="tablaDatos">
    //    cada fila: <tr data-fila data-categoria="..."> ; fila vacía: <tr id="filaVacia">
    var table = document.getElementById('tablaDatos');
    if (table) {
        var input = document.getElementById('filtroTexto');
        var selects = document.querySelectorAll('select[data-filtro]');
        var counter = document.getElementById('contadorFilas');
        var empty = document.getElementById('filaVacia');
        var rows = Array.prototype.slice.call(table.querySelectorAll('tbody tr[data-fila]'));

        var aplicar = function () {
            var q = norm(input ? input.value.trim() : '');
            var visibles = 0;
            rows.forEach(function (row) {
                var ok = norm(row.textContent).indexOf(q) !== -1;
                selects.forEach(function (sel) {
                    if (ok && sel.value) {
                        ok = row.getAttribute('data-' + sel.getAttribute('data-filtro')) === sel.value;
                    }
                });
                row.style.display = ok ? '' : 'none';
                if (ok) { visibles++; }
            });
            if (counter) { counter.textContent = visibles; }
            if (empty) { empty.style.display = visibles === 0 ? '' : 'none'; }
        };
        if (input) { input.addEventListener('input', aplicar); }
        selects.forEach(function (s) { s.addEventListener('change', aplicar); });
        var limpiar = document.getElementById('limpiarFiltros');
        if (limpiar) {
            limpiar.addEventListener('click', function () {
                if (input) { input.value = ''; }
                selects.forEach(function (s) { s.value = ''; });
                aplicar();
            });
        }
        aplicar();
    }

    // 3. Mostrar / ocultar contraseña
    document.querySelectorAll('[data-toggle-pass]').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var campo = document.querySelector(btn.getAttribute('data-toggle-pass'));
            var icono = btn.querySelector('i');
            var visible = campo.type === 'text';
            campo.type = visible ? 'password' : 'text';
            icono.className = visible ? 'bi bi-eye' : 'bi bi-eye-slash';
        });
    });

    // 4. Validación de formularios con estilos de Bootstrap
    document.querySelectorAll('.needs-validation').forEach(function (form) {
        form.addEventListener('submit', function (e) {
            if (!form.checkValidity()) {
                e.preventDefault();
                e.stopPropagation();
            }
            form.classList.add('was-validated');
        });
    });

    // 5. Fecha mínima = hoy en los campos de fecha de viaje
    document.querySelectorAll('input[data-min-today]').forEach(function (inp) {
        var d = new Date();
        var m = String(d.getMonth() + 1).padStart(2, '0');
        var day = String(d.getDate()).padStart(2, '0');
        inp.min = d.getFullYear() + '-' + m + '-' + day;
    });

    // 6. Total estimado de la reserva según nº de personas
    var personas = document.getElementById('personas');
    var total = document.getElementById('totalEstimado');
    if (personas && total) {
        var actualizar = function () {
            var n = Math.max(1, Math.min(20, parseInt(personas.value, 10) || 1));
            var t = n * parseFloat(personas.getAttribute('data-precio'));
            total.textContent = '$' + Math.round(t).toLocaleString('es-CO');
        };
        personas.addEventListener('input', actualizar);
        actualizar();
    }

    // 7. Contadores animados en el inicio
    document.querySelectorAll('[data-count]').forEach(function (el) {
        var meta = parseInt(el.getAttribute('data-count'), 10) || 0;
        var paso = Math.max(1, Math.ceil(meta / 30));
        var actual = 0;
        var t = setInterval(function () {
            actual = Math.min(meta, actual + paso);
            el.textContent = actual;
            if (actual >= meta) { clearInterval(t); }
        }, 28);
    });

    // 8. Las alertas se cierran solas a los 6 segundos
    if (window.bootstrap) {
        document.querySelectorAll('.alert[data-autoclose]').forEach(function (a) {
            setTimeout(function () { bootstrap.Alert.getOrCreateInstance(a).close(); }, 6000);
        });
    }
})();
