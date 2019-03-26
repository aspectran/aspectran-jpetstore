/*
 * Copyright (c) 2008-2019 The Aspectran Project
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

import com.aspectran.core.adapter.SessionAdapter;
import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.aware.ActivityContextAware;
import com.aspectran.core.context.ActivityContext;

@Component
@Bean("userSessionManager")
@AvoidAdvice
public class UserSessionManager implements ActivityContextAware {

    /**
     * The key used to store user sessions
     */
    public static final String USER_SESSION_KEY = "user";

    private ActivityContext activityContext;

    protected void save(UserSession userSession) {
        getSessionAdapter().setAttribute(USER_SESSION_KEY, userSession);
    }

    public void expire() {
        getSessionAdapter().removeAttribute(USER_SESSION_KEY);
    }

    public void checkUserAuthenticated() {
        UserSession userSession = getUserSession();
        if (!userSession.isAuthenticated()) {
            throw new UserAuthenticationRequiredException();
        }
    }

    public UserSession getUserSession() {
        try {
            UserSession userSession = getSessionAdapter().getAttribute(USER_SESSION_KEY);
            if (userSession == null) {
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
            expire();
            return null;
        }
    }

    private SessionAdapter getSessionAdapter() {
        if (activityContext == null) {
            throw new IllegalArgumentException("ActivityContext is not injected");
        }
        SessionAdapter sessionAdapter = activityContext.getCurrentActivity().getSessionAdapter();
        if (sessionAdapter == null) {
            throw new UnsupportedOperationException("There is no SessionAdapter in " +
                    activityContext.getCurrentActivity());
        }
        return sessionAdapter;
    }

    @Override
    public void setActivityContext(ActivityContext activityContext) {
        this.activityContext = activityContext;
    }

}