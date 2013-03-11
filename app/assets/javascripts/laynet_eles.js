$().ready(function(){
    $('#testconnlaynetele').click(function(){
        href="/laynet_ele/testconn"
        ip=document.getElementById('laynet_ele_conn_ip').value
        port=document.getElementById('laynet_ele_conn_port').value
        $(this).attr('href', href + '?ip=' + ip + '&port=' + port);
    });
});