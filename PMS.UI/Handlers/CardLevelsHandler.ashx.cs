using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Newtonsoft.Json;

namespace PMS.UI.Handlers
{
    /// <summary>
    /// CardLevelsHandler 的摘要说明
    /// </summary>
    public class CardLevelsHandler : IHttpHandler
    {
        private IBLL.ICardLevelsBLL _ICardLevelsBLL = new BLL.CardLevelsBLL();

        public void ProcessRequest(HttpContext context)
        {
            string method = context.Request["Method"];
            switch(method)
            {
                case "GetCardLevelList":
                    GetCardLevelList(context);
                    break;
                case "InsertCardLevel":
                    InsertCardLevel(context);
                    break;
                case "DeleteCardLevel":
                    DeleteCardLevel(context);
                    break;
                case "GetSingleCardLevel":
                    GetSingleCardLevel(context);
                    break;
                case "UpdateCardLevel":
                    UpdateCardLevel(context);
                    break;
                case "GetAllCardLevelName":
                    GetAllCardLevelName(context);
                    break;
                
            }
        }
        /// <summary>
        /// 获取会员等级列表
        /// </summary>
        /// <param name="context"></param>
        private void GetCardLevelList(HttpContext context)
        {
            int recordCount;
            DataTable dt = _ICardLevelsBLL.GetCardLevelsList(Convert.ToInt32(context.Request["PageSize"]), Convert.ToInt32(context.Request["CurrentIndexCount"]), out recordCount, context.Request["CL_LevelName"]??"");
            string json = JsonConvert.SerializeObject(new {total=recordCount,rows=dt });
            context.Response.Write(json);
        }
        /// <summary>
        /// 新增会员等级
        /// </summary>
        /// <param name="context"></param>
        private void InsertCardLevel(HttpContext context)
        {
            Model.CardLevels c = new Model.CardLevels();
            c.CL_LevelName = context.Request["CL_LevelName"];
            c.CL_NeedPoint = context.Request["CL_NeedPoint"];
            c.CL_Percent = Convert.ToDouble(context.Request["CL_Percent"]);
            c.CL_Point  = Convert.ToDouble(context.Request["CL_Point"]);
            string s;
            if(_ICardLevelsBLL.InsertCardLevel(c))
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
        /// 删除会员等级
        /// </summary>
        /// <param name="context"></param>
        public void DeleteCardLevel(HttpContext context)
        {
            Model.CardLevels c = new Model.CardLevels();
            c.CL_ID =Convert.ToInt32(context.Request["CL_ID"]);
            string s;
            if (_ICardLevelsBLL.DeleteCardLevel(c))
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
        /// 获取单个会员等级
        /// </summary>
        /// <param name="context"></param>
        public void GetSingleCardLevel(HttpContext context)
        {
            Model.CardLevels c = _ICardLevelsBLL.GetSingleLCardLevel(Convert.ToInt32(context.Request["CL_ID"]));
            string json = JsonConvert.SerializeObject(c);
            context.Response.Write(json);
        }

        /// <summary>
        /// 修改会员等级
        /// </summary>
        /// <param name="context"></param>
        public void UpdateCardLevel(HttpContext context)
        {

            Model.CardLevels c = new Model.CardLevels();
            c.CL_LevelName = context.Request["CL_LevelName"];
            c.CL_NeedPoint = context.Request["CL_NeedPoint"];
            c.CL_Percent = Convert.ToDouble(context.Request["CL_Percent"]);
            c.CL_Point = Convert.ToDouble(context.Request["CL_Point"]);
            c.CL_ID = Convert.ToInt32(context.Request["CL_ID"]);
            string s;
            if (_ICardLevelsBLL.UpdateCardLevel(c))
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
        /// 获取所有的等级名称
        /// </summary>
        /// <param name="context"></param>
        public void GetAllCardLevelName(HttpContext context)
        {
            DataTable dt = _ICardLevelsBLL.GetAllCardLevelName();
            string json = JsonConvert.SerializeObject(dt);
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