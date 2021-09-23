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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/statics/layui/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <!-- 搜索条件 -->
        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="userName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">真实姓名</label>
                            <div class="layui-input-inline">    
                                <input type="text" name="realName" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">用户性别</label>
                            <div class="layui-input-inline">
                                <select name="sex" autocomplete="off" class="layui-input">
                                    <option value="">请选择性别</option>
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">所属部门</label>
                            <div class="layui-input-inline">
                                <select name="deptId" autocomplete="off" id="s_deptId" class="layui-input">
                                    <option value="">请选择部门</option>
                                </select>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">开始日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="startDate" id="startTime" autocomplete="off" class="layui-input" readonly>
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">结束日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="endDate" id="endTime" autocomplete="off" class="layui-input" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-block" style="text-align: center">
                            <button type="submit" class="layui-btn"  lay-submit lay-filter="data-search-btn"><i class="layui-icon layui-icon-search"></i>搜索</button>
                            <button type="reset" class="layui-btn layui-btn-warm"><i class="layui-icon layui-icon-refresh-1"></i>重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <!-- 表格工具栏 -->
        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>添加 </button>
            </div>
        </script>

        <!-- 数据表格 -->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <!-- 行工具栏 -->
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-xs data-count-edit" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete"><i class="layui-icon layui-icon-close"></i>删除</a>
            <button class="layui-btn layui-btn-xs layui-btn-warm" lay-event="resetPwd"><i class="layui-icon layui-icon-refresh"></i>重置密码 </button>
            <button class="layui-btn layui-btn-xs" lay-event="grantRole"><i class="layui-icon layui-icon-edit"></i>分配角色 </button>
        </script>

        <!-- 添加和修改窗口 -->
        <div style="display: none;padding: 5px" id="addOrUpdateWindow">
            <form class="layui-form" style="width:90%;" id="dataFrm" lay-filter="dataFrm">
                <!-- 隐藏域，保存用户id -->
                <input type="hidden" name="id" id="id">

                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">登陆名称</label>
                        <div class="layui-input-block">
                            <input type="text" name="userName" id="userName" lay-verify="required"  autocomplete="off" placeholder="请输入登陆名称" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">用户姓名</label>
                        <div class="layui-input-block">
                            <input type="text" name="realName" id="realName" lay-verify="required" autocomplete="off" placeholder="请输入用户姓名" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-block">
                            <input type="text" name="email" id="email" lay-verify="required|email"  autocomplete="off" placeholder="请输入电子邮箱" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">联系方式</label>
                        <div class="layui-input-block">
                            <input type="text" name="phone" id="phone" lay-verify="required|phone" autocomplete="off" placeholder="请输入联系方式" class="layui-input">
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">入职日期</label>
                        <div class="layui-input-block">
                            <input type="text" name="hireDate" id="hireDate" readonly lay-verify="required" autocomplete="off" placeholder="请选择入职日期" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">所属部门</label>
                        <div class="layui-input-block">
                            <select name="deptId" id="deptId" class="layui-input">
                                <option value="">请选择部门</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">用户性别</label>
                        <div class="layui-input-block">
                            <input type="radio" name="sex" value="1" title="男" checked>
                            <input type="radio" name="sex" value="2" title="女" >
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">用户状态</label>
                        <div class="layui-input-block">
                            <input type="radio" name="status" value="1" title="正常" checked>
                            <input type="radio" name="status" value="2" title="异常" >
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">用户备注</label>
                    <div class="layui-input-block">
                        <textarea class="layui-textarea" name="remark" id="remark"></textarea>
                    </div>
                </div>


                <div class="layui-form-item layui-row layui-col-xs12">
                    <div class="layui-input-block" style="text-align: center;">
                        <button type="button" class="layui-btn" lay-submit lay-filter="doSubmit"><span class="layui-icon layui-icon-add-1"></span>提交</button>
                        <button type="button" class="layui-btn layui-btn-warm" ><span class="layui-icon layui-icon-refresh-1"></span>重置</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 用户分配角色弹出层 -->
        <div style="display: none;padding: 5px" id="selectUserRoleDiv">
            <table class="layui-hide" id="roleTable" lay-filter="roleTable"></table>
        </div>

    </div>
