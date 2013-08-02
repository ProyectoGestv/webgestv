
function enviarinformacion(){

    var valoresenviar = $('#formu').serialize();
    jQuery.ajax({
        url: '/actualizartabla',
        data: valoresenviar,
        dataType: "html",
        success: function(data, request)
        {
        $('#informacion').html(data);

        },
        error: function(data)
        {
        $('#formulario').html(data.responseText)

        var e = document.getElementById("report_option");
        var strUser = e.options[e.selectedIndex].value;
        visibletiempo_o_fecha(strUser);

        }
        });


};

function recargar_atributo(id) {

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

function datostiemporeal (id,atributo) {
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


function visibletiempo_o_fecha(valor)
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



