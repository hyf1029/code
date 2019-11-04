<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="PMS.UI.Index" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>会员消费积分管理平台</title>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/index.css" rel="stylesheet" />
    <link href="jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
    <link href="jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
    <script src="jquery-easyui-1.5/jquery.min.js"></script>
    <script src="jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script src="jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(function () {
            //在前台自动显示菜单的信息根据用户的信息
            //BindMenuDataGroupType();
            //绑定菜单单击事件
            BindMenuClickHrefEvent();
            //读取动态时间的变化
            //ReadDateTimeShow();
            //这里实现对时间动态的变化
            //var setTimeInterval = setInterval(ReadDateTimeShow, 1000);
            //实现Tab布局
            $("#ttTab").tabs({});

            $(".CloseAll").click(function () {
                $("#ttTab li").each(function (index, obj) {
                    //获取所有可关闭的选项卡
                    var tab = $(".tabs-closable", this).text();
                    $(".easyui-tabs").tabs('close', tab);
                });
            });
            $(".ExchangePassword").click(function () {
                $("#dlg").dialog({ width: 300, height: 200 }).dialog("setTitle", "修改个人密码").dialog("open");
                $("#frm").attr("src", "/Login/ExchangPassword");
            });
            $(".ExchangeMessage").click(function () {
                $("#dlg").dialog({ width: 300, height: 200 }).dialog("setTitle", "修改个人资料").dialog("open");
                $("#frm").attr("src", "/Login/ExchangeMessage");
            });
            var b_c, c;
            $(".ul-menu li").hover(
                function () {
                    b_c = $(this).css("background-color");
                    $(this).css("background-color", "#34AFFF");
                    c = $(this).css("color");
                    $(this).css("color", "#ffffff");
                    $(this).css("cursor", "pointer");
                },
                function () {
                    $(this).css("background-color", b_c);
                    $(this).css("color", c);
                }
            );
            //修改个人信息
            $("#btnUpdateInfo").click(function () {

                UpdatePersonalInfo();
            });
            //修改密码
            $("#btnUpdatePwd").click(function () {

                var pwd = $("#txtPwd").val().trim();
                $.ajax({
                    type: "get",
                    url: "/Handlers/UsersHandler.ashx",
                    dataType: "json",
                    data: {
                        Method: "VilidatePwd",


                    },
                    success: function (data) {
                        var s = data.U_Password;
                        if (pwd == s) {
                            UpdatePersonalPwd();
                        }
                        else {
                            $.messager.alert("提示", "会员密码输入错误!!", "warning");
                        }
                    }
                });
            });
        });
        //绑定前台菜单栏
        function BindMenuDataGroupType() {
            //根据异步读取发送过来的Json字符串
            $.getJSON("/Home/LoadMenuData", {}, function (data) {
                //实现在菜单拦中的显示,遍历节点集合
                for (var i = 0; i < data.length; i++) {
                    var groupInfo = data[i]; //拿到组的信息

                    //拿到内容的信息,每个菜单项构造成一个p标签
                    var strMenuItemHTMl = "";
                    for (var j = 0; j < groupInfo.MenuItems.length; j++) {
                        var menuItem = groupInfo.MenuItems[j];
                        strMenuItemHTMl += '<p><a href="javascript:void(0)" src="' + menuItem.Url + '" class="menuLink">' + menuItem.MenuName + '</a></p>';
                    }
                    //EasyUI新增节点
                    $("#aa").accordion('add', {
                        title: groupInfo.GroupName,
                        content: strMenuItemHTMl,
                        selected: false
                    });
                    //$("#aa").accordion('select', groupInfo.GroupName);
                }
                //绑定用户单击跳转事件
                BindMenuClickHrefEvent();
            });
        }
        //实现用户单击导航栏跳转页面的方法
        function BindMenuClickHrefEvent() {
            $(".ul-menu li a").click(function () {
                //获取按钮里面的Src属性
                var src = $(this).attr("url");
                //将主框架的iframe跳转到菜单指向的地址，$("#frmWorkArea").attr("src", src);
                //Tab页面新增页面标签，每当单击左边的导航栏的时候跳转
                var titleShow = $(this).text();
                var strHtml = '<iframe id="frmWorkArea" width="100%" height="99%" frameborder="0" scrolling="no" src="' + src + '"></iframe>';
                //判断Tab标签中是否有相同的数据标签
                var isExist = $("#ttTab").tabs('exists', titleShow);
                if (!isExist) {
                    $("#ttTab").tabs('add', {
                        title: titleShow,
                        content: strHtml,
                        iconCls: 'icon-ok',
                        closable: true
                    });
                }
                else {
                    $('#ttTab').tabs('select', titleShow);
                }
            });
        }
        //读取动态时间的变化
        function ReadDateTimeShow() {
            var year = new Date().getFullYear();
            var Month = new Date().getMonth() + 1;
            var Day = new Date().getDate();
            var Time = new Date().toLocaleTimeString();
            var AddDate = year + "年" + Month + "月" + Day + "日 " + Time;
            $("#date").text(AddDate);
        }
        //打开修改个人资料的模态窗体
        function UpdateInfo() {
           
            $("#dlg5").dialog({ title: '修改个人资料' }).dialog("open").dialog("center");
            $.ajax({
                type: "get",
                url: "/Handlers/UsersHandler.ashx",
                dataType: "json",
                data: {
                    Method: "SearchPersonalInfo",
                    r: Math.random()
                },
                success: function (data) {
                    $("#txtU_LoginName").val(data.U_LoginName);

                    $("#txtU_RealName").val(data.U_RealName);
                    if (data.U_Sex == "男") {
                        $("#male").prop("checked", "checked");
                    }
                    else {
                        $("#female").prop("checked", "checked");
                    }
                    $("#txtU_Telephone").val(data.U_Telephone);

                }

            });
        }

        //修改个人资料的方法
        function UpdatePersonalInfo() {
            $.ajax({
                type: "get",
                url: "/Handlers/UsersHandler.ashx",
                data: {
                    Method: "UpdatePersonalInfo",
                    U_LoginName: $("#txtU_LoginName").val(),
                    U_RealName: $("#txtU_RealName").val().trim(),
                    U_Sex: $("#male").is(":checked") ? "男" : "女",
                    U_Telephone: $("#txtU_Telephone").val().trim(),
                    r:Math.random()
                },
                success: function (data) {
                    if (data == "1") {
                        $("#dlg5").dialog("close");
                        $.messager.alert("提示", "修改成功!!", "info");

                    }
                    else {
                        $.messager.alert("提示", "修改失败!!", "warning");
                    }
                }

            });
        }

        //打开修改个人密码的模态窗体
        function OpenPwdDialog() {
            $("#form6")[0].reset();
            $("#dlg6").dialog({ title: '修改个人密码' }).dialog("open").dialog("center");
        }

        //修改个人密码的方法
        function UpdatePersonalPwd() {
            var newPwd = $("#txtNewPwd").val();
            var rePwd = $("#txtRePwd").val();
            if (newPwd == "") {
                $.messager.alert("提示", "新密码不能为空!!", "error");
                return;
            }
            if (newPwd == "") {
                $.messager.alert("提示", "确认密码不能为空!!", "error");
                return;
            }
            if (newPwd != rePwd) {
                $.messager.alert("提示", "两次密码不一致,请重新输入!!", "error");
                return;
            }
            $.ajax({
                type: "get",
                url: "/Handlers/UsersHandler.ashx",
                data: {
                    Method: "UpdatePersonalPwd",
                    U_Password: $("#txtRePwd").val(),
                    r:Math.random()

                },
                success: function (data) {
                    if (data == "1") {
                        $("#dlg6").dialog("close");
                        $.messager.alert("提示", "修改成功!!", "info");

                    }
                    else {
                        $.messager.alert("提示", "修改失败!!", "warning");
                    }
                }

            });
        }

    </script>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
        <div data-options="region:'north',border:false" style="height: 60px; background: #2E70CC; padding: 10px; color: #ffffff">
            <div style="float: left;">
                <img alt="" src="/Images/logo.png" width="120px" height="40px" />
            </div>
            <div style="float: left; font-size: 14px; padding-left: 30px; padding-top: 15px;">
                会员消费积分管理平台&nbsp;&nbsp;&nbsp;&nbsp; 当前用户:<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </div>
            <div class="link" style="float: right; font-size: 14px; padding-right: 100px; padding-top: 10px; background: #2E70CC;">
                <a href="#" class="easyui-linkbutton CloseAll" data-options="plain:true,iconCls:'icon_Delete'">关闭全部</a>
                <a href="#" class="easyui-menubutton" data-options="menu:'#mm1',iconCls:'icon_Person2'">账号管理</a>
            </div>
            <div id="mm1" style="width: 150px;">
                <div data-options="iconCls:'icon_PersonEdit'">
                    <a onclick="UpdateInfo()">修改个人资料</a>
                </div>
                <div class="menu-sep">
                </div>
                <div data-options="iconCls:'icon_Edit'">
                    <a onclick="OpenPwdDialog()">修改密码</a>
                </div>
                <div class="menu-sep">
                </div>
                <div data-options="iconCls:'icon-back'">
                    <asp:LinkButton ID="btnExit" runat="server" OnClick="btnExit_Click">退出系统</asp:LinkButton>
                </div>
            </div>
        </div>
        <div data-options="region:'west',split:true,title:'菜单导航'" style="width: 180px;">
            <div class="easyui-accordion" data-options="fit:true,border:false">
                <div title="系统管理" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="ShopList.aspx">店铺管理</a></li>
                        <li><a url="CardLevelsList.aspx">会员等级管理</a></li>
                    </ul>
                </div>
                <div title="用户管理" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="UsersList.aspx">用户列表</a></li>
                    </ul>
                </div>
                <div title="礼品管理" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="ExchangGiftsList.aspx">礼品列表</a></li>
                    </ul>
                </div>
                <div title="会员管理" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="MemCardsList.aspx">会员列表</a></li>
                    </ul>
                </div>
                <div title="会员消费" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="FastConsume.aspx">快速消费</a></li>
                        <li><a url="SubtractPoint.aspx">会员减积分</a></li>
                        <li><a url="ConsumeOrdersLIst.aspx">消费历史记录</a></li>
                    </ul>
                </div>
                <div title="积分兑换" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="PointExchangeGift.aspx">积分兑换礼品</a></li>
                        <li><a url="PointRecash.aspx">积分返现</a></li>
                        <li><a url="ExchangLogsLIst.aspx">兑换历史记录</a></li>
                    </ul>
                </div>
                <div title="统计中心" style="padding: 10px;">
                    <ul class='ul-menu'>
                        <li><a url="FastComsumeSum.aspx">快速消费统计</a></li>
                        <li><a url="ConsumeOrdersSum.aspx">会员消费情况统计</a></li>
                        <li><a url="JianPointSum.aspx">减积分统计</a></li>
                        <li><a url="PointRecashSum.aspx">积分返现统计</a></li>
                        <li><a url="ExchangLogsSum.aspx">礼品兑换统计</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div data-options="region:'center'" style="overflow: hidden;">
            <div id="ttTab" class="easyui-tabs" data-options="tools:'#tab-tools',border:false,fit:true"
                style="overflow: hidden;">
            </div>
        </div>
        <div data-options="region:'south',border:false" style="height: 40px; padding: 10px; background: #2E70CC; text-align: center; color: #ffffff">
            版权所有 @@copy 2015 会员消费积分管理平台
        </div>
        <div id="dlg" class="easyui-dialog" data-options="modal:true,closed:true">
            <iframe id="frm" width="99%" height="98%" frameborder="0" scrolling="no"></iframe>
        </div>
    </form>


    <div id="dlg5" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 400px; height: 200px; padding: 10px">
        <table align="center">
            <tr>
                <td>登录名：
                </td>
                <td>
                    <input id="txtU_LoginName" type="text" />
                </td>
            </tr>

            <tr>
                <td>真实姓名：
                </td>
                <td>
                    <input id="txtU_RealName" type="text" />
                </td>
            </tr>


            <tr>
                <td>性别：
                </td>
                <td>
                    <input id="male" name="sex" type="radio" checked="checked" />男<input id="female" name="sex" type="radio" />女
                </td>
            </tr>
            <tr>
                <td>联系电话：
                </td>
                <td>
                    <input id="txtU_Telephone" type="text" />
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <input id="btnUpdateInfo" type="button" value="修改" />
                </td>
            </tr>
        </table>
    </div>
    <div id="dlg6" class="easyui-dialog" title="Basic Dialog" data-options="iconCls:'icon-save',closed:true,modal:true" style="width: 400px; height: 200px; padding: 10px">
        <form id="form6">
            <table align="center">
                <tr>
                    <td>旧密码：
                    </td>
                    <td>
                        <input id="txtPwd" type="text" />
                    </td>
                </tr>


                <tr>
                    <td>新密码：
                    </td>
                    <td>
                        <input id="txtNewPwd" type="text" />
                    </td>
                </tr>
                <tr>
                    <td>确认密码：
                    </td>
                    <td>
                        <input id="txtRePwd" type="text" />
                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td>
                        <input id="btnUpdatePwd" type="button" value="修改" />
                    </td>
                </tr>
            </table>
        </form>
    </div>

</body>
</html>

