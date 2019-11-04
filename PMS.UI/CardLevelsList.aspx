<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CardLevelsList.aspx.cs" Inherits="PMS.UI.CardLevelsList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script type="text/javascript">
       
     
        var currentIndex=1;  //显示第几页
          
       
       
        //文档就绪函数
        $(function () {

            GetCardLevelList();

            //查询
            $("#btnSearch").click(function () {
                GetCardLevelList();
            });

            //打开新增的模态窗体
            $("#btnAdd").click(function () {
                $("#form1")[0].reset();
                $("#myModal").modal({ backdrop: 'static' });
                $("#myModalLabel").text("新增会员卡类别");
                $("#btnInsert").show();
                $("#btnUpdate").hide();
            });


            //实现新增会员等级
            $("#btnInsert").click(function () {
                //使用的是$.get()
                $.get("/Handlers/CardLevelsHandler.ashx", {
                    Method: "InsertCardLevel",
                    CL_LevelName: $("#txtName").val().trim(),
                    CL_NeedPoint: $("#txtNeedPoint").val().trim(),
                    CL_Percent: $("#txtPercent").val().trim(),
                    CL_Point: $("#txtPoint").val().trim()
                  

                }, function (data) {
                    if (data == "1") {

                        $("#myModal").modal("hide");
                        GetCardLevelList();
                        alert("新增成功");

                    }
                    else {
                        alert("新增失败");
                    }

                });

            });

            //实现修改
            $("#btnUpdate").click(function () {
                //使用的是$.get()
                $.get("/Handlers/CardLevelsHandler.ashx", {
                    Method: "UpdateCardLevel",
                    CL_LevelName: $("#txtName").val(),
                    CL_NeedPoint: $("#txtNeedPoint").val(),
                    CL_Percent: $("#txtPercent").val(),
                    CL_Point: $("#txtPoint").val(),
                    CL_ID: $("#hiddenID").val()

                }, function (data) {
                    if (data == "1") {

                        $("#myModal").modal("hide");
                        GetCardLevelList();
                        alert("修改成功");

                    }
                    else {
                        alert("修改失败");
                    }

                });

            });

            $("#ddlPageSize").change(function () {
                currentIndex = 1;
                GetCardLevelList();
            
            });

            //首页
            $("#btnFrist").click(function () {
                currentIndex = 1;
                GetCardLevelList();
            });

            //上一页
            $("#btnPresion").click(function () {

                if (currentIndex == 1) {
                    currentIndex = 1;
                }
                else {
                    currentIndex--;

                }
                GetCardLevelList();

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
                GetCardLevelList();
            });

            //末页
            $("#btnLast").click(function () {
                var recordCount = $("#HidRecordCount").val();
                var pageSize = $("#ddlPageSize").val();
                n = Math.ceil(recordCount / pageSize);
                currentIndex = n;
                GetCardLevelList();

            });
            
        });

        function SetPage(pageSize, recordCount)
        {
           
        }


        //获取会员等级列表
        function GetCardLevelList() {
            //使用的 $.getJSON()
            $.getJSON("/Handlers/CardLevelsHandler.ashx", {
                Method: "GetCardLevelList",
                PageSize: $("#ddlPageSize").val(),
                CurrentIndexCount:currentIndex,
                CL_LevelName: $("#txtCardLevel").val().trim()
            }, function (data) {
                var s;
                $.each(data.rows, function (index, o) {
                    s += "<tr>";
                    s += "<td>" + o.CL_ID + "</td>";
                    s += "<td>" + o.CL_LevelName + "</td>";
                    s += "<td>" + o.CL_NeedPoint + "</td>";
                    s += "<td>" + o.CL_Point + "</td>";
                    s += "<td>" + o.CL_Percent + "</td>";
                    s += "<td>";
                    s += " <input id='Button1' type='button' value='删除' class='btn  btn-success btn-sm' onclick='DeleteCardLevel(" + o.CL_ID + ")' />";
                    s += "<input id='Button2' type='button' value='修改' class='btn  btn-info btn-sm' onclick='OpenUpdateModal(" + o.CL_ID + ")'/>";
                    s += "</td>";
                    s += "</tr>";
                });
                $("#tableCardLevel tr:gt(0)").remove();
                $("#tableCardLevel").append(s);
                $("#HidRecordCount").val(data.total);
                
            })
        }

        var recordCount = $("#HidRecordCount").val();
        //删除会员等级
        function DeleteCardLevel(id) {
            if (confirm("你确定要删除吗？")) {
                //使用的 $.ajax()
                $.ajax({
                    type: "get",
                    url: "/Handlers/CardLevelsHandler.ashx",
                    data: {
                        Method: "DeleteCardLevel",
                        CL_ID: id
                    },
                    success: function (data) {
                        if (data == "1") {
                            GetCardLevelList();
                            alert("删除成功");

                        }
                        else {
                            alert("删除失败");
                        }
                    }
                });
            }
        }


        //打开修改的模态窗体
        function OpenUpdateModal(id) {
            $("#form1")[0].reset();
            $("#myModal").modal({ backdrop: 'static' });
            $("#myModalLabel").text("修改会员卡类别");
            $("#btnInsert").hide();
            $("#btnUpdate").show();
          
            $.ajax({
                type: "get",
                url: "/Handlers/CardLevelsHandler.ashx",
                dataType: "json",
                data: {
                    Method: "GetSingleCardLevel",
                    CL_ID: id
                },
                success: function (data) {
                  
                    $("#txtName").val(data.CL_LevelName);
                    $("#txtNeedPoint").val(data.CL_NeedPoint);
                    $("#txtPoint").val(data.CL_Point);
                    $("#txtPercent").val(data.CL_Percent);
                    $("#hiddenID").val(data.CL_ID);
                    
                }
            });

        }

    </script>
</head>
<body>

    <div>

        <table align="center">
            <tr>
                <td>等级名称：<input id="txtCardLevel" type="text" /></td>
                <td>
                    <input id="btnSearch" type="button" value="查询" class="btn  btn-success btn-sm"/>
                    <input id="btnAdd" type="button" value="新增" class="btn btn-info btn-sm" />
                </td>

            </tr>
        </table>

        <table align="center" id="tableCardLevel" border="1" style="text-align:center">
            <tr style="background-color:#99CCFF">
                <th style="text-align:center">等级编号</th>
                <th style="text-align:center">等级名称</th>
                <th style="text-align:center">所需最大积分</th>
                <th style="text-align:center">扣分比例</th>
                <th style="text-align:center">折扣比例</th>
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
                                        <td>等级名称：
                                        </td>
                                        <td>
                                            <input id="txtName" type="text" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>所需最大积分：
                                        </td>
                                        <td>
                                            <input id="txtNeedPoint" type="text" /><br />
                                            <span style="color: #ff0000">(注：消费##人民币自动兑换成1积分，默认 10RMB=1积分)</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>兑换比例：
                                        </td>
                                        <td>
                                            <input id="txtPoint" type="text" /><br />
                                            <span style="color: #ff0000">(注：达到此等级时，所享受的折扣率，如:0.87表示八折,1表示不打折)</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>折扣比例：
                                        </td>
                                        <td>
                                            <input id="txtPercent" type="text" />
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
