
function sendd (){

    var valuesToSubmit = $('#formu').serialize();
    jQuery.ajax({
        url: '/actualizar', //sumbits it to the given url of the form
        data: valuesToSubmit,
        dataType: "html" , // you want a difference between normal and ajax-calls, and json is standard
        success: function(data, request)
        {
        $('#informacion').html(data);

        },
        error: function(data)
        {
        $('#formulario').html(data.responseText)

        var e = document.getElementById("report_option");
        var strUser = e.options[e.selectedIndex].value;
        visible(strUser);

        }
        });


};

function reload_mcr(id,report) {

    jQuery.ajax({
        url: "/buscaratr",
        type: "GET",
        data: {"mcr" : id},
        dataType: "html",
        success: function(data)
        {
         $('#atrr').html(data);
        }
    });
}

function getdata (id,atr) {
    jQuery.ajax({
        url: "/getdatos",
        type: "GET",
        data: {"tstamp" : id , "atr":atr},
        dataType: "json",
        success: function(data)
        {
         return data;
        }
    });
}


function visible(valor)
{
    var fecha = document.getElementById('rangof');
    var tiempo = document.getElementById('rangot');
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


function llamar()
{

alert("llamar");

}