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
    /// ExchangGiftsHandler 的摘要说明
    /// </summary>
    public class ExchangGiftsHandler : IHttpHandler,IRequiresSessionState
    {
        private IBLL.IExchangGiftsBLL _IExchangGiftsBLL = new BLL.ExchangGiftsBLL();
        

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch(method)
            {
                case "GetPageExchangeGiftsByCondition":
                    GetPageExchangeGiftsByCondition(context);
                    break;
                case "InsertGift":
                    InsertGift(context);
                    break;
                case "GetSingleGift":
                    GetSingleGift(context);
                    break;
                case "UpdateGift":
                    UpdateGift(context);
                    break;
                case "DeleteGift":
                    DeleteGift(context);
                    break;
                case "GetExchangeGifts":
                    GetExchangeGifts(context);
                    break;
            }
        }
        /// <summary>
        /// 根据条件给礼品分页
        /// </summary>
        /// <param name="context"></param>
        private void GetPageExchangeGiftsByCondition(HttpContext context)
        {
            Model.Users u = (Model.Users)context.Session["Users"];
            int recordCount;
            DataTable dt = _IExchangGiftsBLL.P_GetPageExchangeGiftsByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["EG_GiftCode"]??"", context.Request["EG_GiftName"]??"",Convert.ToInt32(u.S_ID));
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 新增礼品
        /// </summary>
        /// <param name="context"></param>
        public void InsertGift(HttpContext context)
        {
            Model.Users u = (Model.Users)context.Session["Users"];
            Model.ExchangGifts g = new Model.ExchangGifts();
            g.S_ID = u.S_ID;
            g.EG_GiftCode = context.Request["EG_GiftCode"];
            g.EG_GiftName= context.Request["EG_GiftName"];
            g.EG_Photo = context.Request["EG_Photo"];
            g.EG_Remark = context.Request["EG_Remark"];
            g.EG_Point =Convert.ToInt32(context.Request["EG_Point"]);
            g.EG_Number =Convert.ToInt32(context.Request["EG_Number"]);
            string s;
            if (_IExchangGiftsBLL.InsertGift(g))
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
        /// 获取单个礼品信息
        /// </summary>
        /// <param name="context"></param>
        public void GetSingleGift(HttpContext context)
        {
            Model.ExchangGifts g = _IExchangGiftsBLL.GetSingleGift(Convert.ToInt32(context.Request["EG_ID"]));
            string json = JsonConvert.SerializeObject(g);
            context.Response.Write(json);
        }
        /// <summary>
        /// 修改礼品
        /// </summary>
        /// <param name="context"></param>
        public void UpdateGift(HttpContext context)
        {
            Model.ExchangGifts g = new Model.ExchangGifts();
            g.EG_ID = Convert.ToInt32(context.Request["EG_ID"]);
            g.EG_GiftCode = context.Request["EG_GiftCode"];
            g.EG_GiftName = context.Request["EG_GiftName"];
            g.EG_Photo = context.Request["EG_Photo"];
            g.EG_Remark = context.Request["EG_Remark"];
            g.EG_Point = Convert.ToInt32(context.Request["EG_Point"]);
            g.EG_Number = Convert.ToInt32(context.Request["EG_Number"]);
            string s;
            if (_IExchangGiftsBLL.UpdateGift(g))
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
        /// 删除礼品
        /// </summary>
        /// <param name="context"></param>
        public void DeleteGift(HttpContext context)
        {
            Model.ExchangGifts g = new Model.ExchangGifts();
            g.EG_ID= Convert.ToInt32(context.Request["EG_ID"]);
            string s;
            if (_IExchangGiftsBLL.DeleteGift(g))
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
        /// 礼品列表
        /// </summary>
        /// <param name="context"></param>
        private void GetExchangeGifts(HttpContext context)
        {
            Model.Users u = (Model.Users)context.Session["Users"];
            int recordCount;
            DataTable dt = _IExchangGiftsBLL.P_GetPageExchangeGiftsByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount,"", "", 0);
            string json = JsonConvert.SerializeObject(new { total = recordCount, rows = dt });
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