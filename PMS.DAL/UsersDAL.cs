using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;
using System.Data.SqlClient;

namespace PMS.DAL
{
    public class UsersDAL : IDAL.IUsersDAL
    {
        public bool DeleteUser(Model.Users u)
        {
            string sql = "P_DeleteUser";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",u.U_ID)
            };
            return DBHelper.ExecuteNonQuery(sql,true,para);
        }

      
        public Users GetSingleUser(int id)
        {
            string sql = "P_GetSingleUser";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",id)
            };
            DataTable dt= DBHelper.ExecuteSelect(sql, true, para);
            DataRow dr = dt.Rows[0];
            Model.Users u = new Users();
            if (dr["S_ID"] != DBNull.Value)
            {
                u.S_ID = (int)dr["S_ID"];
            }
            if (dr["U_ID"] != DBNull.Value)
            {
                u.U_ID = (int)dr["U_ID"];
            }
            if (dr["U_LoginName"] != DBNull.Value)
            {
                u.U_LoginName = (string)dr["U_LoginName"];
            }
            if (dr["U_Password"] != DBNull.Value)
            {
                u.U_Password = (string)dr["U_Password"];
            }
            if (dr["U_RealName"] != DBNull.Value)
            {
                u.U_RealName = (string)dr["U_RealName"];
            }
            if (dr["U_Sex"] != DBNull.Value)
            {
                u.U_Sex = (string)dr["U_Sex"];
            }

            if (dr["U_Telephone"] != DBNull.Value)
            {
                u.U_Telephone = (string)dr["U_Telephone"];
            }
            if (dr["U_Role"] != DBNull.Value)
            {
                u.U_Role = (int)dr["U_Role"];
            }

            if (dr["U_CanDelete"] != DBNull.Value)
            {
                u.U_CanDelete = (bool)dr["U_CanDelete"];
            }
            return u;
        }

 
        public DataTable GetUsersList(int pageSize, int currentIndexCount, out int recordCount, string loginName, string realName, string tel, int sid)
        {
            string sql = "P_GetUserList";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndexCount),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@U_LoginName",loginName),
                                    new SqlParameter("@U_RealName",realName),
                                    new SqlParameter("@U_Telephone",tel),
                                     new SqlParameter("@S_ID",sid)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public bool InsertUser(Model.Users u)
        {
            string sql = "P_InsertUser";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",u.S_ID),
                                    new SqlParameter("@U_LoginName",u.U_LoginName),
                                    new SqlParameter("@U_Password",u.U_Password),
                                    new SqlParameter("@U_RealName",u.U_RealName),
                                    new SqlParameter("@U_Telephone",u.U_Telephone),
                                    new SqlParameter("@U_Sex",u.U_Sex),
                                    new SqlParameter("@U_Role",u.U_Role),
                                    new SqlParameter("@U_CanDelete",u.U_CanDelete)

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public Users SearchUserPwd(int id)
        {
            string sql = "P_SearchUserPwd";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",id)
                                 

            };
            DataTable dt= DBHelper.ExecuteSelect(sql, true, para);
            DataRow dr = dt.Rows[0];
            Model.Users u = new Users();
            if (dr["U_Password"] != DBNull.Value)
            {
                u.U_Password = (string)dr["U_Password"];
            }
            return u;
        }

        public bool UpdatePersonalInfo(Users u)
        {
            string sql = "P_UpdatePersonalInfo";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",u.U_ID),
                                    new SqlParameter("@U_LoginName",u.U_LoginName),
                                    new SqlParameter("@U_RealName",u.U_RealName),
                                    new SqlParameter("@U_Telephone",u.U_Telephone),
                                    new SqlParameter("@U_Sex",u.U_Sex)
                                  

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool UpdatePersonalPwd(Users u)
        {
            string sql = "P_UpdatePersonalPwd";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",u.U_ID),
                                    new SqlParameter("@U_Password",u.U_Password)


            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public bool UpdateUser(Model.Users u)
        {
            string sql = "P_UpdateUser";
            SqlParameter[] para = {
                                    new SqlParameter("@U_ID",u.U_ID),
                                    new SqlParameter("@U_LoginName",u.U_LoginName),
                                    new SqlParameter("@U_Password",u.U_Password),
                                    new SqlParameter("@U_RealName",u.U_RealName),
                                    new SqlParameter("@U_Telephone",u.U_Telephone),
                                    new SqlParameter("@U_Sex",u.U_Sex),
                                    new SqlParameter("@U_Role",u.U_Role),
                                    new SqlParameter("@U_CanDelete",u.U_CanDelete)
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }

        public Users ValidateUsers(string userName, string passWord)
        {
            string sql = "P_UserLogin";
            SqlParameter[] para = {
                                    new SqlParameter("@U_LoginName",userName),
                                    new SqlParameter("@U_Password",passWord)
            };
            DataTable dt= DBHelper.ExecuteSelect(sql,true,para);
            Model.Users u = new Users();
            if (dt.Rows.Count>0)
            {
                DataRow dr = dt.Rows[0];
                u.S_ID = (int)dr["S_ID"];
                u.U_ID = (int)dr["U_ID"];
                u.U_LoginName = (string)dr["U_LoginName"];
                u.U_Password = (string)dr["U_Password"];
                u.U_RealName = (string)dr["U_RealName"];
                u.U_Sex = (string)dr["U_Sex"];
                u.U_Telephone = (string)dr["U_Telephone"];
                u.U_Role = (int)dr["U_Role"];
                u.U_CanDelete = (bool)dr["U_CanDelete"];


            }
            else
            {
                u = null;
            }
            return u;
        }
    }
}
