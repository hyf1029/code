<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PMS.UI.Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>会员消费积分管理平台-登录</title>
    <link href="Content/login.css" rel="stylesheet" />
    <script src="jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript">
    $(function () {
        $('.rem').click(function () {
            $(this).toggleClass('selected');
        })
        $('#signup_select').click(function () {
            $('.form_row ul').show();
            event.cancelBubble = true;
        })
        $('#d').click(function () {
            $('.form_row ul').toggle();
            event.cancelBubble = true;
        })
        $('body').click(function () {
            $('.form_row ul').hide();
        })
        $('.form_row li').click(function () {
            var v = $(this).text();
            $('#signup_select').val(v);
            $('.form_row ul').hide();
        })
    })
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div class='signup_container'>
        <h1 class='signup_title'>
            用户登陆</h1>
        <img src="Images/Login/people.png" id='admin' />
        <div id="signup_forms" class="signup_forms clearfix">
            <div class="form_row first_row">
                <label for="U_LoginName">
                    请输入用户名</label>
                <asp:TextBox ID="U_LoginName" runat="server" placeholder="请输入用户名" data-required="required"></asp:TextBox>
            </div>
            <div class="form_row">
                <label for="U_Password">
                    请输入密码</label>
                <asp:TextBox ID="U_Password" runat="server" placeholder="请输入密码"  data-required="required" TextMode="Password"></asp:TextBox>
            </div>
        </div>
        <div class="login-btn-set">
            <asp:Button ID="Button1" runat="server" CssClass="login-btn" OnClick="Button1_Click"/>
        </div>
    </div>
    </form>
</body>
</html>
