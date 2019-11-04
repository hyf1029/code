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
    public class MemCardsDAL : IDAL.IMemCardsDAL
    {
        public bool DeleteMenCard(MemCards mc)
        {
            string sql = "P_DeleteMenCard";
            SqlParameter[] para = {
                                   new SqlParameter("@MC_CardID",mc.MC_CardID),
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool FastConsume(ConsumeOrders co, MemCards m)
        {
            string sql = "P_FastConsume";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",co.S_ID),
                                    new SqlParameter("@U_ID",co.U_ID),
                                    new SqlParameter("@CO_OrderCode",co.CO_OrderCode),
                                    new SqlParameter("@CO_OrderType",co.CO_OrderType),
                                    new SqlParameter("@MC_ID",co.MC_ID),
                                    new SqlParameter("@MC_CardID",co.MC_CardID),
                                    new SqlParameter("@CO_TotalMoney",co.CO_TotalMoney),
                                    new SqlParameter("@CO_DiscountMoney",co.CO_DiscountMoney),
                                    new SqlParameter("@CO_GavePoint",co.CO_GavePoint),
                                    new SqlParameter("@CO_CreateTime",co.CO_CreateTime),
                                    new SqlParameter("@MC_Point",m.MC_Point),
                                    new SqlParameter("@MC_TotalCount",m.MC_TotalCount)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public DataTable GetMaxMenCards()
        {
            string sql = "P_GetMaxMenCards";
            return DBHelper.ExecuteSelect(sql, true);
        }

        public DataTable GetPageMenCardsByCondition(int pageSize, int currenIndexCoount, out int recordcount, string mc_CardID, string mc_Name, string mc_Mobile, int cl_ID, int mc_State,int sid)
        {
            string sql = "P_GetPageMenCardsByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currenIndexCoount),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@MC_CardID",mc_CardID),
                                    new SqlParameter("@MC_Name",mc_Name),
                                    new SqlParameter("@MC_Mobile",mc_Mobile),
                                    new SqlParameter("@CL_ID",cl_ID),
                                    new SqlParameter("@MC_State",mc_State),
                                    new SqlParameter("@S_ID",sid)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordcount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public MemCards GetPwd(string name)
        {
            string sql = "P_SearchPwd";
            SqlParameter[] para = {
                                    new SqlParameter("@MC_Name",name)
            };
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            DataRow dr = dt.Rows[0];
            Model.MemCards m = new MemCards();
            if(dr["MC_Password"] != DBNull.Value)
            {
                m.MC_Password = (string)dr["MC_Password"];
            }
            return m;
        }

        public MemCards GetSingleMenCard(int id)
        {
            string sql = "P_GetSingleMemCard";
            SqlParameter[] para = {
                 new SqlParameter("@MC_CardID",id)
            };
            DataTable dt= DBHelper.ExecuteSelect(sql,true,para);
            DataRow dr = dt.Rows[0];
            Model.MemCards m = new MemCards();
            if(dr["S_ID"]!=DBNull.Value)
            {
                m.S_ID = (int)dr["S_ID"];
            }
            if (dr["CL_ID"] != DBNull.Value)
            {
                m.CL_ID = (int)dr["CL_ID"];
            }
            if (dr["MC_BirthdayType"] != DBNull.Value)
            {
                m.MC_BirthdayType = (byte)dr["MC_BirthdayType"];
            }
            if (dr["MC_Birthday_Day"] != DBNull.Value)
            {
                m.MC_Birthday_Day = (int)dr["MC_Birthday_Day"];
            }
            if (dr["MC_Birthday_Month"] != DBNull.Value)
            {
                m.MC_Birthday_Month = (int)dr["MC_Birthday_Month"];
            }
            if (dr["MC_CardID"] != DBNull.Value)
            {
                m.MC_CardID = (string)dr["MC_CardID"];
            }
            if (dr["MC_CreateTime"] != DBNull.Value)
            {
                m.MC_CreateTime = (DateTime)dr["MC_CreateTime"];
            }
            if (dr["MC_ID"] != DBNull.Value)
            {
                m.MC_ID = (int)dr["MC_ID"];
            }
            if (dr["MC_IsPast"] != DBNull.Value)
            {
                m.MC_IsPast = (bool)dr["MC_IsPast"];
            }
            if (dr["MC_IsPointAuto"] != DBNull.Value)
            {
                m.MC_IsPointAuto = (bool)dr["MC_IsPointAuto"];
            }
            if (dr["MC_Mobile"] != DBNull.Value)
            {
                m.MC_Mobile = (string)dr["MC_Mobile"];
            }
            if (dr["MC_Money"] != DBNull.Value)
            {
                m.MC_Money = (float)dr["MC_Money"];
            }
            if (dr["MC_Name"] != DBNull.Value)
            {
                m.MC_Name = (string)dr["MC_Name"];
            }
            if (dr["MC_OverCount"] != DBNull.Value)
            {
                m.MC_OverCount = (int)dr["MC_OverCount"];
            }
            if (dr["MC_Password"] != DBNull.Value)
            {
                m.MC_Password = (string)dr["MC_Password"];
            }
            if (dr["MC_PastTime"] != DBNull.Value)
            {
                m.MC_PastTime = (DateTime)dr["MC_PastTime"];
            }
            if (dr["MC_Photo"] != DBNull.Value)
            {
                m.MC_Photo = (string)dr["MC_Photo"];
            }
            if (dr["MC_Point"] != DBNull.Value)
            {
                m.MC_Point = (int)dr["MC_Point"];
            }
            if (dr["MC_RefererCard"] != DBNull.Value)
            {
                m.MC_RefererCard = (string)dr["MC_RefererCard"];
            }
            if (dr["MC_RefererID"] != DBNull.Value)
            {
                m.MC_RefererID = (int)dr["MC_RefererID"];
            }
            if (dr["MC_RefererName"] != DBNull.Value)
            {
                m.MC_RefererName = (string)dr["MC_RefererName"];
            }
            if (dr["MC_Sex"] != DBNull.Value)
            {
                m.MC_Sex = (int)dr["MC_Sex"];
            }
            if (dr["MC_State"] != DBNull.Value)
            {
                m.MC_State = (int)dr["MC_State"];
            }
            if (dr["MC_TotalCount"] != DBNull.Value)
            {
                m.MC_TotalCount = (int)dr["MC_TotalCount"];
            }
            if (dr["MC_TotalMoney"] != DBNull.Value)
            {
                m.MC_TotalMoney = (float)dr["MC_TotalMoney"];
            }
            return m;


        }

        public bool InsertMenCards(MemCards mc)
        {
            string sql = "P_InsertMenCards";
            SqlParameter[] para = {
                                   new SqlParameter("@CL_ID",mc.CL_ID),
                                   new SqlParameter("@S_ID",mc.S_ID),
                                   new SqlParameter("@MC_CardID",mc.MC_CardID),
                                   new SqlParameter("@MC_Password",mc.MC_Password),
                                   new SqlParameter("@MC_Name",mc.MC_Name),
                                   new SqlParameter("@MC_Sex",mc.MC_Sex),
                                   new SqlParameter("@MC_Mobile",mc.MC_Mobile),
                                   new SqlParameter("@MC_BirthdayType",mc.MC_BirthdayType),
                                   new SqlParameter("@MC_Birthday_Month",mc.MC_Birthday_Month),
                                   new SqlParameter("@MC_Birthday_Day",mc.MC_Birthday_Day),
                                   new SqlParameter("@MC_IsPast",mc.MC_IsPast),
                                   new SqlParameter("@MC_PastTime",mc.MC_PastTime),
                                   new SqlParameter("@MC_State",mc.MC_State),
                                   new SqlParameter("@MC_Money",mc.MC_Money),
                                   new SqlParameter("@MC_Point",mc.MC_Point),
                                   new SqlParameter("@MC_IsPointAuto",mc.MC_IsPointAuto),
                                   new SqlParameter("@MC_RefererCard",mc.MC_RefererCard),
                                   new SqlParameter("@MC_RefererName",mc.MC_RefererName),
                                   new SqlParameter("@MC_CreateTime",mc.MC_CreateTime)

            };
            return DBHelper.ExecuteNonQuery(sql,true,para);
        }

        public bool JianPoint(ConsumeOrders co, MemCards m)
        {
            string sql = "P_JianPoint";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",co.S_ID),
                                    new SqlParameter("@U_ID",co.U_ID),
                                    new SqlParameter("@CO_OrderCode",co.CO_OrderCode),
                                    new SqlParameter("@CO_OrderType",co.CO_OrderType),
                                    new SqlParameter("@MC_ID",co.MC_ID),
                                    new SqlParameter("@MC_CardID",co.MC_CardID),
                                    new SqlParameter("@CO_Remark",co.CO_Remark),
                                    new SqlParameter("@CO_GavePoint",co.CO_GavePoint),
                                    new SqlParameter("@CO_CreateTime",co.CO_CreateTime),
                                    new SqlParameter("@MC_Point",m.MC_Point)
                                 
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool NewCard(MemCards mc)
        {
            string sql = "P_NewCard";
            SqlParameter[] para = {
                                   new SqlParameter("@MC_ID",mc.MC_ID),
                                   new SqlParameter("@MC_CardID",mc.MC_CardID),
                                   new SqlParameter("@MC_Password",mc.MC_Password)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public DataTable SearchByTelOrCardID(int MC_CardIDTel)
        {
            string sql = "P_SearchByCardIDOrTel";
            SqlParameter[] para = {
                                  
                                   new SqlParameter("@MC_CardIDTel",MC_CardIDTel)
                                   
            };
            return  DBHelper.ExecuteSelect(sql, true, para);
           
        }

        public DataTable SearchMenCardByS_ID(int pageSize, int currenIndexCount, out int recordcount, int s_ID)
        {
            string sql = "P_SearchMenCardByS_ID";
            SqlParameter[] para = {
                                   new SqlParameter("@PageSize",pageSize),
                                   new SqlParameter("@CurrentIndexCount",currenIndexCount),
                                   new SqlParameter("@RecordCount",0),
                                   new SqlParameter("@S_ID",s_ID)

            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt= DBHelper.ExecuteSelect(sql, true, para);
            recordcount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public bool UpdateMenCard(MemCards mc)
        {
            string sql = "P_UpdateMenCard";
            SqlParameter[] para = {
                                   new SqlParameter("@CL_ID",mc.CL_ID),
                                   new SqlParameter("@MC_CardID",mc.MC_CardID),
                                   new SqlParameter("@MC_Password",mc.MC_Password),
                                   new SqlParameter("@MC_Name",mc.MC_Name),
                                   new SqlParameter("@MC_Sex",mc.MC_Sex),
                                   new SqlParameter("@MC_Mobile",mc.MC_Mobile),
                                   new SqlParameter("@MC_BirthdayType",mc.MC_BirthdayType),
                                   new SqlParameter("@MC_Birthday_Month",mc.MC_Birthday_Month),
                                   new SqlParameter("@MC_Birthday_Day",mc.MC_Birthday_Day),
                                   new SqlParameter("@MC_IsPast",mc.MC_IsPast),
                                   new SqlParameter("@MC_PastTime",mc.MC_PastTime),
                                   new SqlParameter("@MC_State",mc.MC_State),
                                   new SqlParameter("@MC_Money",mc.MC_Money),
                                   new SqlParameter("@MC_Point",mc.MC_Point),
                                   new SqlParameter("@MC_IsPointAuto",mc.MC_IsPointAuto),
                                   new SqlParameter("@MC_RefererCard",mc.MC_RefererCard),
                                   new SqlParameter("@MC_RefererName",mc.MC_RefererName)
                               
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool UpdateState(MemCards mc)
        {
            string sql = "P_UpdateState";
            SqlParameter[] para = {
                                 
                                   new SqlParameter("@MC_CardID",mc.MC_CardID),
                                   new SqlParameter("@MC_State",mc.MC_State)
                                

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
