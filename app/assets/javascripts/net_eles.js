$().ready(function(){
    $('#testconnnetele').click(function(){
        href="/net_ele/testconn"
        ip=document.getElementById('net_ele_conn_ip').value
        port=document.getElementById('net_ele_conn_port').value
        $(this).attr('href', href + '?ip=' + ip + '&port=' + port);
    });
});