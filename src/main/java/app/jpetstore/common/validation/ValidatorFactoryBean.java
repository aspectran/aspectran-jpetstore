/*
 * Copyright (c) 2018-2025 The Aspectran Project
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
package app.jpetstore.common.validation;

import com.aspectran.core.component.bean.ablility.DisposableBean;
import com.aspectran.core.component.bean.ablility.InitializableFactoryBean;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.support.i18n.message.MessageSource;
import com.aspectran.core.support.i18n.message.MessageSourceResourceBundle;
import jakarta.validation.MessageInterpolator;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.hibernate.validator.messageinterpolation.ResourceBundleMessageInterpolator;

@Component
@Bean
public class ValidatorFactoryBean implements InitializableFactoryBean<Validator>, DisposableBean {

    private final MessageSource messageSource;

    private ValidatorFactory validatorFactory;

    private Validator validator;

    @Autowired(required = false)
    public ValidatorFactoryBean(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @Override
    public void initialize() {
        if (validator == null) {
            MessageInterpolator messageInterpolator = null;
            if (messageSource != null) {
                messageInterpolator = new ResourceBundleMessageInterpolator(locale ->
                        new MessageSourceResourceBundle(messageSource, locale));
            }
            validatorFactory = Validation.byDefaultProvider()
                    .configure()
                    .messageInterpolator(messageInterpolator)
                    .buildValidatorFactory();
            validator = validatorFactory.getValidator();
        }
    }

    @Override
    public Validator getObject() {
        return validator;
    }


    @Override
    public void destroy() throws Exception {
        if (validatorFactory != null) {
            validatorFactory.close();
            validatorFactory = null;
            validator = null;
        }
    }

}
