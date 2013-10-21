/*
 * Chrome requests recorder class.
 */

(function(LI) {
    LI.Recorder = function() {
        this.recording = false;
        this.requests = {};
        this.onBeforeRequestCb = $.proxy(this._onBeforeRequest, this);
        this.onBeforeSendHeadersCb = $.proxy(this._onBeforeSendHeaders, this);
    };

    LI.Recorder.prototype.getRequests = function() {
        var requests = [],
            request = null,
            method = null,
            body = null;
        for (var reqId in this.requests) {
            request = this.requests[reqId];
            method = request.method.toUpperCase();
            body = null;

            if (-1 != $.inArray(method, ['POST', 'PUT'])) {
                if (request.requestBody.formData) {
                    body = request.requestBody.formData;
                } else {
                    body = request.requestBody.raw;
                }
            }

            requests.push({
                'method': method,
                'url': request.url,
                'headers': request.requestHeaders,
                'body': body
            });
        }
        return requests;
    };

    LI.Recorder.prototype.pause = function() {
        this.stop();
    };

    LI.Recorder.prototype.reset = function() {
        this.requests = {};
    };

    LI.Recorder.prototype.start = function(tabId) {
        var request_filter = {
            tabId: tabId,
            urls: []
        };

        chrome.webRequest.onBeforeRequest.addListener(
            this.onBeforeRequestCb, request_filter, ["requestBody"]);
        chrome.webRequest.onBeforeSendHeaders.addListener(
            this.onBeforeSendHeadersCb, request_filter, ["requestHeaders"]);
        this.recording = true;
        this.setIcon(tabId, "img/icon-16.png");
    };

    LI.Recorder.prototype.stop = function(tabId) {
        chrome.webRequest.onBeforeRequest.removeListener(
            this.onBeforeRequestCb);
        chrome.webRequest.onBeforeSendHeaders.removeListener(
            this.onBeforeSendHeadersCb);
        this.recording = false;
        this.setIcon(tabId, "img/icon-16.png");
    };

    LI.Recorder.prototype.setIcon = function(tabId, icon) {
        chrome.browserAction.setIcon({"tabId": tabId, "path": icon});
    };

    LI.Recorder.prototype._onBeforeRequest = function(details) {
        this.requests[details.requestId] = details;
    };

    LI.Recorder.prototype._onBeforeSendHeaders = function(details) {
        if (this.requests[details.requestId]) {
            this.requests[details.requestId].requestHeaders = details.requestHeaders;
        }
    };
})(LI);
