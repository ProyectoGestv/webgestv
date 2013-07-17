


function clickear (){

    console.log("holaa");
    var valuesToSubmit = $('#formu').serialize();
    console.log(valuesToSubmit);
    jQuery.ajax({
        url: '/actualizar', //sumbits it to the given url of the form
        data: valuesToSubmit,
        dataType: "html" , // you want a difference between normal and ajax-calls, and json is standard
        success: function(data)
        {
        $('#informacion').html(data);
        console.log(data);
        }});


};

function reload_mcr(id) {
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

function select_time(id) {
    jQuery.ajax({
        url: "/rango",
        type: "GET",
        data: {"id" : id},
        dataType: "html",
        success: function(data)
        {
            $('#rango').html(data);
        }
    });
}


function visible(valor)
{
 console.log(valor);
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

}