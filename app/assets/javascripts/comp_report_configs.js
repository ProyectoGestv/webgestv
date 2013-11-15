var integer_radio;
var  prev_checked_radio;
$(document).ready(create_options_form);



function create_options_form()
{
   /* capture la ultima fila  seleccionando uno de los campos*/
   integer_radio =  $('input[type=radio]:last').attr('id').replace(/\D/g, '');
   /*pase por cada una de las filas bloqueando los campos hasta que el usuario seleccione uno para modificar*/
   for(i=0;i<=integer_radio;i++)
   {
   block_row(i , 0);
   }
}

// bloqueamos la fila segun la seleccion del usuario o los parametros por defecto (indispensable)
function block_row(rownumber , option)
{
  $(".text_field_v_"+rownumber).attr("disabled", true);
  if(option==1)  // bloqueamos la fila completa  como cuando se tiene el atr_variable
  {$("#check_"+rownumber).attr("disabled", true);}
  if(option == 2) // si no esta checked solo este se desbloquea y si no tiene atr variable asociado
  {$("#check_"+rownumber).attr("disabled", false);}
}

// habilitamos la fila segun la seleccion del usuario o los parametros por defecto de algunos campos ( indispensable )
function unblock_row(rownumber , option)
{
    $(".text_field_v_"+rownumber).attr("disabled",false);
    if(option == 1) // si cambiamos de atributo variable el check tambien se habilita
    { $("#check_"+rownumber).attr("disabled", false);}
}

// al cargar el formulario leemos el tipo de dato de cada filtro y desabilitamos algunos campos de los filtros que sean booleanos o string  (indispensable)
function unblock_row_by_type(rownumber)
{
 var type  = $("#input_text_type_"+rownumber).val();
 // string
 if (type == 'string')
 {   $("#input_text_equal_to_"+rownumber).attr("disabled", true);
     $("#input_text_different_to_"+rownumber).attr("disabled", true);
 }
 //boolean
 if (type == 'boolean')
 {   $("#input_text_equal_to_"+rownumber).attr("disabled", true);
     $("#input_text_different_to_"+rownumber).attr("disabled", true);
 }
}

// desabilita campos del form invisible para no enviar parametros
function disable_row(rownumber)
{$('.row_'+rownumber+'').attr("disabled",true);}

//habilita campos del form invisible para enviar parametos
function enable_row(rownumber)
{$('.row_'+rownumber+'').attr("disabled",false);}

//  cambios registrados en el formulario visible sobre los botones o los textfields (indispensable)
function radio_click_change(value , id)
{
    var id_invisible_atr = ($('#'+id+'').data("target"));
    $('#'+id_invisible_atr+'').val(value);
    id_row_str = $('#'+id+'').attr('id').replace(/\D/g, '');
    block_row(id_row_str , 1);
    if (prev_checked_radio)
    {
        if(!$("#radio_"+prev_checked_radio).is(":checked"))
        {
            block_row(prev_checked_radio,2);
        }
        if($("#radio_"+prev_checked_radio).is(":checked"))
        {
            unblock_row(prev_checked_radio , 1);
        }
    }
    prev_checked_radio = id_row_str;
}
//

function check_change(value , id)
{
    var   value_check = 1 ;
    id_row_str_check = $('#'+id+'').attr('id').replace(/\D/g, '');
    if ($('#'+id+'').is(':checked')== true)
    {
     unblock_row(id_row_str_check , 0);
     unblock_row_by_type(id_row_str_check);
      // mandamos valor a form invisible
     $('#reports_composite_configurator_filters_attributes_'+id_row_str_check+'_filter_attribute').val(value_check);;
    }
    if ($('#'+id+'').is(':checked') == false)
    {
    value_check = 0 ;
    block_row(id_row_str_check , 0);
    $('#reports_composite_configurator_filters_attributes_'+id_row_str_uncheck+'_filter_attribute').val(value_check);
    alert('no check');
    }

}

