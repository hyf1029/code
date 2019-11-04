<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemCardsList.aspx.cs" Inherits="PMS.UI.MemCardsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .auto-style1 {
        }

        #Text8 {
            width: 69px;
        }

        #Text9 {
            width: 68px;
        }

        #txtMonth {
            width: 60px;
        }

        #txtDay {
            width: 60px;
        }

        .auto-style2 {
            width: 332px;
        }

        .auto-style3 {
            width: 90px;
        }

        .auto-style4 {
            width: 81px;
        }

        .auto-style5 {
            width: 69px;
        }
    </style>
    <link href="jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
    <link href="jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.5/jquery.min.js"></script>
    <script src="jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        //文档就绪函数
        $(function () {

            GetAllCardName();

            $('#dg').datagrid({
                url: '/Handlers/MemCardsHandler.ashx',
                queryParams: {
                    Method: "GetPageMenCardsByCondition"
                },
                pagination: true,
                toolbar: "#tb",
                fit: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'MC_ID', title: '会员编号', width: 100, align: 'center' },
                    { field: 'MC_CardID', title: '会员卡号', width: 100, align: 'center' },
                    { field: 'MC_Name', title: '会员姓名', width: 100, align: 'center' },
                    { field: 'MC_Mobile', title: '手机号', width: 100, align: 'center' },
                    { field: 'MC_TotalMoney', title: '累计消费', width: 100, align: 'center' },
                    {
                        field: 'MC_State', title: '会员卡状态', formatter: function (value) {
                            if (value == '1') {
                                return '正常';
                            } else if (value == '2') {
                                return '挂失';
                            } else if (value == '3') {
                                return '锁定';
                            }
                        }, width: 100, align: 'center'
                    },
                    { field: 'MC_Point', title: '当前积分', width: 100, align: 'center' },
                    {
                        field: 'MC_Sex', title: '性别', formatter: function (value) {
                            if (value == '1') {
                                return '男';
                            } else if (value == '0') {
                                return '女';
                            }
                        }, width: 100, align: 'center'
                    },
                    { field: 'MC_CreateTime', title: '登记时间', width: 150, align: 'center' },
                    { field: 'CL_LevelName', title: '当前等级', width: 100, align: 'center' }

                ]]
            });

            //实现查询
            $("#btnsearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageMenCardsByCondition",
                    MC_CardID: $("#txtCard").val().trim(),
                    MC_Name: $("#txtName").val().trim(),
                    MC_Mobile: $("#txtTel").val().trim(),
                    CL_ID: $("#ddlCL_ID").val(),
                    MC_State: $("#ddlState").val()
                });


            });

            //实现添加的功能
            $("#btnAdd").click(function () {
                InsertMemCard();
            });
            //实现修改的功能
            $("#btnUpdate").click(function () {
                UpdateMemCard();
            });
            //实现挂失/锁定的功能
            $("#btnUpdateState").click(function () {
                Updatestate();
            });
            //实现转账功能
            $("#btnTran").click(function () {
                InsertTransferLog();
            });
            //实现换卡功能
            $("#btnNewCard").click(function () {
                var pwd = $("#txtPwd").val().trim();
                $.ajax({
                    type: "get",
                    url: "/Handlers/MemCardsHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "vilidatePwd",
                        MC_Name: $("#lblmcName").text()

                    },
                    success: function (data) {
                        var s = data.MC_Password;
                        if (pwd == s) {
                            NewCard();
                        }
                        else {
                            $.messager.alert("提示", "会员密码输入错误!!", "warning");
                        }
                    }
                });
            });



        });

        //绑定等级名称
        function GetAllCardName() {
            $.ajax({
                type: "get",
                url: "/Handlers/CardLevelsHandler.ashx",
                data: {
                    Method: "GetAllCardLevelName"
                },
                dataType: "json",
                success: function (data) {
                    var s;
                    $.each(data, function (index, o) {
                        s += " <option value='" + o.CL_ID + "'>" + o.CL_LevelName + "</option>";
                    });
                    $("#ddlCL_ID,#ddlCardLevel").append(s);
                }

            });


        }

        //打开新增会员的模态窗口
        function OpenInsertDialog() {
            $("#form1")[0].reset();
            $("#btnAdd").show();
            $("#btnUpdate").hide();
            $("#dlg").dialog({ title: "新增会员" }).dialog("open").dialog("center");
            $("#txtPassWord").val(1);
            $("#txtRePassWord").val(1);
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "GetMaxMenCards"
                },
                dataType: "json",
                success: function (data) {
                    $.each(data, function (index, o) {
                        $("#txtMCCard").val(o.MC_CardID);
                        var s = $("#txtMCCard").val();
                        s++;
                        $("#txtMCCard").val(s);
                    });

                }

            });
            //实现查询推荐人
            $("#btnSelect").click(function () {
                $.ajax({
                    type: "get",
                    url: "/Handlers/MemCardsHandler.ashx",
                    data: {
                        Method: "GetSingleMenCards",
                        MC_CardID: $("#txtRefererCard").val().trim()
                    },
                    dataType: "json",
                    success: function (data) {
                        $("#txtRefererName").val(data.MC_Name);

                    }
                });
            });

        }

        //实现新增会员的方法
        function InsertMemCard() {
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "InsertMemCard",
                    MC_CardID: $("#txtMCCard").val().trim(),
                    MC_Name: $("#txtMCName").val().trim(),
                    MC_Mobile: $("#txtTelPhone").val().trim(),
                    MC_Sex: $("#ddlSex").val(),
                    CL_ID: $("#ddlCardLevel").val(),
                    MC_BirthdayType: $("#gong").is(":checked") ? 1 : 0,
                    MC_Birthday_Month: $("#txtMonth").val().trim(),
                    MC_Birthday_Day: $("#txtDay").val().trim(),
                    MC_IsPast: $("#ckIsPast").is(":checked") ? "true" : "false",
                    MC_PastTime: $("#txtPastTime").val().trim(),
                    MC_State: $("#ddlCardState").val(),
                    MC_Money: $("#txtMCMoney").val().trim(),
                    MC_Point: $("#txtPoint").val().trim(),
                    MC_IsPointAuto: $("#ckIsPointAuto").is(":checked") ? "true" : "false",
                    MC_RefererCard: $("#txtRefererCard").val().trim(),
                    MC_RefererName: $("#txtRefererName").val().trim()
                },
                success: function (data) {
                    if (data == "1") {
                        $("#dg").datagrid("load");
                        $("#dlg").dialog("close");
                        $.messager.alert("提示", "添加成功", "info");
                    }
                    else {
                        $.messager.alert("提示", "添加失败", "warning");
                    }
                }

            });
        }

        //打开修改会员的模态窗口
        function OpenUpdateDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行!!", "warning");
            }
            else {
                var id = row.MC_CardID;
                $("#form1")[0].reset();
                $("#btnAdd").hide();
                $("#btnUpdate").show();
                $("#dlg").dialog({ title: "修改会员" }).dialog("open").dialog("center");
                $.ajax({
                    type: "get",
                    url: "/Handlers/MemCardsHandler.ashx",
                    data: {
                        Method: "GetSingleMenCards",
                        MC_CardID: id
                    },
                    dataType: "json",
                    success: function (data) {

                        $("#txtMCCard").val(data.MC_CardID);
                        $("#txtMCName").val(data.MC_Name);
                        $("#txtTelPhone").val(data.MC_Mobile);
                        $("#ddlSex").val(data.MC_Sex);
                        $("#ddlCardLevel").val(data.CL_ID);
                        if (data.MC_BirthdayType == 1) {
                            $("#gong").prop("checked", "checked");
                        }
                        $("#txtMonth").val(data.MC_Birthday_Month);
                        $("#txtDay").val(data.MC_Birthday_Day);
                        if (data.MC_IsPast) {
                            $("#ckIsPast").prop("checked", "checked");
                        }
                        $("#txtPastTime").val(data.MC_PastTime);
                        $("#ddlCardState").val(data.MC_State);
                        $("#txtMCMoney").val(data.MC_Money);
                        $("#txtPoint").val(data.MC_Point);
                        if (data.MC_IsPointAuto) {
                            $("#ckIsPointAuto").prop("checked", "checked");
                        }
                        $("#txtRefererCard").val(data.MC_RefererCard);
                        $("#txtRefererName").val(data.MC_RefererName);
                        $("#txtPassWord").val(data.MC_Password);
                    }
                });
            }
        }

        //实现修改会员的方法
        function UpdateMemCard() {
            var pwd = $("#txtPassWord").val().trim();
            var repwd = $("#txtRePassWord").val().trim();
            if (pwd != repwd) {
                $.messager.alert("提示", "密码不一致,请重新填写！！", "warning");
            }
            else {
                $.ajax({
                    type: "get",
                    url: "/Handlers/MemCardsHandler.ashx",
                    data: {
                        Method: "UpdateMemCard",
                        MC_CardID: $("#txtMCCard").val().trim(),
                        MC_Name: $("#txtMCName").val().trim(),
                        MC_Mobile: $("#txtTelPhone").val().trim(),
                        MC_Sex: $("#ddlSex").val(),
                        CL_ID: $("#ddlCardLevel").val(),
                        MC_BirthdayType: $("#gong").is(":checked") ? 1 : 0,
                        MC_Birthday_Month: $("#txtMonth").val().trim(),
                        MC_Birthday_Day: $("#txtDay").val().trim(),
                        MC_IsPast: $("#ckIsPast").is(":checked") ? "true" : "false",
                        MC_PastTime: $("#txtPastTime").val().trim(),
                        MC_State: $("#ddlCardState").val(),
                        MC_Money: $("#txtMCMoney").val().trim(),
                        MC_Point: $("#txtPoint").val().trim(),
                        MC_IsPointAuto: $("#ckIsPointAuto").is(":checked") ? "true" : "false",
                        MC_RefererCard: $("#txtRefererCard").val().trim(),
                        MC_RefererName: $("#txtRefererName").val().trim(),
                        MC_Password: $("#txtRePassWord").val().trim()
                    },
                    success: function (data) {
                        if (data == "1") {
                            $("#dg").datagrid("reload");
                            $("#dlg").dialog("close");
                            $.messager.alert("提示", "修改成功", "info");
                        }
                        else {
                            $.messager.alert("提示", "修改失败", "warning");
                        }
                    }

                });
            }

        }

        //实现删除会员
        function DeleteMenCard() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行！！", "warning");
            }
            else {
                $.messager.confirm("提示", "你确定要删除吗？", function (r) {
                    if (r == true) {
                        $.ajax({
                            type: "get",
                            url: "/Handlers/MemCardsHandler.ashx",
                            data: {
                                Method: "DeleteMenCard",
                                MC_CardID: row.MC_CardID

                            },
                            success: function (data) {
                                if (data == "1") {
                                    $("#dg").datagrid("reload");
                                    $.messager.alert("提示", "删除成功", "info");
                                }
                                else {
                                    $.messager.alert("提示", "删除失败", "warning");
                                }
                            }

                        });
                    }
                });
            }
        }

        //打开挂失/锁定的模态窗体
        function OpenUpdateStateDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行!!", "warning");
            }
            else {
                $("#form2")[0].reset();
                $("#dlg2").dialog({ title: "挂失/锁定" }).dialog("open").dialog("center");
                $("#txtCard2").val(row.MC_CardID);
                $("#ddlMC_State").val(row.MC_State);
            }
        }

        //实现挂失/锁定的方法
        function Updatestate() {
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "UpdateState",
                    MC_CardID: $("#txtCard2").val(),
                    MC_State: $("#ddlMC_State").val()

                },
                success: function (data) {
                    if (data == "1") {
                        $("#dg").datagrid("reload");
                        $("#dlg2").dialog("close");
                        $.messager.alert("提示", "修改成功", "info");
                    }
                    else {
                        $.messager.alert("提示", "修改失败", "warning");
                    }
                }

            });
        }

        //打开会员转账的模态窗体
        function OpenTransDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行!!", "warning");
            }
            else {
                $("#lblFromCard").text("");
                $("#lblFromName").text("");
                $("#lblFromPoint").text("");
                $("#lblFromMoney").text("");
                $("#lblToCard2").text("");
                $("#lblToPoint").text("");
                $("#lblToName").text("");
                $("#lblToMoney").text("");

                $("#form3")[0].reset();
                $("#dlg3").dialog({ title: "会员转账" }).dialog("open").dialog("center");
                $("#lblFromCard").text(row.MC_CardID);
                $("#lblFromName").text(row.MC_Name);
                $("#lblFromPoint").text(row.MC_Point);
                $("#lblFromMoney").text(row.MC_TotalMoney);
                $("#HidFromMC_ID").val(row.MC_ID);
            }
            //实现查询转入会员信息
            $("#btnToSelect").click(function () {
                $.ajax({
                    type: "get",
                    url: "/Handlers/MemCardsHandler.ashx",
                    data: {
                        Method: "GetSingleMenCards",
                        MC_CardID: $("#txtToCard").val().trim()
                    },
                    dataType: "json",
                    success: function (data) {

                        $("#lblToCard2").text(data.MC_CardID);
                        $("#lblToPoint").text(data.MC_Point);
                        $("#lblToName").text(data.MC_Name);
                        $("#lblToMoney").text(data.MC_TotalMoney);
                        $("#HidToMC_ID").val(data.MC_ID);

                    }
                });
            });
        }

        //实现会员转账的方法
        function InsertTransferLog() {
            if ($("#lblToCard2").text() == "") {
                $.messager.alert("提示", "输入的会员不能为空!!", "error");
                return;
            }
            var mc_Point = $("#lblToPoint").text();
            var transPoint = $("#txtMoney").val();
            if (isNaN(transPoint)) {
                $.messager.alert("提示", "被转积分必须是数字!!", "error");
                return;
            }
            if (parseInt(transPoint) > parseInt(mc_Point)) {
                $.messager.alert("提示", "积分不足，无法转账", "error");
                $("#txtMoney").val("");
                return;
            }
            $.ajax({
                type: "get",
                url: "/Handlers/TransferLogsHandler.ashx",
                data: {
                    Method: "InsertTransferLog",
                    TL_FromMC_ID: $("#HidFromMC_ID").val(),
                    TL_FromMC_CardID: $("#lblFromCard").text(),
                    TL_ToMC_ID: $("#HidToMC_ID").val(),
                    TL_ToMC_CardID: $("#lblToCard2").text(),
                    TL_TransferMoney: $("#txtMoney").val(),
                    TL_Remark: $("#txtRemark").val()
                },
                success: function (data) {
                    if (data == "1") {
                        $("#dg").datagrid("reload");
                        $("#dlg3").dialog("close");
                        $.messager.alert("提示", "转账成功!!", "info");
                    }
                    else {
                        $.messager.alert("提示", "转账失败!!", "warning");
                    }
                }

            });
        }

        //打开会员换卡的模态窗体
        function OpenNewCardDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行!!", "warning");
            }
            else {
                $("#txtPwd").val("");
                $("#txtNewCard").val("");
                $("#txtNewCardPwd").val("");
                $("#txtReNewCardPwd").val("");

                $("#form4")[0].reset();
                $("#dlg4").dialog({ title: "会员换卡" }).dialog("open").dialog("center");
                $("#lblmcName").text(row.MC_Name);
                $("#lblCardLevel").text(row.MC_CardID);
                $("#lblTime").text(row.MC_CreateTime);
                $("#HidMC_ID").val(row.MC_ID);
            }
        }

        //实现会员换卡的方法
        function NewCard() {
            if ($("#txtNewCard").val() == "")
            {
                $.messager.alert("提示", "新会员卡号不能为空!!", "error");
                return;
            }
            if (isNaN($("#txtNewCard").val()))
            {
                $.messager.alert("提示", "新会员卡号只能是数字!!", "error");
                $("#txtNewCard").val("");
                return;
            }
            var newPwd = $("#txtNewCardPwd").val();
            var rePwd = $("#txtReNewCardPwd").val();
            if (newPwd=="")
            {
                $.messager.alert("提示", "新会员卡密码不能为空!!", "error");
                return;
            }
            if (rePwd == "") {
                $.messager.alert("提示", "确认密码不能为空!!", "error");
                return;
            }
            if (newPwd!= rePwd)
            {
                $.messager.alert("提示", "两次密码输入不一致，请重新输入!!", "error");
                $("#txtNewCardPwd").val("");
                $("#txtReNewCardPwd").val("");
                return;
            }
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "NewCard",
                    MC_ID: $("#HidMC_ID").val(),
                    MC_CardID: $("#txtNewCard").val(),
                    MC_Password: $("#txtReNewCardPwd").val()

                },
                success: function (data) {
                    if (data == "1") {
                        $("#dg").datagrid("reload");
                        $("#dlg4").dialog("close");
                        $.messager.alert("提示", "换卡成功", "info");
                    }
                    else {
                        $.messager.alert("提示", "换卡失败", "warning");
                    }
                }
            });
        }
    </script>

