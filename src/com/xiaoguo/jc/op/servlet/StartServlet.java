package com.xiaoguo.jc.op.servlet;

import baseproj.common.util.LoggerUtil;
import baseproj.common.web.taglib.IsmTag;
import baseproj.inter.I18NHandler;
import com.xiaoguo.jc.common.utils.GetWebConfig;
import com.xiaoguo.jc.common.web.right.RightHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * 启动初始化系统参数
 * 
 * @author Administrator
 * 
 */
public class StartServlet extends HttpServlet {
    private static final long serialVersionUID = 8116219822239884792L;

    protected static final Logger logger = LoggerFactory.getLogger(StartServlet.class);

    private String version = "1.01.01";
    private String resourcetype = "zh";
    private String webType = "op";

    /**
     * 系统初始化
     * 
     * 
     * @return
     * @throws
     */
    @Override
    public void init() throws ServletException {
        try {
            // 初始化配置信息
            GetWebConfig.init();

            // 获取门户版本信息
            version = GetWebConfig.getValue("version");
            // 读取国际化资源文件
            resourcetype = GetWebConfig.getValue("resourcetype");
            I18NHandler.initial("GlobalResource", webType, resourcetype);

            // 给权限标签设置处理器
            IsmTag.setRightHander(RightHandler.getInstance());

            // 将启动的日志记录到tomcat/logs/version.txt中
            LoggerUtil.writeStartLog("jc op start success! Version: " + version + "\n");

            logger.info("\n********* jc-op initialize all config successful! *********");
        } catch (Exception ex) {
            LoggerUtil.writeStartLog("jc op start failed! Version: " + version + "\n");
            logger.error("\n********* jc-op initialize fail! *********", ex);
            throw new ServletException(ex);
        }
    }

    /**
     * Destroy.
     * 
     * @version
     */
    @Override
    public void destroy() {
    }
}
