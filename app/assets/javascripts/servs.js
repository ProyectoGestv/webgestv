$('.testconnserv').bind('ajax:success', function(){
});
$().ready(function(){
    $('#testconnserv').click(function(){
        repo=document.getElementById('serv_mother').value
        port=document.getElementById('conn_port').value
        $(this).attr('href', $(this).attr('href') + '?repo=' + repo + '&port=' + port);
    });
});