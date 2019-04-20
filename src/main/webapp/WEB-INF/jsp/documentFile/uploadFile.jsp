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
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
    <legend>文件上传</legend>
</fieldset>

    <div style="padding: 20px; background-color: #F2F2F2;">
        <div class="layui-row layui-col-space15">
            <div class="layui-inline">
                <label class="layui-form-label">上传文件：</label>
                <div class="layui-input-inline">
                    <button type="button" class="layui-btn" id="test3"><i class="layui-icon"></i>上传文件</button>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">文件描述</label>
                <div class="layui-input-inline">
                    <input type="text" name="filemsg" id="filemsg" lay-verify="required" autocomplete="off" placeholder="请输入文件描述"
                           class="layui-input">
                </div>
            </div>
            <button class="layui-btn"
                    style="margin-left: 120px" id="test4">立即添加
            </button>
        </div>
    </div>


<script src="<%=contextPath%>/layui/layui.js"></script>
<script>
    layui.use(['upload', 'form'], function () {
        var $ = layui.jquery;
        var form = layui.form;
        var upload = layui.upload;
        var uploadInst = upload.render({
            elem: '#test3'
            , url: '<%=contextPath%>/download/fileSave' //后台上传地址
            ,data :{
                filemsg : function(){
                    return $('#filemsg').val();
                }
            }
            , accept: 'file' //普通文件
            , auto: false
            ,bindAction : '#test4'
            ,field : 'mf' //文件上传对应表单name属性值
            , done: function (res) {
                if(res.code > 0){
                    return layer.msg('上传失败');
                }
               layer.msg('上传成功');
            }
        });

    });

</script>
</body>
</html>
