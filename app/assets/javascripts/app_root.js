var hash_separator = ':';

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

function reset_bar_colors ()
{
  for (var i in window.charts)
  {
    var c = window.charts[i];
    if (typeof c.last_updated_index != 'undefined')
    {
      c.series[0].data[c.last_updated_index].update({color: bar_color});
    }
    else
    {
      //console.log('no last index for ', c);
    }
  }
}

function clear_highlight_map(map_id){
  var items = $(map_id + ' svg g path');
  for (var j=0; j<items.length; j++){
    $(items[j]).attr('class', $(items[j]).attr('class_orig'));
  }  
}

function reset_map_colors (){
  clear_highlight_map('#map_georgia');
  clear_highlight_map('#map_afghan');
  clear_highlight_map('#map_iraq');
}

function reset_profiles(){
  $('#soldier_profiles .soldier_profile.active').slideUp();
  $('#thumbs > ul > li > a').removeClass('active');
  $('#soldier_profiles .soldier_profile.active').removeClass('active');
  location.hash = "_";

  // reset all bar colors
//$('.highcharts-series-group .highcharts-series rect').attr('fill', bar_color);
  reset_bar_colors();

  // reset map colors
  reset_map_colors();
  
  // clear which thumb is active
  $('#thumbs').data('activeindex', -1);

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
      var chartname = chart_id.replace('#chart_', '');
      window.charts[chartname].series[0].data[j].update({
        color: bar_color_highlight
      });
      window.charts[chartname].last_updated_index = j;
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
      var chartname = chart_id.replace('#chart_', '');
      window.charts[chartname].series[0].data[j].update({
        color: bar_color_highlight
      });
      window.charts[chartname].last_updated_index = j;
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
  });
  window.charts.date_died.last_updated_index = i;
}

function highlight_map_shape(id, map_id, data_name){
  clear_highlight_map(map_id);
  var items = $(map_id + ' svg g path');
  for (var j=0; j<items.length; j++){
    var name = $(items[j]).attr('shape_name');
    if (name == $('#thumbs li a[data-id="' + id + '"]').data(data_name)){
      $(items[j]).attr('class', 'map_color_highlight');
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

  // remember which thumb is active
  $('#thumbs').data('activeindex', $('#thumbs li a[data-id="' + id + '"]').parent().index());

  // highlight the matching chart bars
  // - first reset all bar colors
//$('.highcharts-series-group .highcharts-series rect').attr('fill', bar_color);
  reset_bar_colors();
  
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

  // place from
  highlight_map_shape(id, "#map_georgia", "region-from");
  
  // place died
  highlight_map_shape(id, "#map_iraq", "place-died");
  highlight_map_shape(id, "#map_afghan", "place-died");

  ////////////////////////
  // update social links
  var soldier = $('#thumbs li a[data-id="' + id + '"]');
  update_social_links(id, gon.root_url + "#" + $(soldier).data('permalink'), $(soldier).data('name') + " @ " + gon.app_name);

  return true;
}

$(document).ready(function() {
   
    $(window).load(function(){
      // if name exists in hash, then highlight appropriate data
      // - if has : and starts with chart -> chart
      // - if has : and starts with map -> map
      // - else soldier name
      if (location.hash != undefined && location.hash.length > 1 && location.hash != "#_"){
        var name = location.hash.replace('#','');

        if (name.indexOf(hash_separator) == -1){
          // soldier name
          var item = $('#thumbs li > a[data-permalink="' + name + '"]');
          if (item.length == 1){
            $(item).addClass('active');
            load_soldier_profile($(item).data('id'));
          }
        } else if (name.indexOf('chart_') == 0){
          // chart
          // split hash into components
          // [0] = div id
          // [1] = bar text
          var comps = name.split(hash_separator);
          // if date died chart, must use gon variable to get index
          if (comps[0].indexOf('date_died') == -1){
            var texts = [];
            $('#' + comps[0] + ' svg g.highcharts-axis-labels text tspan').each(function(){ texts.push($(this).text()) });
            var index = texts.indexOf(comps[1]);
          } else {
            var index = gon.date_died_filtered.indexOf(comps[1]);
          }
          // find index of bar text
          if (index != -1){
            // use index to get reference to correct bar
            highlight_bar_photos($('#' + comps[0] + ' svg g.highcharts-series-group g.highcharts-series rect')[index]);
          }
        } else if (name.indexOf('map_') == 0){
          // map
          // split hash into components
          // [0] = div id
          // [1] = shape name
          var comps = name.split(hash_separator);
          var dataname = 'place-died';
          if (comps[0].indexOf('georgia') != -1){
            dataname = 'region-from';
          }
          highlight_map_photos($('#' + comps[0] + ' svg g path[shape_name="' + comps[1] + '"]'), dataname);
        }
      }
    });

  $('#thumbs li > a').click(function () {
    // if this photo is for the profile that is open, hide everything
    var was_active = $('#soldier_profiles .soldier_profile.active');
    if (was_active.length == 1 && $(this).data('id') == $(was_active).data('id')){
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
    var id = $(this).data('id');
    var parent = $('#thumbs li > a[data-id="' + id + '"]').parent();
    var new_item = $(parent).next().children();
    // if this is the last item in the list, go back to the first one
    if ($(parent).is('li:last-child')){
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
    var id = $(this).data('id');
    var parent = $('#thumbs li > a[data-id="' + id + '"]').parent();
    var new_item = $(parent).prev().children();
    // if this is the first item in the list, go back to the last one
    if ($(parent).is('li:first-child')){
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
