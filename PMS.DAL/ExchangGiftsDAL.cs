using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.DAL
{
    public class ExchangGiftsDAL : IDAL.IExchangGiftsDAL
    {
        public bool DeleteGift(ExchangGifts g)
        {
            string sql = "P_DeleteGifts";
            SqlParameter[] para = {
                                    new SqlParameter("@EG_ID",g.EG_ID)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public Model.ExchangGifts GetSingleGift(int eg_ID)
        {
            string sql = "P_GetSingleGifts";
            SqlParameter[] para = {
                                    new SqlParameter("@EG_ID",eg_ID)
            };
            DataTable dt = DBHelper.ExecuteSelect(sql,true,para);
            DataRow dr = dt.Rows[0];
            Model.ExchangGifts g = new ExchangGifts();
            g.EG_ID = (int)dr["EG_ID"];
            g.S_ID = (int)dr["S_ID"];
            if (dr["EG_GiftCode"] != DBNull.Value)
            {
                g.EG_GiftCode = (string)dr["EG_GiftCode"];
            }
               
            if (dr["EG_GiftName"] != DBNull.Value)
            {
                g.EG_GiftName = (string)dr["EG_GiftName"];
            }
                
            if(dr["EG_Photo"]!=DBNull.Value)
            {
                g.EG_Photo = (string)dr["EG_Photo"];
            }
            if(dr["EG_Number"] != DBNull.Value)
            {
                g.EG_Number = (int)dr["EG_Number"];
            }
           if(dr["EG_Point"]!=DBNull.Value)
            {
                g.EG_Point = (int)dr["EG_Point"];
            }
           
            if (dr["EG_Remark"] != DBNull.Value)
            {
                g.EG_Remark = (string)dr["EG_Remark"];
            }
            if (dr["EG_ExchangNum"] != DBNull.Value)
            {
                g.EG_ExchangNum = (int)dr["EG_ExchangNum"];
            }
               
            return g;
        }

        public bool InsertGift(ExchangGifts g)
        {

            string sql = "P_InsertGifts";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",g.S_ID),
                                    new SqlParameter("@EG_GiftCode",g.EG_GiftCode),
                                    new SqlParameter("@EG_GiftName",g.EG_GiftName),
                                    new SqlParameter("@EG_Photo",g.EG_Photo),
                                    new SqlParameter("@EG_Point",g.EG_Point),
                                    new SqlParameter("@EG_Number",g.EG_Number),
                                    new SqlParameter("@EG_Remark",g.EG_Remark)

            };
            return DBHelper.ExecuteNonQuery(sql,true,para);
        }

      

        public DataTable P_GetPageExchangeGiftsByCondition(int pageIndex, int currentCountindex, out int recordCount, string eg_GiftCode, string eg_GiftName, int sid)
        {
            string sql = "P_GetPageExchangeGiftsByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageIndex",pageIndex),
                                    new SqlParameter("@CurrentCountIndex",currentCountindex),
                                    new SqlParameter("@RecordeCount",0),
                                    new SqlParameter("@EG_GiftCode",eg_GiftCode),
                                    new SqlParameter("@EG_GiftName",eg_GiftName),
                                    new SqlParameter("@S_ID",sid)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public bool UpdateGift(ExchangGifts g)
        {
            string sql = "P_UpdateGifts";
            SqlParameter[] para = {
                                    new SqlParameter("@EG_ID",g.EG_ID),
                                    new SqlParameter("@EG_GiftCode",g.EG_GiftCode),
                                    new SqlParameter("@EG_GiftName",g.EG_GiftName),
                                    new SqlParameter("@EG_Photo",g.EG_Photo),
                                    new SqlParameter("@EG_Point",g.EG_Point),
                                    new SqlParameter("@EG_Number",g.EG_Number),
                                    new SqlParameter("@EG_Remark",g.EG_Remark)

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
