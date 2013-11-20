var integer_radio;
var  prev_checked_radio;
$(document).ready(create_options_form);

function create_options_form()
{
   /*pase por cada una de las filas bloqueando los campos hasta que el usuario seleccione uno para modificar*/
   $(".input_text_field").attr("disabled", true );
}

// bloqueamos la fila segun la seleccion del usuario o los parametros por defecto (indispensable)
function block_row(rownumber , option)
{
  $(".text_field_v_"+rownumber).attr("disabled", true);

  if(option==1)  // bloqueamos la fila completa  como cuando se tiene el atr_variable
  {
   $("#check_"+rownumber).attr("disabled", true);
  }
  if(option == 2) // si no esta checked solo este se desbloquea y si no tiene atr variable asociado
  {
   $("#check_"+rownumber).attr("disabled", false);
  }
}

// habilitamos la fila segun la seleccion del usuario o los parametros por defecto de algunos campos ( indispensable )
    function unblock_row(rownumber , option)
    {
    $(".text_field_v_"+rownumber).attr("disabled",false);

    if(option == 1) // si cambiamos de atributo variable el check tambien se habilita
    {
     $("#check_"+rownumber).attr("disabled", false);
    }
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
     $('#reports_composite_configurator_filters_attributes_'+id_row_str_check+'_filter_attribute').val(value_check);
    }
    if ($('#'+id+'').is(':checked') == false)
    {
    value_check = 0 ;
    block_row(id_row_str_check , 0);
    $('#reports_composite_configurator_filters_attributes_'+id_row_str_check+'_filter_attribute').val(value_check);
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

function verify_fields_and_remove() // verificamos cuales campos tienen un valor asociado y los asociamos con el form invisible sin importar si fue digitado previamente o es digitado
{
 $.each($(".input_text_field"),function(index,row)
 {
    if ($("#"+row.id+"").val()=="")
    {
    $('#'+$('#'+row.id+'').data("target")+'').attr("disabled",true);
    }

 });
}
///////////////////////////////

function verify_data_to_send()
{
    var value_checked;

    $.each($(".input_check"),function(index,row)
    {
     value_checked = $("#"+row.id+"").val();
     console.log(value_checked);
     if(value_checked == 0 || $("#radio_"+index).is(":checked") )  //verificar cual tiene el checkbox inactivo y eliminar los campos del filtro
     {
     disable_row(index);
     }
     });
}

// enviar la informacion //
function send_form()
{    verify_fields_and_remove();
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
         recovery_fields();
        },
        error:function(data)
        {
         $('#form_composite').change();
         $('#form_composite').html(data.responseText);
         create_options_form();
         recovery_fields();
        }
    });
}

function recovery_fields()
{
    var variable_atr = $('#reports_composite_configurator_variable_atr').val();

    $.each($(".input_field"),function(index_text,row_text)
    {
        $.each($(".input_text_field"),function(index_text_b , field_text){
        if ($('#'+field_text.id+'').data("target")  == row_text.id)
        {
          $("#"+field_text.id+"").val($("#"+row_text.id+"").val());
        }
        });
    });


    $.each($(".input_radio_visible"),function(index_radio , field_radio)
    {
        enable_row(index_radio);
        var filter_atr = $('#reports_composite_configurator_filters_attributes_'+index_radio+'_filter_attribute').val();


        if (variable_atr == $("#"+field_radio.id+"").val())
        {
            $("#"+field_radio.id+"").prop('checked',true);
            block_row(index_radio , 1)
            prev_checked_radio = index_radio ;
        }
        if(filter_atr == $("#check_"+index_radio).val())
        {
            $("#check_"+index_radio).prop('checked',true);
            if(variable_atr == $("#radio_"+index_radio).val())
            {
                block_row(index_radio , 1);
                prev_checked_radio = index_radio ;
            }
            else
            {
                unblock_row(index_radio , 1);
            }
        }

    });
}
