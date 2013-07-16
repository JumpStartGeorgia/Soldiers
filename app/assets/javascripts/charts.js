var bar_color = '#f1dce1';
//var bar_color_highlight = '#a31e33';
var bar_color_highlight = '#ab9b4d';
var bar_height = 13;
var date_died_bar_height = 9;
var axis_label_width = '150px';
var axis_label_width_wider = '250px';
var chart_line_color = '#c9c9c9';

$(document).ready(function() {

  window.charts = {};

  Highcharts.setOptions({
    lang: {
      downloadPNG: gon.highcharts_downloadPNG,
      downloadJPEG: gon.highcharts_downloadJPEG,
      downloadPDF: gon.highcharts_downloadPDF,
      downloadSVG: gon.highcharts_downloadSVG,
      printChart: gon.highcharts_printChart
    }
  });

  if (gon.gender_values){
    window.charts.gender = $('#chart_gender').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.gender_headers.length
        },
        title: {
            text: gon.gender_title,
        },
        xAxis: {
            categories: gon.gender_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.gender_title,
            data: gon.gender_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.age_values){
    window.charts.age = $('#chart_age').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.age_headers.length
        },
        title: {
            text: gon.age_title
        },
        xAxis: {
            categories: gon.age_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.age_title,
            data: gon.age_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.country_values){
    window.charts.country = $('#chart_country').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.country_headers.length
        },
        title: {
            text: gon.country_title
        },
        xAxis: {
            categories: gon.country_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.country_title,
            data: gon.country_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.rank_values){
    window.charts.rank = $('#chart_rank').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.rank_headers.length
        },
        title: {
            text: gon.rank_title
        },
        xAxis: {
            categories: gon.rank_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width_wider
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.rank_title,
            data: gon.rank_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.served_with_values){
    window.charts.served_with = $('#chart_served_with').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.served_with_headers.length
        },
        title: {
            text: gon.served_with_title
        },
        xAxis: {
            categories: gon.served_with_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width_wider
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.served_with_title,
            data: gon.served_with_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.incident_description_values){
    window.charts.incident_description = $('#chart_incident_description').highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.incident_description_headers.length
        },
        title: {
            text: gon.incident_description_title
        },
        xAxis: {
            categories: gon.incident_description_headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width_wider
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.incident_description_title,
            data: gon.incident_description_values
        }]
    }).highcharts();
  }

  ////////////////////////////////////////
  if (gon.incidents_num > 0){
    for(var i=0;i<gon.incidents_num;i++){
      window.charts['chart_incident_type_' + i] = $('#chart_incident_type_' + i).highcharts({
        chart: {
            type: 'bar',
            height: 50 + (bar_height+5)*gon.incident_types[i].headers.length
        },
        title: {
            text: gon.incident_types[i].title
        },
        xAxis: {
            categories: gon.incident_types[i].headers,
            title: {
                text: null
            },
            lineColor: chart_line_color,
            tickColor: chart_line_color,
            labels: {
              style: {
                  width: axis_label_width
              }
            }
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
          enabled: false
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.incident_types[i].title,
            data: gon.incident_types[i].values
        }]
      }).highcharts();
    }
  }


  ////////////////////////////////////////
  if (gon.date_died_values){
    window.charts.date_died = $('#chart_date_died').highcharts({
        chart: {
            type: 'column',
            marginLeft: 40,
            marginRight: 40
        },
        title: {
            text: gon.date_died_title
        },
        xAxis: {
            categories: gon.date_died_headers,
            title: {
                text: null
            },
            type: 'datetime',
            dateTimeLabelFormats: {
                month: '%d %b'
            },
            tickInterval: 10,
            lineColor: chart_line_color,
            tickColor: chart_line_color
        },
        yAxis: {
            min: 0,
            title: {
                text: null
            },
            labels: {
                enabled: false
            },
            gridLineWidth: 0
        },
        plotOptions: {
            column: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: date_died_bar_height,
              color: bar_color
  	        }
        },
        legend: {
            enabled: false
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.x + ':</b> '+ this.y;
            }
        },
        credits: {
            enabled: false
        },
        series: [{
            name: gon.date_died_title,
            data: gon.date_died_values
        }]
    }).highcharts();
  }



  function search_recursive (object, value, maxlevel, strict, curlevel, keychain)
  {
    typeof curlevel == 'undefined' && (curlevel = 1);
    typeof maxlevel == 'undefined' && (maxlevel = 1000);
    typeof keychain == 'undefined' && (keychain = '');
    for (var i in object)
    {
      if (!Object.prototype.hasOwnProperty.call(object, i))
      {
        continue;
      }
      if (strict && object[i] === value || !strict && object[i] == value)
      {
        return keychain + '.' + i;
      }
      else if (typeof object[i] == 'object' && curlevel < maxlevel)
      {
        var result = search_recursive(object[i], value, maxlevel, strict, curlevel + 1, keychain + '.' + i);
        if (result !== false)
        {
          return result;
        }
      }
    }
    return false;
  }



 $('.highcharts-series.highcharts-tracker rect').click(function ()
 {
  // clear all profiles and map/chart highlights
  reset_profiles();
    
   var self = $(this),
   svg = self.closest('svg');

 /*
   var clickindex = svg.data('clickindex');

   if (clickindex != self.index())
   {
     svg.data('clickindex', self.index());
   }
   else
   {
     svg.data('clickindex', null);
     $('#thumbs > ul > li > a').removeClass('active').eq($('#thumbs').data('activeindex')).addClass('active');
     return;
   }
 */
   var value = svg.find('.highcharts-axis-labels text').eq(self.index()).text(),
   title = svg.find('.highcharts-title').text();
   var result = search_recursive(gon, title, 1);
   if (result == false)
   {
     return false;
   }
   dataname = result.slice(1).replace(/_title$/, '').replace('_', '-');

   var list = $('#thumbs > ul > li > a');

//   $('#thumbs').data('activeindex', list.filter('.active').parent().index());

   if (dataname == 'age')
   {
     var range = value.split('-');
     list.removeClass('active').each(function ()
     {
       var _self = $(this);
       if (_self.data('age') >= range[0] && _self.data('age') <= range[1])
       {
         _self.addClass('active');
       }
     });
   }
   else
   {
     if (dataname == 'date-died')
     {
       value = gon.date_died_filtered[self.index()];
     }

     list.removeClass('active').filter('[data-' + dataname + '="' + value + '"]').addClass('active');
   }


   // camel_case to camelCase
   // .replace(/_[a-z]/, function (s){ return s.slice(1).toUpperCase(); })


    // highlight this bar
    var chartname = $(svg).parent().parent().attr('id').replace('chart_', '');
    window.charts[chartname].series[0].data[self.index()].update({
      color: bar_color_highlight
    });
    window.charts[chartname].last_updated_index = self.index();
    
 });

});
