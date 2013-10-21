/* Main file responsible for hooking into request API and recording traffic. */

// Extension namespace.
var LI = {
    _recorder: null,
    getRecorderInstance: function() {
        if (!this._recorder) {
            this._recorder = new LI.Recorder();
        }
        return this._recorder;
    }
};

/**
 * Handles requests sent by the popup script.
 */
function onRequest(request, sender, sendResponse) {
    var recorder = null;

    if ('start-recording' == request.type) {
        chrome.tabs.getSelected(null, function(tabs) {
            recorder = LI.getRecorderInstance();
            recorder.start(tabs.id);
        });
    } else if ('stop-recording' == request.type) {
        chrome.tabs.getSelected(null, function(tabs) {
            recorder = LI.getRecorderInstance();
            recorder.stop(tabs.id);

            // Generate user scenario load script from collected requests and send
            // it to submission page.
            var generator = new LI.LoadScriptGenerator();
            var load_script = generator.generateFromRequests(recorder.getRequests());
            var msg = {
                'type': 'script-generated',
                'load_script': load_script
            };
            //alert(load_script);
            chrome.tabs.create({'url': 'editor.html', 'active': true, 'openerTabId': tabs.id}, function(tab) {
                chrome.extension.sendRequest(msg, function(response) {});
            });
        });
    }

    // Return nothing to let the connection be cleaned up.
    sendResponse({});
}

// Listen for the content script to send a message to the background page.
chrome.extension.onRequest.addListener(onRequest);
