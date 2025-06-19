/*
 * Copyright (c) 2018-present The Aspectran Project
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

import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Scope;
import com.aspectran.core.context.rule.type.ScopeType;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

@Component
@Bean("beanValidator")
@Scope(ScopeType.REQUEST)
public class BeanValidator {

    private final Validator validator;

    private Map<String, String> errors;

    @Autowired
    public BeanValidator(Validator validator) {
        this.validator = validator;
    }

    public <T> boolean validate(T model, Class<?>... groups) {
        Set<ConstraintViolation<T>> violations = validator.validate(model, groups);
        if (!violations.isEmpty()) {
            for (ConstraintViolation<T> violation : violations) {
                touchErrors().put(violation.getPropertyPath().toString(), violation.getMessage());
            }
            return true;
        } else {
            return false;
        }
    }

    public boolean hasErrors() {
        return (errors != null);
    }

    public Map<String, String> getErrors() {
        return errors;
    }

    public void putError(String key, String message) {
        touchErrors().put(key, message);
    }

    public void clearErrors() {
        errors.clear();
        errors = null;
    }

    private Map<String, String> touchErrors() {
        if (errors == null) {
            errors = new LinkedHashMap<>();
        }
        return errors;
    }

}
