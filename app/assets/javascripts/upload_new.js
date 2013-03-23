
function abrirAco(name)
{
    $(name).collapse({ toggle: true });
}

function abrirAllAco()
{
    $('.collapse').collapse({ toggle: true });
}

function showAllAco()
{
    $('.accordion-body').collapse('show');
}

function cerrarAllAco()
{
    $('.accordion-body.in').collapse('toggle');
}
