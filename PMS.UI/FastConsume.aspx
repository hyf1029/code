<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FastConsume.aspx.cs" Inherits="PMS.UI.FastConsume" %>

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


            $("#txtMoney2").keyup(function () {
                var CL_Point = Number($("#HidCL_Point").val());
                var CL_Percent = Number($("#HidCL_Percent").val());
                var totalMoney = Number($("#txtMoney2").val());
                if (totalMoney != "") {
                    var money = totalMoney * CL_Percent;
                    $("#txtPercentMoney").val(money);
                    var txtPercentMoney = Number($("#txtPercentMoney").val());
                    $("#txtPoint2").val(txtPercentMoney * CL_Point);
                    var coTotalMoney = Number($("#lblTotalMoney").text());
                    $("#HidTotalMoney").val(txtPercentMoney + coTotalMoney);
                    var MCPoint = Number($("#lblPoint").text());
                    var COPoint = Number($("#txtPoint2").val());
                    $("#HidMC_Point").val(MCPoint + COPoint);

                } else {
                    $("#txtPercentMoney").val("");
                    $("#txtPoint2").val("");
                }


            });

            //马上结算
            $("#btnMoney").click(function () {


                var s = Number($("#HidMC_TotalCount").val());
                s++;
                $("#HidMC_TotalCount").val(s);//消费的次数

                FastConsume();

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
                            $("#lblConsumeDate").text(o.MC_CreateTime);
                            $("#lblCardLevel").text(o.CL_LevelName);
                            $("#lblPoint").text(o.MC_Point);
                            if (o.MC_TotalMoney != null)
                            {
                                $("#lblTotalMoney").text(o.MC_TotalMoney);
                            }
                           
                            $("#HidCL_Percent").val(o.CL_Percent);
                            $("#HidCL_Point").val(o.CL_Point);
                            $("#HidMC_ID").val(o.MC_ID);
                            $("#HidMC_Point").val(o.MC_Point);
                            if (o.MC_TotalCount != null)
                            {
                                $("#HidMC_TotalCount").val(o.MC_TotalCount);
                            }
                            $("#HidMC_CardID").val(o.MC_CardID);
                        });
                 
                   

                }
            });
        }


        //马上结算的方法
        function FastConsume() {
            $.ajax({
                type: "get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "FastConsume",
                    MC_CardID: $("#HidMC_CardID").val(),
                    MC_ID: $("#HidMC_ID").val(),
                    CO_TotalMoney: $("#HidTotalMoney").val(),
                    CO_DiscountMoney: $("#txtPercentMoney").val().trim(),
                    CO_GavePoint: $("#txtPoint2").val().trim(),
                    MC_Point: $("#HidMC_Point").val(),
                    MC_TotalCount: $("#HidMC_TotalCount").val()
                },
                success: function (data) {
                    if (data == 1) {
                        $.messager.alert("提示", "结算成功", "info");
                        $("#txtCardTel").val("");
                        $("#lblName").text("");
                        $("#lblCardLevel").text("");
                        $("#lblPoint").text("");
                        $("#lblTotalMoney").text("");
                        $("#txtMoney2").val("");
                        $("#txtPercentMoney").val("");
                        $("#txtPoint2").val("");
                    }
                    else {
                        $.messager.alert("提示", "结算失败", "warning");
                    }

                }
            });
        }

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

                    <input id="btnSearch" type="button" value="查找" />
                </td>
                <td>消费时间：
                </td>
                <td>
                    <label id="lblConsumeDate"></label>
                </td>
            </tr>
            <tr>
                <td>姓名：
                </td>
                <td>
                    <label id="lblName"></label>
                </td>
                <td>等级：
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
    <fieldset style="margin-top: 10px;margin-bottom:10px;">
        <legend></legend>
        <span style="color: red">暂无优惠活动</span>
    </fieldset>
    <table style="line-height: 27px">
        <tr>
            <td>请输入消费金额：</td>
            <td>
                <input id="txtMoney2" type="text" />
            </td>
            <td colspan="2">此处输入金额会按会员等级自动打折</td>
        </tr>
        <tr>
            <td>折后总金额：</td>
            <td>
                <input id="txtPercentMoney" type="text" />
            </td>
            <td colspan="2">可自动累计积分数量：<input id="txtPoint2" type="text" /></td>
        </tr>
        <tr>
            <td>付款方式：</td>
            <td>
                <input id="rdMoney" type="radio" checked="checked" />现金支付</td>
            <td colspan="2">优惠活动：<span style="color: red">暂无</span></td>
        </tr>
    </table>
    <fieldset style="margin-top: 10px">
        <legend>
            <h2>说明</h2>
        </legend>
        <table style="line-height: 27px">
            <tr>
                <td>输入实际的消费金额，系统会自动按照会员等级中的设置按照一定比例计算积分并累计到会员账户</td>
            </tr>
            <tr>
                <td>在"系统管理"-"会员等级管理"中可设置RMB和会员积分的兑换比例</td>
            </tr>
            <tr>
                <td>在"系统管理"-"会员等级管理"中可设置是否允许直接输入折后总金额</td>
            </tr>
            <tr>
                <td>在"系统管理"-"会员等级管理"中可设置是否允许直接输入累计积分数量</td>
            </tr>

        </table>


    </fieldset>
    <br />
    <br />
    <input id="btnMoney" type="button" value="马上结算"  />

    <input id="HidCL_Percent" type="hidden" />
    <input id="HidCL_Point" type="hidden" />
    <input id="HidMC_ID" type="hidden" />
     <input id="HidMC_CardID" type="hidden" />
    <input id="HidTotalMoney" type="hidden" />
    <input id="HidMC_Point" type="hidden" />
    <input id="HidMC_TotalCount" type="hidden" />



</body>
</html>
