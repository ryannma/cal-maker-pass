// initialize items
var items;
items = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/query?q=%QUERY'
  }
});
items.initialize();

// initialize transactions
var transactions;
transactions = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  remote: {
    url: '/tquery?q=%QUERY'
  }
});
transactions.initialize();

$(document).ready( function () {

  // items
	$('#phrase.typeahead').typeahead({
          hint: true,
          highlight: true,
          minLength: 1
        }, {
          name: 'items',
          displayKey: 'name',
          source: items.ttAdapter()
        }
    );

  $('#search-bar-container').keypress(function(e) {
      if(e.which == 13) {
        $.ajax({
          url: '/items/find',
          data: { 'phrase' : $("#phrase").val() },
          method: 'GET',
          dataType: 'script'
        });
      }
  });

  $('#search-bar-container').on('focus', '#phrase', function () {
    $('.search-svg').attr('id', 'hilited-glass');
  });

  $('#search-bar-container').on('blur', '#phrase', function () {
    $('.search-svg').removeAttr('id');
  });

  // transactions
  $('#tphrase.typeahead').typeahead({
          hint: true,
          highlight: true,
          minLength: 1
        }, {
          name: 'transactions',
          displayKey: 'purpose',
          source: transactions.ttAdapter()
        }
    );

  $('#tsearch-bar-container').keypress(function(e) {
      if(e.which == 13) {
        $.ajax({
          url: '/transactions/find',
          data: { 'tphrase' : $("#tphrase").val() },
          method: 'GET',
          dataType: 'script'
        });
      }
  });

  $('#tsearch-bar-container').on('focus', '#tphrase', function () {
    $('.search-svg').attr('id', 'hilited-glass');
  });

  $('#tsearch-bar-container').on('blur', '#tphrase', function () {
    $('.search-svg').removeAttr('id');
  });

});