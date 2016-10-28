package com.xiaoguo.jc.op.action.syscfg;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.enums.OperateLogEnum;
import com.xiaoguo.jc.common.model.system.config.SysCfgParamDto;
import com.xiaoguo.jc.common.service.system.config.SysCfgParamService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

/**
 * 全局配置
 * 
 * @author hjzeng-2015
 * 
 */
public class SysConfigAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private SysCfgParamService sysCfgParamService;

    private SysCfgParamDto sysCfgParam;

    /**
     * 系统参数列表
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (sysCfgParam == null) {
            sysCfgParam = new SysCfgParamDto();
        }
        sysCfgParam.setPage(super.getPage());

        this.dataList = sysCfgParamService.querySysCfgParamListByPage(sysCfgParam);
        return LIST;
    }

    /**
     * 调整到修改页面
     * 
     * @return
     * @throws Exception
     */
    public String toEdit() throws Exception {
        sysCfgParam = sysCfgParamService.findSysCfgParamById(sysCfgParam);
        return EDIT;
    }

    /**
     * 执行修改参数操作
     * 
     * @throws Exception
     */
    public void edit() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            if (sysCfgParam == null) {
                sysCfgParam = new SysCfgParamDto();
            }
            des[1] = sysCfgParam.getParamcode();

            sysCfgParamService.updateSysCfgParam(sysCfgParam);

            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改系统参数成功");
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("修改系统参数失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.SYSTEM_SYSPARAM_EDIT, des);
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 执行同步参数操作
     * 
     * @throws Exception
     */
    public void sync() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            if (sysCfgParam == null) {
                sysCfgParam = new SysCfgParamDto();
            }
            des[1] = sysCfgParam.getParamcode();

            boolean isSync = sysCfgParamService.syncSysCfgParam(sysCfgParam);

            if (isSync) {
                des[2] = getText("common.log.success");
                rm.setStatus(ResultMessage.SUCCESS);
                rm.setMessage("修改系统参数成功");
            } else {
                des[2] = getText("common.log.fail");
                rm.setStatus(ResultMessage.FAIL);
                rm.setMessage("修改系统参数失败");
            }
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("修改系统参数失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.SYSTEM_SYSPARAM_EDIT, des);
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    public SysCfgParamDto getSysCfgParam() {
        return sysCfgParam;
    }

    public void setSysCfgParam(SysCfgParamDto sysCfgParam) {
        this.sysCfgParam = sysCfgParam;
    }
}
