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
//= require chosen-jquery
//= require country_state_select
//= require jquery-ui
//= require_tree .

$(function () {
    var selectItem = function (event, ui) {
        window.location.replace("/catalog/index?product_name="+ui.item.value);
        return false;
    }
    $("#search_text").autocomplete({
        source: function (request, response) {
        	$.get(
            "/products/search/"+request.term,
            function (data) {
            	response(data)
            });
    },
        select: selectItem,
        minLength: 1
    });
});

$(document).on('ready page:load', function() {
return CountryStateSelect({
	country_id: "seller_country",
	state_id: "seller_state",
	city_id: "seller_city",
});
});