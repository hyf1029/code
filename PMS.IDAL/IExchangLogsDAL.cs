using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace PMS.IDAL
{
    public interface IExchangLogsDAL
    {
        bool PointExchange(Model.ExchangLogs el,Model.MemCards m,Model.ExchangGifts eg);

        DataTable GetPageExchangLogsByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel);
    }
}
