<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersList.aspx.cs" Inherits="PMS.UI.UsersList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script type="text/javascript">
        var currentIndex = 1;  //显示第几页
      

        $(function () {

            //var c;
            //$("#tableUserList tr").hover(
            //    function () {
            //        c = $(this).css("background-color");
            //        $(this).css("background-color", "#99CCFF");
            //    },
            //    function () {
            //        $(this).css("background-color", c);
            //    }
            //);

            GetUserList();

            //查询
            $("#btnSearch").click(function () {

                GetUserList();
            });
            //打开新增用户的窗体
            $("#btnAdd").click(function () {
                $("#myModal").modal({ backdrop: 'static' });
                $("#myModalLabel").text("新增用户");
                $("#btnUpdate").hide();
                $("#btnInsert").show();
                $("#pass").hide();
                $("#form1")[0].reset();
            });

            //新增用户
            $("#btnInsert").click(function () {

                $.ajax({
                    type: "get",
                    url: "/Handlers/UsersHandler.ashx",
                    data: {
                        Method: "InsertUser",
                        U_LoginName: $("#txtU_LoginName").val().trim(),
                        U_RealName: $("#txtU_RealName").val().trim(),
                        U_Sex: $("#male").is(":checked") ? "男" : "女",
                        U_Telephone: $("#txtU_Telephone").val().trim(),
                        U_Role: $("#ddlU_Role").val(),
                        U_CanDelete: $("#ckU_CanDelete").is(":checked") ? "true" : "false"
                    },
                    success: function (data) {

                        if (data == "1") {
                            $("#myModal").modal("hide");
                            GetUserList();
                            alert("新增成功");
                        }
                        else {
                            alert("新增失败");
                        }

                    }
                });
            });


            $("#btnUpdate").click(function () {
                $.ajax({
                    type: "get",
                    url: "/Handlers/UsersHandler.ashx",
                    data: {
                        Method: "UpdateUser",
                        U_LoginName: $("#txtU_LoginName").val(),
                        U_Password:$("#txtPassword").val(),
                        U_RealName: $("#txtU_RealName").val(),
                        U_Sex: $("#male").is(":checked") ? "男" : "女",
                        U_Telephone: $("#txtU_Telephone").val(),
                        U_Role: $("#ddlU_Role").val(),
                        U_CanDelete: $("#ckU_CanDelete").is(":checked") ? "true" : "false",
                        U_ID: $("#hiddenID").val()
                    },
                    success: function (data) {

                        if (data == "1") {
                            $("#myModal").modal("hide");
                            GetUserList();
                            alert("修改成功");
                        }
                        else {
                            alert("修改失败");
                        }

                    }
                });

            });


            $("#ddlPageSize").change(function () {
                currentIndex = 1;
                GetUserList();

            });


            //首页
            $("#btnFrist").click(function () {
                currentIndex = 1;
                GetUserList();

            });

            //上一页
            $("#btnPresion").click(function () {

                if (currentIndex == 1) {
                    currentIndex = 1;
                }
                else {
                    currentIndex--;

                }
                GetUserList();

            });

            //下一页
            $("#btnNext").click(function () {
                var recordCount = $("#HidRecordCount").val();
                var pageSize = $("#ddlPageSize").val();
                var n = Math.ceil(recordCount / pageSize);
                if (currentIndex == n) {
                    currentIndex = n;
                }
                else {
                    currentIndex++;

                }
                GetUserList();
            });

            //末页
            $("#btnLast").click(function () {
                var recordCount = $("#HidRecordCount").val();
                var pageSize = $("#ddlPageSize").val();
                var n = Math.ceil(recordCount / pageSize);
                currentIndex = n;
                GetUserList();

            });

        });

        //获取用户列表
        function GetUserList() {
            $.ajax({
                type: "get",
                url: "/Handlers/UsersHandler.ashx",
                dataType: "json",
                data: {
                    Method: "GetUserList",
                    PageSize: $("#ddlPageSize").val(),
                    CurrentIndexCount: currentIndex,
                    U_LoginName: $("#txtLoginName").val().trim(),
                    U_RealName: $("#txtRealName").val().trim(),
                    U_Telephone: $("#txtTel").val().trim()
                },
                success: function (data) {
                    var s = "";
                    $.each(data.rows, function (index, o) {
                        if (o.U_Role == 1) {
                            o.U_Role = "系统管理员";
                        }
                        if (o.U_Role == 2) {
                            o.U_Role = "店长";
                        }
                        if (o.U_Role == 3) {
                            o.U_Role = "业务员";
                        }
                        if (o.U_CanDelete == true) {
                            o.U_CanDelete = "是";
                            $("#Button1").show();
                        }
                        else {
                            o.U_CanDelete = "否";
                            $("#Button1").hide();

                        }
                        s += "<tr>";
                        s += "<td>" + o.U_ID + "</td>";
                        s += "<td>" + o.U_LoginName + "</td>";
                        s += "<td>" + o.U_RealName + "</td>";
                        s += "<td>" + o.U_Sex + "</td>";
                        s += "<td>" + o.U_Telephone + "</td>";
                        s += "<td>" + o.U_Role + "</td>";
                        s += "<td>" + o.U_CanDelete + "</td>";
                        s += "<td> "
                        s += "<input id='Button1' type='button' value='删除' class='btn btn-success btn-sm' " + IsDisplay(o.U_CanDelete) + "  onclick='DeleteUser(" + o.U_ID + ")' />";
                        s += "<input id='Button2' type='button' value='修改' class='btn btn-info btn-sm'  onclick='OpenUpdateDailog(" + o.U_ID + ")'/>";
                        s += "</td>"
                        s += "</tr>";
                      
                    });
                    $("#tableUserList tr:gt(0)").remove();
                    $("#tableUserList").append(s);
                    $("#HidRecordCount").val(data.total);
                }
            });
            
        }

        function IsDisplay(canDelete)
        {
            var i = "";
            if (canDelete=="是")
            {
                i = "";
            }
            else
            {
                i = "style='display:none'";
            }
            return i;
        }



        //删除用户
        function DeleteUser(id) {
            if (confirm("你确定要删除吗?")) {
                $.get("/Handlers/UsersHandler.ashx", {
                    Method: "DeleteUser",
                    U_ID: id
                }, function (data) {

                    if (data == "1") {
                        GetUserList();
                        alert("删除成功");
                    }
                    else {
                        alert("删除失败");
                    }
                });
            }

        }

        //打开修改的模态窗口
        function OpenUpdateDailog(id) {
            $("#form1")[0].reset();
            $("#myModal").modal({ backdrop: 'static' });
            $("#myModalLabel").text("修改用户");
            $("#btnUpdate").show();
            $("#btnInsert").hide();
            $("#pass").show();

            $.ajax({
                type: "get",
                url: "/Handlers/UsersHandler.ashx",
                data: {
                    Method: "GetSingleUser",
                    U_ID: id
                },
                dataType: "json",
                success: function (data) {

                    $("#txtU_LoginName").val(data.U_LoginName);
                    $("#ddlU_Role").val(data.U_Role);
                    $("#txtU_RealName").val(data.U_RealName);
                    if (data.U_Sex == "男") {
                        $("#male").prop("checked", "checked");
                    }
                    else {
                        $("#female").prop("checked", "checked");
                    }
                    $("#txtU_Telephone").val(data.U_Telephone);
                    $("#ddlU_Role").val(data.U_Role);
                    if (data.U_CanDelete == "1") {
                        $("#ckU_CanDelete").prop("checked", "checked")
                    }
                    $("#txtPassword").val(data.U_Password);
                    $("#hiddenID").val(data.U_ID);

                }
            });
        }
    </script>
