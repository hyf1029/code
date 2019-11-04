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
    /// ConsumeOrdersHandler 的摘要说明
    /// </summary>
    public class ConsumeOrdersHandler : IHttpHandler,IRequiresSessionState
    {
        private IBLL.IConsumeOrdersBLL _IConsumeOrdersBLL = new BLL.ConsumeOrdersBLL();

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch(method)
            {
                case "GetPageConsumeOrdersByCondition":
                    GetPageConsumeOrdersByCondition(context);
                    break;
                case "PointCash":
                    PointCash(context);
                    break;
                case "GetPageSubintPointByCondition":
                    GetPageSubintPointByCondition(context);
                    break;
                case "GetPageFastComsumeSumByCondition":
                    GetPageFastComsumeSumByCondition(context);
                    break;
                case "GetPagePointReCashSumByCondition":
                    GetPagePointReCashSumByCondition(context);
                    break;
                case "GetPageExchangLogsSumByCondition":
                    GetPageExchangLogsSumByCondition(context);
                    break;
                case "GetPageConsumeOrdersSumByCondition":
                    GetPageConsumeOrdersSumByCondition(context);
                    break;


            }
        }

        /// <summary>
        /// 根据条件给消费记录分页
        /// </summary>
        /// <param name="context"></param>
        public void GetPageConsumeOrdersByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPageConsumeOrdersByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount,context.Request["CardTel"]??"");
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 积分返现
        /// </summary>
        /// <param name="context"></param>
        public void PointCash(HttpContext context)
        {
            using (TransactionScope ts =new TransactionScope()) {
                Model.ConsumeOrders co = new Model.ConsumeOrders();
                Model.MemCards m = new Model.MemCards();
                Model.Users u = (Model.Users)context.Session["Users"];
                co.S_ID = u.S_ID;
                co.U_ID = u.U_ID;
                co.MC_CardID = context.Request["MC_CardID"];
                co.MC_ID = Convert.ToInt32(context.Request["MC_ID"]);
                co.CO_OrderType = 2;
                co.CO_OrderCode = DateTime.Now.ToString("yyyyMMddHHmmss");
                co.CO_GavePoint = Convert.ToInt32(context.Request["CO_GavePoint"]);
                co.CO_CreateTime = DateTime.Now;
                co.CO_Recash = float.Parse(context.Request["CO_Recash"]);
                m.MC_Point = Convert.ToInt32(context.Request["MC_Point"]);
                string s;
                if (_IConsumeOrdersBLL.PointCash(co, m))
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
     

        public void GetPageSubintPointByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPageSubintPointByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["Begindate"] ?? "", context.Request["Enddate"] ?? "", context.Request["Fuhao"] ?? "", context.Request["CO_GavePoint"] ?? "", context.Request["MC_CardTel"] ?? "", Convert.ToInt32(context.Request["CL_ID"]), context.Request["CO_OrderCode"] ?? "");
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }

        public void GetPageFastComsumeSumByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPageFastComsumeSumByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["Begindate"] ?? "", context.Request["Enddate"] ?? "", context.Request["Fuhao"] ?? "", context.Request["CO_GavePoint"] ?? "", context.Request["MC_CardTel"] ?? "", Convert.ToInt32(context.Request["CL_ID"]), context.Request["CO_OrderCode"] ?? "");
            string json = JsonConvert.SerializeObject(new { total = recordCount, rows = dt });
            context.Response.Write(json);
        }

        public void GetPagePointReCashSumByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPagePointReCashSumByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["Begindate"] ?? "", context.Request["Enddate"] ?? "", context.Request["Fuhao"] ?? "", context.Request["CO_GavePoint"] ?? "", context.Request["MC_CardTel"] ?? "", Convert.ToInt32(context.Request["CL_ID"]), context.Request["CO_OrderCode"] ?? "");
            string json = JsonConvert.SerializeObject(new { total = recordCount, rows = dt });
            context.Response.Write(json);
        }

        public void GetPageExchangLogsSumByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPageExchangLogsSumByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["Begindate"] ?? "", context.Request["Enddate"] ?? "", context.Request["MC_CardTel"] ?? "");
            string json = JsonConvert.SerializeObject(new { total = recordCount, rows = dt });
            context.Response.Write(json);
        }

        public void GetPageConsumeOrdersSumByCondition(HttpContext context)
        {
            int recordCount;
            DataTable dt = _IConsumeOrdersBLL.GetPageConsumeOrdersSumByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, context.Request["Begindate"] ?? "", context.Request["Enddate"] ?? "", context.Request["MC_CardTel"] ?? "",Convert.ToInt32(context.Request["CO_OrderType"]));
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