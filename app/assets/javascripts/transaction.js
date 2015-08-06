$(document).ready( function () {

	$('#transaction-table-wrapper').on('click', '.sorter', function () {
        var tsort_by = $(this).prop('id');
        $.ajax({
            url: '/transactions/load',
            data: { 'tsort_by' : tsort_by },
            method: 'GET',
            dataType: 'script'
        }).done( function () {
            var tsort_type = $('#transaction-table').attr('data-tsort-type');
            var id = '#' + tsort_by;
            var svg = id + ' svg';
            var span = id + ' span';
            $(id).addClass('hilite');
            if (tsort_type == 'ascending') {
                $(span).addClass('sort-align')
                $(svg).attr('class', 'sort-show-down');
            } else if (tsort_type == 'descending') {
                $(span).addClass('sort-align')
                $(svg).attr('class', 'sort-show-up');
            }        
        });
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
    });

});