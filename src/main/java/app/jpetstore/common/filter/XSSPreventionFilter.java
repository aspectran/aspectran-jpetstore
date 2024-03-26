package app.jpetstore.common.filter;

import com.aspectran.core.activity.Translet;
import com.aspectran.core.adapter.RequestAdapter;
import com.aspectran.core.component.bean.annotation.AvoidAdvice;
import com.aspectran.utils.apon.ArrayParameters;
import org.owasp.esapi.Encoder;
import org.owasp.esapi.reference.DefaultEncoder;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

/**
 * A Filter to prevent Cross-site Scripting (XSS).
 * This filter escapes all parameters and headers of a HttpServletRequest.
 */
@AvoidAdvice
public class XSSPreventionFilter {

    private boolean canonicalize;

    private boolean allowMultipleEncoding;

    private boolean allowMixedEncoding;

    private Encoder esapiEncoder;

    private Pattern[] patterns;

    /**
     * It is recommended to canonicalize using the ESAPI library to avoid encoded attacks.
     *
     * @param canonicalize true if enabling canonicalization of the input using the
     *                     ESAPI library, false otherwise
     */
    public void setCanonicalize(boolean canonicalize) {
        this.canonicalize = canonicalize;
        if (canonicalize) {
            // possible codecs: CSSCodec, HTMLEntityCodec, JavaScriptCodec, MySQLCodec,
            //                  OracleCodec, PercentCodec, UnixCodec, VBScriptCodec, WindowsCodec
            List<String> codecList = Arrays.asList("HTMLEntityCodec", "PercentCodec", "JavaScriptCodec");
            this.esapiEncoder = new DefaultEncoder(codecList);
        } else {
            this.esapiEncoder = null;
        }
    }

    public void setAllowMultipleEncoding(boolean allowMultipleEncoding) {
        this.allowMultipleEncoding = allowMultipleEncoding;
    }

    public void setAllowMixedEncoding(boolean allowMixedEncoding) {
        this.allowMixedEncoding = allowMixedEncoding;
    }

    public void setPatterns(String patterns) {
        if (patterns == null) {
            throw new IllegalArgumentException("patterns must not be null");
        }
        ArrayParameters xssPatternParameters;
        try {
            xssPatternParameters = new ArrayParameters(XSSPatternItem.class, patterns);
        } catch (IOException e) {
            throw new IllegalArgumentException("Patterns parameter can not be parsed", e);
        }
        setXSSPatternParameters(xssPatternParameters);
    }

    public void setXSSPatternParameters(ArrayParameters xssPatternParameters) {
        if (xssPatternParameters == null) {
            throw new IllegalArgumentException("xssPatternParameters must not be null");
        }
        List<Pattern> patterns = null;
        List<XSSPatternItem> list = xssPatternParameters.getParametersList();
        if (list != null) {
            patterns = new ArrayList<>(list.size());
            for (XSSPatternItem item : list) {
                String patternStr = item.getPattern();
                boolean caseInsensitive = item.isCaseInsensitive();
                boolean multiline = item.isMultiline();
                boolean dotall = item.isDotall();
                int flags = 0;
                if (caseInsensitive) {
                    flags |= Pattern.CASE_INSENSITIVE;
                }
                if (multiline) {
                    flags |= Pattern.MULTILINE;
                }
                if (dotall) {
                    flags |= Pattern.DOTALL;
                }
                Pattern pattern = Pattern.compile(patternStr, flags);
                patterns.add(pattern);
            }
        }
        if (patterns != null && !patterns.isEmpty()) {
            this.patterns = patterns.toArray(new Pattern[0]);
        } else {
            this.patterns = null;
        }
    }

    public void filter(Translet translet) {
        if (translet != null && translet.getRequestAdapter() != null) {
            RequestAdapter requestAdapter = translet.getRequestAdapter();
            if (requestAdapter.hasHeaders()) {
                for (List<String> list : requestAdapter.getHeaderMap().values()) {
                    for (int i = 0; i < list.size(); i++) {
                        list.set(i, stripXSS(list.get(i)));
                    }
                }
            }
            if (requestAdapter.hasParameters()) {
                for (String[] arr : requestAdapter.getParameterMap().values()) {
                    for (int i = 0; i < arr.length; i++) {
                        arr[i] = stripXSS(arr[i]);
                    }
                }
            }
        }
    }

    private String stripXSS(String value) {
        if (value != null) {
            if (canonicalize) {
                value = esapiEncoder.canonicalize(value, allowMultipleEncoding, allowMixedEncoding);
            }

            // Avoid null characters
            value = value.replaceAll("\0", "");

            // Remove all sections that match a pattern
            if (patterns != null) {
                for (Pattern scriptPattern : patterns) {
                    value = scriptPattern.matcher(value).replaceAll("");
                }
            }
        }
        return value;
    }

}
