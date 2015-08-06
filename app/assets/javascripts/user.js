function editUser(id) {
    setupModal('user', id, 'edit', ['first_name', 'last_name', 'sid', 'email', 'privilege'], 'GET');
}

function setupModal(controller, id, method, form_attributes, ajax_method) {
    $.ajax({
        url: '/'+controller+'s/'+id+'/'+method,
        data: { 'id' : id },
        method: ajax_method,
        dataType: 'script',
        success: function() {
            var obj_id = id;
            document.querySelector('#'+method+'-'+controller+'-back').addEventListener('click', function(event) {
                $('#modal').fadeOut(500);
            });
            document.querySelector('#modal-overlay').addEventListener('click', function(event) {
                $('#modal').fadeOut(500);
            });
            if (document.querySelector('#'+method+'-'+controller+'-delete') !== null) {
                document.querySelector('#'+method+'-'+controller+'-delete').addEventListener('click', function(event) {
                    $.ajax({
                        url: '/'+controller+'s/'+obj_id,
                        method: 'DELETE'
                    }).success(function () {
                        location.reload();
                    });
                });
            }
            document.querySelector('#'+method+'-'+controller+'-update').addEventListener('click', function(event) {
                obj_dict = {}
                for (var i=0; i<form_attributes.length; i++) {
                    key = form_attributes[i];
                    obj_dict[key] = $('#'+controller+'_'+key).val();
                }
                $.ajax({
                    url: '/'+controller+'s/'+obj_id,
                    method: 'PUT',
                    data: obj_dict
                }).success(function () {
                    location.reload();
                });
            });
        }
    });
}

function makeButtonActive( buttonId ) {
    $('#'+buttonId).removeClass('button-red');
    $('#'+buttonId).addClass('button-blue');
}