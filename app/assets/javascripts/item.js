function showItem( id ) {
    $.ajax({
        url: '/items/show_item',
        data: { 'id' : id },
        method: 'POST',
        dataType: 'script',
        success: function() {
            var item_id = id;
            document.querySelector('#modal-overlay').addEventListener('click', function() {
                $('#modal').fadeOut(200);
            });
            document.querySelector('#show-item-back').addEventListener('click', function() {
                $('#modal').fadeOut(200);
            });
            document.querySelector('#modal-overlay').addEventListener('click', function() {
                $('#modal').fadeOut(200);
            });
            document.querySelector('#show-item-delete').addEventListener('click', function() {
                $.ajax({
                    url: '/items/' + item_id+'/delete',
                    method: 'POST'
                });
            });
            document.querySelector('#show-item-update').addEventListener('click', function() {
                    var name = document.getElementById('item_name').value;
                    var price = document.getElementById('item_price').value;
                    var quantity = document.getElementById('item_quantity').value;
                    var status = document.getElementById('item_status').value;
                    var kind = document.getElementById('item_kind').value;
                    var item_dict = {'name': name, 'price': price, 'quantity': quantity, 'status':status, 'kind':kind};
                    $.ajax({
                        url: '/items/'+item_id+'/update',
                        method: 'POST',
                        data: {
                            item: item_dict
                        }
                    });
            });
        }
    });
}

$(document).ready( function () {

    $('#new-item-button').click( function () {
        $.ajax({
            url: '/items/create_item',
            method: 'POST',
            dataType: 'script',
            success: function () {
                document.querySelector('#new-item-cancel').addEventListener('click', function() {
                    $('#modal').fadeOut(200);
                });
                document.querySelector('#modal-overlay').addEventListener('click', function() {
                    $('#modal').fadeOut(200);
                });
                document.querySelector('#new-item-add').addEventListener('click', function() {
                    var name = document.getElementById('item_name').value;
                    var price = document.getElementById('item_price').value;
                    var quantity = document.getElementById('item_quantity').value;
                    var status = document.getElementById('item_status').value;
                    var kind = document.getElementById('item_kind').value;
                    var item_dict = {'name': name, 'price': price, 'quantity': quantity, 'status':status, 'kind':kind};
                    $.ajax({
                        url: '/items',
                        method: 'POST',
                        data: {
                            item: item_dict
                        }
                    });
                });
            }
        });
    });

    $('#inventory-wrapper').on('click', '.sorter', function () {
        var sort_by = $(this).prop('id');
        $.ajax({
            url: '/items/load',
            data: { 'sort_by' : sort_by },
            method: 'GET',
            dataType: 'script'
        });
    });

});