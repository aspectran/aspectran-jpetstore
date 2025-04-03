/*
 * Copyright (c) 2008-2025 The Aspectran Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package app.jpetstore.monitoring.log;

import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.utils.StringUtils;
import com.aspectran.utils.annotation.jsr305.NonNull;
import com.aspectran.web.websocket.jsr356.AspectranConfigurator;
import com.aspectran.web.websocket.jsr356.SimplifiedEndpoint;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@Component
@ServerEndpoint(
        value = "/monitoring/logtail",
        configurator = AspectranConfigurator.class
)
public class LogtailEndpoint extends SimplifiedEndpoint {

    private static final String COMMAND_JOIN = "JOIN:";

    private static final String COMMAND_LEAVE = "LEAVE";

    private static final String MESSAGE_PING = "--ping--";

    private static final String MESSAGE_PONG = "--pong--";

    private LogTailerManager logTailerManager;

    public void setLogTailerManager(LogTailerManager logTailerManager) {
        this.logTailerManager = logTailerManager;
    }

    @Override
    protected void registerMessageHandlers(@NonNull Session session) {
        session.addMessageHandler(String.class, message -> {
            setLoggingGroup();
            handleMessage(session, message);
        });
    }

    public void handleMessage(Session session, String message) {
        if (MESSAGE_PING.equals(message)) {
            pong(session);
            return;
        }
        if (message != null && message.startsWith(COMMAND_JOIN)) {
            join(session, message);
        } else if (COMMAND_LEAVE.equals(message)) {
            removeSession(session);
        }
    }

    @Override
    protected void onSessionRemoved(Session session) {
        logTailerManager.release(session);
    }

    private void pong(Session session) {
        sendText(session, MESSAGE_PONG);
    }

    private void join(Session session, String message) {
        if (addSession(session)) {
            String[] names = StringUtils.splitWithComma(message.substring(COMMAND_JOIN.length()));
            logTailerManager.join(session, names);
        }
    }

}
