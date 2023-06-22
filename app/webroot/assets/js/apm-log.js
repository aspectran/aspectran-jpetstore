function LogTailer(endpoint, tailers) {
    this.endpoint = endpoint;
    this.tailers = tailers;
    this.socket = null;
    this.heartbeatTimer = null;
    this.scrollTimer = null;
    this.oldDateTime = null;

    this.openSocket = function() {
        if (this.socket) {
            this.socket.close();
        }
        let url = new URL(this.endpoint, location.href);
        url.protocol = url.protocol.replace('https:', 'wss:');
        url.protocol = url.protocol.replace('http:', 'ws:');
        this.socket = new WebSocket(url.href);
        let self = this;
        this.socket.onopen = function (event) {
            self.printEventMessage("Socket connection successful");
            self.socket.send("JOIN:" + self.tailers);
            self.heartbeatPing();
            self.switchTailBite(false, true);
        };
        this.socket.onmessage = function (event) {
            if (typeof event.data === "string") {
                if (event.data === "--heartbeat-pong--") {
                    self.heartbeatPing();
                    return;
                }
                let msg = event.data;
                let idx = msg.indexOf(":");
                if (idx !== -1) {
                    let tailerName = msg.substring(0, idx);
                    let text = msg.substring(idx + 1);
                    if (text.startsWith("last:")) {
                        text = text.substring(5);
                        self.printMessage(tailerName, text, false);
                    } else {
                        self.printMessage(tailerName, text, true);
                    }
                }
            }
        };
        this.socket.onclose = function (event) {
            self.printEventMessage('Socket connection closed. Please refresh this page to try again!');
            self.closeSocket();
        };
        this.socket.onerror = function (event) {
            console.error("WebSocket error observed:", event);
            self.printErrorMessage('Could not connect to WebSocket server');
            self.switchTailBite(false, false);
            setTimeout(function () {
                self.openSocket();
            }, 60000);
        };
    };

    this.closeSocket = function() {
        if (this.socket) {
            this.socket.close();
            this.socket = null;
        }
    };

    this.heartbeatPing = function() {
        if (this.heartbeatTimer) {
            clearTimeout(this.heartbeatTimer);
        }
        let self = this;
        this.heartbeatTimer = setTimeout(function () {
            if (self.socket) {
                self.socket.send("--heartbeat-ping--");
                self.heartbeatTimer = null;
                self.heartbeatPing();
            }
        }, 57000);
    };

    this.printMessage = function(tailer, text, visualize) {
        if (visualize) {
            this.launchMissile(text);
        }
        let line = $("<p/>").text(text);
        let logtail = $("#" + tailer);
        logtail.append(line);
        this.scrollToBottom(logtail);
    };

    this.printEventMessage = function(text, tailer) {
        let logtail = (tailer ? $("#" + tailer) : $(".log-tail"));
        $("<p/>").addClass("event").html(text).appendTo(logtail);
        this.scrollToBottom(logtail);
    };

    this.printErrorMessage = function(text, tailer) {
        let logtail = (tailer ? $("#" + tailer) : $(".log-tail"));
        $("<p/>").addClass("event error").html(text).appendTo(logtail);
        this.scrollToBottom(logtail);
    };

    this.switchTailBite = function(logtail, status) {
        if (!logtail) {
            logtail = $(".log-tail");
        }
        if (status !== true && status !== false) {
            status = !logtail.data("bite");
        }
        if (status) {
            logtail.closest(".log-container").find(".tail-status").addClass("active");
            logtail.data("bite", true);
            this.scrollToBottom(logtail)
        } else {
            logtail.closest(".log-container").find(".tail-status").removeClass("active");
            logtail.data("bite", false);
        }
    };

    this.scrollToBottom = function(logtail) {
        if (logtail.data("bite")) {
            if (this.scrollTimer) {
                clearTimeout(this.scrollTimer);
            }
            this.scrollTimer = setTimeout(function () {
                logtail.scrollTop(logtail.prop("scrollHeight"));
                if (logtail.find("p").length > 11000) {
                    logtail.find("p:gt(10000)").remove();
                }
            }, 300);
        }
    };

    this.pattern1 = /^DEBUG (.+) \[(.+)] Session (\S+) complete, active requests=(\d+)/;
    this.pattern2 = /^DEBUG (.+) \[(.+)] Invalidate session id=(\S+)/;
    this.pattern3 = /^DEBUG (.+) \[(.+)] Session (\S+) accessed, stopping timer, active requests=(\d+)/;
    this.pattern4 = /^DEBUG (.+) \[(.+)] Create new session id=(\S+)/;

    this.launchMissile = function(line) {
        let matches1 = this.pattern1.exec(line);
        let matches2 = this.pattern2.exec(line);
        let matches3 = this.pattern3.exec(line);
        let matches4 = this.pattern4.exec(line);

        if (matches1 || matches2 || matches3 || matches4) {
            console.log(line);
            console.log('matches1', matches1);
            console.log('matches2', matches2);
            console.log('matches3', matches3);
            console.log('matches4', matches4);
        }

        let dateTime = "";
        let sessionId = "";
        let requests = 0;
        let delay = 0;
        if (matches1 || matches2) {
            if (matches1) {
                sessionId = matches1[3];
                requests = matches1[4];
            } else {
                sessionId = matches2[3];
            }
            if (requests > 3) {
                requests = 3;
            }
            requests++;
            let mis = $(".missile-route").find(".missile[sessionId='" + (sessionId + requests) + "']");
            console.log("remove delay:", mis.data("delay")||0);
            if (mis.length > 0) {
                let dur = 850 + mis.data("delay")||0;
                if (mis.hasClass("mis-2")) {
                    dur += 250;
                } else if (mis.hasClass("mis-3")) {
                    dur += 500;
                }
                setTimeout(function () {
                    mis.remove();
                }, dur);
            }
            return;
        }
        if (matches3 || matches4) {
            if (matches3) {
                dateTime = matches3[1];
                sessionId = matches3[3];
                requests = matches3[4];
            } else {
                dateTime = matches4[1];
                sessionId = matches4[3];
            }
            if (requests > 3) {
                requests = 3;
            }
            let dt = moment(dateTime);
            if (this.oldDateTime) {
                delay = dt.diff(this.oldDateTime);
                console.log("diff:", delay);
                if (delay > 1000) {
                    delay = 0;
                }
            }
            this.oldDateTime = dt;
        }
        if (requests > 0) {
            let mis = $("<div/>").attr("sessionId", sessionId + requests);
            mis.css("top", this.generateRandom(3, 90 - (requests * 2)) + "%");
            mis.appendTo($(".missile-route")).addClass("hidden missile");
            mis.data("delay", delay);
            if (delay > 0) {
                console.log("launched!", delay);
                setTimeout(function () {
                    mis.addClass("mis-" + requests).removeClass("hidden");
                }, delay);
            } else {
                console.log("launched!", delay);
                mis.addClass("mis-" + requests).removeClass("hidden");
            }
        }
    };

    this.generateRandom = function(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min;
    };
}