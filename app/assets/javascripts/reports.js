var valoresenviar;

function enviarinformacion()
{
    valoresenviar = $('#formu').serialize();
     jQuery.ajax({
        url: '/actualizartabla',
        data: valoresenviar,
        dataType: "json",
        success: function(data,request)
        {
        $('#formularioconsulta').change();
        $('#formularioconsulta').html(data.formm);
        $('#rangofecha').change();
        $('#rangotiempo').change();
        var e = document.getElementById("report_option");
        var strUser = e.options[e.selectedIndex].value;
        visibletiempofecha(strUser);
        $('#informacion').html(data.selectt);

        },
        error:function(data)
        {
        $('#formularioconsulta').change();
        $('#formularioconsulta').html(data.responseText);
        var e = document.getElementById("report_option");
        var strUser = e.options[e.selectedIndex].value;
        visibletiempofecha(strUser);
        }

        });


};

function recargaratributo(id){

    jQuery.ajax({
        url: "/buscaratributo",
        type: "GET",
        data: {"mcr" : id},
        dataType: "html",
        success: function(data)
        {
         $('#divatributoformulario').html(data);
        }
    });
}



function recargarmacroatributo(id){

    jQuery.ajax({
        url: "/buscarmacroatributo",
        type: "GET",
        data: {"manrsc" : id},
        dataType: "html",
        success: function(data)
        {
            $('#divmacroatributoformulario').html(data);
        }
    });
}


function datostiemporeal(id,atributo) {
    jQuery.ajax({
        url: "/datostiemporeal",
        type: "GET",
        data: {"tstamp" : id , "atr":atributo},
        dataType: "json",
        success: function(data)
        {
         return data;
        }
    });
}


function visibletiempofecha(valor)
{
    var fecha = document.getElementById('rangofecha');
    var tiempo = document.getElementById('rangotiempo');
    if (valor == 1)
    {

    fecha.style.display = 'inline'
    tiempo.style.display = 'none'
    }
    if (valor == 2)
    {
    fecha.style.display = 'none'

    tiempo.style.display = 'inline'
    }
    if(valor == 3)
    {
    fecha.style.display = 'none'
    tiempo.style.display = 'none'
    }

}





