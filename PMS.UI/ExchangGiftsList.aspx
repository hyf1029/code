<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExchangGiftsList.aspx.cs" Inherits="PMS.UI.ExchangGiftsList" %>

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
        //文档就绪函数
        $(function () {

            $('#dg').datagrid({
                url: '/Handlers/ExchangGiftsHandler.ashx',
                queryParams: {
                    Method: "GetPageExchangeGiftsByCondition"
                },
                toolbar: "#tb",
                pagination: true,
                fit: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'EG_ID', title: '礼品编号', width: 100, align: 'center' },
                    { field: 'EG_GiftCode', title: '礼品编码', width: 100, align: 'center' },
                    { field: 'EG_GiftName', title: '礼品名称', width: 100, align: 'center' },
                    { field: 'EG_Point', title: '所需积分', width: 100, align: 'center' },
                    { field: 'EG_Number', title: '总数量', width: 100, align: 'center' },
                    { field: 'EG_ExchangNum', title: '已兑换数量', width: 100, align: 'center' }
                ]]
            });

            //查询
            $("#btnsearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageExchangeGiftsByCondition",
                    EG_GiftCode: $("#txtEcode").val().trim(),
                    EG_GiftName: $("#txtGiftName").val().trim()
                });


            });

            //实现新增礼品功能
            $("#btnInsert").click(function () {
                InsertGift();
            });

            //实现修改礼品功能
            $("#btnUpdate").click(function () {
                UpdteGift();
            });

        });

        //打开新增礼品的模态窗体
        function OpenInsertDialog() {
            $("#dlg").dialog({ title: "新增礼品" }).dialog("open").dialog("center");
            $("#form1")[0].reset();
            $("#btnInsert").show();
            $("#btnUpdate").hide();
            
        }

        //实现新增礼品的方法
        function InsertGift() {
            $.ajax({
                type: "get",
                url: "/Handlers/ExchangGiftsHandler.ashx",
                data: {
                    Method: "InsertGift",
                    EG_GiftCode: $("#txtCode").val().trim(),
                    EG_GiftName: $("#txtName").val().trim(),
                    EG_Photo: $("#txtPhoto").val().trim(),
                    EG_Point: $("#txtPoint").val().trim(),
                    EG_Number: $("#txtGiftCount").val().trim(),
                    EG_Remark: $("#txtRemark").val().trim()
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

        //打开修改礼品的模态窗体
        function OpenUpdateDialog() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选中需要操作的行！！", "warning");
            }
            else {
                var id = row.EG_ID;
                $("#form1")[0].reset();
                $("#btnInsert").hide();
                $("#btnUpdate").show();
                $("#dlg").dialog({ title: "修改礼品" }).dialog("open").dialog("center");

                $.ajax({
                    type: "post",
                    url: "/Handlers/ExchangGiftsHandler.ashx",
                    data: {
                        Method: "GetSingleGift",
                        EG_ID: id
                    },
                    dataType: "json",
                    success: function (data) {
                        $("#txtCode").val(data.EG_GiftCode);
                        $("#txtName").val(data.EG_GiftName);
                        $("#txtPhoto").val(data.EG_Photo);
                        $("#txtPoint").val(data.EG_Point);
                        $("#txtGiftCount").val(data.EG_Number);
                        $("#txtRemark").val(data.EG_Remark);
                        $("#HidID").val(data.EG_ID);
                        //alert(data)
                    }
                });

            }


        }

        //实现修改礼品的方法
        function UpdteGift() {
            $.ajax({
                type: "get",
                url: "/Handlers/ExchangGiftsHandler.ashx",
                data: {
                    Method: "UpdateGift",
                    EG_GiftCode: $("#txtCode").val().trim(),
                    EG_GiftName: $("#txtName").val().trim(),
                    EG_Photo: $("#txtPhoto").val().trim(),
                    EG_Point: $("#txtPoint").val().trim(),
                    EG_Number: $("#txtGiftCount").val().trim(),
                    EG_Remark: $("#txtRemark").val().trim(),
                    EG_ID: $("#HidID").val()
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

        //实现删除功能
        function DeleteGift() {
            var row = $("#dg").datagrid("getSelected");
            if (row == null) {
                $.messager.alert("提示", "请选择要操作的行！！", "warning");
            }
            else {
                $.messager.confirm('确认对话框', '你确定要删除吗？', function (r) {
                    if (r == true) {
                        var id = row.EG_ID;
                        $.post("/Handlers/ExchangGiftsHandler.ashx", {
                            Method: "DeleteGift",
                            EG_ID: id
                        }, function (data) {
                            if (data == "1") {
                                $("#dg").datagrid("reload");
                                $("#dlg").dialog("close");
                                $.messager.alert("提示", "删除成功", "info");
                            }
                            else {
                                $.messager.alert("提示", "删除成功", "warning");
                            }

                        });

                    }

                });


            }
        }


    </script>
</head>
<body>
    <div id="tb" style="padding: 2px 5px;">
        <div style="padding: 5px 0;">
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="OpenInsertDialog()">新增</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="OpenUpdateDialog()">修改</a>
            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="DeleteGift()">删除</a>
        </div>
        礼品编码：<input id="txtEcode" type="text" />
        礼品名称：<input id="txtGiftName" type="text" />
        <a id="btnsearch" href="#" class="easyui-linkbutton" iconcls="icon-search">查询</a>
    </div>
    <table id="dg"></table>

    <!--模态窗体-->
    <div id="dlg" class="easyui-dialog" title="Complex Toolbar on Dialog" style="width: 400px; height: 250px; padding: 10px"
        data-options="iconCls: 'icon-save',toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true,modal:true">
        <form id="form1" runat="server">
            <table align="center">
                <tr>
                    <td>礼品代号：</td>
                    <td>
                        <input id="txtCode" type="text" /></td>
                </tr>
                <tr>
                    <td>礼品名称：</td>
                    <td>
                        <input id="txtName" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>礼品图片：</td>
                    <td>
                        <input id="txtPhoto" type="text" /></td>
                </tr>
                <tr>
                    <td>所需积分：</td>
                    <td>
                        <input id="txtPoint" type="text" /></td>
                </tr>
                <tr>
                    <td>礼品数量：</td>
                    <td>
                        <input id="txtGiftCount" type="text" />

                    </td>
                </tr>
                <tr>
                    <td>备注：</td>
                    <td>
                        <input id="txtRemark" type="text" /></td>
                </tr>
            </table>
        </form>
    </div>
    <div id="dlg-buttons">

        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
        <a id="btnInsert" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">添加</a>
        <a id="btnUpdate" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">修改</a>
        <input id="HidID" type="hidden" />
    </div>

</body>
</html>
