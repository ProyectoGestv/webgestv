$('.testconnnetele').bind('ajax:success', function(){
});
$().ready(function(){
    href="/net_ele/testconn"
    $('#testconnnetele').click(function(){
        ip=document.getElementById('conn_ip').value
        port=document.getElementById('conn_port').value
        $(this).attr('href', href + '?ip=' + ip + '&port=' + port);
    });
});