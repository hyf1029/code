<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PointRecash.aspx.cs" Inherits="PMS.UI.PointRecash" %>

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
            var date = new Date;
            var year = date.getFullYear();
            var month = date.getMonth(); 
            var day = date.getDate(); 
            $("#txtDate").val(year + "-" + month + "-" + day);

            $("#txtExchangPoint").keyup(function () {
                var txtExchangPoint = Number($("#txtExchangPoint").val());
                var HidCL_Percent = Number($("#HidCL_Percent").val()); 
                var lblPoint = Number($("#lblPoint").text());
                if (txtExchangPoint != "")
                {
                    $("#txtCash").val(txtExchangPoint / 10);
                    $("#txtLastPoint").val(lblPoint - txtExchangPoint);
                }
                else
                {
                    $("#txtCash").val("");
                    $("#txtLastPoint").val("");
                }
               
              
            });

            //马上返现
            $("#btnCash").click(function () {

                PointCash();
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
                    r:Math.random()

                },
                success: function (data) {
                    $.each(data, function (index, o) {

                        $("#lblName").text(o.MC_Name);
                        $("#lblCardLevel").text(o.CL_LevelName + "  "+("折扣比例："+o.CL_Percent));
                        $("#lblPoint").text(o.MC_Point);
                        if (o.MC_TotalMoney != null) {
                            $("#lblTotalMoney").text(o.MC_TotalMoney);
                        }
                        $("#HidMC_ID").val(o.MC_ID);
                        $("#HidMC_Point").val(o.MC_Point);
                        $("#HidMC_CardID").val(o.MC_CardID);
                        $("#HidCL_Percent").val(o.CL_Percent);
                    });
                }
            });
        }

        //积分返现的方法
        function PointCash() {
            var txtExchangPoint = Number($("#txtExchangPoint").val());
            var lblPoint = Number($("#lblPoint").text());
            if (txtExchangPoint > lblPoint)
            {
                $.messager.alert("提示", "积分不足,无法返现", "warning");
                $("#txtExchangPoint").val("");
                $("#txtCash").val("");
                $("#txtLastPoint").val("");
                return;
            }
            $.ajax({
                type: "get",
                url: "/Handlers/ConsumeOrdersHandler.ashx",
                data: {
                    Method: "PointCash",
                    MC_CardID: $("#HidMC_CardID").val().trim(),
                    MC_ID: $("#HidMC_ID").val(),
                    CO_GavePoint: $("#txtExchangPoint").val().trim(),
                    CO_Recash: $("#txtCash").val().trim(),
                    MC_Point: $("#txtLastPoint").val().trim(),
                    r:Math.random()

                },
                success: function (data) {
                    if (data == "1") {
                        $.messager.alert("提示", "积分返现成功", "info");
                        $("#txtCardTel").val("");
                        $("#lblName").text("");
                        $("#lblCardLevel").text("");
                        $("#lblPoint").text("");
                        $("#lblTotalMoney").text("");
                        $("#txtExchangPoint").val("");
                        $("#txtCash").val("");
                        $("#txtLastPoint").val("");
                    }
                    else {
                        $.messager.alert("提示", "积分返现失败", "warning");
                    }

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
    <fieldset style="margin-bottom: 10px">
        <legend>
            <h2>积分返现</h2>
        </legend>
        <table style="line-height: 25px">
            <tr>
                <td>兑换日期：
                </td>
                <td>
                    <input id="txtDate" type="text" />
                </td>

            </tr>
            <tr>
                <td>兑换积分：
                </td>
                <td>
                    <input id="txtExchangPoint" type="text" />
                </td>
                <td>积分返现：
                </td>
                <td>
                    <input id="txtCash" type="text" />
                </td>
            </tr>
            <tr>
                <td>剩余积分：
                </td>
                <td>
                    <input id="txtLastPoint" type="text" />
                </td>
               
            </tr>
        </table>
    </fieldset>
    <fieldset style="margin-bottom: 10px">
        <legend>
            <h2>说明</h2>
        </legend>
        操作过程中,只需输入操作的会员卡号/手机号查询对应会员，再输入兑换积分，系统将自动计算.<br />
        在"管理"-"其他设置"可以设置会员积分返现的兑换比例.
    </fieldset>
    <input id="btnCash" type="button" value="马上返现" />
     <input id="HidMC_ID" type="hidden" />
    <input id="HidMC_CardID" type="hidden" />
    <input id="HidCL_Percent" type="hidden" />
</body>
</html>
