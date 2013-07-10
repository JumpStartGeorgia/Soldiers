function highlight_map_photos(ths, dataname){
  var shape_name = $(ths).attr('shape_name');
  var list = $('#thumbs > ul > li > a');
  list.removeClass('active').filter('[data-' + dataname + '="' + shape_name + '"]').addClass('active');
 }

function reset_highlight_map_photos(){
  $('#thumbs > ul > li > a').removeClass('active').eq($('#thumbs').data('activeindex')).addClass('active');
}


$(document).ready(function() {
  if (gon.map_georgia) {
//    var proj = d3.geo.mercator().scale(12000).translate([-1200,1650])
    var proj = d3.geo.mercator().scale(16000).translate([-1755,2175])
    var path = d3.geo.path().projection(proj);

    var w = 350, h = 160;

    var map = d3.select("#maps #map_georgia")
      .append("svg:svg")
      .attr("id", "svg_map_georgia")
      .attr("width", w + 40)
      .attr("height", h + 20);

    var tooltip_georgia = d3.select("#maps #map_georgia").append("div")
      .attr("class", "tooltip hidden");
    
    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_georgia.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        })
        .attr("class_orig",function(d){
          return d["properties"]["classname"]
        })
        .attr("shape_name",function(d){
          return d["properties"]["Shape_Name"]
        })
        .attr("count",function(d){
          return d["properties"]["count"]
        })
        .on("mousemove", function(d,i) {
          var mouse = d3.mouse(this);
          tooltip_georgia
            .classed("hidden", false)
            .attr("style", "left:"+(mouse[0]+25)+"px;top:"+mouse[1]+"px")
            .html(d["properties"]["Shape_Name"] + "<br />" + d["properties"]["count"]);
          highlight_map_photos(this, 'region-from');
        })
        .on("mouseout",  function(d,i) {
          tooltip_georgia.classed("hidden", true);
          reset_highlight_map_photos();
        });

  }
  if (gon.map_afghan) {
    var w = 350, h = 160;

//    var proj = d3.geo.mercator().scale(3000).translate([-400,400])
//    var proj = d3.geo.mercator().scale(4000).translate([-533,533])
    var proj = d3.geo.mercator().scale(5000).translate([-750,595])
    var path = d3.geo.path().projection(proj);


    var map = d3.select("#maps #map_afghan")
      .append("svg:svg")
      .attr("id", "svg_map_afghan")
      .attr("width", w + 40)
      .attr("height", h + 20);

    var tooltip_afghan = d3.select("#maps #map_afghan").append("div")
      .attr("class", "tooltip hidden");
    
    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_afghan.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        })
        .attr("class_orig",function(d){
          return d["properties"]["classname"]
        })
        .attr("shape_name",function(d){
          return d["properties"]["Shape_Name"]
        })
        .attr("count",function(d){
          return d["properties"]["count"]
        })
        .on("mousemove", function(d,i) {
          var mouse = d3.mouse(this);
          tooltip_afghan
            .classed("hidden", false)
            .attr("style", "left:"+(mouse[0]+25)+"px;top:"+mouse[1]+"px")
            .html("<strong>" + d["properties"]["Shape_Name"] + "</strong><br />" + gon.label_death + ": " + d["properties"]["count"]);
          highlight_map_photos(this, 'place-died');
        })
        .on("mouseout",  function(d,i) {
          tooltip_afghan.classed("hidden", true);
          reset_highlight_map_photos();
        });

  }
  if (gon.map_iraq) {
    var w = 350, h = 160;

//    var proj = d3.geo.mercator().scale(5000).translate([-430,585])
    var proj = d3.geo.mercator().scale(5500).translate([-490,632])
    var path = d3.geo.path().projection(proj);


    var map = d3.select("#maps #map_iraq")
      .append("svg:svg")
      .attr("id", "svg_map_iraq")
      .attr("width", w + 40)
      .attr("height", h + 20);

    var tooltip_iraq = d3.select("#maps #map_iraq").append("div")
      .attr("class", "tooltip hidden");
   

    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_iraq.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        })
        .attr("class_orig",function(d){
          return d["properties"]["classname"]
        })
        .attr("shape_name",function(d){
          return d["properties"]["Shape_Name"]
        })
        .attr("count",function(d){
          return d["properties"]["count"]
        })
        .on("mousemove", function(d,i) {
          var mouse = d3.mouse(this);
          tooltip_iraq
            .classed("hidden", false)
            .attr("style", "left:"+(mouse[0]+25)+"px;top:"+mouse[1]+"px")
            .html("<strong>" + d["properties"]["Shape_Name"] + "</strong><br />" + gon.label_death + ": " + d["properties"]["count"]);
          highlight_map_photos(this, 'place-died');
        })
        .on("mouseout",  function(d,i) {
          tooltip_iraq.classed("hidden", true);
          reset_highlight_map_photos();
        });

  }
  
});
