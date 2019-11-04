using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;

namespace PMS.UI.Handlers
{
    /// <summary>
    /// ShopsHandler 的摘要说明
    /// </summary>
    public class ShopsHandler : IHttpHandler
    {
        private IBLL.IShopsBLL _IShopsBLL = new BLL.ShopsBLL();
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch (method)
            {
                case "GetPageShopsByCondition":
                    GetPageShopsByCondition(context);
                    break;
                case "InsertShops":
                    InsertShop(context);
                    break;
                case "Deleteshop":
                    DeleteShop(context);
                    break;
                case "GetSingleShop":
                    GetSingleShop(context);
                    break;
                case "UpdateShop":
                    UpdateShops(context);
                    break;
                case "SetShopsAdmin":
                    SetShopsAdmin(context);
                    break;
            }
        }

        /// <summary>
        /// 获取店铺列表
        /// </summary>
        /// <param name="context"></param>
        public void GetPageShopsByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IShopsBLL.GetShopsList(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount,context.Request["S_Name"]??"", context.Request["S_ContactName"]??"", context.Request["S_Address"]??"");
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 新增店铺
        /// </summary>
        /// <param name="context"></param>
        public void InsertShop(HttpContext context)
        {
            Model.Shops s = new Model.Shops();
            s.S_Name = context.Request["S_Name"];
            s.S_Category = Convert.ToInt32(context.Request["S_Category"]);
            s.S_ContactName = context.Request["S_ContactName"];
            s.S_ContactTel = context.Request["S_ContactTel"];
            s.S_Address = context.Request["S_Address"];
            s.S_Remark = context.Request["S_Remark"];
            s.S_CreateTime = DateTime.Now;
            s.S_IsHasSetAdmin = false;
            string i = "";
            if (_IShopsBLL.InsertShops(s))
            {
                i = "1";
            }
            else
            {
                i = "0";
            }
            context.Response.Write(i);
        }

        /// <summary>
        /// 删除店铺
        /// </summary>
        /// <param name="context"></param>
        public void DeleteShop(HttpContext context)
        {
            Model.Shops s = new Model.Shops();
            s.S_ID = Convert.ToInt32(context.Request["S_ID"]);
            string i;
            if (_IShopsBLL.DeleteShops(s))
            {
                i = "1";
            }
            else
            {
                i = "0";
            }
            context.Response.Write(i);
        }

        /// <summary>
        /// 获取单个店铺
        /// </summary>
        /// <param name="context"></param>
        private void GetSingleShop(HttpContext context)
        {

            Model.Shops s = _IShopsBLL.GetSingleShops(Convert.ToInt32(context.Request["S_ID"]));
            string json = JsonConvert.SerializeObject(s);
            context.Response.Write(json);
        }

        /// <summary>
        /// 修改店铺
        /// </summary>
        /// <param name="context"></param>
        public void UpdateShops(HttpContext context)
        {

            Model.Shops s = new Model.Shops();
            s.S_Name = context.Request["S_Name"];
            s.S_Category = Convert.ToInt32(context.Request["S_Category"]);
            s.S_ContactName = context.Request["S_ContactName"];
            s.S_ContactTel = context.Request["S_ContactTel"];
            s.S_Address = context.Request["S_Address"];
            s.S_Remark = context.Request["S_Remark"];
            s.S_ID = Convert.ToInt32(context.Request["S_ID"]);
            string i;
            if (_IShopsBLL.UpdateShops(s))
            {
                i = "1";
            }
            else
            {
                i = "0";
            }
            context.Response.Write(i);
        }
        /// <summary>
        /// 分配管理员
        /// </summary>
        /// <param name="context"></param>
        public void SetShopsAdmin(HttpContext context)
        {
            Model.Shops s = new Model.Shops();
            Model.Users u = new Model.Users();
            s.S_ID = Convert.ToInt32(context.Request["S_ID"]);
            s.S_IsHasSetAdmin = true;
            u.S_ID = Convert.ToInt32(context.Request["S_ID"]);
            u.U_LoginName = context.Request["U_LoginName"];
            u.U_Password = "123456";
            u.U_Role = 2;
            u.U_CanDelete = true;
            var i = "";
            if(_IShopsBLL.InsertAdminUser(u,s))
            {
                i = "1";
            }
            else
            {
                i = "0";
            }
            context.Response.Write(i);
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