$(document).ready(function() {
    $('.popover-test').popover(placement="bottom", trigger= "hover");

    $('#all').on('click', function (e) {
        update_alerts('all')
    });
    $('#alarm').on('click', function (e) {
        update_alerts('alarm')
    });
    $('#anmly').on('click', function (e) {
        update_alerts('anmly')
    });
    $('#notif').on('click', function (e) {
        update_alerts('notif')
    });
    $('#myAtt').on('click', function (e) {
        update_alerts('myAtt')
    });
    $('#noAtt').on('click', function (e) {
        update_alerts('noAtt')
    });
    $('#solved').on('click', function (e) {
        update_alerts('solved')
    });

    $('#all').button('toggle')
    update_alerts('all');
});

function openModal(alert_id,filtro) {
    document.getElementById("solve_alert_alert_id").value = alert_id;
    document.getElementById("solve_alert_filtro").value = filtro;
    $('#myModal').modal();
}

function openModalLoc(selection) {
    jQuery.ajax({
        url: "/topologies",
        type: "GET",
        data: {},
        dataType: "json",
        success: function(data) {
            var nodos1 = jQuery.parseJSON(data.nodos);
            var enlaces1 = jQuery.parseJSON(data.enlaces);
            $("#topo").empty();
            openTopology(nodos1, enlaces1, selection);
            $('#modalLoc').modal();
        }
    });
}

function update_alerts(filtro) {
    jQuery.ajax({
        url: "/update_alerts",
        type: "GET",
        data: {"filter" : filtro},
        dataType: "html",
        success: function(data) {
            document.getElementById('divalertas').innerHTML=data;
            //window.setTimeout("update_alerts()",5000);
        }
    });
}

function attend_alert(alrt_id, filtro) {
    jQuery.ajax({
        url: "/attend_alert",
        type: "GET",
        data: {"alrt_id" : alrt_id},
        dataType: "html",
        success: function(data) {
            if(filtro=='noAtt')
                $('#alrt_'+alrt_id).fadeOut(500, function(){ $(this).remove();});
            document.getElementById('state_'+alrt_id).innerHTML=data;
        }
    });
}

function openTopology(nodos, enlaces, selection) {

    function pageWidth() {
        return window.innerWidth != null? window.innerWidth : document.documentElement && document.documentElement.clientWidth ?       document.documentElement.clientWidth : document.body != null ? document.body.clientWidth : null;
    }

    function pageHeight() {
        return  window.innerHeight != null? window.innerHeight : document.documentElement && document.documentElement.clientHeight ?  document.documentElement.clientHeight : document.body != null? document.body.clientHeight : null;
    }

    var width = 1024, height = 768;

    var svg = d3.select("#topo").append("svg")
        .attr("width", width)
        .attr("height", height);

    var force = d3.layout.force()
        .size([width, height])
        .charge(-800)
        .linkDistance(140);

    var graph = {
        nodes: nodos,
        links: enlaces
    };

    graph.nodes.forEach(function(d) { if (d.name==selection){d.fixed = true; d.x=width/2; d.y=height/2;} });

    force
        .nodes(graph.nodes)
        .links(graph.links)
        .on("tick", tick)
        .start();

    var link = svg.selectAll(".link")
        .data(graph.links)
        .enter().append("g")
        .attr("class", "link");

    link.append("line")
        .style("stroke-width", "2px");

    var node = svg.selectAll(".node")
        .data(graph.nodes)
        .enter().append("g")
        .attr("class", "node")
        .call(force.drag);

    node.append("circle")
        .attr("r", 20)
        .style("fill", "white" )

    node.append("circle")
        .attr("r", 20)
        .style("fill", function(d) { if (d._type==="LaynetEle") return "blue"; else if (d._type==="NetEle") return "green"; else return "red"; })
        .style('stroke', "black")
        .style('stroke-width', function(d){if (d.name==selection) return 3; else  return 0; })
        .style('stroke-opacity', function(d){if (d.name==selection) return 1; else  return 0; })
        .style('opacity', function(d){if (d.name==selection) return 1; else  return 0.3; });

    node.append("text")
        .attr("dy", "-22px")
        .attr("text-anchor", "middle")
        .style('opacity', function(d){if (d.name==selection) return 1; else  return 0.6; })
        .text(function(d) { return d.name; });

    function tick() {
        link.selectAll("line")
            .attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });

        node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
    }

}
