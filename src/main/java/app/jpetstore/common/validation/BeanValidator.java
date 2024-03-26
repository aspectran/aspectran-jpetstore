package app.jpetstore.common.validation;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.component.bean.annotation.Autowired;
import com.aspectran.core.component.bean.annotation.Bean;
import com.aspectran.core.component.bean.annotation.Component;
import com.aspectran.core.component.bean.annotation.Scope;
import com.aspectran.core.context.rule.type.ScopeType;
import com.aspectran.web.support.http.HttpStatusSetter;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validator;

import java.util.HashMap;
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

    @SuppressWarnings("rawtypes")
    public <T> Map<String, String> validate(Translet translet, T model, Class<?>... groups) {
        Set<ConstraintViolation<T>> constraintViolations = validator.validate(model, groups);
        if (!constraintViolations.isEmpty()) {
            for (ConstraintViolation violation : constraintViolations) {
                touchErrors().put(violation.getPropertyPath().toString(), violation.getMessage());
            }
            HttpStatusSetter.badRequest(translet);
            return getErrors();
        }
        return null;
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
        errors = null;
    }

    private Map<String, String> touchErrors() {
        if (errors == null) {
            errors = new HashMap<>();
        }
        return errors;
    }

}
