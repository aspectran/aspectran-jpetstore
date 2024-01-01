/*
 * Copyright (c) 2008-2024 The Aspectran Project
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
package com.aspectran.jpetstore.common.user;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.adapter.SessionAdapter;
import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.aware.ActivityContextAware;
import com.aspectran.core.context.ActivityContext;
import com.aspectran.utils.Assert;

import java.util.HashMap;

@Component
@Bean("userSessionManager")
@AvoidAdvice
public class UserSessionManager implements ActivityContextAware {

    /**
     * The key used to store user sessions
     */
    public static final String USER_SESSION_KEY = "user";

    private ActivityContext context;

    protected void save(UserSession userSession) {
        getSessionAdapter().setAttribute(USER_SESSION_KEY, userSession);
    }

    public void expire() {
        getSessionAdapter().invalidate();
    }

    public void checkUserAuthentication(Translet translet) {
        UserSession userSession = getUserSession(false);
        if (userSession == null || !userSession.isAuthenticated()) {
            //throw new UserAuthenticationRequiredException();
            translet.redirect("/account/signonForm", new HashMap<>() {{
                put("referer", translet.getRequestName());
            }});
        }
    }

    public UserSession getUserSession() {
        return getUserSession(true);
    }

    public UserSession getUserSession(boolean create) {
        try {
            UserSession userSession = getSessionAdapter().getAttribute(USER_SESSION_KEY);
            if (userSession == null && create) {
                synchronized (USER_SESSION_KEY) {
                    userSession = getSessionAdapter().getAttribute(USER_SESSION_KEY);
                    if (userSession == null) {
                        userSession = new UserSession();
                        save(userSession);
                    }
                }
            }
            return userSession;
        } catch (ClassCastException e) {
            // Exception that can occur if the UserSession class changes during development.
            if (create) {
                UserSession userSession = new UserSession();
                save(userSession);
                return userSession;
            } else {
                expire();
                return null;
            }
        }
    }

    private SessionAdapter getSessionAdapter() {
        Assert.state(context != null, "No ActivityContext injected");
        SessionAdapter sessionAdapter = context.getCurrentActivity().getSessionAdapter();
        if (sessionAdapter == null) {
            throw new UnsupportedOperationException("No such SessionAdapter in " +
                    context.getCurrentActivity());
        }
        return sessionAdapter;
    }

    @Override
    @AvoidAdvice
    public void setActivityContext(ActivityContext context) {
        this.context = context;
    }

}
