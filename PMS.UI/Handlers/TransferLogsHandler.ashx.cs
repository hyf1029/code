using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace PMS.UI.Handlers
{
    /// <summary>
    /// TransferLogsHandler 的摘要说明
    /// </summary>
    public class TransferLogsHandler : IHttpHandler,IRequiresSessionState
    {
        private IBLL.ITransferLogsBLL _ITransferLogsBLL = new BLL.TransferLogsBLL();

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch(method)
            {
                case "InsertTransferLog":
                    InsertTransferLog(context);
                    break;
            }
        }
        /// <summary>
        /// 添加转账记录
        /// </summary>
        /// <param name="context"></param>
        public void InsertTransferLog(HttpContext context)
        {
            Model.TransferLogs t = new Model.TransferLogs();
            Model.Users u = (Model.Users)context.Session["Users"];
            t.S_ID = u.S_ID;
            t.U_ID = u.U_ID;
            t.TL_FromMC_CardID = context.Request["TL_FromMC_CardID"];
            t.TL_FromMC_ID =Convert.ToInt32(context.Request["TL_FromMC_ID"]);
            t.TL_ToMC_CardID = context.Request["TL_ToMC_CardID"];
            t.TL_ToMC_ID = Convert.ToInt32(context.Request["TL_ToMC_ID"]);
            t.TL_Remark = context.Request["TL_Remark"];
            t.TL_TransferMoney =Convert.ToDecimal(context.Request["TL_TransferMoney"]);
            t.TL_CreateTime = DateTime.Now;
            string s;
            if(_ITransferLogsBLL.InsertTransferLog(t))
            {
                s = "1";
            }
            else
            {
                s = "0";
            }
            context.Response.Write(s);
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