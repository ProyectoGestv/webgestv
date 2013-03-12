function update_linksb(name) {
    jQuery.ajax({
        url: "/update_linksb",
        type: "GET",
        data: {"name" : name},
        dataType: "html",
        success: function(data) {
            //alert(data);
            //jQuery("#linksbDiv").HTML(data);
            document.getElementById('linksbDiv').innerHTML=data;
        }
    });
}