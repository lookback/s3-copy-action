// Options are saved in localStorage.

function save_options() {
    localStorage['debug'] = $('#debug').prop('checked');
    localStorage['api_url'] = $('#api-url').val();
    localStorage['api_token'] = $('#api-token').val();
}

$(document).load(function() {
    if (localStorage['debug'] == 'true') {
        $('#debug').prop('checked', true);
    }
    $('#api-url').val(localStorage["api_url"]);
    $('#api-token').val(localStorage["api_token"]);
    $('#save').click(save_options);
});
