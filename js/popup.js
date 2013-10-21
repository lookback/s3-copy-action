/* Code for extension popup. */

$(function() {
    $('#start-recording').click(function() {
        var msg = {
            'type': 'start-recording'
        };
        chrome.extension.sendRequest(msg, function(response) {});
    });
    $('#stop-recording').click(function() {
        var msg = {
            'type': 'stop-recording'
        };
        chrome.extension.sendRequest(msg, function(response) {});
    });
    $('#start-recording').focus();
});
