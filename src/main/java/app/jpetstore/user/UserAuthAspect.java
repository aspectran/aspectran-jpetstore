/*
 * Copyright (c) 2008-present The Aspectran Project
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

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Action;
import com.aspectran.core.component.bean.annotation.Aspect;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Before;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.ExceptionThrown;
import com.aspectran.core.component.bean.annotation.Joinpoint;
import com.aspectran.utils.annotation.jsr305.NonNull;

import java.util.Map;

/**
 * <p>Created: 4/5/24</p>
 */
@Component
@Bean
@Aspect("userAuthAspect")
@Joinpoint(
        pointcut = {
                "+: /order/**",
                "+: /account/edit**"
        }
)
public class UserAuthAspect {

    private final UserSessionManager userSessionManager;

    @Autowired
    public UserAuthAspect(UserSessionManager userSessionManager) {
        this.userSessionManager = userSessionManager;
    }

    @Before
    public void before() {
        userSessionManager.checkAuthentication();
    }

    @ExceptionThrown(UserAuthRequiredException.class)
    @Action("msg")
    public String exceptionThrown(@NonNull Translet translet) {
        translet.redirect("/account/signonForm", Map.of("referer", translet.getRequestName()));
        return "User Authentication Required";
    }

}
