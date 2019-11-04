<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExchangLogsSum.aspx.cs" Inherits="PMS.UI.ExchangLogsSum" %>

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
                url: '/Handlers/ConsumeOrdersHandler.ashx',
                queryParams: {
                    Method: "GetPageExchangLogsSumByCondition"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                columns: [[

                    { field: 'MC_CardID', title: '会员卡号', width: 100, align: 'center' },
                    { field: 'MC_Name', title: '会员名称', width: 100, align: 'center' },
                      { field: 'EG_ID', title: '礼品编号', width: 120, align: 'center' },
                     { field: 'EG_GiftName', title: '礼品名称', width: 200, align: 'center' },
                     { field: 'EG_Point', title: '所需积分', width: 120, align: 'center' },
                    { field: 'EL_Number', title: '数量', width: 100, align: 'center' },
                     { field: 'EL_CreateTime', title: '兑换时间', width: 100, align: 'center' }


                ]]
            });

            //查询
            $("#btnSearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageExchangLogsSumByCondition",
                    Begindate: $("#BeginDate").datebox('getValue'),
                    Enddate: $("#EndDate").datebox('getValue'),
                    MC_CardTel: $("#txtCardID").val()

                });

            });

        });


    </script>
</head>
<body>
    <fieldset>
        <legend>查询</legend>
        <table>
            <tr>
                <td>卡号/手机：<input id="txtCardID" type="text" />

                </td>
                <td>兑换日期：<input id="BeginDate" type="text" class="easyui-datebox" required="required"></input>

                    至
                    <input id="EndDate" type="text" class="easyui-datebox" required="required"></input>


                    <input id="btnSearch" type="button" value="查询" />
                </td>
            </tr>

        </table>
    </fieldset>
    <table id="dg"></table>
</body>
</html>
