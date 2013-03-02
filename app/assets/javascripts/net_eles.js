$('.testconnnetele').bind('ajax:success', function(){
});
$().ready(function(){
    $('#testconnnetele').click(function(){
        ip=document.getElementById('conn_ip').value
        port=document.getElementById('conn_port').value
        $(this).attr('href', $(this).attr('href') + '?ip=' + ip + '&port=' + port);
    });
});