// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready( function () {
	$('.plus-svg').click( function () {
		$('#modal').fadeIn(500);
	});
	$('#new-item-cancel').click( function () {
		$('#modal').fadeOut(500);
	});
	$('#modal-overlay').click( function () {
		$('#modal').fadeOut(500);
	});
	$('.shop-svg').click( function () {
		manageCart();
	});
	// $('#new-item-container').click( function (e) {
	// 	e.stopPropagation();
	// })
});

function manageCart() {
	var itemsPanel = $('#items-panel');
	var cartPanel = $('#cart-panel');
	if ( itemsPanel.hasClass('items-panel-expanded')) {
		itemsPanel.removeClass('items-panel-expanded');
		cartPanel.removeClass('cart-panel-hidden');
	} else {
		itemsPanel.addClass('items-panel-expanded');
		cartPanel.addClass('cart-panel-hidden');
	}
}

function manageSort() {
	
}