</head>
<body>
    <div id="tb" style="padding: 2px 5px;">
        <div style="padding: 5px 0;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="OpenInsertDialog()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="OpenUpdateDialog()">修改</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="DeleteMenCard()">删除</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-lock'" onclick="OpenUpdateStateDialog()">挂失/锁定</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="OpenTransDialog()">会员转账</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="OpenNewCardDialog()">会员换卡</a>
        </div>
        会员卡号：<input id="txtCard" type="text" />
        会员姓名：<input id="txtName" type="text" />
        电话：<input id="txtTel" type="text" />
        会员等级：<select id="ddlCL_ID">
            <option value="0">--请选择--</option>

        </select>
        状态：<select id="ddlState">
            <option value="0">--请选择--</option>
            <option value="1">正常</option>
            <option value="2">挂失</option>
            <option value="3">锁定</option>

        </select>
        <a id="btnsearch" href="#" class="easyui-linkbutton" iconcls="icon-search">查询</a>
    </div>
    <table id="dg"></table>

    <!--dlg-->
    <div id="dlg" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 800px; height: 400px; padding: 10px">
        <form id="form1">
            <table align="center" style="line-height: 27px">
                <tr>
                    <td class="auto-style2">会员卡号:<input id="txtMCCard" type="text" readonly="true" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">会员姓名:<input id="txtMCName" type="text" /></td>
                    <td>手机号码:<input id="txtTelPhone" type="text" /></td>
                </tr>
                <tr>
                    <td class="auto-style2">卡片密码:<input id="txtPassWord" type="text" /></td>
                    <td>确认密码:<input id="txtRePassWord" type="text" /></td>
                </tr>
                <tr>
                    <td class="auto-style2">会员性别：<select id="ddlSex" name="D1">
                        <option value="2">--请选择--</option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select></td>
                    <td>会员等级:<select id="ddlCardLevel" name="D3">
                        <option value="0">--请选择--</option>

                    </select></td>
                </tr>
                <tr>
                    <td class="auto-style2">会员生日:<input id="gong" type="radio" name="a" checked="checked" />公历<input id="nong" type="radio" name="a" />农历</td>
                    <td>
                        <input id="txtMonth" type="text" />月<input id="txtDay" type="text" />日</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <input id="ckIsPast" type="checkbox" />设置卡片过期时间(到期则此卡自动失效)</td>
                    <td>
                        <input id="txtPastTime" type="text" /></td>
                </tr>
                <tr>
                    <td class="auto-style2">卡片状态:<select id="ddlCardState" name="D2">
                        <option value="0">--请选择--</option>
                        <option value="1">正常</option>
                        <option value="2">挂失</option>
                        <option value="3">锁定</option>
                    </select></td>
                    <td>卡片付费:<input id="txtMCMoney" type="text" /></td>
                </tr>
                <tr>
                    <td class="auto-style1" colspan="2">
                        <hr />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">积分数量:<input id="txtPoint" type="text" /></td>
                    <td>
                        <input id="ckIsPointAuto" type="checkbox" />积分是否自动转换成等级</td>
                </tr>
                <tr>
                    <td class="auto-style2">推荐人:<input id="txtRefererCard" type="text" /><input id="btnSelect" type="button" value="查询" /></td>
                    <td>推荐人姓名:<input id="txtRefererName" type="text" /></td>
                </tr>
                <tr>
                    <td class="auto-style2">&nbsp;</td>
                    <td>
                        <input id="btnAdd" type="button" value="新增" />
                        <input id="btnUpdate" type="button" value="修改" />
                    </td>
                </tr>
            </table>
        </form>
    </div>


    <!--dlg2-->
    <div id="dlg2" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 400px; height: 150px; padding: 10px">
        <form id="form2">
            <table align="center">
                <tr>
                    <td>会员卡号:</td>
                    <td>
                        <input id="txtCard2" type="text" />

                    </td>
                </tr>
                <tr>
                    <td>状态:</td>
                    <td>
                        <select id="ddlMC_State">
                            <option value="0">--请选择--</option>
                            <option value="1">正常</option>
                            <option value="2">挂失</option>
                            <option value="3">锁定</option>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input id="btnUpdateState" type="button" value="修改" />

                    </td>
                </tr>
            </table>
        </form>
    </div>


    <!--dlg3-->
    <div id="dlg3" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 410px; height: 450px; padding: 10px">
        <form id="form3">
            <fieldset style="margin-bottom: 10px; width: 350px;">
                <legend>
                    <h2>转出会员</h2>
                </legend>
                <table style="line-height: 25px">
                    <tr>
                        <td>卡号：
                        </td>
                        <td class="auto-style3">
                            <label id="lblFromCard"></label>
                        </td>
                        <td>姓名：
                        </td>
                        <td>
                            <label id="lblFromName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>账户积分：
                        </td>
                        <td class="auto-style3">
                            <label id="lblFromPoint"></label>
                        </td>
                        <td>累计消费：
                        </td>
                        <td>
                            <label id="lblFromMoney"></label>

                        </td>
                    </tr>
                </table>
            </fieldset>
            <label style="margin-bottom: 5px">点击查看获取当前输入会员信息</label><br />
            <input id="txtToCard" type="text" /><input id="btnToSelect" type="button" value="查询" />
            <fieldset style="margin-top: 10px; width: 350px;">
                <legend>
                    <h2>转入会员</h2>
                </legend>
                <table style="line-height: 25px">
                    <tr>
                        <td class="auto-style4">卡号：
                        </td>
                        <td class="auto-style5">
                            <label id="lblToCard2"></label>
                        </td>
                        <td>姓名：
                        </td>
                        <td>
                            <label id="lblToName"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">账户积分：
                        </td>
                        <td class="auto-style5">
                            <label id="lblToPoint"></label>
                        </td>
                        <td>累计消费：
                        </td>
                        <td>
                            <label id="lblToMoney"></label>

                        </td>
                    </tr>
                </table>
            </fieldset>
            <table>
                <tr>
                    <td>转积分数量:</td>
                    <td>
                        <input id="txtMoney" type="text" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>操作备注:</td>
                    <td>
                        <input id="txtRemark" type="text" /></td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input id="btnTran" type="button" value="转账" /></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <input id="HidFromMC_ID" type="hidden" /><input id="HidToMC_ID" type="hidden" />
        </form>
    </div>

    <!--dlg4-->
    <div id="dlg4" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 410px; height: 450px; padding: 10px">
        <form id="form4">
            <fieldset style="margin-bottom: 10px; width: 350px;">
                <legend>
                    <h2>会员卡基本信息</h2>
                </legend>
                <table style="line-height: 25px">
                    <tr>
                        <td>会员姓名：
                        </td>
                        <td>
                            <label id="lblmcName"></label>
                        </td>

                    </tr>
                    <tr>
                        <td>会员等级：
                        </td>
                        <td>
                            <label id="lblCardLevel"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>登记日期：
                        </td>
                        <td>
                            <label id="lblTime"></label>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset style="margin-top: 10px; width: 350px;">
                <legend>
                    <h2>转入会员</h2>
                </legend>
                <table>
                    <tr>
                        <td>请输入此卡密码:</td>
                        <td>
                            <input id="txtPwd" type="text" /></td>

                    </tr>
                    <tr>
                        <td>新会员卡号:</td>
                        <td>
                            <input id="txtNewCard" type="text" /></td>

                    </tr>

                    <tr>
                        <td>新会员卡号密码:</td>
                        <td>
                            <input id="txtNewCardPwd" type="text" /></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>确认密码</td>
                        <td>
                            <input id="txtReNewCardPwd" type="text" /></td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input id="btnNewCard" type="button" value="换卡" /></td>

                    </tr>

                </table>
            </fieldset>

            <input id="HidMC_ID" type="hidden" />
        </form>
    </div>
</body>
</html>
