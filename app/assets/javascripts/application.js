// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require jquery-ui
//= require autocomplete-rails
//= require jquery
//= require jquery_ujs


$(document).on('ready page:load', function() {
  return CountryStateSelect({
    country_id: "country_id",
    state_id: "state_id"
  });
});

function sticky_relocate() {
	var window_top = $(window).scrollTop();
	var div_top = $('#sticky-anchor').offset().top;
	if (window_top > div_top) {
        $('#sticky').addClass('stick');
    } else {
        $('#sticky').removeClass('stick');
    }
}



$(function(){
	$(window).scroll(sticky_relocate);
	sticky_relocate();
});
