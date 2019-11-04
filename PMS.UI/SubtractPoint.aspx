<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubtractPoint.aspx.cs" Inherits="PMS.UI.SubtractPoint" %>

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
            //查询
            $("#btnSearch").click(function () {
               
                FingMen();

            });

            //马上扣除积分
            $("#btnJian").click(function () {
               
                JianPoint();
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

        //减积分的方法
        function JianPoint()
        {

            var mcPoint = Number($("#lblPoint").text());
            var jianPoint = Number($("#txtJianPoint").val());
            if (jianPoint > mcPoint)
            {
                $.messager.alert("提示", "积分不足,无法扣除", "warning");
                $("#txtJianPoint").val("");
                return;
            }
            $("#HidMC_Point").val(mcPoint - jianPoint);

            $.ajax({
                type:"get",
                url: "/Handlers/MemCardsHandler.ashx",
                data: {
                    Method: "JianPoint",
                    MC_CardID: $("#HidMC_CardID").val().trim(),
                    MC_ID: $("#HidMC_ID").val(),
                    CO_GavePoint: $("#txtJianPoint").val().trim(),
                    CO_Remark:$("#txtRemark").val().trim(),
                    MC_Point: $("#HidMC_Point").val()
                   
                },
                success: function (data) {
                    if(data=="1")
                    {
                        $.messager.alert("提示", "会员减积分成功", "info");
                        $("#txtCardTel").val("");
                        $("#lblName").text("");
                        $("#lblCardLevel").text("");
                        $("#lblPoint").text("");
                        $("#lblTotalMoney").text("");
                        $("#txtJianPoint").val("");
                        $("#txtRemark").val("");
                    }
                    else
                    {
                        $.messager.alert("提示", "会员减积分失败", "warning");
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
                    <input id="btnSearch" type="button" value="查找"/>
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

     <fieldset style="margin-top:10px;margin-bottom:10px;">
        <legend>
            <h2>减积分信息</h2>
        </legend>
        <table style="line-height: 25px">
            <tr>
                <td>扣除积分：
                </td>
                <td>
                    <input id="txtJianPoint" type="text" />
                   
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
    </fieldset>
    <br />
    <input id="btnJian" type="button" value="马上扣除" />
     <input id="HidMC_CardID" type="hidden" />
     <input id="HidMC_ID" type="hidden" />
     <input id="HidMC_Point" type="hidden" />
</body>
</html>
