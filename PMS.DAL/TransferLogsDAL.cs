using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;
using System.Data;
using System.Data.SqlClient;

namespace PMS.DAL
{
    public class TransferLogsDAL : IDAL.ITransferLogsDAL
    {
        public bool InsertTransferLog(TransferLogs t)
        {
            string sql = "P_InsertTransferLogs";
            SqlParameter[] para = {
                                    new SqlParameter("@S_ID",t.S_ID),
                                    new SqlParameter("@U_ID",t.U_ID),
                                    new SqlParameter("@TL_FromMC_ID",t.TL_FromMC_ID),
                                    new SqlParameter("@TL_FromMC_CardID",t.TL_FromMC_CardID),
                                    new SqlParameter("@TL_ToMC_ID",t.TL_ToMC_ID),
                                    new SqlParameter("@TL_ToMC_CardID",t.TL_ToMC_CardID),
                                    new SqlParameter("@TL_TransferMoney",t.TL_TransferMoney),
                                    new SqlParameter("@TL_Remark",t.TL_Remark),
                                    new SqlParameter("@TL_CreateTime",t.TL_CreateTime)
                                    
            };
            return DBHelper.ExecuteNonQuery(sql, true, para);
        }
    }
}
