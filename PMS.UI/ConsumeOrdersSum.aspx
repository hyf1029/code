<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsumeOrdersSum.aspx.cs" Inherits="PMS.UI.ConsumeOrdersSum" %>

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

            $('#dg1').datagrid({
                url: '/Handlers/MemCardsHandler.ashx',
                queryParams: {
                    Method: "SearchMenCardByS_ID"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                onLoadSuccess: Sum,
                onClickRow:aa,
                columns: [[
                    { field: 'MC_CardID', title: '会员卡号', width: 100, align: 'center' },
                    { field: 'MC_Name', title: '会员姓名', width: 100, align: 'center' },
                    { field: 'MC_TotalMoney', title: '累计消费', width: 100, align: 'center' }

                ]]
            });
            
    

            $('#dg2').datagrid({
                url: '/Handlers/ConsumeOrdersHandler.ashx',
                queryParams: {
                    Method: "GetPageConsumeOrdersSumByCondition"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                onLoadSuccess:Sum2,
                columns: [[
                    { field: 'CO_OrderCode', title: '订单号', width: 110, align: 'center' },
                    { field: 'MC_CardID', title: '会员卡号', width: 100, align: 'center' },
                    { field: 'MC_Name', title: '会员姓名', width: 100, align: 'center' },
                    { field: 'CO_DiscountMoney', title: '消费金额', width: 100, align: 'center' },
                     { field: 'CO_GavePoint', title: '获得积分', width: 100, align: 'center' },
                    { field: 'CO_CreateTime', title: '消费时间', width: 120, align: 'center' },

                    {
                        field: 'CO_OrderType', title: '类型', width: 100, align: 'center',
                        formatter: function (value) {
                            if (value == '1') {
                                return '兑换积分';
                            } else if (value == '2') {
                                return '积分返现';
                            }
                            else if (value == '3') {
                                return '减积分';
                            }
                            else if (value == '4') {
                                return '转介绍积分';
                            }
                            else if (value == '5') {
                                return '快速消费';
                            }
                        }
                    }

                ]]
            });

            //查询
            $("#btnSearch").click(function () {
                $('#dg2').datagrid('load', {
                    Method: "GetPageConsumeOrdersSumByCondition",
                    Begindate: $("#BeginDate").datebox('getValue'),
                    Enddate: $("#EndDate").datebox('getValue'),
                    MC_CardTel: $("#txtCardID").val(),
                    CO_OrderType: $("#ddlOrderType").val()
                });


            });


        });

        function Sum() {
            var rows = $("#dg1").datagrid("getRows");
            var TotalMoney = 0;
            for (var i = 0; i < rows.length; i++) {
                TotalMoney += rows[i]["MC_TotalMoney"];
            }
            $("#lblTotalMoney").text("总金额合计：￥" + TotalMoney);
        }

        function Sum2() {
            var rows = $("#dg2").datagrid("getRows");
            var TotalMoney = 0;
            var Point = 0;
            for (var i = 0; i < rows.length; i++) {
                TotalMoney += rows[i]["CO_DiscountMoney"];
                Point += rows[i]["CO_GavePoint"];
            }
            $("#lblTotalMoney2").text("总金额合计：￥" + TotalMoney);
            $("#lblGavePoint").text("总积分合计：￥" + Point);
        }

        function aa()
        {
            var rows = $("#dg1").datagrid("getSelected");
            $('#dg2').datagrid('load', {
                Method: "GetPageConsumeOrdersSumByCondition",
                MC_CardTel: rows.MC_CardID
               
            });
        }
    </script>
</head>
<body>
    <fieldset>
        <legend>查询</legend>
        <table>
            <tr>
                <td>消费日期：
                    <input id="BeginDate" type="text" class="easyui-datebox" required="required" style="width: 100px"></input>
                    <input id="BeginTime" type="text" style="width: 100px" value="00:00:00" disabled="disabled" />
                     至
                    <input id="EndDate" type="text" class="easyui-datebox" required="required" style="width: 100px"></input>
                    <input id="EndTime" type="text" style="width: 100px" value="23:59:59" disabled="disabled" />
                </td>
                <td>卡号/手机：
                    <input id="txtCardID" type="text" style="width: 100px" />
                </td>
                <td>消费类型：
                    <select id="ddlOrderType">
                        <option value="0">不限消费类型</option>
                        <option value="1">兑换积分</option>
                        <option value="2">积分返现</option>
                        <option value="3">减积分</option>
                        <option value="4">转介绍积分</option>
                        <option value="5">快速消费</option>
                    </select>
                </td>
                <td>
                    <input id="btnSearch" type="button" value="查询" />
                </td>
            </tr>
        </table>
    </fieldset>
    <table id="dg1"></table>
    <label id="lblTotalMoney" style="color: red; font-weight: bold;"></label>
    <table id="dg2"></table>
    <label id="lblTotalMoney2" style="color: red; font-weight: bold;"></label>
    <label id="lblGavePoint" style="color: red; font-weight: bold;"></label>
</body>
</html>
