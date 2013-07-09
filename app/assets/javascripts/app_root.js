function update_social_links(id, new_url, new_text){
/*
  // twitter
  $('#socialside #twitter #twitter-button').empty();
  var clone = $('#socialside #twitter #twitter-template').clone();
  clone.removeAttr("style"); // unhide the clone
  clone.attr("data-text", new_text); 
  clone.attr("data-url", new_url); 
  clone.attr("data-counturl", new_url);
  clone.attr("class", "twitter-share-button"); 
  $('#socialside #twitter #twitter-button').append(clone);
  twttr.widgets.load();

  // facebook
  $('#socialside .fb-like').attr('data-href', new_url);
  FB.XFBML.parse();
*/
  // seems like addthis automatically reloads its links
}

function reset_profiles(){
  $('#soldier_profiles .soldier_profile.active').slideUp(function(){
    $('#thumbs li > a.active').removeClass('active');
    $('#soldier_profiles .soldier_profile.active').removeClass('active');
  });
  location.hash = "_";

  // first reset all bar colors
  $('.highcharts-series-group .highcharts-series rect').attr('fill', bar_color);

  ////////////////////////
  // update social links
  update_social_links(null, gon.root_url, gon.app_name);
}

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
      window.charts[chart_id.replace('#chart_', '')].series[0].data[j].update({
        color: bar_color_highlight
      })
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
      //$(chart_id + ' .highcharts-series-group .highcharts-series rect').eq(j).attr('fill', bar_color_highlight);
      window.charts[chart_id.replace('#chart_', '')].series[0].data[j].update({
        color: bar_color_highlight
      })
      break;
    }
  }
}

function highlight_chart_data_date_died (id)
{
  //var j = gon.date_died_filtered.indexOf($('#thumbs li a[data-id="' + id + '"]').data('date-died'));
  //$('#chart_date_died .highcharts-series-group .highcharts-series rect').eq(j).attr('fill', bar_color_highlight);
  var date = new Date($('#thumbs li a[data-id="' + id + '"]').data('date-died'));
  var value = date.getFullYear() + ' ' + gon.abbrv_month_names[date.getMonth()+1];

//  var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
//  var value = date.getFullYear() + ' ' + months[date.getMonth()];
  for (var i in window.charts.date_died.series[0].data)
  {
    var d = window.charts.date_died.series[0].data[i];
    if (d.category == value)
    {
      break;
    }
  }
  window.charts.date_died.series[0].data[i].update({
    color: bar_color_highlight
  })
}

function load_soldier_profile (id)
{
  var profiles = $('#soldier_profiles .soldier_profile');
  if (profiles.is(':animated'))
  {
    return false;
  }

  var target = profiles.filter('[data-id="' + id + '"]');
  var active = profiles.filter('.active');
  if (active.length)
  {
    target.addClass('absolute').addClass('active').fadeIn();
    active.removeClass('active').fadeOut(function (){ target.removeClass('absolute'); });
  }
  else
  {
    target.addClass('active').slideDown();
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
  highlight_chart_data(id, '#chart_incident_description', 'incident-description');

  // date died
  highlight_chart_data_date_died(id);
/*
  for (var i=0; i<gon.incidents_num; i++)
  {
    highlight_chart_data(id, '#chart_incident_type_'+i.toString(), 'incident-description');
  }
*/

  ////////////////////////
  // update social links
  var soldier = $('#thumbs li a[data-id="' + id + '"]');
  update_social_links(id, gon.root_url + "#" + $(soldier).data('permalink'), $(soldier).data('name') + " @ " + gon.app_name);

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
    // if this photo is already active, hide everything
    if ($(this).hasClass('active')){
      reset_profiles();
      return;
    }

    if (load_soldier_profile($(this).data('id')) === false)
    {
      return;
    }

    var active = $('#soldier_profiles .soldier_profile.active');
    if (active.height() > 10)
    {
      var y = active.offset().top + active.outerHeight() - $(window).height();
    }
    else
    {
      var clone = active.clone();
      clone.removeAttr('style').addClass('actualheight').appendTo(active.parent());
      var y = active.offset().top + clone.outerHeight() - $(window).height();
      clone.remove();
    }
    if (active.length && $(window).scrollTop() < y)
    {
      $('html, body').delay(10).animate({ scrollTop: y }, 'fast');
    }

    $('#thumbs li > a.active').removeClass('active');
    $(this).addClass('active');
    location.hash = $(this).data('permalink');
  });
  

  // hide the profile section
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_close > a').click(function (){
    reset_profiles()
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
