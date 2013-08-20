var dataa;

function reload_mac(id,composite) {

    jQuery.ajax({
        url: "/searchatr",
        type: "GET",
        data: {"mcr" : id},
        dataType: "html",
        success: function(data)
        {
         dataa  = id ;
         $('#atri').html(data);
        }
    });
}

function reload_hsts(id,composite) {

    jQuery.ajax({
        url: "/edit_multiple",
        type: "GET",
        data: {"hsts" : id},
        dataType: "html",
        success: function(data)
        {
            alert(data);
            dataa  = id ;
            $('#hsts').html(data);

        }
    });
}

function reload_atr(id,composite) {

    jQuery.ajax({
        url: "/items",
        type: "GET",
        data: {"atrhst" : id , "mcr" : dataa},
        dataType: "html",
        success: function(data)
        {
            $('#atrhst').html(data);
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

