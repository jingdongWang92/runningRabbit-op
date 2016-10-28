package com.xiaoguo.jc.op.action.ttg;

import java.io.PrintWriter;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.constants.CommonConstants;
import com.xiaoguo.jc.common.dto.base.ResultMessage;
import com.xiaoguo.jc.common.dto.request.merchant.GetCouponDetailReqDto;
import com.xiaoguo.jc.common.dto.request.merchant.WriteOffReqDto;
import com.xiaoguo.jc.common.dto.response.BaseRespDto;
import com.xiaoguo.jc.common.dto.response.merchant.GetCouponDetailRespDto;
import com.xiaoguo.jc.common.enums.CommonEnum;
import com.xiaoguo.jc.common.model.coupon.UserCouponInfoDto;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.coupon.UserCouponInfoService;
import com.xiaoguo.jc.common.service.exception.JcServiceException;
import com.xiaoguo.jc.common.service.merchant.MerchantService;
import com.xiaoguo.jc.common.service.system.operator.OperatorService;
import com.xiaoguo.jc.op.action.BaseAction;
import com.xiaoguo.yo.common.util.crypto.Des;
import com.xiaoguo.yo.common.util.json.JsonUtil;

/**
 * 奖券核销控制器 yjc
 */
public class UseCouponAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 8003036628189138901L;

    @Autowired
    private MerchantService merchantService;
    @Autowired
    private UserCouponInfoService service;
    @Autowired
    private OperatorService operatorService;

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
        this.dataList = service.queryWriteOffByPage(dto);
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
     * 进入查询页面
     * 
     * @return
     * @throws Exception
     */
    public String toConfirm() throws Exception {
        if (null == dto) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象为null,操作非法！");
        }
        OperatorDto operator = super.getOperator(request);
        dto.setOperatorno(operator.getOperatorno());
        dto.setOperatorName(operator.getOperatorname());

        GetCouponDetailReqDto req = new GetCouponDetailReqDto();
        req.setAccount(Des.encryptDES(operator.getAccount(), CommonConstants.DES_KEY));
        req.setPassword(Des.encryptDES(operator.getPassword(), CommonConstants.DES_KEY));
        req.setCode(dto.getCode());
        GetCouponDetailRespDto resp = merchantService.getCouponDetail(req);
        if (null == resp) {
            throw new JcServiceException(JcServiceException.ERROR_00001, "对象不存在！");
        }
        if (!CommonEnum.RespCode.SUCCESS.getCode().equals(resp.getRespCode())) {
            throw new JcServiceException(JcServiceException.ERROR_00001, resp.getRespMsg());
        }
        dto.setId(resp.getCouponId());
        dto.setPic(resp.getImgurl());
        dto.setName(resp.getCname());
        dto.setTitle(resp.getTitle());
        dto.setIntegral(resp.getIntegral());
        dto.setRemarks(resp.getRemarks());
        dto.setStartDate(resp.getStartTime());
        dto.setEndDate(resp.getEndTime());
        dto.setOperatorPic(resp.getShopimgurl());
        dto.setType(resp.getType());
        dto.setCode(resp.getCode());
        dto.setActName(resp.getActName());
        dto.setAddress(resp.getAddress());
        dto.setMobile(resp.getMobile());
        return "confirm";
    }

    /**
     * 新增页面
     * 
     * @return
     * @throws Exception
     */
    public String toAdd() throws Exception {
        dto = new UserCouponInfoDto();
        OperatorDto operator = super.getOperator(request);
        dto.setOperatorName(operator.getOperatorname());
        dto.setOperatorno(operator.getOperatorno());
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
            OperatorDto operator = null;
            if (null == dto.getOperatorno()) {
                operator = super.getOperator(request);
                dto.setOperatorno(operator.getOperatorno());
            } else {
                operator = new OperatorDto();
                operator.setOperatorno(dto.getOperatorno());
                operator = operatorService.select(operator);
                if (null == operator) {
                    throw new JcServiceException(JcServiceException.ERROR_00001, "商家不存在！");
                }
            }

            WriteOffReqDto req = new WriteOffReqDto();
            req.setAccount(Des.encryptDES(operator.getAccount(), CommonConstants.DES_KEY));
            req.setPassword(Des.encryptDES(operator.getPassword(), CommonConstants.DES_KEY));
            req.setCode(dto.getCode());
            BaseRespDto resp = merchantService.writeOff(req);
            if (null != resp && CommonEnum.RespCode.SUCCESS.getCode().equals(resp.getRespCode())) {
                rm.setStatus(ResultMessage.SUCCESS);
                rm.setMessage("核销成功");
            } else {
                rm.setStatus(ResultMessage.FAIL);
                rm.setMessage("核销失败！" + resp.getRespMsg());
            }
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
