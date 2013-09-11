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
    $('#myAtt').on('click', function (e) {
        update_alerts('myAtt')
    });
    $('#noAtt').on('click', function (e) {
        update_alerts('noAtt')
    });
    $('#solved').on('click', function (e) {
        update_alerts('solved')
    });

    $('#all').button('toggle')
    update_alerts('all');
});

function openModal(alert_id,filtro) {
    document.getElementById("solve_alert_alert_id").value = alert_id;
    document.getElementById("solve_alert_filtro").value = filtro;
    $('#myModal').modal();
}

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

function attend_alert(alrt_id, filtro) {
    jQuery.ajax({
        url: "/attend_alert",
        type: "GET",
        data: {"alrt_id" : alrt_id},
        dataType: "html",
        success: function(data) {
            if(filtro=='noAtt')
                $('#alrt_'+alrt_id).fadeOut(500, function(){ $(this).remove();});
            document.getElementById('state_'+alrt_id).innerHTML=data;
        }
    });
}