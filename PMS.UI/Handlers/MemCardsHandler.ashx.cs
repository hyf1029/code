using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;
using System.Web.SessionState;
using System.Transactions;

namespace PMS.UI.Handlers
{
    /// <summary>
    /// MemCardsHandler 的摘要说明
    /// </summary>
    public class MemCardsHandler : IHttpHandler,IRequiresSessionState
    {
        private IBLL.IMemCardsBLL _IMemCardsBLL = new BLL.MemCardsBLL();
        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch (method)
            {
                case "GetPageMenCardsByCondition":
                    GetPageMenCardsByCondition(context);
                    break;
                case "GetMaxMenCards":
                    GetMaxMenCards(context);
                    break;
                case "InsertMemCard":
                    InsertMemCard(context);
                    break;
                case "DeleteMenCard":
                    DeleteMenCard(context);
                    break;
                case "GetSingleMenCards":
                    GetSingleMenCards(context);
                    break;
                case "UpdateMemCard":
                    UpdateMemCard(context);
                    break;
                case "UpdateState":
                    UpdateState(context);
                    break;
                case "NewCard":
                    NewCard(context);
                    break;
                case "vilidatePwd":
                    GetPwd(context);
                    break;
                case "FingMen":
                    FingMen(context);
                    break;
                case "FastConsume":
                    FastConsume(context);
                    break;
                case "JianPoint":
                    JianPoint(context);
                    break;
                case "SearchMenCardByS_ID":
                    SearchMenCardByS_ID(context);
                    break;
            }
        }
        /// <summary>
        /// 根据条件给会员进行分页
        /// </summary>
        /// <param name="context"></param>
        public void GetPageMenCardsByCondition(HttpContext context)
        {
            Model.Users u = (Model.Users)context.Session["Users"];
            int recordCount;
            DataTable dt = _IMemCardsBLL.GetPageMenCardsByCondition(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount,context.Request["MC_CardID"]??"", context.Request["MC_Name"]??"", context.Request["MC_Mobile"]??"", Convert.ToInt32(context.Request["CL_ID"]), Convert.ToInt32(context.Request["MC_State"]),Convert.ToInt32(u.S_ID));
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 获取最后一个会员账号
        /// </summary>
        /// <param name="context"></param>
        public void GetMaxMenCards(HttpContext context)
        {
            DataTable dt = _IMemCardsBLL.GetMaxMenCards();
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 新增会员
        /// </summary>
        /// <param name="context"></param>
        public void InsertMemCard(HttpContext context)
        {
            Model.Users u = (Model.Users)context.Session["Users"];
            Model.MemCards mc = new Model.MemCards();
            mc.MC_CardID = context.Request["MC_CardID"];
            mc.MC_Name = context.Request["MC_Name"];
            mc.MC_Mobile = context.Request["MC_Mobile"];
            mc.MC_Sex = Convert.ToInt32(context.Request["MC_Sex"]);
            mc.CL_ID= Convert.ToInt32(context.Request["CL_ID"]);
            mc.MC_BirthdayType= Convert.ToByte(context.Request["MC_BirthdayType"]);
            mc.MC_Birthday_Month = Convert.ToInt32(context.Request["MC_Birthday_Month"]);
            mc.MC_Birthday_Day = Convert.ToInt32(context.Request["MC_Birthday_Day"]);
            mc.MC_IsPast = Convert.ToBoolean(context.Request["MC_IsPast"]);
            mc.MC_PastTime = Convert.ToDateTime(context.Request["MC_PastTime"]);
            mc.MC_State = Convert.ToInt32(context.Request["MC_State"]);
            mc.MC_Money = float.Parse(context.Request["MC_Money"]);
            mc.MC_Point= Convert.ToInt32(context.Request["MC_Point"]);
            mc.MC_IsPointAuto= Convert.ToBoolean(context.Request["MC_IsPointAuto"]);
            mc.MC_RefererCard = context.Request["MC_RefererCard"];
            mc.MC_RefererName = context.Request["MC_RefererName"];
            mc.MC_CreateTime = DateTime.Now;
            mc.MC_Password = "1";
            mc.S_ID = u.S_ID;
            string s = "";
            if(_IMemCardsBLL.InsertMenCards(mc))
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
        /// 删除会员
        /// </summary>
        /// <param name="context"></param>
        public void DeleteMenCard(HttpContext context)
        {
            Model.MemCards mc = new Model.MemCards();
            mc.MC_CardID = context.Request["MC_CardID"];
            string s = "";
            if (_IMemCardsBLL.DeleteMenCard(mc))
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
        /// 获取单个会员信息
        /// </summary>
        /// <param name="context"></param>
        public void GetSingleMenCards(HttpContext context)
        {
            Model.MemCards mc = _IMemCardsBLL.GetSingleMenCard(Convert.ToInt32(context.Request["MC_CardID"]));
            string json = JsonConvert.SerializeObject(mc);
            context.Response.Write(json);
        }
        /// <summary>
        /// 修改会员
        /// </summary>
        /// <param name="context"></param>
        public void UpdateMemCard(HttpContext context)
        {
            Model.MemCards mc = new Model.MemCards();
            mc.MC_CardID = context.Request["MC_CardID"];
            mc.MC_Name = context.Request["MC_Name"];
            mc.MC_Mobile = context.Request["MC_Mobile"];
            mc.MC_Sex = Convert.ToInt32(context.Request["MC_Sex"]);
            mc.CL_ID = Convert.ToInt32(context.Request["CL_ID"]);
            mc.MC_BirthdayType = Convert.ToByte(context.Request["MC_BirthdayType"]);
            mc.MC_Birthday_Month = Convert.ToInt32(context.Request["MC_Birthday_Month"]);
            mc.MC_Birthday_Day = Convert.ToInt32(context.Request["MC_Birthday_Day"]);
            mc.MC_IsPast = Convert.ToBoolean(context.Request["MC_IsPast"]);
            mc.MC_PastTime = Convert.ToDateTime(context.Request["MC_PastTime"]);
            mc.MC_State = Convert.ToInt32(context.Request["MC_State"]);
            mc.MC_Money = float.Parse(context.Request["MC_Money"]);
            mc.MC_Point = Convert.ToInt32(context.Request["MC_Point"]);
            mc.MC_IsPointAuto = Convert.ToBoolean(context.Request["MC_IsPointAuto"]);
            mc.MC_RefererCard = context.Request["MC_RefererCard"];
            mc.MC_RefererName = context.Request["MC_RefererName"];
           mc.MC_Password = context.Request["MC_Password"];
            string s = "";
            if (_IMemCardsBLL.UpdateMenCard(mc))
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
        /// 挂失/锁定
        /// </summary>
        /// <param name="context"></param>
        public void UpdateState(HttpContext context)
        {
            Model.MemCards mc = new Model.MemCards();
            mc.MC_CardID = context.Request["MC_CardID"];
            mc.MC_State = Convert.ToInt32(context.Request["MC_State"]);
            string s = "";
            if (_IMemCardsBLL.UpdateState(mc))
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
        /// 换卡
        /// </summary>
        /// <param name="context"></param>
        public void NewCard(HttpContext context)
        {
            Model.MemCards mc = new Model.MemCards();
            mc.MC_CardID = context.Request["MC_CardID"];
            mc.MC_Password = context.Request["MC_Password"];
            mc.MC_ID = Convert.ToInt32(context.Request["MC_ID"]);
            string s = "";
            if (_IMemCardsBLL.NewCard(mc))
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
        /// 获取会员卡密码
        /// </summary>
        /// <param name="context"></param>
        public void GetPwd(HttpContext context)
        {
            
            Model.MemCards mc = _IMemCardsBLL.GetPwd(context.Request["MC_Name"]);
            string json = JsonConvert.SerializeObject(mc);
            context.Response.Write(json);

        }
        /// <summary>
        /// 快速消费查找会员
        /// </summary>
        /// <param name="context"></param>
        public void FingMen(HttpContext context)
        {
            DataTable dt = _IMemCardsBLL.SearchByTelOrCardID(Convert.ToInt32(context.Request["MC_CardID"]));
            string json = JsonConvert.SerializeObject(dt);
            context.Response.Write(json);
        }
        /// <summary>
        /// 快速消费
        /// </summary>
        /// <param name="context"></param>
        public void FastConsume(HttpContext context)
        {
            using (TransactionScope ts = new TransactionScope())
            {
                Model.ConsumeOrders co = new Model.ConsumeOrders();
                Model.MemCards m = new Model.MemCards();
                Model.Users u = (Model.Users)context.Session["Users"];
                co.S_ID = u.S_ID;
                co.U_ID = u.U_ID;
                co.MC_CardID = context.Request["MC_CardID"];
                co.MC_ID = Convert.ToInt32(context.Request["MC_ID"]);
                co.CO_TotalMoney = float.Parse(context.Request["CO_TotalMoney"]);
                co.CO_OrderType = 5;
                co.CO_OrderCode = DateTime.Now.ToString("yyyyMMddHHmmss");
                co.CO_GavePoint = Convert.ToInt32(context.Request["CO_GavePoint"]);
                co.CO_CreateTime = DateTime.Now;
                co.CO_DiscountMoney = float.Parse(context.Request["CO_DiscountMoney"]);
                m.MC_TotalCount = Convert.ToInt32(context.Request["MC_TotalCount"]);
                m.MC_Point = Convert.ToInt32(context.Request["MC_Point"]);
                string s;
                if (_IMemCardsBLL.FastConsume(co, m))
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
        /// 减积分
        /// </summary>
        /// <param name="context"></param>
        public void JianPoint(HttpContext context)
        {
            using (TransactionScope ts = new TransactionScope())
            {
                Model.ConsumeOrders co = new Model.ConsumeOrders();
                Model.MemCards m = new Model.MemCards();
                Model.Users u = (Model.Users)context.Session["Users"];
                co.S_ID = u.S_ID;
                co.U_ID = u.U_ID;
                co.MC_CardID = context.Request["MC_CardID"];
                co.MC_ID = Convert.ToInt32(context.Request["MC_ID"]);
                co.CO_OrderType = 3;
                co.CO_OrderCode = DateTime.Now.ToString("yyyyMMddHHmmss");
                co.CO_GavePoint = Convert.ToInt32(context.Request["CO_GavePoint"]);
                co.CO_CreateTime = DateTime.Now;
                co.CO_Remark = context.Request["CO_Remark"];
                m.MC_Point = Convert.ToInt32(context.Request["MC_Point"]);
                string s;
                if (_IMemCardsBLL.JianPoint(co, m))
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

        public void SearchMenCardByS_ID(HttpContext context)
        {
            int recordCount;
            Model.Users u = (Model.Users)context.Session["Users"];
            DataTable dt = _IMemCardsBLL.SearchMenCardByS_ID(Convert.ToInt32(context.Request["rows"]), Convert.ToInt32(context.Request["page"]), out recordCount, u.S_ID);
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
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