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
// = require jquery
// = require jquery_ujs
//= require turbolinks
//= require_tree .
//= require twitter/typeahead

var items;

items = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
  	url: '/query?q=%QUERY'
  }
});

items.initialize();


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
	$('.cart-svg').click( function () {
		manageCart();
	});

	$('#phrase.typeahead').typeahead({
		  hint: true,
		  highlight: true,
		  minLength: 1
		}, {
		  name: 'items',
		  displayKey: 'name',
		  source: items.ttAdapter()
		});

	$('.comment-arrow').click( function () {
		var commentArrow = $(this);
		var comments = $(".cart-textarea");
		if ( commentArrow.hasClass('comment-arrow-down') ) {
			commentArrow.removeClass('comment-arrow-down');
			comments.fadeOut(100);	
			setTimeout( function () {
				comments.css("height","0px");
			}, 100);
		} else {
			commentArrow.addClass('comment-arrow-down');
			comments.css("height","33px");
			setTimeout( function () {
				comments.fadeIn(100);
			}, 100);
		}
	});
	// $('#new-item-container').click( function (e) {
	// 	e.stopPropagation();
	// })

});

// document.onkeydown=function(){
//     if(window.event.keyCode=='13'){
//     	console.log("should had submitted")
//     	console.log($('#search-form'))
//         $('#search-form').submit();
//         $('#search-form').method='post';
//     }
// }

function manageCart() {
	var itemsPanel = $('#items-panel');
	var cartPanel = $('#cart-panel');
	var checkoutFooter = $('#checkout-footer');
	var cartItems = $('#cart-items');
	var addColumn = $('.add-column');
	if ( itemsPanel.hasClass('items-panel-expanded')) {
		itemsPanel.removeClass('items-panel-expanded');
		cartPanel.removeClass('cart-panel-hidden');
		checkoutFooter.fadeIn(300);
		cartItems.fadeIn(300);
		addColumn.css('width', 'auto');
		setTimeout( function () {
			addColumn.fadeIn(300);
		}, 100);
	} else {
		itemsPanel.addClass('items-panel-expanded');
		cartPanel.addClass('cart-panel-hidden');
		checkoutFooter.fadeOut(300);
		cartItems.fadeOut(300);
		addColumn.css('width', '0');
		setTimeout( function () {
			addColumn.fadeOut(300);
		}, 100);
	}
}

function updateCart( id ) {
	$.ajax({
		url: '/items/add_item',
		data: {'id': id },
		method: 'POST'})
	.done ( function ( data ) {
		var cart = data;
		var cart_items = data["cart_items"];
		var cart_total = data["cart_total"];
		console.log(cart_total);
		$('#cart-wrapper')
		.html('<%= escape_javascript( render partial: "cart", collection: ' + cart_items + ', as: "cart_items") %>');
	});
}
