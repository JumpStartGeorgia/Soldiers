function highlight_chart_data_age(id, chart_id, data_name){
  var items = $(chart_id + ' .highcharts-axis-labels text');
  for (var j=0; j<items.length; j++){
    var t = $(items[j]).find('tspan').text();
    // if the text is too long, it will take up more than one tspan for full name
    // so have to build full name
    if ($(items[j]).find('tspan').length > 1){
      t = $(items[j]).find('tspan').map(function() {
        return $(this).text();
      }).get().join(' ');      
    }

    // split the numbers
    var nums = t.split('-');

    if (nums[0] <= $('#thumbs li a[data-id="' + id + '"]').data(data_name) && nums[1] >= $('#thumbs li a[data-id="' + id + '"]').data(data_name)){
      // found match, now highlight the correct bar
      $($(chart_id + ' .highcharts-series-group .highcharts-series rect')[j]).attr('fill', bar_color_highlight);
      break;
    }
  }
}

function highlight_chart_data(id, chart_id, data_name){
  var items = $(chart_id + ' .highcharts-axis-labels text');
  for (var j=0; j<items.length; j++){
    var t = $(items[j]).find('tspan').text();
    // if the text is too long, it will take up more than one tspan for full name
    // so have to build full name
    if ($(items[j]).find('tspan').length > 1){
      t = $(items[j]).find('tspan').map(function() {
        return $(this).text();
      }).get().join(' ');      
    }

    if (t == $('#thumbs li a[data-id="' + id + '"]').data(data_name)){
      // found match, now highlight the correct bar
      $($(chart_id + ' .highcharts-series-group .highcharts-series rect')[j]).attr('fill', bar_color_highlight);
      break;
    }
  }
}

function load_soldier_profile (id)
{
  var profiles = $('#soldier_profiles .soldier_profile');
  if (profiles.is(':animated'))
  {
    return false;
  }

  if (profiles.filter('.active').length)
  {
    profiles.filter('.active').fadeOut(function()
    {
      $(this).removeClass('active');
      profiles.filter('[data-id="' + id + '"]').addClass('active').fadeIn();
    });
  }
  else
  {
    profiles.filter('[data-id="' + id + '"]').addClass('active').slideDown();
  }

  // highlight the matching chart bars
  // - first reset all bar colors
  $('.highcharts-series-group .highcharts-series rect').attr('fill', bar_color);
  // gender
  highlight_chart_data(id, '#chart_gender', 'gender');

  // age
  highlight_chart_data_age(id, '#chart_age', 'age');

  // country
  highlight_chart_data(id, '#chart_country', 'country');

  // rank
  highlight_chart_data(id, '#chart_rank', 'rank');

  // served_with
  highlight_chart_data(id, '#chart_served_with', 'served-with');

  // incidents
  for (var i=0; i<gon.incidents_num; i++)
  {
    highlight_chart_data(id, '#chart_incident_type_'+i.toString(), 'incident-description');
  }
  return true;
}

$(document).ready(function() {

    $(window).load(function(){
      // if name exists in hash, then show that profile
      if (location.hash != undefined && location.hash.length > 1 && location.hash != "#_"){
        var name = location.hash.replace('#','');
        var item = $('#thumbs li > a[data-permalink="' + name + '"]');
        if (item.length == 1){
          $(item).addClass('active');
          load_soldier_profile($(item).data('id'));
        }
      }
    });

  $('#thumbs li > a').click(function () {
    if (load_soldier_profile($(this).data('id')) === false)
    {
      return;
    }

    var active = $('#soldier_profiles .soldier_profile.active');
    if (active.length)
    {
      $('html, body').animate({ scrollTop: active.offset().top + active.outerHeight() - $(window).height() }, 'fast');
    }

    $('#thumbs li > a.active').removeClass('active');
    $(this).addClass('active');
    location.hash = $(this).data('permalink');
  });
  

  // hide the profile section
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_close > a').click(function (){
    $('#soldier_profiles .soldier_profile.active').slideUp(function(){
      $('#thumbs li > a.active').removeClass('active');
      $('#soldier_profiles .soldier_profile.active').removeClass('active');
    });
    location.hash = "_";
  });
  
  // load the next one
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_next > a').click(function (){
    var new_item = $('#thumbs li > a.active').parent().next().children();
    // if this is the last item in the list, go back to the first one
    if ($('#thumbs li > a.active').parent().is('li:last-child')){
      new_item = $('#thumbs li:first-child').children();
    }

    // if the last animation is still running
    if (load_soldier_profile($(new_item).data('id')) === false)
    {
      return;
    }
    $('#thumbs li > a.active').removeClass('active');
    $(new_item).addClass('active');
    location.hash = $(new_item).data('permalink');
  });
  
  // load the previous one
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_previous > a').click(function (){
    var new_item = $('#thumbs li > a.active').parent().prev().children();
    // if this is the first item in the list, go back to the last one
    if ($('#thumbs li > a.active').parent().is('li:first-child')){
      new_item = $('#thumbs li:last-child').children();
    }


    if (load_soldier_profile($(new_item).data('id')) === false)
    {
      return;
    }
    $('#thumbs li > a.active').removeClass('active');
    $(new_item).addClass('active');
    location.hash = $(new_item).data('permalink');
  });
  

});
