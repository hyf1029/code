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
    public class ConsumeOrdersDAL : IDAL.IConsumeOrdersDAL
    {
        public DataTable GetPageConsumeOrdersByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel)
        {
            string sql = "GetPageConsumeOrdersByCondition";
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

        public DataTable GetPageConsumeOrdersSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel, int type)
        {
            string sql = "P_GetPageConsumeOrdersSumByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentByIndex",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@beginTime",beginTime),
                                    new SqlParameter("@endTime",endTime),
                                    new SqlParameter("@MC_CardTel",mcCardTel),
                                    new SqlParameter("@Type",type)

            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public DataTable GetPageExchangLogsSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel)
        {
            string sql = "P_GetPageExchangLogsSumByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@beginTime",beginTime),
                                    new SqlParameter("@endTime",endTime),
                                    new SqlParameter("@MC_CardTel",mcCardTel)
                                  
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public DataTable GetPageFastComsumeSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            string sql = "P_GetPageFastComsumeSumByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@beginTime",beginTime),
                                    new SqlParameter("@endTime",endTime),
                                    new SqlParameter("@fuhao",fuhao),
                                    new SqlParameter("@CO_GavePoint",gavePoint),
                                    new SqlParameter("@MC_CardTel",mcCardTel),
                                    new SqlParameter("@CL_ID",cl_ID),
                                    new SqlParameter("@CO_OrderCode",orderCode)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public DataTable GetPagePointReCashSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            string sql = "P_GetPagePointReCashSumByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@beginTime",beginTime),
                                    new SqlParameter("@endTime",endTime),
                                    new SqlParameter("@fuhao",fuhao),
                                    new SqlParameter("@CO_GavePoint",gavePoint),
                                    new SqlParameter("@MC_CardTel",mcCardTel),
                                    new SqlParameter("@CL_ID",cl_ID),
                                    new SqlParameter("@CO_OrderCode",orderCode)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public DataTable GetPageSubintPointByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            string sql = "P_GetPageSubintPointByCondition";
            SqlParameter[] para = {
                                    new SqlParameter("@PageSize",pageSize),
                                    new SqlParameter("@CurrentIndexCount",currentIndex),
                                    new SqlParameter("@RecordCount",0),
                                    new SqlParameter("@beginTime",beginTime),
                                    new SqlParameter("@endTime",endTime),
                                    new SqlParameter("@fuhao",fuhao),
                                    new SqlParameter("@CO_GavePoint",gavePoint),
                                    new SqlParameter("@MC_CardTel",mcCardTel),
                                    new SqlParameter("@CL_ID",cl_ID),
                                    new SqlParameter("@CO_OrderCode",orderCode)
            };
            para[2].Direction = ParameterDirection.Output;
            DataTable dt = DBHelper.ExecuteSelect(sql, true, para);
            recordCount = Convert.ToInt32(para[2].Value);
            return dt;
        }

        public bool PointCash(ConsumeOrders co, MemCards m)
        {
            string sql = "P_PointCash";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",co.S_ID),
                                    new SqlParameter("@U_ID",co.U_ID),
                                    new SqlParameter("@CO_OrderCode",co.CO_OrderCode),
                                    new SqlParameter("@CO_OrderType",co.CO_OrderType),
                                    new SqlParameter("@MC_ID",co.MC_ID),
                                    new SqlParameter("@MC_CardID",co.MC_CardID),
                                    new SqlParameter("@CO_Recash",co.CO_Recash),
                                    new SqlParameter("@CO_GavePoint",co.CO_GavePoint),
                                    new SqlParameter("@CO_CreateTime",co.CO_CreateTime),
                                    new SqlParameter("@MC_Point",m.MC_Point)

            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
