using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class ExchangLogsBLL : IBLL.IExchangLogsBLL
    {
        private IDAL.IExchangLogsDAL _IExchangLogsDAL = new DAL.ExchangLogsDAL();

        public DataTable GetPageExchangLogsByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel)
        {
            return _IExchangLogsDAL.GetPageExchangLogsByCondition(pageSize, currentIndex, out recordCount, mcCardTel);
        }

        public bool PointExchange(ExchangLogs el, MemCards m, Model.ExchangGifts eg)
        {
            return _IExchangLogsDAL.PointExchange(el, m,eg);
        }
    }
}
