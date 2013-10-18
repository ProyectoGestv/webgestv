$(document).ready(function()
{
   var  prev_checked_radio;
   /* capture de last row  seleccionando uno de los campos*/
   var integer_radio =  $('input[type=radio]:last').attr('id').replace(/\D/g, '');
   /*pase por cada una de las filas bloqueando los campos hasta que el usuario seleccione uno para modificar*/
   for(i=0;i<=integer_radio;i++)
   {
   block_row(i , 0);
   }

  $('input[type=radio]').on( "click", function()
  {
        value_radio = $( "input[type=radio]:checked" ).val();
        id_row_str = $( "input[type=radio]:checked").attr('id').replace(/\D/g, '');
        block_row(id_row_str , 1);
        if (prev_checked_radio)
          {
          if(!$("#check_"+prev_checked_radio).is(":checked"))
           {
           block_row(prev_checked_radio,2);
           }
          if($("#check_"+prev_checked_radio).is(":checked"))
           {
           unblock_row(prev_checked_radio , 1);
           }
          }
         prev_checked_radio = id_row_str;

  });


  $('input[type=checkbox]').on("click",function()
  {
      var   value_check = 1 ;

      if ($(this).is(":checked"))
      {
          id_row_str_check = $(this).attr('id').replace(/\D/g, '');
          unblock_row(id_row_str_check , 0);
          unblock_row_by_type(id_row_str_check);
          // mandamos valor a form invisible
          //console.log("hola filter :" + value_check);
          //console.log("hola filter id :" + id_row_str_check);
          $('#reports_composite_configurator_filters_attributes_'+id_row_str_check+'_filter_attribute').val(value_check);
          //var af =  $('#reports_composite_configurator_filters_attributes_'+id_row_str_check+'_filter_attribute');
          //console.log(af);


      }
      if(!$(this).is(":checked"))
      {
          value_check = 0 ;
          id_row_str_uncheck = $(this).attr('id').replace(/\D/g, '');
          //console.log(id_row_str_uncheck);
          block_row(id_row_str_uncheck , 0);
          // mandamos valores a form invisible
          //console.log("hola filter :" + value_check);
          //console.log("hola filter id :" + id_row_str_uncheck);
          $('#reports_composite_configurator_filters_attributes_'+id_row_str_uncheck+'_filter_attribute').val(value_check);
          //var af =  $('#reports_composite_configurator_filters_attributes_'+id_row_str_uncheck+'_filter_attribute');
          //console.log(af);
      }
  });

  });



function block_row(rownumber , option)
{
  $("#input_text_higher_"+rownumber).attr("disabled", true);
  $("#input_text_less_to_"+rownumber).attr("disabled", true);
  $("#input_text_equal_to_"+rownumber).attr("disabled", true);
  $("#input_text_different_to_"+rownumber).attr("disabled", true);
  if(option==1)
  {
  $("#check_"+rownumber).attr("disabled", true);
  }
  if(option == 2)
  {
  $("#check_"+rownumber).attr("disabled", false);
  }
}


function unblock_row(rownumber , option)
{
    $("#check_"+rownumber).attr("disabled", false);
    $("#input_text_higher_"+rownumber).attr("disabled", false);
    $("#input_text_less_to_"+rownumber).attr("disabled", false);
    $("#input_text_equal_to_"+rownumber).attr("disabled", false);
    $("#input_text_different_to_"+rownumber).attr("disabled", false);
    if(option == 1)
    {
     $("#check_"+rownumber).attr("disabled", false);
    }
}

function unblock_row_by_type(rownumber)
{
 var type  = $("#input_text_type_"+rownumber).val();
 // string
 if (type == 'string')
 {
     $("#input_text_equal_to_"+rownumber).attr("disabled", true);
     $("#input_text_different_to_"+rownumber).attr("disabled", true);
 }
 //boolean
 if (type == 'boolean')
 {
     $("#input_text_equal_to_"+rownumber).attr("disabled", true);
     $("#input_text_different_to_"+rownumber).attr("disabled", true);
 }

}