</head>
<body>

    <div>

        <table align="center">
            <tr>
                <td>登录名：<input id="txtLoginName" type="text" /></td>
                <td>真实姓名：<input id="txtRealName" type="text" /></td>
                <td>联系电话：<input id="txtTel" type="text" /></td>
                <td>
                    <input id="btnSearch" type="button" value="查询" class="btn btn-success btn-sm" />
                    <input id="btnAdd" type="button" value="新增" class="btn btn-info btn-sm" />
                </td>
            </tr>
        </table>

        <table align="center" id="tableUserList" border="1" style="text-align:center">
            <tr style="background-color:#99CCFF">
                <th style="text-align:center">用户编号</th>
                <th style="text-align:center">登陆名</th>
                <th style="text-align:center">真实姓名</th>
                <th style="text-align:center">性别</th>
                <th style="text-align:center">联系电话</th>
                <th style="text-align:center">用户角色</th>
                <th style="text-align:center">是否可以删除</th>
                <th style="text-align:center">操作</th>
            </tr>
        </table>
        <br />
        <div style="text-align:center">
            <select id="ddlPageSize">
                <option value="2">2</option>
                <option value="4">4</option>
                <option value="6">6</option>
                <option value="8">8</option>
                <option value="10">10</option>
            </select>
            <input id="btnFrist" type="button" value="首页" />
            <input id="btnPresion" type="button" value="上一页" />
            <input id="btnNext" type="button" value="下一页" />
            <input id="btnLast" type="button" value="末页" /><br/>
            总记录数：
            <input id="HidRecordCount" type="text" readonly="true" />
        </div>
        <!-- Modal1 -->
        <div class="modal" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    </div>
                    <div class="modal-body">
                        <div>
                            <form id="form1" runat="server">
                                <table align="center">
                                    <tr>
                                        <td>登录名：
                                        </td>
                                        <td>
                                            <input id="txtU_LoginName" type="text" />
                                        </td>
                                    </tr>
                                    <tr id="pass">
                                        <td>密码：
                                        </td>
                                        <td>
                                            <input id="txtPassword" type="text" />
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
                                        <td>角色：
                                        </td>
                                        <td>
                                            <select id="ddlU_Role" name="D1">
                                                <option value="0">--请选择--</option>
                                                <option value="2">店长</option>
                                                <option value="3">业务员</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>是否可以删除：
                                        </td>
                                        <td>
                                            <input id="ckU_CanDelete" type="checkbox" />是
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" id="btnInsert" class="btn btn-primary">添加</button>
                        <button type="button" id="btnUpdate" class="btn btn-primary">修改</button>
                        <input id="hiddenID" type="hidden" />
                    </div>
                </div>
            </div>
        </div>



    </div>


</body>
</html>
