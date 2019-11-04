using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PMS.DAL
{
    public class DBHelper
    {
        //1、获取数据库连接字符串
        public static string connString = ConfigurationManager.ConnectionStrings["MPMS"].ConnectionString;//Ctrl+J
        //2、专门用来执行增、删、改的方法
        /// <summary>
        /// 此方法专门用来执行增、删、改的sql语句;如果执行成功，则返回true;如果执行失败，则返回false;
        /// </summary>
        /// <param name="sql">参数化的sql语句</param>
        /// <param name="isStoredProcedure">表示调用的是否是存储过程</param>
        /// <param name="para">SqlParameter数组型的参数:在调用方传一个SqlParameter[]数组</param>
        /// <returns></returns>
        public static bool ExecuteNonQuery(string sql,bool isStoredProcedure,params SqlParameter[] para)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    if (para != null)
                    {
                        cmd.Parameters.AddRange(para);
                    }
                    if(isStoredProcedure)
                    {
                        //表示调用的是存储过程
                        cmd.CommandType = CommandType.StoredProcedure;
                    }
                    //打开连接
                    if (conn.State == ConnectionState.Closed)
                    {
                        conn.Open();
                    }
                    int i = cmd.ExecuteNonQuery();
                    return i > 0 ? true : false;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 此方法专门用来执行sql语句，并且返回一个DataTable对象
        /// </summary>
        /// <param name="sql">参数化的sql语句(一般为含有select关键字的sql语句)</param>
        /// <param name="isStoredProcedure">用来指示要执行的SQL语句是否是存储过程</param>
        /// <param name="para">SqlParameter数组型的参数:如果此sql语句没有参数则para为null;否则在调用方传一个SqlParameter[]数组</param>
        /// <returns>DataTable</returns>
        public static DataTable ExecuteSelect(string sql, bool isStoredProcedure, params SqlParameter[] para)
        {
            //SQL注入式攻击
            try
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, connString);
                if (para != null)
                {
                    da.SelectCommand.Parameters.AddRange(para);
                }
                if (isStoredProcedure)
                {
                    //表示要执行的是存储过程
                    da.SelectCommand.CommandType = CommandType.StoredProcedure;
                }
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
