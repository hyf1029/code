using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
   public interface IExchangLogsBLL
    {
        bool PointExchange(Model.ExchangLogs el, Model.MemCards m, Model.ExchangGifts eg);

        DataTable GetPageExchangLogsByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel);
    }
}
