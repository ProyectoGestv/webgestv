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

function reload_atr(id,composite) {

    jQuery.ajax({
        url: "/items",
        type: "GET",
        data: {"atrhst" : id , "mcr" : dataa},
        dataType: "html",
        success: function(data)
        {
            alert(data)
            $('#atrhst').html(data);
        }
    });
}