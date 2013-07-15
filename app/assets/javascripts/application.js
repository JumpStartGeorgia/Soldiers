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
var ws = {};

$window.load(function ()
{
  ws.header = $('.navbar-fixed-top .container-fluid > .container-fluid');
  ws.thumbs = $('#thumbs');
  ws.thumbs.css({position: 'absolute', left: 0, right: 0, zIndex: 1020});
  ws.placeholder = ws.thumbs.before('<div id="thumbs-placeholder" style="width: 100%;"></div>').prev();

  $window.scroll(function (e)
  {
    if (ws.placeholder_offset_top - ws.header_height <= $window.scrollTop())
    {
      if (ws.thumbs.css('position') != 'fixed')
      {
        ws.thumbs.css({position: 'fixed', top: ws.header_height});
      }
    }
    else if (ws.thumbs.css('position') == 'fixed')
    {
      ws.thumbs.css({position: 'absolute', top: ws.placeholder_offset_top});
    }
  });

}).bind('load resize', function ()
{
  ws.placeholder.height(ws.thumbs.outerHeight(true));

  ws.placeholder_offset_top = ws.placeholder.offset().top;
  ws.header_height = ws.header.outerHeight(true);

  ws.thumbs.css({top: (ws.thumbs.css('position') == 'fixed') ? ws.header_height : ws.placeholder_offset_top});

  //($window.width() > fix_to_static) ? $('.navbar-fixed-top').outerHeight(true) : 0;
  //$('#center_header > a').outerHeight(true);
});









