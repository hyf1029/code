<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShopList.aspx.cs" Inherits="PMS.UI.ShopList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
    <link href="jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.5/jquery.min.js"></script>
    <script src="jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {

            $('#dg').datagrid({
                url: '/Handlers/ShopsHandler.ashx',
                queryParams: {
                    Method: "GetPageShopsByCondition"
                },
                toolbar: "#tb",
                pagination: true,
                fit: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'S_ID', title: '店铺编号', width: 100, align: 'center' },
                    { field: 'S_Name', title: '店铺名称', width: 100, align: 'center' },
                    {
                        field: 'S_Category', title: '店铺类型', width: 100, align: 'center',
                        formatter: function (value, row) {
                            var s = "";
                            switch (row.S_Category) {
                                case 1:
                                    s = "总部";
                                    break;
                                case 2:
                                    s = "加盟店";
                                    break;
                                case 3:
                                    s = "自营店";
                                    break;
                            }
                            return s;
                        }
                    },
                    { field: 'S_ContactName', title: '联系人', width: 100, align: 'center' },
                    { field: 'S_ContactTel', title: '联系电话', width: 100, align: 'center' },
                    { field: 'S_Address', title: '地址', width: 300, align: 'center' },
                    { field: 'S_Remark', title: '备注', width: 100, align: 'center' },
                    {
                        field: 'S_IsHasSetAdmin', title: '是否分配管理员', width: 100, align: 'center',
                        formatter: function (value, row) {
                            if (value == '1') {
                                return '是';
                            }
                            else {
                                return '否';
                            }
                        }
                    },
                    { field: 'S_CreateTime', title: '加盟时间', width: 100, align: 'center' }
                ]]
            });

            //查询
            $("#btnSearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageShopsByCondition",
                    S_Name: $("#txtS_Name").val().trim(),
                    S_ContactName: $("#txtS_ContactName").val().trim(),
                    S_Address: $("#txtS_Address").val().trim()

                });


            });


            //实现新增店铺功能
            $("#btnInsert").click(function () {
                InsertShop();
            });

            //实现修改店铺功能
            $("#btnUpdate").click(function () {
                UpdateShop();
            });

        });
        //打开新增店铺的模态窗体
        function OpenInsertDialog() {
            $("#form1")[0].reset();
            $("#btnInsert").show();
            $("#btnUpdate").hide();
            $("#dlg").dialog({ title: "新增店铺" }).dialog("open").dialog("center");
        }
        //实现新增店铺的方法
        function InsertShop() {
            //使用的是$.get()
            $.get("/Handlers/ShopsHandler.ashx", {
                Method: "InsertShops",
                S_Name: $("#txtSName").val().trim(),
                S_Category: $("#ddlS_Category").val(),
                S_ContactName: $("#txtContactName").val().trim(),
                S_ContactTel: $("#txtTel").val().trim(),
                S_Address: $("#txtAddress").val().trim(),
                S_Remark: $("#txtRemark").val().trim()
            }, function (data) {
                if (data == "1") {
                    $("#dg").datagrid("load");
                    $("#dlg").dialog("close");
                    $.messager.alert("提示", "添加成功", "info");
                }
                else {
                    $.messager.alert("提示", "添加失败", "warning");
                }

            });

        }

        //打开修改店铺的模态窗体
        function OpenUpdateDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选中需要操作的行！！", "warning");
            }
            else {
                var id = row.S_ID;
                $("#form1")[0].reset();
                $("#btnInsert").hide();
                $("#btnUpdate").show();
                $("#dlg").dialog({ title: "修改店铺" }).dialog("open").dialog("center");

                $.ajax({
                    type: "get",
                    url: "/Handlers/ShopsHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "GetSingleShop",
                        S_ID: id
                    },
                    success: function (data) {
                        $("#txtSName").val(data.S_Name);
                        $("#ddlS_Category").val(data.S_Category);
                        $("#txtContactName").val(data.S_ContactName);
                        $("#txtTel").val(data.S_ContactTel);
                        $("#txtAddress").val(data.S_Address);
                        $("#txtRemark").val(data.S_Remark);
                        $("#hiddenID").val(data.S_ID);


                    }
                });
            }


        }

        //实现修改店铺的方法
        function UpdateShop() {
            //使用的是$.get()
            $.get("/Handlers/ShopsHandler.ashx", {
                Method: "UpdateShop",
                S_Name: $("#txtSName").val(),
                S_Category: $("#ddlS_Category").val(),
                S_ContactName: $("#txtContactName").val(),
                S_ContactTel: $("#txtTel").val(),
                S_Address: $("#txtAddress").val(),
                S_Remark: $("#txtRemark").val(),
                S_ID: $("#hiddenID").val()
            }, function (data) {

                if (data == "1") {
                    $("#dg").datagrid("reload");
                    $("#dlg").dialog("close");
                    $.messager.alert("提示", "修改成功", "info");

                }
                else {
                    $.messager.alert("提示", "修改失败", "warning");
                }

            });
        }

        //实现删除功能
        function DeleteShop() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行！！", "warning");
            }
            else {
                $.messager.confirm('确认对话框', '你确定要删除吗？', function (r) {
                    if (r == true) {
                        var id = row.S_ID;
                        //使用的是$.post()
                        $.post("/Handlers/ShopsHandler.ashx", {
                            Method: "Deleteshop",
                            S_ID: id
                        }, function (data) {

                            if (data == "1") {
                                $("#dg").datagrid("reload");
                                $("#dlg").dialog("close");
                                $.messager.alert("提示", "删除成功", "info");
                            }
                            else {
                                $.messager.alert("提示", "删除失败", "warning");
                            }

                        });

                    }

                });


            }
        }
        //打开分配管理员的模态窗口
        function OpenSetAdminDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行！！", "warning");
            }
            else {
                if (row.S_IsHasSetAdmin) {
                    $.messager.alert("提示", "该店铺已分配管理员，请重新选择店铺！！", "warning");
                }
                else {
                    $("#form2")[0].reset();
                    $("#dlg2").dialog({ title: "分配管理员" }).dialog("open").dialog("center");
                    var id = row.S_ID;
                    $("#btnSetAdmin").click(function () {
                        $.ajax({
                            type: "get",
                            url: "/Handlers/ShopsHandler.ashx",
                            data: {
                                Method: "SetShopsAdmin",
                                S_ID: id,
                                U_LoginName: $("#txtUserName").val().trim()
                            },
                            success: function (data) {
                                if (data == 1) {
                                    $("#dg").datagrid("reload");
                                    $("#dlg2").dialog("close");
                                    $.messager.alert("提示", "分配成功", "info");
                                }
                                else {
                                    $.messager.alert("提示", "分配失败", "warning");
                                }

                            }

                        });
                    });

                }
            }
        }

    </script>

