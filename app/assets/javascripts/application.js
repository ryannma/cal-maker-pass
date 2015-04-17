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