package com.xiaoguo.jc.op.filter;

import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.yo.common.util.json.JsonUtil;
import com.xiaoguo.yo.common.util.session.SessionUtil;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * OP门户登录检查过滤器
 */
public class LoginCheckFilter implements Filter {
    private String frontPageUrl;
    private String indexPageUrl;

    private String[] unchecked;

    @Override
    public void init(FilterConfig filterConfig) {
        frontPageUrl = filterConfig.getInitParameter("frontPage");
        indexPageUrl = filterConfig.getInitParameter("indexPage");
        unchecked = filterConfig.getInitParameter("unchecked").split(",");
    }

    @Override
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException,
            ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String contextPath = req.getContextPath();
        String url = req.getRequestURI();

        boolean redirect;
        String redirectUrl = null;

        try {
            // 如果用户访问的路径是/login.action 则过滤它，并执行其他操作
            if (isUncheck(contextPath, url)) {
                redirect = false;
            } else {
                // 如果用户访问的路径不是/login.action
                // 则从session对象里得到操作员判断是否为空，为空就跳转到登录，不为空就执行其他操作
                OperatorDto operator = null;
                HttpSession session = SessionUtil.getSession(req);
                if (session != null) {
                    operator = (OperatorDto) session.getAttribute("Operator");
                }

                if (session != null && operator != null) {
                    if (url.equals(contextPath + '/')) {
                        redirect = true;
                        redirectUrl = indexPageUrl;
                    } else {
                        // 设置当前选择菜单
                        String topId = request.getParameter("topId");
                        String parentId = request.getParameter("parentId");
                        String menuId = request.getParameter("menuId");
                        if (StringUtils.isNotBlank(topId) || StringUtils.isNotBlank(parentId)
                                || StringUtils.isNotBlank(menuId)) {
                            operator.setTopId(topId);
                            operator.setParentId(parentId);
                            operator.setMenuId(menuId);
                        } else {
                            if (url.endsWith(indexPageUrl)) {
                                operator.setTopId(null);
                                operator.setParentId(null);
                                operator.setMenuId(null);
                            }
                        }
                        redirect = false;
                    }
                } else {
                    if (req.getHeader("x-requested-with") != null
                            && req.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                        ResultMessage rm = new ResultMessage();
                        rm.setStatus(ResultMessage.LOGOUT);
                        rm.setMessage("登录过期，请重新登录");
                        res.setContentType("text/json; charset=utf-8");
                        res.setCharacterEncoding("utf-8");
                        res.getWriter().write(JsonUtil.object2json(rm));
                        return;
                    }
                    redirect = true;
                    redirectUrl = frontPageUrl;
                }
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
        if (redirect) {
            String host = "http://" + req.getHeader("Host");
            res.sendRedirect(host + req.getContextPath() + redirectUrl);
        } else {
            chain.doFilter(request, response);
        }
    }

    private boolean isUncheck(String contextPath, String url) {
        for (int i = 0; i < unchecked.length; i++) {
            String temp = unchecked[i].trim();
            if (url.startsWith(contextPath + temp)) {
                return true;
            }
        }
        return false;
    }
}
