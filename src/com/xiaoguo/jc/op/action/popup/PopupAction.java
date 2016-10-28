package com.xiaoguo.jc.op.action.popup;

import org.springframework.beans.factory.annotation.Autowired;

import com.xiaoguo.jc.common.model.rabbit.RabbitDto;
import com.xiaoguo.jc.common.model.system.operator.OperatorDto;
import com.xiaoguo.jc.common.service.system.operator.OperatorService;
import com.xiaoguo.jc.op.action.BaseAction;

/**
 * 专用于弹出窗口action
 * 
 * @author hjzeng-2015
 * 
 */
public class PopupAction extends BaseAction {
    private static final long serialVersionUID = 5315558488133085689L;

    /** The operator service. */
    @Autowired
    private OperatorService operatorService;

    private RabbitDto rabbit;

    /** The operator. */
    private OperatorDto operator;

    public String toOperatorPopup() throws Exception {
        if (operator == null) {
            operator = new OperatorDto();
        }
        operator.setPage(this.getPage());
        operator.setOperatortype(this.getOperator(request).getOperatortype());
        dataList = operatorService.queryOperatorListByPage(operator);
        return "operatorPopup";
    }

    public String mapCoordinate() {
        if (null != rabbit) {
            rabbit.setX(rabbit.getX());
            rabbit.setY(rabbit.getY());
        }
        return "mapCoordinate";
    }

    public RabbitDto getRabbit() {
        return rabbit;
    }

    public void setRabbit(RabbitDto rabbit) {
        this.rabbit = rabbit;
    }
}
