/**
 * Created by wxk on 2015/9/18.
 */
$(function(){
    var submitFo = false;

    $('#simplewizardinwidget').wizard().on('finished', function (e) {
        var selectedTbodyTr = $("#selected").find("tbody > tr");
        if(selectedTbodyTr.length <= 0) {
            bootbox.alert('请先选择训练时间');
            e.preventDefault();
            return;
        }
        bootbox.confirm('确认完成教练信息的录入了吗？', function (result) {
            if (result) {
                backToList('businessBrand_toList.action');
            } else {
                e.preventDefault();
            }
        });
    }).on('change', function (e, wizard) {
        switch(wizard.step) {
            case 1: {
                if(!submitFo) {
                    e.preventDefault();
                    bootbox.alert("请先保存教练基本信息");
                }

                break;
            }
            case 2: {
                if(!uploadHead1 || !uploadHead2) {
                    bootbox.alert("请上传形象照和头像");
                    e.preventDefault();
                }

                break;
            }
        }
    }).on('stepclick', function (e) {
        e.preventDefault();
    });
    
    
    
    //校验提交操作
    $('#fo').bootstrapValidator({
        submitHandler:function(form){
            ajaxPostRequest('businessBrand_add.action', 'fo', function callback(result){
                if (result && result.status == '1') {
                    submitFo = true;
                    // 设置全局教练ID
                    $("#id").val(result.data);
                }
            });
        }
    });
});