</head>
<body>
    <div id="tb" style="padding: 2px 5px;">
        <div style="padding: 5px 0;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="OpenInsertDialog()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="OpenUpdateDialog()">修改</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="DeleteShop()">删除</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="OpenSetAdminDialog()">分配管理员</a>
        </div>
        店铺名称：<input id="txtS_Name" type="text" />
        联系人：<input id="txtS_ContactName" type="text" />
        店铺地址：<input id="txtS_Address" type="text" />
        <a id="btnSearch" href="#" class="easyui-linkbutton" iconcls="icon-search">查询</a>
    </div>
    <table id="dg"></table>

    <!--模态窗体-->
    <div id="dlg" class="easyui-dialog" title="Complex Toolbar on Dialog" style="width: 400px; height: 250px; padding: 10px"
        data-options="iconCls: 'icon-save',toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true,modal:true">
        <form id="form1">
            <table align="center">
                <tr>
                    <td>店铺名称：
                    </td>
                    <td>
                        <input id="txtSName" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>店铺类别：
                    </td>
                    <td>
                        <select id="ddlS_Category" name="D1">
                            <option value="0">--请选择--</option>
                            <option value="1">总部</option>
                            <option value="2">加盟店</option>
                            <option value="3">自营店</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>联系人：
                    </td>
                    <td>
                        <input id="txtContactName" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>联系电话：
                    </td>
                    <td>
                        <input id="txtTel" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>店铺地址：
                    </td>
                    <td>
                        <input id="txtAddress" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>备注：
                    </td>
                    <td>
                        <input id="txtRemark" type="text" />
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div id="dlg-buttons">

        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
        <a id="btnInsert" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">添加</a>
        <a id="btnUpdate" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">修改</a>
        <input id="hiddenID" type="hidden" />
    </div>


    <div id="dlg2" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 400px; height: 200px; padding: 10px">
        <form id="form2">
            <table align="center">
                <tr>
                    <td>用户名：
                    </td>
                    <td>
                        <input id="txtUserName" type="text" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input id="btnSetAdmin" type="button" value="分配店长的账号" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <span style="color: #ff0000">账号的默认密码为:123456</span>
                    </td>

                </tr>
            </table>
        </form>
    </div>
</body>
</html>
