package com.xiaoguo.jc.op.util;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.util.LocalizedTextUtil;
import org.apache.commons.lang3.StringUtils;

import java.util.Locale;

/**
 * 在XML校验配置文件输出国际化占位符信息
 * 
 * @author
 * 
 */
public class ResourceUtil {
    private static final Locale LOCALE = ActionContext.getContext().getLocale();

    public static String getValue(String key, Object... values) {
        String result = null;
        if (StringUtils.isNotBlank(key)) {
            // 获取资源文件中的字符串对象，并传入参数，后边的Object数组对象表示要插入到占位符上的具体的对象
            result = LocalizedTextUtil.findDefaultText(key, LOCALE, values);
        }
        return result;
    }
}