</div>
<script src="${pageContext.request.contextPath}/statics/layui/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table','laydate','jquery'], function () {
        var $ = layui.jquery,
            form = layui.form,
            laydate = layui.laydate,
            table = layui.table;

        //获取<meta>标签中封装的CSRF Token
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        //将头中的CSRF Token信息进行发送
        $(document).ajaxSend(function (e,xhr,options) {
            xhr.setRequestHeader(header,token);
        });

        //渲染日期组件
        laydate.render({
            elem: '#startTime', //指定元素
            type: 'date'
        });
        laydate.render({
            elem: '#endTime', //指定元素
            type: 'date'
        });
        laydate.render({
            elem: '#hireDate' //指定元素
        });

        //渲染表格组件
        var tableIns = table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/admin/user/list',
            toolbar: '#toolbarDemo',
            cols: [[
                {field: 'id', width: 100, title: '用户编号', align: "center"},
                {field: 'userName', width: 120, title: '登录名', align: "center"},
                {field: 'realName', width: 120, title: '真实姓名', align: "center"},
                {field: 'phone', width: 150, title: '联系方式', align: "center"},
                {field: 'sex', width: 80, title: '性别', align: "center",templet:function (d) {
                        return d.sex == 1 ? "<font color='blue'>男</font>" : "<font color='red'>女</font>";
                    }},
                {field: 'dept', width: 120, title: '所属部门', align: "center",templet:function (d) {
                        return d.dept.deptName;
                    }},
                {field: 'hireDate', width: 180, title: '入职日期', align: "center"},
                {field: 'status', width: 80, title: '状态', align: "center",templet:function (d) {
                        return d.status == 1 ? "<font color='blue'>正常</font>" : "<font color='red'>异常</font>";
                    }},
                {title: '操作', minWidth: 120, toolbar: '#currentTableBar', align: "center"}
            ]],
            page: true,
            done: function (res, curr, count) {
                //判断当前页码是否是大于1并且当前页的数据量为0
                if (curr > 1 && res.data.length == 0) {
                    var pageValue = curr - 1;
                    //刷新数据表格的数据
                    tableIns.reload({
                        page: {curr: pageValue}
                    });
                }
            }
        });

        //监听模糊查询
        form.on("submit(data-search-btn)",function (data) {
            tableIns.reload({
                where:data.field,//查询条件
                page:{
                    curr:1
                }
            });


            return false;
        })
        
        
        //发送请求查询部门列表（将数据追加到部门下拉列表中）
        $.get("/admin/dept/findDeptList",function(result){

            var html = "";
            for (let i = 0; i < result.length; i++) {
                html +="<option value='"+result[i].id+"'>"+result[i].deptName+"</option>";
            }
            //将网页代码追加到下拉列表中
            $("[name='deptId']").append(html);
            //重新渲染下拉列表
            form.render("select");

        },"json");

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
                case 'resetPwd':
                    resetPwd(obj.data);
                    break;
                case 'grantRole':
                    grantRole(obj.data);
                    break;
            }
        });


        //定义变量，分别保存提交地址和窗口索引
        var url,mainIndex;

        /**
         * 打开添加窗口
         */
        function openAddWindow() {
            mainIndex = layer.open({
                type:1,
                title:"添加用户",
                area: ["800px", "500px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success:function () {
                    //提交地址
                    url = "/admin/user/addUser";
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                }
            });
        }

        /**
         * 打开修改窗口
         */
        function openUpdateWindow(data) {
            mainIndex = layer.open({
                type:1,
                title:"修改用户",
                area: ["800px", "500px"],//窗口宽高
                content: $("#addOrUpdateWindow"),//引用的内容窗口
                success:function () {
                    //提交地址
                    url = "/admin/user/updateUser";
                    //表单数据回显
                    form.val("dataFrm",data);
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
         * 删除
         * @param data
         */
        function deleteById(data) {
            layer.confirm("确定要删除[<font color='red'>"+data.realName+"</font>]吗?",{icon:3,title:"提示"},function (index) {
                //发送请求
                $.post("/admin/user/deleteById",{"id":data.id},function(result){
                    if(result.success){
                        //提示
                        layer.alert(result.message,{icon:1});
                        //刷新数据表格
                        tableIns.reload();
                    }else{
                        //提示
                        layer.alert(result.message,{icon:2});
                    }
                },"json");


                layer.close(index);
            });
        }
        /**
         * 重置密码
         * @param data
         */
        function resetPwd(data) {
            layer.confirm("确定要重置[<font color='red'>"+data.realName+"</font>]用户的密码吗?",{icon:3,title:"提示"},function (index) {
                //发送请求
                $.post("/admin/user/resetPwd",{"id":data.id},function(result){
                    if(result.success){
                        //提示
                        layer.alert(result.message,{icon:1});
                        //刷新数据表格
                        tableIns.reload();
                    }else{
                        //提示
                        layer.alert(result.message,{icon:2});
                    }
                },"json");


                layer.close(index);
            });
        }

        /**
         * 打开分配角色窗口
         * @param data
         */
        function grantRole(data) {
            mainIndex = layer.open({
                type:1,
                title:"分配[<font color='red'>"+data.realName+"</font>]角色",
                area: ["1000px", "500px"],//窗口宽高
                content: $("#selectUserRoleDiv"),//引用的内容窗口
                btn:["<i class='layui-icon layui-icon-ok'></i>确定","<i class='layui-icon layui-icon-close'></i>取消"],
                yes:function(index,layero){
                    //选中行对象
                    var checkStatus = table.checkStatus('roleTable');
                    //定义数组，保存选中行的ID
                    var idArr = [];
                    //判断是否有选中行
                    if(checkStatus.data.length>0){
                        //获取选中行的数据
                        for (let i = 0; i < checkStatus.data.length; i++) {
                            idArr.push(checkStatus.data[i].id);//角色ID
                        }
                        //将数组转成字符串
                        var ids = idArr.join(",");
                        //发送请求(参数分别是角色ID，用户ID)
                        $.post("/admin/user/grantRole",{"ids":ids,"userId":data.id},function(result){
                            if(result.success){
                                layer.alert(result.message,{icon:1});
                            }else{
                                layer.alert(result.message,{icon:2});
                            }
                        },"json");

                        //关闭分配角色窗口
                        //layer.close(mainIndex);

                    }else{
                        layer.msg("请选择要分配的角色");
                    }
                },
                btn2:function(index,layero){
                    //关闭当前窗口
                    layer.close(index);
                },
                success:function () {
                    //初始化加载角色数据
                    initRoleData(data);
                }
            });
        }

        /**
         * 初始化角色列表
         * @param data
         */
        function initRoleData(data) {
            table.render({
                elem: '#roleTable',
                url: '${pageContext.request.contextPath}/admin/role/initRoleListByUserId?userId='+data.id,
                cols: [[
                    {type: "checkbox", width: 50},
                    {field: 'id', width: 100, title: '角色编号', align: "center"},
                    {field: 'roleCode', minWidth: 150, title: '角色编码', align: "center"},
                    {field: 'roleName', minWidth: 150, title: '角色名称', align: "center"},
                    {field: 'roleDesc', minWidth: 200, title: '角色描述', align: "center"},
                ]],
            });
        }

    });

</script>

</body>
</html>
