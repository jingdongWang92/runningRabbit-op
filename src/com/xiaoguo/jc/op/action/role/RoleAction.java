package com.xiaoguo.jc.op.action.role;

import baseproj.common.exception.BaseServiceException;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.enums.OperateLogEnum;
import com.xiaoguo.jc.common.model.system.role.RoleDto;
import com.xiaoguo.jc.common.service.system.role.RoleService;
import com.xiaoguo.jc.common.service.system.role.impl.RoleServiceException;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;

/**
 * 角色管理处理
 * 
 * @author hjzeng-2015
 * 
 */
public class RoleAction extends BaseAction {
    private static final long serialVersionUID = -8053822226311527188L;

    @Autowired
    private RoleService roleService;

    private RoleDto role;

    public String toList() throws Exception {
        if (role == null) {
            role = new RoleDto();
        }
        role.setPage(this.getPage());
        role.setOperatorno(this.getOperator(request).getOperatorno());
        role.setOper(this.getOperator(request));
        dataList = roleService.queryRoleByPage(role);
        return LIST;
    }

    public String toAdd() throws Exception {
        if (role == null) {
            role = new RoleDto();
        }
        // 设置当前操作员的编号，查询权限用
        role.setOperatorno(this.getOperator(request).getOperatorno());
        role.setOperatorname(this.getOperator(request).getOperatorname());
        role.setCreateRoleno(Integer.parseInt(this.getOperator(request).getRoleno()));
        // 查询当前要建的权限有哪些是可供选择的
        role = roleService.queryRoleGroup(role);
        return ADD;
    }

    public String toEdit() throws Exception {
        if (role == null) {
            role = new RoleDto();
        }
        // 查询当前角色
        role = roleService.select(role);
        role.setOperatorname(this.getOperator(request).getOperatorname());
        role.setCreateRoleno(Integer.parseInt(this.getOperator(request).getRoleno()));
        Integer roleno = role.getRoleno();
        // 查询当前角色有哪些权限和当前角色有哪些权限可供增删
        role = roleService.queryRoleGroup(role);
        role.setRoleno(roleno);
        return EDIT;
    }

    public String toDetail() throws Exception {
        if (role == null) {
            role = new RoleDto();
        }
        // 查询当前角色
        role = roleService.select(role);
        role.setOperatorname(this.getOperator(request).getOperatorname());
        role.setCreateRoleno(Integer.parseInt(this.getOperator(request).getRoleno()));
        Integer roleno = role.getRoleno();
        // 查询当前角色有哪些权限和当前角色有哪些权限可供增删
        role = roleService.queryRoleGroup(role);
        role.setRoleno(roleno);
        return DETAIL;
    }

    public void del() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            if (role == null) {
                role = new RoleDto();
            }
            role.setOperatorname(getOperator(request).getOperatorname());
            role = roleService.select(role);
            roleService.delete(role);
            des[1] = role.getRolename();
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("删除角色信息成功");
        } catch (BaseServiceException e) {
            rm.setMessage(e.getErroDesc());
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            if (null != role) {
                des[1] = role.getRolename();
            }
            rm.setMessage("删除角色信息失败");
        } finally {
            createOperatorLog(OperateLogEnum.System.OPERATOR_ROLE_DEL, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    public void add() throws Exception {
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            if (role == null) {
                role = new RoleDto();
            }
            // 检查用户名是否存在
            this.checkRoleName(role);
            // 验证是否选择权限信息
            if (role.getOpernoList() == null || role.getOpernoList().isEmpty()) {
                throw new RoleServiceException(RoleServiceException.AUTH_INFO_EMPTY);
            }
            // 设置创建人
            role.setOperatorno(getOperator(request).getOperatorno());
            role.setOperatorname(getOperator(request).getOperatorname());
            des[1] = role.getRolename();
            // 保存角色
            roleService.insert(role);
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("新增角色信息成功");
        } catch (BaseServiceException e) {
            rm.setMessage(e.getErroDesc());
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("新增角色信息失败");
        } finally {
            createOperatorLog(OperateLogEnum.System.OPERATOR_ROLE_ADD, des);
            printJson(JsonUtil.bean2json(rm));
        }
    }

    /**
     * 校验角色名称是否已存在
     * 
     * @throws Exception
     */
    private void checkRoleName(RoleDto role) throws Exception {
        if (StringUtils.isBlank(role.getRolename())) {
            throw new RoleServiceException(RoleServiceException.ROLE_NAME_EMPTY);
        }
        // 验证角色名称是否已存在
        RoleDto roleDto = roleService.findRoleByName(role);
        if (roleDto != null) {
            throw new RoleServiceException(RoleServiceException.ROLE_NAME_EXIT);
        }
    }

    public void edit() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        String[] des = new String[3];
        try {
            if (role == null) {
                role = new RoleDto();
            }
            if (role.getOpernoList() == null || role.getOpernoList().isEmpty()) {
                throw new RoleServiceException(RoleServiceException.AUTH_INFO_EMPTY);
            }
            // 设置创建人（这里是修改者）
            role.setOperatorname(getOperator(request).getOperatorname());
            des[1] = role.getRolename();
            // 修改
            roleService.update(role);
            des[2] = getText("common.log.success");
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("修改角色信息成功");
        } catch (BaseServiceException e) {
            rm.setMessage(e.getErroDesc());
        } catch (Exception e) {
            des[2] = getText("common.log.fail");
            rm.setMessage("修改角色信息失败");
        } finally {
            createOperatorLog(OperateLogEnum.System.OPERATOR_ROLE_EDIT, des);
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    public String popRolesByOperator() throws Exception {
        role = role == null ? new RoleDto() : role;
        role.setPage(this.getPage());
        role.setAccount(this.getOperator(request).getAccount());
        role.setOperatorno(this.getOperator(request).getOperatorno());
        this.dataList = roleService.queryRolesByOeratorAndByPage(role);

        return "rolePop";
    }

    public RoleDto getRole() {
        return role;
    }

    public void setRole(RoleDto role) {
        this.role = role;
    }

}