/*
function remove_row(rownumber)
{
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_name_attribute').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_filter_attribute').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_higher_to').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_less_to').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_equal_to').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_different_to').remove();
$('#reports_composite_configurator_filters_attributes_'+rownumber+'_associated_attribute').remove();
}
  */

function remove_row(rownumber)
{
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_name_attribute').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_filter_attribute').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_higher_to').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_less_to').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_equal_to').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_different_to').attr("disabled", true);
    $('#reports_composite_configurator_filters_attributes_'+rownumber+'_associated_attribute').attr("disabled", true);
}

function validate_fields(rownumber)
{}


function verify_fields_and_remove(rownumber)
{
var higher = $("#input_text_higher_"+rownumber).val();
var less = $("#input_text_less_to_"+rownumber).val();
var equal = $("#input_text_equal_to_"+rownumber).val();
var different= $("#input_text_different_to_"+rownumber).val();

if(!higher){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_higher_to').attr("disabled", true);}
if(!less){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_less_to').attr("disabled", true);}
if(!equal){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_equal_to').attr("disabled", true);}
if(!different){$('#reports_composite_configurator_filters_attributes_'+rownumber+'_different_to').attr("disabled", true);}
}

function radio_click_change(value , id)
{
   $('#reports_composite_configurator_variable_atr').val(value);
   //var af =  $('#reports_composite_configurator_variable_atr');
   // console.log(af);
   // console.log("radio click value : " +value );
   // console.log("radio click id :  " + id);
}

function input_text_higher_change(value , id)
{
    var intid = id.replace(/\D/g, '')
    $('#reports_composite_configurator_filters_attributes_'+intid+'_higher_to').val(value);
    //var af =  $('#reports_composite_configurator_filters_attributes_'+intid+'_higher_to');
    //console.log(af);
    //console.log("hola text higher :" + value);
    //console.log("hola text higher id :" + id);
}


function input_text_less_change(value , id)
{
    var intid = id.replace(/\D/g, '')
    $('#reports_composite_configurator_filters_attributes_'+intid+'_less_to').val(value);
    //var af =  $('#reports_composite_configurator_filters_attributes_'+intid+'_less_to');
    //console.log("hola text less :" + value);
    //console.log("hola text less id :" + id);
}


function input_text_equal_change(value , id)
{
    var intid = id.replace(/\D/g, '')
    $('#reports_composite_configurator_filters_attributes_'+intid+'_equal_to').val(value);
    //var af =  $('#reports_composite_configurator_filters_attributes_'+intid+'_equal_to');
    //console.log("hola text equal :" + value);
    //console.log("hola text equal id :" + id);
}


function input_text_different_change(value , id)
{
    var intid = id.replace(/\D/g, '')
    $('#reports_composite_configurator_filters_attributes_'+intid+'_different_to').val(value);
    //var af =  $('#reports_composite_configurator_filters_attributes_'+intid+'_different_to');
    //console.log("hola text different" + value);
    //console.log("hola text different id" + id);
}

// enviar la informacion //
function send_form()
{
    var integer_radio =  $('input[type=radio]:last').attr('id').replace(/\D/g, '');
    for(i=0;i<=integer_radio;i++)
    {
    var value_check = $('#reports_composite_configurator_filters_attributes_'+i+'_filter_attribute').val();
    console.log('value check' + value_check);
    if(value_check == 0)
    {
    //verificar cual tiene el checkbox inactivo y eliminar los campos del filtro
    remove_row(i);
    }

    if(value_check == 1)
    {
    validate_fields(i);
    verify_fields_and_remove(i);
    }


    }

    //un metodo para coger el formulario invisible y modificarlo antes de serializarlo ?
    // for para cada fila saber cual esta radiobutton activo y cuales no ( de estos se verifican cuales estan check y cuales no
    // los que no esten se descartan y los que esten se verifican los campos que tienen valores los campos que no tengan valores se descartan


    var valuesconfig = $('#form_report_composite').serialize();
    console.log(valuesconfig)
    jQuery.ajax({
        type: "POST" ,
        url: "/send_form",
        data: valuesconfig,
        dataType: "json",
        success: function(data)
        {
        },
        error:function(data)
        {
        }
    });

}
