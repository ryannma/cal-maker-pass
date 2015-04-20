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
$('.cart-item').bind('input propertychange', function(){
	  alert($(this).val());
	});

$(document).ready( function () {

	updateCart(null);
	history.navigationMode = 'compatible';

	$('#new-item-button').click( function () {
		$('#modal').fadeIn(500);
	});
	$('#new-item-cancel').click( function () {
		$('#modal').fadeOut(500);
	});
	$('#modal-overlay').click( function () {
		$('#modal').fadeOut(500);
	});
	// $('#cart-panel').on('click', '#cart-button', function () {
	// 	manageCart();
	// });

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

	$('#checkout-button').click( function() {
		var cart_items = document.getElementById('cart-items').getElementsByClassName('cart-item');
		var bought_items = []
		var checkout_button = document.getElementById('checkout-button').setAttribute('href', "/");
		for (i = 0; i < cart_items.length; i++) {
			var item = []
			var cart_item = cart_items[i];
			var quantity = cart_item.getElementsByClassName('cart-item-quantity')[0].value;
			var item_name = cart_item.getElementsByClassName('cart-item-name')[0].innerHTML;
			item.push(item_name);
			item.push(quantity);
			bought_items.push(item);
		}
		if (bought_items.length > 0) {
			var user = document.getElementById('transaction_user').value;
			var purpose = document.getElementById('transaction_purpose').value;
			$.ajax({
				url: '/transactions/checkout',
		    method: 'post',
		    data: {
		      items: bought_items,
		      buyer: user,
		      purpose: purpose,
		    },
		    success: function () {
		    }
		  });
		}
		else {
			showAlert("No items to checkout");

		}
	});

	$('.transaction-arrow').click( function () {
		var transactionArrow = $(this);
		var parentRow = this.parentElement.parentElement;
		var row_index = parentRow.rowIndex;
		var additional = 1;
		var nextRow = parentRow.parentNode.rows[row_index];
		
		if ( transactionArrow.hasClass('transaction-arrow-down') ) {
			transactionArrow.removeClass('transaction-arrow-down');
			while (nextRow.className.indexOf("line_item_row") > -1) {
				nextRow.style.display = "none";
				nextRow.className = "line_item_row";
				nextRow = parentRow.parentNode.rows[row_index+additional];
				additional += 1;
			}
		} else {
			transactionArrow.addClass('transaction-arrow-down');
			while (nextRow.className.indexOf("line_item_row") > -1) {
				nextRow.style.display = "";
				nextRow.className = nextRow.className+" line_item_expanded";
				nextRow = parentRow.parentNode.rows[row_index + additional];
				additional += 1;
			}
		}

		// var line_items = document.getElementsByClassName('line_item_expanded');
		// var visible_line_items = false;
		// var line_item_headers = document.getElementsByClassName('line_item_headers');
		// for (i = 0; i < line_items.length; i++) {
		// 	if (line_items[i].style.display) {
		// 		visible_line_items = true;
		// 	}
		// }
		// if (visible_line_items == false) {
		// 	for (i = 0; i < line_item_headers.length; i++) {
		// 		line_item_headers[i].style.visibility = "hidden";
		// 	}
		// }
		// else {
		// 	for (i = 0; i < line_item_headers.length; i++) {
		// 		line_item_headers[i].style.visibility = "visibile";
		// 	}
		// }


	});
	// $('#new-item-container').click( function (e) {
	// 	e.stopPropagation();
	// })

});

document.onkeydown=function(){
    if(window.event.keyCode=='13'){
 		search();
    }
}


function manageCart() {
	if ($('#items-panel').hasClass('items-panel-expanded')) {
		expandCart();
	} else {
		hideCart();
	}
}

function hideCart() {
	$('#items-panel').addClass('items-panel-expanded');
	$('#cart-panel').addClass('cart-panel-hidden');
	$('#checkout-footer').fadeOut(300);
	$('#cart-items').fadeOut(300);
	$(".add-column").hide();
}

function expandCart() {
	$('#items-panel').removeClass('items-panel-expanded');
	$('#cart-panel').removeClass('cart-panel-hidden');
	$('#checkout-footer').fadeIn(300);
	$('#cart-items').fadeIn(300);
	$('.add-column').css('width', 'auto');
	setTimeout( function () {
		$('.add-column').fadeIn(300);
	}, 100);
}

function updateCart( id ) {
	$.ajax({
		url: '/items/add_item',
		data: { 'id' : id },
		method: 'POST',
		dataType: 'script'
	});
}


function search () {
	$.ajax({
		url: '/items/find',
		data: { 'phrase' : $("#phrase").val() },
		method: 'POST',
		dataType: 'script'
	}).done( function () {
		if ($('#items-panel').hasClass('items-panel-expanded')) {
			$('.add-column').hide();
		} else {
			$('.add-column').show();
		}
	});
}


function sortInventory( sort_by ) {
	$.ajax({
		url: '/items/sort',
		data: { 'sort_by' : sort_by },
		method: 'POST',
		dataType: 'script'
	}).done( function () {
		if ($('#items-panel').hasClass('items-panel-expanded')) {
			$('.add-column').hide();
		} else {
			$('.add-column').show();
		}
	});
}



function showAlert( alert ) {
	console.log('show alert');
	window.alert(alert);
}
