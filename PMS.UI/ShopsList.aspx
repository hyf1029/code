<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShopsList.aspx.cs" Inherits="PMS.UI.ShopsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script type="text/javascript">
        //文档就绪函数
        $(function () {

            GetShopsList();
            //查询
            $("#btnSearch").click(function () {
                GetShopsList();
            });


            //打开新增的模态窗口
            $("#btnAdd").click(function () {
                $("#myModal").modal({ backdrop: 'static' });
                $("#myModalLabel").text("新增店铺");
                $("#btnUpdate").hide();
                $("#btnInsert").show();
                $("#form1")[0].reset();
            });
            //实现新增店铺
            $("#btnInsert").click(function () {
                //使用的是$.get()
                $.get("/Handlers/ShopsHandler.ashx", {
                    Method: "InsertShops",
                    S_Name: $("#txtSName").val().trim(),
                    S_Category: $("#ddlS_Category").val(),
                    S_ContactName: $("#txtContactName").val().trim(),
                    S_ContactTel: $("#txtTel").val().trim(),
                    S_Address: $("#txtAddress").val().trim(),
                    S_Remark: $("#txtRemark").val().trim()
                }, function (data) {
                    if (data == "1") {
                        $("#myModal").modal("hide");
                        alert("新增成功");
                        GetShopsList();
                    }
                    else {
                        alert("新增失败");
                    }

                });

            });


            //实现修改店铺
            $("#btnUpdate").click(function () {
                //使用的是$.get()
                $.get("/Handlers/ShopsHandler.ashx", {
                    Method: "UpdateShop",
                    S_Name: $("#txtSName").val(),
                    S_Category: $("#ddlS_Category").val(),
                    S_ContactName: $("#txtContactName").val(),
                    S_ContactTel: $("#txtTel").val(),
                    S_Address: $("#txtAddress").val(),
                    S_Remark: $("#txtRemark").val(),
                    S_ID: $("#hiddenID").val()
                }, function (data) {

                    if (data == "1") {
                        $("#myModal").modal("hide");
                        GetShopsList();
                        alert("修改成功");

                    }
                    else {
                        alert("修改失败");
                    }

                });
            });

        });

        //获取店铺列表
        function GetShopsList() {

            $.ajax({
                type: "get",
                url: "/Handlers/ShopsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "GetShopsList",
                    S_Name: $("#txtS_Name").val().trim(),
                    S_ContactName: $("#txtS_ContactName").val().trim(),
                    S_Address: $("#txtS_Address").val().trim()
                },
                success: function (data) {
                    var s = "";
                    $.each(data, function (index, o) {
                        if (o.S_Category == 1) {
                            o.S_Category = "总部";
                        }
                        if (o.S_Category == 2) {
                            o.S_Category = "加盟店";
                        }
                        if (o.S_Category == 3) {
                            o.S_Category = "自营店";
                        }
                        if (o.S_IsHasSetAdmin == true) {
                            o.S_IsHasSetAdmin = "已分配";
                        }
                        else {
                            o.S_IsHasSetAdmin = "未分配";
                        }
                        s += "<tr>";
                        s += "<td>" + o.S_ID + "</td>";
                        s += "<td>" + o.S_Name + "</td>";
                        s += "<td>" + o.S_Category + "</td>";
                        s += "<td>" + o.S_ContactName + "</td>";
                        s += "<td>" + o.S_ContactTel + "</td>";
                        s += "<td>" + o.S_Address + "</td>";
                        s += "<td>" + o.S_Remark + "</td>";
                        s += "<td>" + o.S_IsHasSetAdmin + "</td>";
                        s += "<td>" + o.S_CreateTime + "</td>";
                        s += "<td> "
                        s += "<input id='Button1' type='button' value='删除' class='btn btn-success btn-sm'  onclick='DeleteShop(" + o.S_ID + ")' />";
                        s += "<input id='Button2' type='button' value='修改'  class='btn btn-info btn-sm' onclick='OpenUpdateModal(" + o.S_ID + ")'/>";
                        s += "</td>"
                        s += "</tr>";
                    });
                    $("#tableShops tr:gt(0)").remove();
                    $("#tableShops").append(s);
                }
            });

        }

        //删除店铺
        function DeleteShop(id) {

            if (confirm("你确定要删除吗？")) {
                //使用的是$.post()
                $.post("/Handlers/ShopsHandler.ashx", {
                    Method: "Deleteshop",
                    S_ID: id
                }, function (data) {

                    if (data == "1") {
                        GetShopsList();
                        alert("删除成功");
                    }
                    else {
                        alert("删除失败");
                    }

                });
            }

        }

        //打开修改的模态窗口
        function OpenUpdateModal(id) {
            $("#form1")[0].reset();
            // 打开修改的模态窗口
            $("#myModal").modal({ backdrop: 'static' });
            $("#myModalLabel").text("修改店铺");
            $("#btnUpdate").show();
            $("#btnInsert").hide();

            $.ajax({
                type: "get",
                url: "/Handlers/ShopsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "GetSingleShop",
                    S_ID: id
                },
                success: function (data) {
                    $("#txtSName").val(data.S_Name);
                    $("#ddlS_Category").val(data.S_Category);
                    $("#txtContactName").val(data.S_ContactName);
                    $("#txtTel").val(data.S_ContactTel);
                    $("#txtAddress").val(data.S_Address);
                    $("#txtRemark").val(data.S_Remark);
                    $("#hiddenID").val(data.S_ID);


                }
            });
        }

    </script>

</head>
<body>

    <div>

        <table align="center">
            <tr>
                <td>店铺名称：<input id="txtS_Name" type="text" /></td>
                <td>联系人：<input id="txtS_ContactName" type="text" /></td>
                <td>店铺地址：<input id="txtS_Address" type="text" /></td>
                <td>
                    <input id="btnSearch" type="button" value="查询" class="btn btn-success btn-sm" />
                    <input id="btnAdd" type="button" value="新增" class="btn btn-info btn-sm" /></td>
            </tr>
        </table>

        <table align="center" id="tableShops" border="1" style="text-align: center">
            <tr style="background-color: #99CCFF">
                <th style="text-align: center">店铺编号</th>
                <th style="text-align: center">店铺名称</th>
                <th style="text-align: center">店铺类型</th>
                <th style="text-align: center">联系人</th>
                <th style="text-align: center">联系电话</th>
                <th style="text-align: center">地址</th>
                <th style="text-align: center">备注</th>
                <th style="text-align: center">是否分配管理员</th>
                <th style="text-align: center">加盟时间</th>
                <th style="text-align: center">操作</th>
            </tr>
        </table>


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
                                        <td>店铺名称：
                                        </td>
                                        <td>
                                            <input id="txtSName" type="text" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>店铺类别：
                                        </td>
                                        <td>
                                            <select id="ddlS_Category" name="D1">
                                                <option value="0">--请选择--</option>
                                                <option value="1">总部</option>
                                                <option value="2">加盟店</option>
                                                <option value="3">自营店</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>联系人：
                                        </td>
                                        <td>
                                            <input id="txtContactName" type="text" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>联系电话：
                                        </td>
                                        <td>
                                            <input id="txtTel" type="text" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>店铺地址：
                                        </td>
                                        <td>
                                            <input id="txtAddress" type="text" />
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
