
function reload_mcr_atr(id){

    jQuery.ajax({
        url: "/search_mcr_atr",
        type: "GET",
        data: {"manrsc" : id},
        dataType: "html",
        success: function(data)
        {
            $('#div_mcr_atr_form').html(data);
        }
    });
}


function enviarinformacion(id){}