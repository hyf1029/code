
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
    public class CardLevelsDAL : IDAL.ICardLevelsDAL
    {
        public bool DeleteCardLevel(CardLevels c)
        {
            string sql = "P_DeleteCardLevels";
            SqlParameter[] para = {

                                    new SqlParameter("@CL_ID",c.CL_ID)
            };
            return DBHelper.ExecuteNonQuery(sql,true,para);
        }

        public DataTable GetAllCardLevelName()
        {
            string sql = "P_GetAllCardLevelName";
            return DBHelper.ExecuteSelect(sql,true);
        }

        public DataTable GetCardLevelsList(int pageSize, int currentIndexCount, out int recordCount, string levelName)
        {
            string sql = "P_GetCardLevelsList";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndexCount),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@CL_LevelName",levelName)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql,true,para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public CardLevels GetSingleLCardLevel(int id)
        {
            string sql = "P_GetSingleCardLevel";
            SqlParameter[] para = {

                                    new SqlParameter("@CL_ID",id)
            };
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            DataRow dr = dt.Rows[0];
            Model.CardLevels c = new CardLevels();
            c.CL_ID = (int)dr["CL_ID"];
            c.CL_LevelName = (string)dr["CL_LevelName"];
            c.CL_NeedPoint = (string)dr["CL_NeedPoint"];
            c.CL_Percent =Convert.ToDouble(dr["CL_Percent"]);
            c.CL_Point = Convert.ToDouble(dr["CL_Point"]);
            return c;
        }

        public bool InsertCardLevel(CardLevels c)
        {
            string sql = "P_InsertCardLevels";
            SqlParameter[] para = {
                                    new SqlParameter("@CL_LevelName",c.CL_LevelName),
                                    new SqlParameter("@CL_NeedPoint",c.CL_NeedPoint),
                                    new SqlParameter("@CL_Point",c.CL_Point),
                                    new SqlParameter("@CL_Percent",c.CL_Percent)

            };
            return DBHelper.ExecuteNonQuery(sql,true,para);
        }

        public bool UpdateCardLevel(CardLevels c)
        {
            string sql = "P_UpdateCardLevels";
            SqlParameter[] para = {
                                    new SqlParameter("@CL_LevelName",c.CL_LevelName),
                                    new SqlParameter("@CL_NeedPoint",c.CL_NeedPoint),
                                    new SqlParameter("@CL_Point",c.CL_Point),
                                    new SqlParameter("@CL_Percent",c.CL_Percent),
                                    new SqlParameter("@CL_ID",c.CL_ID)

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
