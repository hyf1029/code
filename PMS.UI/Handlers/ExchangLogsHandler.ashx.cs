using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.SessionState;
using Newtonsoft.Json;
using System.Transactions;
namespace PMS.UI.Handlers
{
    /// <summary>
    /// ExchangLogsHandler 的摘要说明
    /// </summary>
    public class ExchangLogsHandler : IHttpHandler, IRequiresSessionState
    {
        private IBLL.IExchangLogsBLL _IExchangLogsBLL = new BLL.ExchangLogsBLL();
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch (method)
            {
                case "PointExchange":
                    PointExchange(context);
                    break;
                case "GetPageExchangLogsByCondition":
                    GetPageExchangLogsByCondition(context);
                    break;
            }
        }

        /// <summary>
        /// 兑换积分
        /// </summary>
        /// <param name="context"></param>
        public void PointExchange(HttpContext context)
        {
            using (TransactionScope ts = new TransactionScope())
            {
                Model.ExchangLogs el = new Model.ExchangLogs();
                Model.MemCards m = new Model.MemCards();
                Model.Users u = (Model.Users)context.Session["Users"];
                Model.ExchangGifts eg = new Model.ExchangGifts();
                el.S_ID = u.S_ID;
                el.U_ID = u.U_ID;
                el.EG_ID = Convert.ToInt32(context.Request["EG_ID"]);
                el.EG_GiftCode = context.Request["EG_GiftCode"];
                el.EG_GiftName = context.Request["EG_GiftName"]; 
                el.EL_Number = Convert.ToInt32(context.Request["EL_Number"]);
                el.EL_Point = Convert.ToInt32(context.Request["EL_Point"]);
                el.EL_CreateTime = DateTime.Now;
                el.MC_CardID = context.Request["MC_CardID"];
                el.MC_ID = Convert.ToInt32(context.Request["MC_ID"]);
                el.MC_Name = context.Request["MC_Name"];
                m.MC_Point = Convert.ToInt32(context.Request["MC_Point"]);
                eg.EG_ExchangNum = Convert.ToInt32(context.Request["EG_ExchangNum"]);
                eg.EG_Number = Convert.ToInt32(context.Request["EG_Number"]);
                string s;
                if (_IExchangLogsBLL.PointExchange(el, m, eg))
                {
                    s = "1";
                }
                else
                {
                    s = "0";
                }
                context.Response.Write(s);
                ts.Complete();
            }
        }
        /// <summary>
        /// 根据条件给兑换记录分页
        /// </summary>
        /// <param name="context"></param>
        public void GetPageExchangLogsByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IExchangLogsBLL.GetPageExchangLogsByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["CardTel"]??"");
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