using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;

namespace PMS.IDAL
{
   public interface IConsumeOrdersDAL
    {
        DataTable GetPageConsumeOrdersByCondition(int pageSize,int currentIndex , out int recordCount,string mcCardTel);

        bool PointCash(Model.ConsumeOrders co,Model.MemCards m);

        DataTable GetPageSubintPointByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime,string endTime,string fuhao,string gavePoint, string mcCardTel,int cl_ID,string orderCode);

        DataTable GetPageFastComsumeSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode);

        DataTable GetPagePointReCashSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode);

        DataTable GetPageExchangLogsSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel);
        DataTable GetPageConsumeOrdersSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel,int type);
    }
}
