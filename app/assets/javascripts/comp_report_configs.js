$(document).ready(function()
{
console.log('hola');

}
);




function send_form(id)
{
    var valuesconfig = $('#form_report_composite').serialize();
    console.log(valuesconfig)
    jQuery.ajax({
        type: "POST" ,
        url: "/send_form",
        data: valuesconfig,
        dataType: "json",
        success: function(data)
        {
            console.log('bien');
            console.log(valuesconfig);
        }
    });
}


function verify_input(datas , id )
{
   var a = 'string'

  if (datas.toString() == a )
  {
   var mayor = document.getElementById(id.toString() + "higher_to");
   var igual = document.getElementById(id.toString() + "equal_to");
   var menor = document.getElementById(id.toString() + "less_to");
   var diferente = document.getElementById(id.toString() + "different_to");

   mayor.disabled = true ;
   menor.disabled = true ;

  }
}

function lock_fields(datos)
{
console.log(datos);

    var elements = document.getElementsByClassName("integer_composite_report");
    for (var i = 0; i < elements.length; i++)
    {
        console.log(elements[i].id);
        elements[i].disabled = true;
    }
}
