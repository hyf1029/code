using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data;
using Newtonsoft.Json;
using System.Web.SessionState;

namespace PMS.UI.Handlers
{
    /// <summary>
    /// UsersHandler 的摘要说明
    /// </summary>
    public class UsersHandler : IHttpHandler,IRequiresSessionState
    {
        private IBLL.IUsersBLL _IUsersBLL = new BLL.UsersBLL();
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch(method)
            {
                case "GetUserList":
                    GetUserList(context);
                    break;
                case "InsertUser":
                    InsertUser(context);
                    break;
                case "DeleteUser":
                    DeleteUser(context);
                    break;
                case "GetSingleUser":
                    GetSingleUser(context);
                    break;
                case "UpdateUser":
                    UpdateUser(context);
                    break;
                case "SearchPersonalInfo":
                    SearchPersonalInfo(context);
                    break;
                case "UpdatePersonalInfo":
                    UpdatePersonalInfo(context);
                    break;
                case "UpdatePersonalPwd":
                    UpdatePersonalPwd(context);
                    break;
                case "VilidatePwd":
                    VilidatePwd(context);
                    break;
            }
        }
        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <param name="context"></param>
        public void GetUserList(HttpContext context)
        {
            Model.Users si = (Model.Users)context.Session["Users"];
            int recordCount;
            DataTable dt = _IUsersBLL.GetUsersList(Convert.ToInt32(context.Request["PageSize"]), Convert.ToInt32(context.Request["CurrentIndexCount"]), out recordCount, context.Request["U_LoginName"]??"", context.Request["U_RealName"]??"", context.Request["U_Telephone"]??"",Convert.ToInt32(si.S_ID));
            string json = JsonConvert.SerializeObject(new { total = recordCount, rows = dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 新增用户
        /// </summary>
        /// <param name="context"></param>
        public void InsertUser(HttpContext context)
        {
            Model.Users si = (Model.Users)context.Session["Users"];
            Model.Users u = new Model.Users();
            u.S_ID = si.S_ID;
            u.U_Password = "1";
            u.U_LoginName = context.Request["U_LoginName"];
            u.U_RealName = context.Request["U_RealName"];
            u.U_Telephone = context.Request["U_Telephone"];
            u.U_Sex = context.Request["U_Sex"];
            u.U_Role =Convert.ToInt32(context.Request["U_Role"]);
            u.U_CanDelete =Convert.ToBoolean(context.Request["U_CanDelete"]);
            string s;
            if(_IUsersBLL.InsertUser(u))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);
        }

        /// <summary>
        /// 删除用户
        /// </summary>
        /// <param name="context"></param>
        public void DeleteUser(HttpContext context)
        {
            Model.Users u = new Model.Users();
            u.U_ID =Convert.ToInt32(context.Request["U_ID"]);
            string s;
            if (_IUsersBLL.DeleteUser(u))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);
        }
        /// <summary>
        /// 获取单个用户
        /// </summary>
        /// <param name="context"></param>
        public void GetSingleUser(HttpContext context)
        {
            Model.Users u = _IUsersBLL.GetSingleUser(Convert.ToInt32(context.Request["U_ID"]));
            string json = JsonConvert.SerializeObject(u);
            context.Response.Write(json);
        }

        /// <summary>
        /// 修改用户
        /// </summary>
        /// <param name="context"></param>
        public void UpdateUser(HttpContext context)
        {
            Model.Users u = new Model.Users();
            u.U_LoginName = context.Request["U_LoginName"];
            u.U_RealName = context.Request["U_RealName"];
            u.U_Password = context.Request["U_Password"];
            u.U_Telephone = context.Request["U_Telephone"];
            u.U_Sex = context.Request["U_Sex"];
            u.U_Role = Convert.ToInt32(context.Request["U_Role"]);
            u.U_CanDelete = Convert.ToBoolean(context.Request["U_CanDelete"]);
            u.U_ID = Convert.ToInt32(context.Request["U_ID"]);
            string s;
            if (_IUsersBLL.UpdateUser(u))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);
        }
        /// <summary>
        /// 获取单个用户信息
        /// </summary>
        /// <param name="context"></param>
        public void SearchPersonalInfo(HttpContext context)
        {
            Model.Users us = (Model.Users)context.Session["Users"];
            Model.Users u = _IUsersBLL.GetSingleUser(us.U_ID);
            string json = JsonConvert.SerializeObject(u);
            context.Response.Write(json);
        }

        /// <summary>
        /// 修改用户个人信息
        /// </summary>
        /// <param name="context"></param>
        public void UpdatePersonalInfo(HttpContext context)
        {
            Model.Users us = (Model.Users)context.Session["Users"];
            Model.Users u = new Model.Users();
            u.U_LoginName = context.Request["U_LoginName"];
            u.U_RealName = context.Request["U_RealName"];
            u.U_Telephone = context.Request["U_Telephone"];
            u.U_Sex = context.Request["U_Sex"];
            u.U_ID = us.U_ID;
            string s;
            if (_IUsersBLL.UpdatePersonalInfo(u))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);
        }
        /// <summary>
        /// 修改个人密码
        /// </summary>
        /// <param name="context"></param>
        public void UpdatePersonalPwd(HttpContext context)
        {
            Model.Users u = new Model.Users();
            Model.Users us = (Model.Users)context.Session["Users"];
            u.U_Password = context.Request["U_Password"];
            u.U_ID = us.U_ID;
            string s;
            if (_IUsersBLL.UpdatePersonalPwd(u))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);

        }
        /// <summary>
        /// 获取旧密码
        /// </summary>
        /// <param name="context"></param>
        public void VilidatePwd(HttpContext context)
        {
            Model.Users us = (Model.Users)context.Session["Users"];
            Model.Users u = _IUsersBLL.SearchUserPwd(us.U_ID);
            string json = JsonConvert.SerializeObject(u);
            context.Response.Write(json);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}