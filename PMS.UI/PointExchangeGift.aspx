<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PointExchangeGift.aspx.cs" Inherits="PMS.UI.PointExchangeGift" %>

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
            //查找会员
            $("#btnSearch").click(function () {
                FingMen();

            });

            $('#dg').datagrid({
                url: '/Handlers/ExchangGiftsHandler.ashx',
                queryParams: {
                    Method: "GetExchangeGifts"
                },
                pagination: true,
                striped: true,
                singleSelect: true,
                columns: [[
                    { field: 'ck', checkbox: true },
                    { field: 'EG_ID', title: '礼品编号', width: 100, align: 'center' },
                    { field: 'EG_GiftCode', title: '礼品代号', width: 100, align: 'center' },
                    { field: 'EG_GiftName', title: '礼品名称', width: 100, align: 'center' },
                    { field: 'EG_Point', title: '所需积分', width: 100, align: 'center' },
                    { field: 'EG_Number', title: '礼品数量', width: 100, align: 'center' },
                    { field: 'EG_ExchangNum', title: '已兑换数量', width: 100, align: 'center' },
                    { field: 'EG_Remark', title: '备注', width: 100, align: 'center' },
                    {
                        field: 'ExchangNum', title: '兑换数量', width: 100, align: 'center',
                        formatter: function (value) {
                            return '<input id="txtExchangeNum" type="text" size="5" />'
                        }
                    }
                ]]
            });


            //马上兑换
            $("#btnExchange").click(function () {
                PointExchange();

            });

        });

        //查找会员的方法
        function FingMen() {
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "FingMen",
                    MC_CardID: $("#txtCardTel").val().trim(),
                    r: Math.random()
                },
                success: function (data) {
                    $.each(data, function (index, o) {

                        $("#lblName").text(o.MC_Name);
                        $("#lblCardLevel").text(o.CL_LevelName);
                        $("#lblPoint").text(o.MC_Point);
                        if (o.MC_TotalMoney != null) {
                            $("#lblTotalMoney").text(o.MC_TotalMoney);
                        }
                        $("#HidMC_ID").val(o.MC_ID);
                        $("#HidMC_Point").val(o.MC_Point);
                        $("#HidMC_CardID").val(o.MC_CardID);

                    });
                }
            });
        }

        //兑换礼品方法
        function PointExchange() {
            $(".datagrid-btable tr").each(function (index, element) {
                var exNum = $(element).find("td input[type='text']").val();
                if (exNum != "") {
                    var id = $(element).find("td:eq(1) div").text();
                    var giftCode = $(element).find("td:eq(2) div").text();
                    var giftName = $(element).find("td:eq(3) div").text();
                    var eg_Point = $(element).find("td:eq(4) div").text();
                    var TotalNumber = $(element).find("td:eq(5) div").text();
                    var egExchangNum = $(element).find("td:eq(6) div").text();
                    var el_Point = eg_Point * exNum;
                    var egNumber = Number(TotalNumber) - Number(exNum);
                    var ExchangNum =Number(egExchangNum) + Number(exNum);
                    var mc_Point = $("#HidMC_Point").val();
                    mc_Point = mc_Point - el_Point;
                    $.ajax({
                        type: "get",
                        url: "/Handlers/ExchangLogsHandler.ashx",
                        data: {
                            Method: "PointExchange",
                            MC_ID: $("#HidMC_ID").val(),
                            MC_CardID: $("#HidMC_CardID").val(),
                            MC_Name: $("#lblName").text(),
                            EG_ID: id,
                            EG_GiftCode: giftCode,
                            EG_GiftName: giftName,
                            EL_Point: el_Point,
                            MC_Point: mc_Point,
                            EG_Number: egNumber,
                            EG_ExchangNum: egExchangNum,
                            EL_Number: exNum
                        },
                        success: function (data) {
                            if (data == 1) {
                                $("#dg").datagrid("reload");
                                $.messager.alert("提示", "兑换成功", "info");
                                $("#txtCardTel").val("");
                                $("#lblName").text("");
                                $("#lblCardLevel").text("");
                                $("#lblPoint").text("");
                                $("#lblTotalMoney").text("");
                            }
                            else {
                                $.messager.alert("提示", "兑换失败", "warning");
                            }
                        }
                    });

                }
               

            });
           
        }
    </script>
</head>
<body>
    <fieldset style="margin-bottom: 10px">
        <legend>
            <h2>查找会员</h2>
        </legend>
        <table style="line-height: 25px">
            <tr>
                <td>卡号/手机：
                </td>
                <td>
                    <input id="txtCardTel" type="text" />
                    <input id="btnSearch" type="button" value="查找" />
                </td>

            </tr>
            <tr>
                <td>会员姓名：
                </td>
                <td>
                    <label id="lblName"></label>
                </td>
                <td>当前等级：
                </td>
                <td>
                    <label id="lblCardLevel"></label>

                </td>
            </tr>
            <tr>
                <td>当前积分：
                </td>
                <td>
                    <label id="lblPoint"></label>
                </td>
                <td>累计消费：
                </td>
                <td>￥<label id="lblTotalMoney"></label>
                </td>
            </tr>
        </table>
    </fieldset>
    <table id="dg"></table>
    <br />
    <label style="color: red">双击"兑换数量"的单元格可以修改兑换数量</label><br />
    <label style="color: red">如果还未设置礼品,请点击<a style="color: #18b2b2">[礼品管理]</a></label><br />
    <input id="btnExchange" type="button" value="马上兑换" />
    <input id="HidMC_ID" type="hidden" />
    <input id="HidMC_CardID" type="hidden" />
    <input id="HidMC_Name" type="hidden" />
    <input id="HidMC_Point" type="hidden" />
</body>
</html>
