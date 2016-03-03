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
//= require bootstrap
//= require turbolinks
//= require chosen-jquery
//= require country_state_select
//= require jquery_ujs
//= require autocomplete-rails
//= require jquery-ui
//= require_tree .
 	
$(document).on('ready page:load', function() {

return CountryStateSelect({
	country_id: "user_country",
	state_id: "user_state",
	city_id: "user_city",
});
});