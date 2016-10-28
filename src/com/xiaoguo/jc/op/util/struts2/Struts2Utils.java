package com.xiaoguo.jc.op.util.struts2;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;

public class Struts2Utils {
    private static final Logger logger = LoggerFactory.getLogger(Struts2Utils.class);

    // header 常量定义
    private static final String ENCODING_PREFIX = "encoding:";
    private static final String NOCACHE_PREFIX = "no-cache:";
    private static final String ENCODING_DEFAULT = "UTF-8";
    private static final boolean NOCACHE_DEFAULT = true;
    public static final String savePath = "upload";

    private Struts2Utils() {
    }

    /**
     * 取得HttpSession的简化方法.
     */
    public static ServletContext getServletContext() {
        return ServletActionContext.getServletContext();
    }

    /**
     * 取得HttpSession的简化方法.
     */
    public static HttpSession getSession() {
        return ServletActionContext.getRequest().getSession();
    }

    /**
     * 取得HttpRequest的简化方法.
     */
    public static HttpServletRequest getRequest() {
        return ServletActionContext.getRequest();
    }

    /**
     * 取得HttpResponse的简化方法.
     */
    public static HttpServletResponse getResponse() {
        return ServletActionContext.getResponse();
    }

    /**
     * 直接输出内容的简便函数.
     * 
     * eg. render("text/plain", "hello", "encoding:UTF-8"); render("text/plain",
     * "hello", "no-cache:false"); render("text/plain", "hello",
     * "encoding:UTF-8", "no-cache:false");
     * 
     * @param headers
     *            可变的header数组，目前接受的值为"encoding:"或"no-cache:",不设置时默认值分别为UTF-8
     *            和true .
     */
    public static void render(final String contentType, final String content, final String... headers) {
        try {
            // 分析headers参数
            String encoding = ENCODING_DEFAULT;
            boolean noCache = NOCACHE_DEFAULT;
            for (String header : headers) {
                String headerName = StringUtils.substringBefore(header, ":");
                String headerValue = StringUtils.substringAfter(header, ":");

                if (StringUtils.equalsIgnoreCase(headerName, ENCODING_PREFIX)) {
                    encoding = headerValue;
                } else if (StringUtils.equalsIgnoreCase(headerName, NOCACHE_PREFIX)) {
                    noCache = Boolean.parseBoolean(headerValue);
                } else
                    throw new IllegalArgumentException(headerName + "不是一个合法的header类型");
            }

            HttpServletResponse response = ServletActionContext.getResponse();

            // 设置headers参数
            String fullContentType = contentType + ";charset=" + encoding;
            ((org.slf4j.Logger) logger).debug("fullContentType:{}", fullContentType);
            response.setContentType(fullContentType);

            if (noCache) {
                response.setHeader("Pragma", "No-cache");
                response.setHeader("Cache-Control", "no-cache");
                response.setDateHeader("Expires", 0);
            }

            response.getWriter().write(content);

        } catch (IOException e) {
            ((org.slf4j.Logger) logger).error(e.getMessage(), e);
        }
    }

    /**
     * 直接输出文本.
     *
     * @see #render(String, String, String...)
     */
    public static void renderText(final String text, final String... headers) {
        render("text/plain", text, headers);
    }

    /**
     * 直接输出HTML.
     *
     * @see #render(String, String, String...)
     */
    public static void renderHtml(final String html, final String... headers) {
        render("text/html", html, headers);
    }

    /**
     * 直接输出XML.
     *
     * @see #render(String, String, String...)
     */
    public static void renderXml(final String xml, final String... headers) {
        render("text/xml", xml, headers);
    }

    /**
     * 直接输出JSON.
     *
     * @param string
     *            json字符串.
     * @see #render(String, String, String...)
     */
    public static void renderJson(final String string, final String... headers) {
        render("application/json", string, headers);
    }

    /**
     * 直接输出图片
     *
     * @param bytes
     */
    public static void renderImage(byte[] bytes) {
        OutputStream out;
        try {
            out = getResponse().getOutputStream();
            out.write(bytes);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            ((org.slf4j.Logger) logger).error(e.getMessage());
        }
    }

    @Deprecated
    public static String generateFilePathName(String fileName) {
        return getUploadPath() + generateFileName(fileName);
    }

    public static String getFilePathName(String fileName) {
        return getUploadPath() + "/" + fileName;
    }

    public static void delete(String fileName) {
        File file = new File(getFilePathName(fileName));
        file.delete();
    }

    public static String getUploadPath() {
        return getServletContext().getRealPath(savePath);
    }

    public static String generateFileName(String fileName) {
        DateFormat dirf = new SimpleDateFormat("yyyyMMdd");
        String formatDir = dirf.format(new Date());

        DateFormat format = new SimpleDateFormat("yyMMddHHmmss");
        String formatDate = format.format(new Date());

        int random = new Random().nextInt(10000);

        int position = fileName.lastIndexOf(".");
        String extension = fileName.substring(position);

        return formatDir + "/" + formatDate + random + extension;
    }

    public static Map<String, Object> buildPropertyFilters(String filterPrefix) {

        HttpServletRequest request = getRequest();

        // 从request中获取含属性前缀名的参数,构造去除前缀名后的参数Map.
        Map<String, Object> filterParamMap = WebUtils.getParametersStartingWith(request, filterPrefix);

        StringBuffer wherehql = new StringBuffer();
        Map<String, Object> result = new LinkedHashMap<String, Object>();

        // 分析参数Map,构造PropertyFilter列表
        for (Object filterName : filterParamMap.keySet()) {
            Object value = filterParamMap.get(filterName);

            // 如果value值为空,则忽略此filter.
            boolean omit = StringUtils.isBlank((String) value);
            if (!omit) {

                // 分析filterName,获取matchType与propertyName
                String matchTypeCode = StringUtils.substringBefore((String) filterName, "_");

                if ("eq like".contains(matchTypeCode)) {
                    throw new IllegalArgumentException("filter名称没有按规则编写,无法得到属性比较类型." + matchTypeCode);
                }

                if (matchTypeCode.equalsIgnoreCase("eq")) {
                    matchTypeCode = " = ";
                }
                if (matchTypeCode.equalsIgnoreCase("like")) {
                    matchTypeCode = " like ";
                    value = value + "%";
                }

                String propertyName = StringUtils.substringAfter((String) filterName, "_");

                if (wherehql.length() > 0) {
                    wherehql.append(" and ");
                }

                if (propertyName.contains("|")) {
                    String[] split = StringUtils.split(propertyName, "|");
                    wherehql.append("(");
                    for (String string : split) {

                        wherehql.append(" obj.").append(string).append(matchTypeCode).append(" ").append(" ? ")
                                .append(" or ");

                        result.put(string + '1', value);

                    }
                    wherehql.delete(wherehql.length() - 3, wherehql.length());
                    wherehql.append(")");
                } else {
                    wherehql.append(" obj.").append(propertyName).append(matchTypeCode).append(" ").append(" ? ")
                            .append(" ");

                    result.put(propertyName, value);
                }
            }
        }
        if (result.size() > 0) {
            result.put("hql", new StringBuffer(" where ").append(wherehql));
        }
        return result;

    }
}
