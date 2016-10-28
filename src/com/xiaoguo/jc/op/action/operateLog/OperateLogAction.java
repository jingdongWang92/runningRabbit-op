package com.xiaoguo.jc.op.action.operateLog;

import com.xiaoguo.jc.common.model.system.operatelog.OperateLogDto;
import com.xiaoguo.jc.common.service.system.operatelog.OperateLogService;
import com.xiaoguo.jc.op.action.BaseAction;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 日志管理处理
 * 
 * @author hjzeng-2015
 * 
 */
public class OperateLogAction extends BaseAction {
    private static final long serialVersionUID = -3798972954947863312L;

    /** The operatelog. */
    private OperateLogDto operatelog;

    /** The operatelog service. */
    @Autowired
    private OperateLogService operatelogService;

    /**
     * qurey operatelog list
     * 
     * @return the string
     * @throws Exception
     *             the exception
     * @version
     */
    public String toList() throws Exception {
        if (operatelog == null) {
            operatelog = new OperateLogDto();
        }
        operatelog.setPage(this.getPage());
        String operatetime = operatelog.getOperatetime();
        if (StringUtils.isNotBlank(operatetime)) {
            String temp[] = operatetime.split("至", 2);
            operatelog.setStarttime(temp[0]);
            operatelog.setEndtime(temp[0]);
        }

        dataList = operatelogService.queryOperateLogsByPage(operatelog);
        return LIST;
    }

    /**
     * query operatelog detail
     * 
     * @return the string
     * @throws Exception
     *             the exception
     * @version
     */
    public String toDetail() throws Exception {
        operatelog = operatelogService.queryOperateLogByNo(operatelog);
        return DETAIL;
    }

    /**
     * @return the operatelog
     */
    public OperateLogDto getOperatelog() {
        return operatelog;
    }

    /**
     * @param operatelog
     *            the operatelog to set
     */
    public void setOperatelog(OperateLogDto operatelog) {
        this.operatelog = operatelog;
    }
}
