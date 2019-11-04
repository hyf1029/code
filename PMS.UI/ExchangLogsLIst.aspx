<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExchangLogsLIst.aspx.cs" Inherits="PMS.UI.ExchangLogsLIst" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
     <link href="jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
    <link href="jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.5/jquery.min.js"></script>
    <script src="jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#dg').datagrid({
                url: '/Handlers/ExchangLogsHandler.ashx',
                queryParams: {
                    Method: "GetPageExchangLogsByCondition"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'EG_GiftName', title: '礼品名称', width: 100, align: 'center' },
                    { field: 'EG_Point', title: '所需积分', width: 100, align: 'center' },
                    { field: 'EL_Number', title: '兑换数量', width: 100, align: 'center' },
                    { field: 'EL_CreateTime', title: '兑换时间', width: 200, align: 'center' }
                    
                ]]
            });

            //查询
            $("#btnSearch").click(function () {
                $('#dg').datagrid('load', {
                    Method: "GetPageExchangLogsByCondition",
                    CardTel: $("#txtCardTel").val().trim()
                  
                });


            });

        });
</script>
</head>
<body>
    <fieldset>
        <legend>
            <h2>查找会员</h2>
        </legend>
        <table style="line-height: 25px">
            <tr>
                <td>卡号/手机：
                </td>
                <td>
                    <input id="txtCardTel" type="text" />
                    <input id="btnSearch" type="button" value="查找"/>
                </td>
               
            </tr>
        </table>
    </fieldset>

     <fieldset style="margin-top:10px; height:500px;" >
        <legend>
            <h2>兑换记录列表</h2>
        </legend>
        <table id="dg" style="white-space:pre"></table>
    </fieldset>
    
</body>
</html>
