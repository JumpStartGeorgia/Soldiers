function load_soldier_profile(id){
  if ($('#soldier_profiles .soldier_profile.active').length > 0){
    $('#soldier_profiles .soldier_profile.active').fadeOut(function(){
      $('#soldier_profiles .soldier_profile.active').removeClass('active');
      $('#soldier_profiles .soldier_profile[data-id="' + id + '"]').addClass('active');
      $('#soldier_profiles .soldier_profile[data-id="' + id + '"]').fadeIn();
    });
  } else {
    $('#soldier_profiles .soldier_profile[data-id="' + id + '"]').addClass('active');
    $('#soldier_profiles .soldier_profile[data-id="' + id + '"]').slideDown();
  }
}

$(document).ready(function() {

  $('#thumbs li > a').click(function () {
    $('#thumbs li > a.active').removeClass('active');
    $(this).addClass('active');
    load_soldier_profile($(this).data('id'));

  });
  

  // hide the profile section
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_close > a').click(function (){
    $('#soldier_profiles .soldier_profile.active').slideUp(function(){
      $('#thumbs li > a.active').removeClass('active');
      $('#soldier_profiles .soldier_profile.active').removeClass('active');
    });
    
  });
  
  // load the next one
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_next > a').click(function (){
    var new_item = $('#thumbs li > a.active').parent().next().children();
    // if this is the last item in the list, go back to the first one
    if ($('#thumbs li > a.active').parent().is('li:last-child')){
      new_item = $('#thumbs li:first-child').children();
    }
    
    $('#thumbs li > a.active').removeClass('active');
    $(new_item).addClass('active');
    load_soldier_profile($(new_item).data('id'));
  });
  
  // load the previous one
  $('#soldier_profiles .soldier_profile .soldier_nav li.soldier_nav_previous > a').click(function (){
    var new_item = $('#thumbs li > a.active').parent().prev().children();
    // if this is the first item in the list, go back to the last one
    if ($('#thumbs li > a.active').parent().is('li:first-child')){
      new_item = $('#thumbs li:last-child').children();
    }
    
    $('#thumbs li > a.active').removeClass('active');
    $(new_item).addClass('active');
    load_soldier_profile($(new_item).data('id'));
  });
  

});
