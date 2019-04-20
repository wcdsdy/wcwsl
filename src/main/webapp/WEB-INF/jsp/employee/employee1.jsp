<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=contextPath%>/layui/css/layui.css" media="all">
    <script type="text/javascript" src="<%=contextPath%>/static/jquery-2.1.3.min.js"></script>
</head>
<body>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend style="text-align: center">员工列表界面</legend>
</fieldset>
<div style="padding: 20px; background-color: #F2F2F2;">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">员工信息列表</div>
                <form action="" method="post">
                    <table id="demo" lay-filter="test"></table>
                </form>
            </div>
        </div>
    </div>
</div>

<%--隐藏编辑弹窗表单--%>
<div class="layui-row" id="popUpdateEmp" style="display:none;">
    <div class="layui-col-md10">
        <form class="layui-form layui-from-pane" action="" style="margin-top:20px">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">姓名</label>
                    <div class="layui-input-inline">
                        <input id="name" readonly="readonly" type="text" name="name" lay-verify="required" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">手机号</label>
                    <div class="layui-input-inline">
                        <input type="tel" id="phone" name="phone" lay-verify="required|phone" autocomplete="off"
                               placeholder="请输入手机号"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-inline">
                        <input type="text" id="email" name="email" lay-verify="email" autocomplete="off"
                               placeholder="请输入邮箱"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">学历</label>
                    <div class="layui-input-inline">
                        <input type="text" id="eduschool" name="eduschool" lay-verify="required" autocomplete="off"
                               placeholder="请输入学历"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">身份证</label>
                    <div class="layui-input-inline">
                        <input type="text" id="idcard" name="idcard" lay-verify="required" autocomplete="off"
                               placeholder="请输入身份证"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">联系地址</label>
                    <div class="layui-input-block">
                        <input type="text" id="address" name="address" lay-verify="required" autocomplete="off"
                               placeholder="请输入联系地址" class="layui-input">
                    </div>
                </div>
            </div>
            <button class="layui-btn" lay-submit lay-filter="updateFormBtn"
                    style="margin-left: 120px">立即修改
            </button>
        </form>
    </div>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit" lay-event="edit">修改</a>
</script>
<script src="<%=contextPath%>/layui/layui.js"></script>
<script>
    layui.use(['table', 'form'], function () {
        var table = layui.table;
        var form = layui.form;
        //第一个实例
        table.render({
            elem: '#demo'
            , height: 160
            , url: '<%=contextPath%>/employee/showemp' //数据接口
            , cols: [[ //表头
                 {field: 'name', title: '姓名', width: 90}
                , {field: 'sex', title: '性别', width: 60}
                , {field: 'phone', title: '手机号', width: 120}
                , {field: 'email', title: '邮箱', width: 140}
                , {field: 'positionId', templet: '<div>{{d.positionId.positionname}}</div>', title: '职位', width: 150}
                , {field: 'eduschool', title: '学历', width: 70}
                , {field: 'idcard', title: '身份证', width: 180}
                , {field: 'deptId', templet: '<div>{{d.deptId.deptname}}</div>', title: '部门', width: 80}
                , {field: 'address', title: '坐标地址', width: 150}
                , {field: 'createtime', title: '建档日期', width: 180}
                , {
                    fixed: 'right', title: '操作', toolbar: '#barDemo', width: 120
                }
            ]]
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            if (obj.event == 'edit') {
                layer.open({
                    type: 1,
                    title: "更新用户",
                    area: ['480px', '510px'],
                    content: $("#popUpdateEmp"),
                    success: function () {
                        //回显数据
                        $("#name").val(data.name);
                        $("#phone").val(data.phone);
                        $("#email").val(data.email);
                        $("#eduschool").val(data.eduschool);
                        $("#idcard").val(data.idcard);
                        $("#address").val(data.address);
                    },
                });
            }
        });
        //更新操作
        form.on('submit(updateFormBtn)', function (data) {
            //发送ajax请求
            $.ajax({
                url: '<%=contextPath%>/employee/empUpdate1',
                data: JSON.stringify(data.field),
                type: 'POST',
                contentType: 'application/json',  //数据类型格式
                success: function (result) {
                    if (result == "success") {
                        layer.closeAll();
                        layer.msg('更新成功', {time: 1 * 1000}, function () {
                            location.reload();
                        });
                    } else {
                        layer.closeAll();
                        layer.msg('更新失败', {time: 1 * 1000}, function () {
                            location.reload();
                        });
                    }
                },
                error: function (errorMsg) {
                    alert("数据异常！" + errorMsg);
                    location.reload();
                },
            });
            return false;
        });
    });
</script>
</body>
</html>