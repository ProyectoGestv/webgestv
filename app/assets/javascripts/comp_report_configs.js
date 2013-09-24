function send_form(id)
{
    // falta por arreglar
    jQuery.ajax({
        url: "/set_form",
        type: "GET",
        data: {"paracom" : id},
        dataType: "html",
        success: function(data)
        {
            $('#div_filters').html(data);
        }
    });
}


function verify_input(data)
{

   console.log("hola mundo");


  if(data = 'integer_composite_report')
  {
   var elements = document.getElementsByClassName("integer_string_composite_report");

   for (var i = 0; i < elements.length; i++)
   {
          elements[i].disabled = true;
   }


  }


}
