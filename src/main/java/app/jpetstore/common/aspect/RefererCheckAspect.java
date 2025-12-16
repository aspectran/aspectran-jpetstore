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
package app.jpetstore.common.aspect;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.activity.response.ResponseTemplate;
import com.aspectran.core.component.bean.annotation.Aspect;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Before;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Joinpoint;
import com.aspectran.utils.StringUtils;
import com.aspectran.web.support.http.HttpStatus;
import org.jspecify.annotations.NonNull;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@Component
@Bean
@Aspect("refererCheckAspect")
@Joinpoint(
        pointcut = {
                "+: /cart/**",
                "+: /order/viewOrder",
                "+: /order/deleteOrder/*",
                "+: /account/editAccountForm"
        }
)
public class RefererCheckAspect {

    private static final Logger logger = LoggerFactory.getLogger(RefererCheckAspect.class);

    @Before
    public void before(@NonNull Translet translet) throws IOException {
        String referer = translet.getRequestAdapter().getHeader("Referer");
        if (!StringUtils.hasText(referer)) {
            if (logger.isDebugEnabled()) {
                logger.debug("No Referer header found");
            }
            ResponseTemplate responseTemplate = new ResponseTemplate(translet.getResponseAdapter());
            responseTemplate.setStatus(HttpStatus.BAD_REQUEST.value());
            translet.response(responseTemplate);
        }
    }

}
