package com.xiaoguo.jc.op.filter;


import com.xiaoguo.jc.common.web.right.RightHandler;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 权限过滤器.
 */
public class UrlCheckFilter implements Filter {

    /** 重定向URL(一般是无操作权限提示页面). */
    private String redirectUrl;

    /** 不需要检查的链接. */
    private String[] unchecked;

    /** 前缀通配符. **/
    private final String prefixSymbol = "*_";

    /**
     * 初始化过滤器.
     * 
     * @param filterConfig
     *            the filter config
     * @throws ServletException
     *             the servlet exception
     * @version
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        redirectUrl = filterConfig.getInitParameter("redirectUrl");
        unchecked = filterConfig.getInitParameter("unchecked").split(",");
    }

    /**
     * 注销过滤器.
     * 
     * @version
     */
    @Override
    public void destroy() {
    }

    /**
     * 过滤器处理.
     * 
     * @param request
     *            the request
     * @param response
     *            the response
     * @param chain
     *            the chain
     * @throws IOException
     *             Signals that an I/O exception has occurred.
     * @throws ServletException
     *             the servlet exception
     * @version
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
            ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (isUnChecked(req) || isHavePriv(req)) { // 当不需要检查 或者 有权限时,直接到下一个过滤器
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + redirectUrl);
        }
    }

    /**
     * 检查操作是否有权限.
     * 
     * @param request
     *            http请求
     * @return 当有权限时返回true,否则返回false
     * @throws ServletException
     *             the servlet exception
     */
    private boolean isHavePriv(HttpServletRequest request) throws ServletException {
        try {
            String url = request.getRequestURI().substring(request.getContextPath().length() + 1);
            return RightHandler.getInstance().isPrivilege(request, url);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    /**
     * 判断是否需要检查
     * 
     * @param request
     *            the request
     * @return 当不需要检查时返回true,否则返回false
     */
    private boolean isUnChecked(HttpServletRequest request) {
        String contextPath = request.getContextPath();
        String uri = request.getRequestURI();

        if (uri.length() - 1 <= contextPath.length()) {
            return true;
        }
        if (uri.startsWith(contextPath + redirectUrl)) { // 重定向URL不要检查
            return true;
        }

        String temp = null;
        for (int i = 0; i < unchecked.length; i++) {
            temp = unchecked[i].trim();
            if (temp.indexOf(prefixSymbol) != -1) {// 若uncheck以前缀通配符开头
                // 正则表达式判断,可以匹配类似: /ami_op/通配符*.action
                String regex = "(\\w|\\/)*" + temp.replace(prefixSymbol, "") + "\\w*" + RightHandler.ACTION_SYMBOL;
                if (uri.matches(regex)) {
                    return true;
                }
            } else { // 无前缀通配符,则按前配置判断
                if (uri.startsWith(contextPath + temp)) {
                    return true;
                }
            }
        }

        return false;
    }
}