function input_text_higher_change(value , id)
{   var id_invisible_atr = ($('#'+id+'').data("target"));
    $('#'+id_invisible_atr+'').val(value);
}
//
function input_text_less_change(value , id)
{ var id_invisible_atr = ($('#'+id+'').data("target"));
    $('#'+id_invisible_atr+'').val(value);
}
//
function input_text_equal_change(value , id)
{   var id_invisible_atr = ($('#'+id+'').data("target"));
    $('#'+id_invisible_atr+'').val(value);
}
//
function input_text_different_change(value , id)
{   var id_invisible_atr = ($('#'+id+'').data("target"));
    $('#'+id_invisible_atr+'').val(value);
}
//////////////

function verify_fields_and_remove(rownumber) // verificamos cuales campos tienen un valor asociado y los asociamos con el form invisible sin importar si fue digitado previamente o es digitado
{
 if(!($("#input_text_higher_"+rownumber).val())){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_higher_to').attr("disabled", true);}
 if(!($("#input_text_less_to_"+rownumber).val())){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_less_to').attr("disabled", true);}
 if(!($("#input_text_equal_to_"+rownumber).val())){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_equal_to').attr("disabled", true);}
 if(!($("#input_text_different_to_"+rownumber).val())){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_different_to').attr("disabled", true);}
}
///////////////////////////////

function verify_data_to_send()
{
    for(i=0;i<=integer_radio;i++)
    {
        var value_check = $('#reports_composite_configurator_filters_attributes_'+i+'_filter_attribute').val();
        if(value_check == 0)  //verificar cual tiene el checkbox inactivo y eliminar los campos del filtro
        {
         disable_row(i);
        }

        if(value_check == 1) // si el checkbox esta activo verificamos si en ese campo habia un radio button activo en este caso para de todos modos desabilitar los filtros
        {
          if($("#radio_"+i).is(":checked"))
           {
            disable_row(i);
           }
          else
           {
            verify_fields_and_remove(i);
           }
        }
    }
}



// enviar la informacion //
function send_form()
{
     verify_data_to_send();
     var valuesconfig = $('#form_report_composite').serialize();
     jQuery.ajax({
        type: "POST" ,
        url: "/send_form",
        data: valuesconfig,
        dataType: "json",
        success: function(data)
        {
         $('#form_composite').change();
         $('#form_composite').html(data.formm);
         $('#table_composite').html(data.selectt);
         create_options_form();
         recovery_fields(integer_radio);
        },
        error:function(data)
        {
         $('#form_composite').change();
         $('#form_composite').html(data.responseText);
         create_options_form();
         recovery_fields(integer_radio);
        }
    });
}


function recovery_fields(integer_radio)
{
  for(i=0;i<=integer_radio;i++)
  {
      enable_row(i);
      var higher_to = $('#reports_composite_configurator_filters_attributes_'+i+'_higher_to').val();
      var less_to = $('#reports_composite_configurator_filters_attributes_'+i+'_less_to').val();
      var equal_to =$('#reports_composite_configurator_filters_attributes_'+i+'_equal_to').val();
      var different_to = $('#reports_composite_configurator_filters_attributes_'+i+'_different_to').val();
      var variable_atr = $('#reports_composite_configurator_variable_atr').val();
      var filter_atr = $('#reports_composite_configurator_filters_attributes_'+i+'_filter_attribute').val();

      // asignamos los valores

      $("#input_text_higher_"+i).val(higher_to);
      $("#input_text_less_to_"+i).val(less_to);
      $("#input_text_equal_to_"+i).val(equal_to)
      $("#input_text_different_to_"+i).val(different_to);
      if (variable_atr == $("#radio_"+i).val())
      {
       $("#radio_"+i).prop('checked',true);
       block_row(i , 1)
       prev_checked_radio = i ;
      }
      if(filter_atr == $("#check_"+i).val())
      {
       $("#check_"+i).prop('checked',true);
       if(variable_atr == $("#radio_"+i).val())
       {
       block_row(i , 1);
       prev_checked_radio = i ;
       }
       else
       {
       unblock_row(i , 1);
       }
       }
  }
}
