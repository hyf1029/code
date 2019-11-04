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
    public class ShopsDAL : IDAL.IShopsDAL
    {
        public bool DeleteShops(Shops s)
        {
            string sql = "P_DeleteShops";
            SqlParameter[] para ={
                                new SqlParameter("@S_ID",s.S_ID)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }


        public DataTable GetShopsList(int pageSize, int currentIndexCount, out int recordCount, string s_Name, string s_ContactName, string s_Address)
        {
            string sql = "GetPageShopsByCondition";
            SqlParameter[] para = {
                                    new SqlParameter ("@PageSize",pageSize),
                                    new SqlParameter ("@CurrentIndexCount",currentIndexCount),
                                    new SqlParameter ( "@RecordCount",0 ),
                                    new SqlParameter ("@S_Name",s_Name ),
                                    new SqlParameter ( "@S_ContactName",s_ContactName ),
                                    new SqlParameter ("@S_Address", s_Address)

            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public Shops GetSingleShops(int id)
        {
            string sql = "P_GetSingleShop";
            SqlParameter[] para ={
                                new SqlParameter("@S_ID",id)
            };
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            DataRow dr = dt.Rows[0];
            Model.Shops s = new Shops();
            s.S_ID = (int)dr["S_ID"];
            s.S_Name = (string)dr["S_Name"];
            s.S_ContactName = (string)dr["S_ContactName"];
            s.S_ContactTel = (string)dr["S_ContactTel"];
            s.S_Address = (string)dr["S_Address"];
            s.S_Category = (int)dr["S_Category"];
            s.S_CreateTime = (DateTime)dr["S_CreateTime"];
            s.S_IsHasSetAdmin = (bool)dr["S_IsHasSetAdmin"];
            if (dr["S_Remark"] != DBNull.Value)
            {
                s.S_Remark = (string)dr["S_Remark"];
            }

            return s;
        }

        public bool InsertAdminUser(Users u, Model.Shops s)
        {
            string sql = "P_SetShopsAdmin";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",u.S_ID),
                                    new SqlParameter("@US_ID",u.S_ID),
                                     new SqlParameter("@U_LoginName",u.U_LoginName),
                                      new SqlParameter("@S_IsHasSetAdmin",s.S_IsHasSetAdmin),
                                      new SqlParameter("@U_PassWord",u.U_Password),
                                        new SqlParameter("@U_Role",u.U_Role),
                                         new SqlParameter("@U_CanDelete",u.U_CanDelete)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool InsertShops(Shops s)
        {
            string sql = "P_InsertShops";
            SqlParameter[] para ={
                                    new SqlParameter("@S_Name",s.S_Name),
                                    new SqlParameter("@S_Category",s.S_Category),
                                    new SqlParameter("@S_ContactName",s.S_ContactName),
                                    new SqlParameter("@S_ContactTel",s.S_ContactTel),
                                    new SqlParameter("@S_Address",s.S_Address),
                                    new SqlParameter("@S_Remark",s.S_Remark),
                                    new SqlParameter("@S_IsHasSetAdmin",s.S_IsHasSetAdmin),
                                    new SqlParameter("@S_CreateTime",s.S_CreateTime)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }



        public bool UpdateShops(Shops s)
        {
            string sql = "P_UpdateShops";
            SqlParameter[] para ={
                                    new SqlParameter("@S_Name",s.S_Name),
                                    new SqlParameter("@S_Category",s.S_Category),
                                    new SqlParameter("@S_ContactName",s.S_ContactName),
                                    new SqlParameter("@S_ContactTel",s.S_ContactTel),
                                    new SqlParameter("@S_Address",s.S_Address),
                                    new SqlParameter("@S_Remark",s.S_Remark),
                                    new SqlParameter("@S_ID",s.S_ID),

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
