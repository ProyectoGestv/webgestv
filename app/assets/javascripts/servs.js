$('.testconnserv').bind('ajax:success', function(){

});
$().ready(function(){
    $('#testconnserv').click(function(){
        href="/serv/testconn"
        repo=document.getElementById('serv_mother').value
        port=document.getElementById('serv_conn_port').value
        $(this).attr('href', href + '?repo=' + repo + '&port=' + port);
    });
});