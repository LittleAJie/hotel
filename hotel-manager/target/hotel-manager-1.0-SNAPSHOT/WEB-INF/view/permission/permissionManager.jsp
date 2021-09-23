<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!-- 获取CSRF Token -->
    <meta name="_csrf" content="${_csrf.token}"/>
    <!-- 获取CSRF头，默认为X-CSRF-TOKEN -->
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.5.5/css/layui.css"   media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/layuimini.css?v=2.0.4.2" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/themes/default.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">

    <%-- 引入dtree.css --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree.css">
    <%-- 引入dtreefont.css --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui_ext/dtree/font/dtreefont.css">

</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row">
            <%-- 左侧菜单树 --%>
            <div class="layui-col-md2">
                <!-- 树节点容器开始 -->
                <ul id="menuTree" class="dtree" data-id="0" style="width: 240px;"></ul>
                <!-- 树节点容器结束 -->
            </div>

            <%-- 右侧数据表格 --%>
            <div class="layui-col-md10">

                <%-- 表格工具栏 --%>
                <script type="text/html" id="toolbarDemo">
                    <div class="layui-btn-container">
                        <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加 </button>
                    </div>
                </script>

                <%-- 数据表格 --%>
                <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

                <%-- 行工具栏 --%>
                <script type="text/html" id="currentTableBar">
                    <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
                    <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-close"></i>删除</a>
                </script>

                <%-- 添加和修改窗口 --%>
                <div style="display: none;padding: 5px" id="addOrUpdateWindow">
                    <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                        <%-- 菜单编号 --%>
                        <input type="hidden" name="id">
                        <div class="layui-form-item">
                            <label class="layui-form-label">父级菜单</label>
                            <div class="layui-input-block">
                                <%-- 父菜单编号 --%>
                                <input type="hidden" name="pid" id="pid">
                                <ul id="menuSelectTree" class="dtree" data-id="0"></ul>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单名称</label>
                            <div class="layui-input-block">
                                <input type="text" name="title" lay-verify="required" autocomplete="off" placeholder="请输入菜单名称" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单地址</label>
                            <div class="layui-input-block">
                                <input type="text" name="href"  autocomplete="off" placeholder="请输入菜单地址" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">菜单图标</label>
                            <div class="layui-input-block">
                                <%-- 隐藏域，保存选中的图标名称 --%>
                                <input type="hidden" name="icon" id="icon">
                                <input type="text" name="iconFa" id="iconPicker" lay-filter="iconPicker" autocomplete="off" placeholder="请输入菜单图标" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">是否展开</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="spread" value="1" title="是">
                                    <input type="radio" name="spread" value="0" title="否" checked>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label">菜单类型</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="type" value="menu" title="菜单" checked lay-filter="checkPermission">
                                    <input type="radio" name="type" value="permission" title="权限" lay-filter="checkPermission">
                                </div>
                            </div>
                        </div>
                        <div class="layui-form-item" style="display: none" id="permissionCodeDiv">
                            <label class="layui-form-label">权限编码</label>
                            <div class="layui-input-block">
                                <input type="text" name="permissionCode"  autocomplete="off" placeholder="请输入权限编码" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item layui-row layui-col-xs12">
                            <div class="layui-input-block" style="text-align: center;">
                                <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span class="layui-icon layui-icon-add-1"></span>提交</button>
                                <button type="reset" class="layui-btn layui-btn-warm"><span class="layui-icon layui-icon-refresh-1"></span>清空</button>
                                <button type="button" class="layui-btn layui-btn-danger" id="resetMenu"><span class="layui-icon layui-icon-return"></span>重置菜单</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>

<%-- 导入layui的js文件--%>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>

