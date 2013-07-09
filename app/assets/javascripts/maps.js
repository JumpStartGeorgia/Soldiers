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

    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_georgia.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        }).attr("region_name",function(d){
          return d["properties"]["REGION"]
        }).attr("count",function(d){
          return d["properties"]["count"]
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

    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_afghan.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        }).attr("region_name",function(d){
          return d["properties"]["NAME_1"]
        }).attr("count",function(d){
          return d["properties"]["count"]
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

    var regions = map.append("g")
      .attr("id", "region");

    regions.selectAll("path")
      .data(gon.map_iraq.features)
      .enter().append("path")
        .attr("d", path)
        .attr("class",function(d){
          return d["properties"]["classname"]
        }).attr("region_name",function(d){
          return d["properties"]["NAME_1"]
        }).attr("count",function(d){
          return d["properties"]["count"]
        });

  }
  
});
