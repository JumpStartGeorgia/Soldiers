// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require i18n
//= require i18n/translations
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.bootstrap
//= require vendor
//= require_tree .

$(document).ready(function(){
	// set focus to first text box on page
	if (gon.highlight_first_form_field){
	  $(":input:visible:enabled:first").focus();
	}

	// workaround to get logout link in navbar to work
	$('body')
		.off('click.dropdown touchstart.dropdown.data-api', '.dropdown')
		.on('click.dropdown touchstart.dropdown.data-api', '.dropdown form', function (e) { e.stopPropagation() });




});


var $window = $(window);
$window.load(function ()
{

  var thumbs = $('#thumbs');
  var starting_top = thumbs.offset().top,
  height = thumbs.outerHeight(true);
  thumbs.css({top: starting_top, position: 'absolute', left: 0, right: 0, zIndex: 1020});
  thumbs.before('<div id="thumbs-placeholder" style="width: 100%; height: ' + height + 'px;"></div>');

  $window.scroll(function ()
  {
    var header_height = $('.navbar-fixed-top').outerHeight(true);//$('#center_header > a').outerHeight(true);
    var thumbs = $('#thumbs'),
    placeholder = $('#thumbs-placeholder');
    if (placeholder.offset().top - header_height <= $window.scrollTop())
    {
      if (thumbs.css('position') != 'fixed')
      {
        thumbs.css({position: 'fixed', top: header_height});
      }
    }
    else if (thumbs.css('position') == 'fixed')
    {
      thumbs.css({position: 'absolute', top: starting_top});
    }
  });


});









