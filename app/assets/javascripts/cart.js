$('.cart-item').bind('input propertychange', function(){
    alert($(this).val());
});

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
    $('#cart-info').fadeOut(300);
    if ($('.comment-arrow').is('#showcom')) {
        manageCommentArrow();
    }
    $(".add-column").hide();
}

function expandCart() {
    $('#items-panel').removeClass('items-panel-expanded');
    $('#cart-panel').removeClass('cart-panel-hidden');
    $('#checkout-footer').fadeIn(300);
    $('#cart-items').fadeIn(300);
    $('#cart-info').fadeIn(300);
    //$('.add-column').css('width', 'auto');
    setTimeout( function () {
        $('.add-column').fadeIn(300);
    }, 100);
}

function updateCart( id ) {
    var cart_sid = $("#SID-input").val()
    var cart_purpose = $('#comment-input').val()
    console.log("woo " + cart_sid);
    console.log("wee " + cart_purpose);
    $.ajax({
        url: '/items/add_item',
        data: { 
            'id' : id,
            'cart_sid' : cart_sid,
            'cart_purpose' : cart_purpose
        },
        method: 'POST',
        dataType: 'script'
    });
}

function deleteCartItem( id ) {
    $.ajax({
        url: '/items/delete_cart_item',
        data: { 'id' : id },
        method: 'POST',
        dataType: 'script'
    });
}

function resetCart() {
    manageCommentArrow();
    hideCart();
    $('#SID-input').val('');
    $('#comment-input').val('');
    $('#cart-items').html('');
}

function manageCommentArrow() {
    var commentArrow = $('.comment-arrow');
    var comments = $(".cart-textarea");
    if ( commentArrow.is('#showcom') ) {
        commentArrow.attr("id", "hidecom")
        comments.fadeOut(100);    
        setTimeout( function () {
            comments.css("height","0px");
        }, 100);
    } else {
        commentArrow.attr("id", "showcom");
        comments.css("height", "75px");
        setTimeout( function () {
            comments.fadeIn(100);
        }, 100);
    }
}

$(document).ready( function () {

	$('.comment-arrow').click( function () {
        manageCommentArrow();
    });

    $('#checkout-button').click( function() {
        $('#checkout-button').attr('href', "/");
        var SID = $("#SID-input").val();
        if (SID === null || SID === '') {
            showAlert("Must enter a Student ID.");
        } else {
            var cart_items = $('#cart-items .cart-item');
            var checkout_list = [];
            for (var i = 0; i < cart_items.length; i++) {
                var item = [];
                var cart_item = cart_items[i];
                var quantity = cart_item.getElementsByClassName('cart-item-quantity')[0].value;
                var item_name = cart_item.getElementsByClassName('cart-item-name')[0].innerHTML;
                item.push(item_name);
                item.push(quantity);
                checkout_list.push(item);
            }
            if (checkout_list.length > 0) {
                var purpose = $('#comment-input').val();
                $.ajax({
                    url: '/transactions/checkout',
                    method: 'POST',
                    data: {
                      items: checkout_list,
                      buyer: SID,
                      purpose: purpose
                    },
                    dataType: 'script',
                    success: function(data, textStatus, jqXHR) {
                        showAlert("Transaction Successful!")
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        if (errorThrown == "Unauthorized") {
                            showAlert("SID not found.\nPlease have the user register on B-Labs.")
                        }
                        if (errorThrown == "Bad Request") {
                            showAlert("Requested quantity is unavailable.")
                        }
                    }
                });
            } else {
                showAlert("No items to checkout.");
            }
        }
    });

});