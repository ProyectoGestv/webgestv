$(document).ready(function() {
    $('.popover-test').popover(placement="bottom", trigger= "hover");

    $('#all').on('click', function (e) {
        update_alerts('all')
    });
    $('#alarm').on('click', function (e) {
        update_alerts('alarm')
    });
    $('#anmly').on('click', function (e) {
        update_alerts('anmly')
    });
    $('#notif').on('click', function (e) {
        update_alerts('notif')
    });

    $('#all').button('toggle')
    update_alerts('all');
});

function update_alerts(filtro) {
    jQuery.ajax({
        url: "/update_alerts",
        type: "GET",
        data: {"filter" : filtro},
        dataType: "html",
        success: function(data) {
            document.getElementById('divalertas').innerHTML=data;
            //window.setTimeout("update_alerts()",5000);
        }
    });
}

