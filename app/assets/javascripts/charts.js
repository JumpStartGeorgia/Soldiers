$(document).ready(function() {

  if (gon.gender_values){
    $('#chart_gender').highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.gender_headers.length
        },
        title: {
            text: gon.gender_title
        },
        xAxis: {
            categories: gon.gender_headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }

  ////////////////////////////////////////
  if (gon.age_values){
    $('#chart_age').highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.age_headers.length
        },
        title: {
            text: gon.age_title
        },
        xAxis: {
            categories: gon.age_headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }

  ////////////////////////////////////////
  if (gon.country_values){
    $('#chart_country').highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.country_headers.length
        },
        title: {
            text: gon.country_title
        },
        xAxis: {
            categories: gon.country_headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }

  ////////////////////////////////////////
  if (gon.rank_values){
    $('#chart_rank').highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.rank_headers.length
        },
        title: {
            text: gon.rank_title
        },
        xAxis: {
            categories: gon.rank_headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }

  ////////////////////////////////////////
  if (gon.served_with_values){
    $('#chart_served_with').highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.served_with_headers.length
        },
        title: {
            text: gon.served_with_title
        },
        xAxis: {
            categories: gon.served_with_headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }

  ////////////////////////////////////////
  if (gon.date_died_values){
    $('#chart_date_died').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: gon.date_died_title
        },
        xAxis: {
            categories: gon.date_died_headers,
            title: {
                text: null
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
            column: {
                dataLabels: {
                    enabled: true
                }
            },
            series: {
	            pointWidth: 20
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
            name: gon.date_died_title,
            data: gon.date_died_values
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
    });
  }


  ////////////////////////////////////////
  if (gon.incidents_num > 0){
    for(var i=0;i<gon.incidents_num;i++){
      $('#chart_incident_type_' + i).highcharts({
        chart: {
            type: 'bar',
            height: 50 + 35*gon.incident_types[i].headers.length
        },
        title: {
            text: gon.incident_types[i].title
        },
        xAxis: {
            categories: gon.incident_types[i].headers,
            title: {
                text: null
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
	            pointWidth: 20
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
        }],
        lang: {
          downloadPNG: gon.highcharts_downloadPNG,
          downloadJPEG: gon.highcharts_downloadJPEG,
          downloadPDF: gon.highcharts_downloadPDF,
          downloadSVG: gon.highcharts_downloadSVG,
          printChart: gon.highcharts_printChart
        }
      });
    }
  }


});
