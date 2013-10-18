/*
 * Chrome requests recorder class.
 */

(function(LI) {
    var BATCH_THREASHOLD = 1000;

    LI.UserScenarioGenerator = function() {
    };

    LI.UserScenarioGenerator.prototype.generateFromRequests = function(requests) {
        var script = "",
            batches = [],
            batch = [],
            last_url_time = Date.now();

        requests.forEach(function(request) {
            // Determine if this URL should start a new batch or join an existing.
            var time = request.timeStamp;
            if (!batch.length || (time - last_url_time) < BATCH_THREASHOLD) {
                batch.push(request);
                if (!batches.length) {
                    batches.push(batch);
                    batch = [];
                    last_url_time = time;
                }
            } else {
                batches.push(batch);
                batch = [request];
                last_url_time = time;
            }
        });

        batches.forEach(function(batch) {
            script += "http.request_batch({\n";
            batch.forEach(function(request) {
                script += "\t{ \"" + request.method.toUpperCase() + "\", " +
                          "\"" + request.url + "\" },\n";
            });
            script += "})\n\n";
        });

        return script;
    };
})(LI);
