<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="PMS.UI.WebForm1" %>

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
      

    </script>
</head>
<body>

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
</body>
</html>
