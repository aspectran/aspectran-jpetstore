/*
 * Copyright (c) 2008-2020 The Aspectran Project
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
package com.aspectran.jpetstore.common.filter;

import com.aspectran.core.util.StringUtils;
import com.aspectran.core.util.apon.AbstractParameters;
import com.aspectran.core.util.apon.ParameterKey;
import com.aspectran.core.util.apon.ValueType;

public class XSSPatternItem extends AbstractParameters {

    private static final ParameterKey pattern;
    private static final ParameterKey caseInsensitive;
    private static final ParameterKey multiline;
    private static final ParameterKey dotall;

    private static final ParameterKey[] parameterKeys;

    static {
        pattern = new ParameterKey("pattern", ValueType.STRING);
        caseInsensitive = new ParameterKey("caseInsensitive", ValueType.BOOLEAN);
        multiline = new ParameterKey("multiline", ValueType.BOOLEAN);
        dotall = new ParameterKey("dotall", ValueType.BOOLEAN);

        parameterKeys = new ParameterKey[] {
                pattern,
                caseInsensitive,
                multiline,
                dotall
        };
    }

    public XSSPatternItem() {
        super(parameterKeys);
    }

    public String getPattern() {
        return StringUtils.nullToEmpty(getString(pattern));
    }

    public XSSPatternItem setPattern(String pattern) {
        putValue(XSSPatternItem.pattern, pattern);
        return this;
    }

    public boolean isCaseInsensitive() {
        return getBoolean(caseInsensitive, false);
    }

    public XSSPatternItem setCaseInsensitive(boolean caseInsensitive) {
        putValue(XSSPatternItem.caseInsensitive, caseInsensitive);
        return this;
    }

    public boolean isMultiline() {
        return getBoolean(multiline, false);
    }

    public XSSPatternItem setMultiline(boolean multiline) {
        putValue(XSSPatternItem.multiline, multiline);
        return this;
    }

    public boolean isDotall() {
        return getBoolean(dotall, false);
    }

    public XSSPatternItem setDotall(boolean dotall) {
        putValue(XSSPatternItem.dotall, dotall);
        return this;
    }

}
