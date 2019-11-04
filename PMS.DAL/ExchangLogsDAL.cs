using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using PMS.Model;

namespace PMS.DAL
{
    public class ExchangLogsDAL : IDAL.IExchangLogsDAL
    {
        public DataTable GetPageExchangLogsByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel)
        {
            string sql = "GetPageExchangLogsByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentByIndex",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@MC_CardTel",mcCardTel)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public bool PointExchange(ExchangLogs el, MemCards m, Model.ExchangGifts eg)
        {
            string sql = "P_PointExchange";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",el.S_ID),
                                    new SqlParameter("@U_ID",el.U_ID),
                                    new SqlParameter("@MC_ID",el.MC_ID),
                                    new SqlParameter("@MC_CardID",el.MC_CardID),
                                    new SqlParameter("@MC_Name",el.MC_Name),
                                    new SqlParameter("@EG_ID",el.EG_ID),
                                    new SqlParameter("@EG_GiftCode",el.EG_GiftCode),
                                    new SqlParameter("@EG_GiftName",el.EG_GiftName),
                                    new SqlParameter("@EL_Number",el.EL_Number),
                                    new SqlParameter("@EL_Point",el.EL_Point),
                                    new SqlParameter("@EL_CreateTime",el.EL_CreateTime),
                                    new SqlParameter("@MC_Point",m.MC_Point),
                                    new SqlParameter("@EG_Number",eg.EG_Number),
                                    new SqlParameter("@EG_ExchangNum",eg.EG_ExchangNum)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
