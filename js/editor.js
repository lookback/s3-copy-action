/* File responsible for handling editing of recorded user scenarios. */

/**
 * Handles requests sent by the background script.
 */
function onRequest(request, sender, sendResponse) {
    if ('script-generated' == request.type) {
        $('#load-script').val(request.load_script);
    }

    // Return nothing to let the connection be cleaned up.
    sendResponse({});
}

// Listen for the content script to send a message to the background page.
chrome.extension.onRequest.addListener(onRequest);
