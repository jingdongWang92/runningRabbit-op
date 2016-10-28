package com.xiaoguo.jc.op.action.operator;

import java.io.PrintWriter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.google.common.collect.Lists;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.enums.OperateLogEnum;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.model.system.role.RoleDto;
import com.xiaoguo.jc.common.service.system.operator.OperatorService;
import com.xiaoguo.jc.common.service.system.operator.impl.OperatorServiceException;
import com.xiaoguo.jc.common.service.system.role.RoleService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

import baseproj.common.exception.BaseServiceException;
import baseproj.common.mybatis.page.PageParameter;

/**
 * 操作员管理处理
 * 
 * @author hjzeng-2015
 * 
 */
public class OperatorAction extends BaseAction {
    private static final long serialVersionUID = 7556189863492229417L;

    /** The operator service. */
    @Autowired
    private OperatorService operatorService;

    /** The operator. */
    private OperatorDto operator;

    @Autowired
    private RoleService roleService;

    private final static String SUPER_ADMIN = "admin";

    public String toList() throws Exception {
        if (operator == null) {
            operator = new OperatorDto();
        }
        operator.setPage(this.getPage());
        // 设置创建者
        if (SUPER_ADMIN.equals(this.getOperator(request).getAccount())) {
            // admin操作员创建者设置为空
            operator.setCreateno(null);
        } else {
            operator.setCreateno(this.getOperator(request).getOperatorno());
        }
        operator.setOperatortype(this.getOperator(request).getOperatortype());
        dataList = operatorService.queryOperatorListByPage(operator);
        return LIST;
    }

    public String toAdd() throws Exception {
        return ADD;
    }

    public void edit() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = null == operator ? new OperatorDto() : operator;

