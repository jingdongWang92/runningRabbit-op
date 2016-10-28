package com.xiaoguo.jc.op.action.ttg;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.dto.request.merchant.WriteOffReqDto;
import com.xiaoguo.jc.common.model.coupon.UserCouponInfoDto;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.coupon.UserCouponInfoRecordService;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.json.JsonUtil;

public class CouponRecordAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private UserCouponInfoRecordService service;

    private UserCouponInfoDto dto;

    /**
     * 列表页
     * 
     * @return
     * @throws Exception
     */
    public String toList() throws Exception {
        if (dto == null) {
            dto = new UserCouponInfoDto();
        }
        OperatorDto operator = super.getOperator(request);
        if (!operator.getOperatorno().equals(1)) {
            dto.setOperatorno(operator.getOperatorno());
        }
        dto.setPage(super.getPage());
        // this.dataList = service.queryWriteOffByPage(dto);
        return LIST;
    }

    /**
     * 详情页面
     * 
     * @return
     * @throws Exception
     */
    public String toDetail() throws Exception {
        if (null == dto || null == dto.getId()) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        dto = service.select(dto);
        return DETAIL;
    }

    /**
     * 新增页面
     * 
     * @return
     * @throws Exception
     */
    public String toAdd() throws Exception {
        return ADD;
    }

    /**
     * 执行新增操作
     * 
     * @throws Exception
     */
    public void add() throws Exception {
        super.setJsonFormat();
        ResultMessage rm = new ResultMessage();
        rm.setStatus(ResultMessage.FAIL);
        try {
            if (null == dto) {
                throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
            }
            dto.setOperatorno(super.getOperator(request).getOperatorno());

            WriteOffReqDto req = new WriteOffReqDto();
            // req.setOperator(dto.getOperatorno());
            // req.setCode(dto.getCode());
            // service.writeOff(req);
            rm.setStatus(ResultMessage.SUCCESS);
            rm.setMessage("核销成功");
        } catch (JcServiceException e) {
            rm.setMessage("核销失败." + e.getErroDesc());
        } catch (Exception e) {
            rm.setMessage("核销失败.");
        } finally {
            PrintWriter pw = response.getWriter();
            pw.write(JsonUtil.bean2json(rm));
        }
    }

    public UserCouponInfoDto getDto() {
        return dto;
    }

    public void setDto(UserCouponInfoDto dto) {
        this.dto = dto;
    }
}
