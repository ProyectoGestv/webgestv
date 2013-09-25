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


function verify_input(data)
{
   console.log("hola mundo");
  if(data = 'integer_composite_report')
  {
   var elements = document.getElementsByClassName("integer_composite_report");

   for (var i = 0; i < elements.length; i++)
   {      console.log(elements[i].name)
          elements[i].disabled = true;
   }
  }
}

function lock_fields(data)
{
console.log(data);
}