            des[1] = operator.getAccount();
            operatorService.update(operator);

            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改操作员信息成功");
        } catch (Exception e) {
            // 跳转到公共错误页面
            des[2] = getText("common.log.fail");
            rm.setMessage("修改操作员信息失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_EDIT, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public void add() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = null == operator ? new OperatorDto() : operator;
            des[1] = operator.getAccount();
            // 设置创建者
            operator.setCreateno(this.getOperator(request).getOperatorno());
            operator.setLevelcode(this.getOperator(request).getLevelcode());

            // 驾校用户，不能选择用户类型，从当前用户继承
            if (operator.getOperatortype() == null) {
                operator.setOperatortype(this.getOperator(request).getOperatortype());
            }
            operatorService.insert(operator);
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("新增操作员信息成功");
        } catch (BaseServiceException e) {
            if (OperatorServiceException.SSO_ACCOUNT_NOTEXIT == e.getErroCode()
                    || OperatorServiceException.OPERATOR_ACCOUNT_EXIT == e.getErroCode()
                    || OperatorServiceException.ROLE_NOTEXIST == e.getErroCode()) {
                rm.setMessage(e.getErroDesc());
            }
        } catch (Exception e) {
            // 跳转到公共错误页面
            des[2] = getText("common.log.fail");
            rm.setMessage("新增操作员信息失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_ADD, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public void del() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = operator == null ? new OperatorDto() : operator;
            operator.setAccount(this.getOperator(request).getAccount());
            operator.setCreateno(this.getOperator(request).getOperatorno());

            des[1] = operator.getAccount();

            // 删除操作员
            operatorService.delete(operator);

            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("删除操作员信息成功");
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("删除操作员信息失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_DEL, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public void queryRoleByOperator() throws Exception {
        // 获取创建人
        OperatorDto operatorDto = getOperator(request);
        operator = operator == null ? new OperatorDto() : operator;
        operator.setOperatorno(operatorDto.getOperatorno());

        List<RoleDto> roleList = operatorService.queryRoleByOperator(operator);

        printJson(JsonUtil.list2json(roleList));
    }

    public String toEdit() throws Exception {
        queryOperator();
        return "edit";
    }

    public String popEdit() throws Exception {
        queryOperator();
        return "popupEdit";
    }

    private void queryOperator() throws Exception {
        if (operator == null) {
            operator = new OperatorDto();
        }
        // 设置创建者,记录业务日志用到
        operator.setCreateno(this.getOperator(request).getOperatorno());
        operator = operatorService.select(operator);
    }

    public String toDetail() throws Exception {
        queryOperator();
        return "detail";
    }

    /**
     * 跳转到重置密码
     * 
     * @return
     * @throws Exception
     */
    public String toResetPwd() throws Exception {
        if (operator == null) {
            operator = new OperatorDto();
        }
        // 设置创建者,记录业务日志用到
        operator.setCreateno(this.getOperator(request).getOperatorno());
        operator = operatorService.select(operator);
        operator.setPassword("");

        return "resetpwd";
    }

    /**
     * 重置密码
     * 
     * @throws Exception
     */
    public void resetPwd() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = null == operator ? new OperatorDto() : operator;
            // 设置创建者,记录业务日志用到
            operator.setAccount(this.getOperator(request).getAccount());
            // 查询操作员，记录操作日志
            OperatorDto oper = operatorService.select(operator);
            des[1] = oper.getAccount();
            // 修改密码
            oper.setPassword(operator.getPassword());
            operatorService.update(oper);
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改操作员密码成功");
        } catch (Exception e) {
            // 跳转到公共错误页面
            des[2] = getText("common.log.fail");
            rm.setMessage("修改操作员密码失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_EDITPWD, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public String toEditPwd() throws Exception {
        if (operator == null) {
            operator = new OperatorDto();
        }
        // 设置创建者,记录业务日志用到
        Integer operatorno = Integer.valueOf(this.getOperator(request).getOperatorno());
        operator.setOperatorno(operatorno);
        operator = operatorService.select(operator);
        operator.setPassword("");

        return "editpwd";
    }

    public void editPwd() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = null == operator ? new OperatorDto() : operator;

            Integer operatorno = Integer.valueOf(this.getOperator(request).getOperatorno());
            operator.setOperatorno(operatorno);
            // 查询操作员，记录操作日志
            OperatorDto oper = operatorService.select(operator);

            // 设置创建者,记录业务日志用到
            operator.setAccount(this.getOperator(request).getAccount());
            des[1] = oper.getAccount();
            // 修改密码
            oper.setPassword(operator.getPassword());
            operatorService.update(oper);
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改操作员密码成功");
        } catch (Exception e) {
            // 跳转到公共错误页面
            des[2] = getText("common.log.fail");
            rm.setMessage("修改操作员密码失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_EDITPWD, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public String popArea() throws Exception {
        return "popArea";
    }

    /**
     * 校验帐号是否已存在
     * 
     * @throws Exception
     */
    public void checkName() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            // 验证帐号是否已存在
            operatorService.checkOperatorAccount(operator);
            rm.setMessage("登录帐号可用");
            rm.setStatus(ResultMessage.SUCCESS);
        } catch (Exception e) {
            rm.setStatus(ResultMessage.FAIL);
            rm.setMessage("登录帐号已被占用");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }

    }

    /**
     * 修改教练状态信息
     * 
     * @throws Exception
     */
    public void changeStatus() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            operator = null == operator ? new OperatorDto() : operator;

            des[1] = String.valueOf(operator.getStatus());

            operatorService.changeStatus(operator);

            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改操作员信息成功");
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("修改操作员信息失败");
        } finally {
            super.createOperatorLog(OperateLogEnum.System.OPERATOR_OPERATOR_EDITSTATUS, des);
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 加载角色列表
     * 
     * @throws Exception
     */
    public void loadRoleList() throws Exception {
        List<RoleDto> roleList = Lists.newArrayList();
        try {
            RoleDto role = new RoleDto();
            role.setPage(new PageParameter(1, Integer.MAX_VALUE));
            roleList = roleService.queryRoleByPage(role);
        } catch (Exception e) {
            log.error("load role list fail", e);
        } finally {
            super.setJsonFormat();
            printJson(JsonUtil.list2json(roleList));
        }

    }

    public OperatorDto getOperator() {
        return operator;
    }

    public void setOperator(OperatorDto operator) {
        this.operator = operator;
    }
}
