<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FastComsumeSum.aspx.cs" Inherits="PMS.UI.FastComsumeSum" %>

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
            GetAllCardName();

            $('#dg').datagrid({
                url: '/Handlers/ConsumeOrdersHandler.ashx',
                queryParams: {
                    Method: "GetPageFastComsumeSumByCondition"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'CO_OrderCode', title: '订单号', width: 120, align: 'center' },
                    { field: 'MC_CardID', title: '会员卡号', width: 100, align: 'center' },
                    { field: 'MC_Name', title: '会员姓名', width: 100, align: 'center' },
                     { field: 'CO_DiscountMoney', title: '消费金额', width: 200, align: 'center' },
                    { field: 'CO_GavePoint', title: '获得积分', width: 100, align: 'center' },
                    { field: 'CO_CreateTime', title: '消费时间', width: 120, align: 'center' }


                ]]
            });

            //查询
            $("#btnSearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageFastComsumeSumByCondition",
                    Begindate: $("#BeginDate").datebox('getValue'),
                    Enddate: $("#EndDate").datebox('getValue'),
                    MC_CardTel: $("#txtCardID").val(),
                    CL_ID: $("#ddlCardLevel").val(),
                    Fuhao: $("#ddlFuhao").val(),
                    CO_GavePoint: $("#txtGavePoint").val(),
                    CO_OrderCode: $("#txtOrderCode").val()

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
                    $("#ddlCardLevel").append(s);
                }

            });


        }

    </script>
</head>
<body>
    <fieldset>
        <legend>查询</legend>
        <table id="tblQuery">
            <tr>
                <td>消费日期：<input id="BeginDate" type="text" class="easyui-datebox" required="required"></input>
                    <input id="BeginTime" type="text" style="width: 100px" value="00:00:00" disabled="disabled" />
                    &nbsp;&nbsp;  至 &nbsp;&nbsp;<input id="EndDate" type="text" class="easyui-datebox" required="required"></input>
                    <input id="EndTime" type="text" style="width: 100px" value="23:59:59" disabled="disabled" />
                </td>
            </tr>
            <tr>
                <td>卡号/手机：<input id="txtCardID" type="text" />&nbsp;&nbsp;
                    按会员等级：<select id="ddlCardLevel">
                        <option value="0">--请选择--</option>
                    </select>
                    &nbsp;&nbsp;消费金额：<select id="ddlFuhao">
                        <option value="">--请选择--</option>
                        <option value=">=">>=</option>
                        <option value="<="><=</option>
                        <option value="=">=</option>
                        <option value="<"><</option>
                        <option value=">">></option>
                    </select>
                    <input id="txtGavePoint" type="text" style="width: 100px" />
                </td>
                <td>
                    <input id="btnSearch" type="button" value="查询" />
                </td>
            </tr>
            <tr>
                <td>订单号：<input id="txtOrderCode" type="text" /></td>
            </tr>
        </table>
    </fieldset>
    <table id="dg"></table>
</body>
</html>

