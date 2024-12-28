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
package app.jpetstore.user;

import com.aspectran.core.adapter.SessionAdapter;
import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.aware.ActivityContextAware;
import com.aspectran.core.context.ActivityContext;
import com.aspectran.utils.Assert;
import com.aspectran.utils.annotation.jsr305.NonNull;

@Component
@Bean("userSessionManager")
@AvoidAdvice
public class UserSessionManager implements ActivityContextAware {

    public static final String USER_SESSION_KEY = "user";

    private ActivityContext context;

    @NonNull
    protected ActivityContext getActivityContext() {
        Assert.state(context != null, "No ActivityContext injected");
        return context;
    }

    @Override
    @AvoidAdvice
    public void setActivityContext(@NonNull ActivityContext context) {
        this.context = context;
    }

    public UserSession get() {
        return get(true);
    }

    public UserSession get(boolean create) {
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

    public void save(UserSession userSession) {
        getSessionAdapter().setAttribute(USER_SESSION_KEY, userSession);
    }

    public void expire() {
        getSessionAdapter().invalidate();
    }

    public void checkAuthentication() {
        UserSession userSession = get(false);
        if (userSession == null || !userSession.isAuthenticated()) {
            throw new UserAuthRequiredException();
        }
    }

    @NonNull
    private SessionAdapter getSessionAdapter() {
        return getActivityContext().getCurrentActivity().getSessionAdapter();
    }

}