<script>
    layui.extend({
        dtree:"${pageContext.request.contextPath}/statics/layui_ext/dtree/dtree",
        iconPickerFa:"${pageContext.request.contextPath}/statics/layui/js/lay-module/iconPicker/iconPickerFa"
    }).use(["layer","table","form","jquery","dtree","iconPickerFa"],function () {
        var layer = layui.layer;
        var table = layui.table;
        var form = layui.form;
        var $ = layui.jquery;
        var dtree = layui.dtree;
        var iconPickerFa = layui.iconPickerFa;


        //获取<meta>标签中封装的CSRF Token
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        //将头中的CSRF Token信息进行发送
        $(document).ajaxSend(function (e,xhr,options) {
            xhr.setRequestHeader(header,token);
        });

        //渲染树形组件
        var menuTree = dtree.render({
            elem: "#menuTree",
            url: "/admin/permission/loadMenuTree",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
        });

        //树形菜单点击事件
        dtree.on("node('menuTree')" ,function(obj){
           tableIns.reload({
               where:{"id":obj.param.nodeId},//其中nodeId是当前选中节点的id值
           });
        });

        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/permission/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 120, title: "菜单编号",align: 'center'},
                {field: 'title', width: 150, title: '菜单名称',align: 'center'},
                {field: 'type', width: 120, title: "菜单类型",align: 'center'},
                //{field: 'permissionCode', minWidth: 120, title: '权限编码',align: 'center'},
                {field: 'href', minWidth: 160, title: '菜单地址',align: 'center'},
                {field: 'icon', width: 100, title: "菜单图标",align: 'center',templet:function (d) {
                        return "<i class='"+d.icon+"'></i>";
                    }},
                {field: 'spread', width: 100, title: '是否展开',align: 'center',templet:function (d) {
                        return d.spread == 1 ? "<font color='blue'>是</font>" :"<font color='red'>否</font>";
                    }},
                {title: '操作', minWidth: 120, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
        });


        //监听表格头部工具栏事件
        table.on("toolbar(currentTableFilter)",function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddWindow();
                    break;
            }
        });

        //监听表格行工具栏事件
        table.on("tool(currentTableFilter)",function (obj) {
            switch (obj.event) {
                case 'edit':
                    openUpdateWindow(obj.data);
                    break;
                case 'delete':
                    deleteById(obj.data);
                    break;
            }
        });


        //渲染下拉菜单树组件
        var menuSelectTree = dtree.renderSelect({
            elem: "#menuSelectTree",
            url: "/admin/permission/loadMenuTree",
            dataStyle: "layuiStyle",  //使用layui风格的数据格式
            dataFormat: "list",  //配置data的风格为list
            response:{message:"msg",statusCode:0},  //修改response中返回数据的定义
        });

        //监听下拉菜单树节点点击事件
        dtree.on("node('menuSelectTree')" ,function(obj){
            $("#pid").val(obj.param.nodeId);//将选中的节点ID赋值给父节点隐藏域
        });


        //渲染图标选择器组件
        iconPickerFa.render({
            // 选择器，推荐使用input
            elem: '#iconPicker',
            // fa 图标接口
            url: "/statics/layui/lib/font-awesome-4.7.0/less/variables.less",
            // 是否开启搜索：true/false，默认true
            search: true,
            // 是否开启分页：true/false，默认true
            page: true,
            // 每页显示数量，默认12
            limit: 12,
            // 点击回调
            click: function (data) {
                //给图标隐藏域赋值
                $("#icon").val("fa "+data.icon);
            },
            // 渲染成功后的回调
            success: function (d) {
                console.log(d);
            }
        });

        //监听菜单类型单选按钮的点击事件
        form.on("radio(checkPermission)",function (data) {
            if(data.value=="permission"){
                $("#permissionCodeDiv").show();//显示权限编码区域
            }else{
                $("#permissionCodeDiv").hide();//隐藏
            }
        });

        //重置下拉菜单
        $("#resetMenu").click(function () {
            menuSelectTree.selectResetVal();
        });


        //定义变量，分别保存提交地址和窗口索引
        var url,mainIndex;

        /**
         * 打开添加窗口
         */
        function openAddWindow() {
            mainIndex = layer.open({
                type:1,
                title:"添加菜单",
                area: ["800px", "500px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success:function () {
                    //提交地址
                    url = "/admin/permission/addPermission";
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //设置默认图标
                    iconPickerFa.checkIcon('iconPicker', 'fa fa-star');
                    $("#icon").val("fa fa-star");
                }
            });
        }

        /**
         * 打开修改窗口
         */
        function openUpdateWindow(data) {
            mainIndex = layer.open({
                type:1,
                title:"修改菜单",
                area: ["800px", "500px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success:function () {
                    //提交地址
                    url = "/admin/permission/updatePermission";
                    //表单数据回显
                    form.val("dataFrm",data);
                    //图标回显
                    iconPickerFa.checkIcon('iconPicker', data.icon);
                    $("#icon").val(data.icon);
                    //父级下拉菜单树回显
                    dtree.dataInit("menuSelectTree",data.pid);//参数1：下拉菜单树的id属性值,参数2：父节点ID值
                    dtree.selectVal("menuSelectTree");//参数1：下拉菜单树的id属性值
                    //判断当前选中节点是否是一级菜单，如果是一级菜单，那么该菜单是没有父级菜单，此时应该显示请选择
                    if(data.pid==0){
                        menuSelectTree.reload();
                    }
                }
            });
        }


        //监听表单提交事件
        form.on("submit(doSubmit)",function (data) {
            //发送请求
            $.post(url,data.field,function(result){
                if(result.success){
                    //提示
                    layer.alert(result.message,{icon:1});
                    //刷新当前数据表格
                    tableIns.reload();
                    //刷新左侧菜单树
                    menuTree.reload();
                    //刷新下拉菜单树
                    menuSelectTree.reload();
                    //关闭当前窗口
                    layer.close(mainIndex);
                }else{
                    //提示
                    layer.alert(result.message,{icon:2});
                }
            },"json");
            return false;
        });

        /**
         * 删除菜单
         * @param data
         */
        function deleteById(data) {
            //验证当前菜单是否有子菜单
            $.get("/admin/permission/checkPermission",{"id":data.id},function(result){

                if(result.exist){
                    layer.alert(result.message,{icon:2});
                }else{
                    //发送删除请求
                    //提示用户是否确认删除
                    layer.confirm("确定要删除[<font>"+data.title+"</font>]菜单吗?",{icon:3,title:"提示"},function (index) {
                        //发送删除的请求
                        $.post("/admin/permission/deleteById",{"id":data.id},function(result){
                            if(result.success){
                                //提示
                                layer.alert(result.message,{icon:1});
                                //刷新当前数据表格
                                tableIns.reload();
                                //刷新左侧菜单树
                                menuTree.reload();
                                //刷新下拉菜单树
                                menuSelectTree.reload();
                            }else{
                                //提示
                                layer.alert(result.message,{icon:2});
                            }
                        },"json");

                        layer.close(index);
                    });

                }

            },"json");
        }



    });
</script>

</html>
