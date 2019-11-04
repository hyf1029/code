using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class TransferLogsBLL : IBLL.ITransferLogsBLL
    {
        private IDAL.ITransferLogsDAL _ITransferLogsDAL = new DAL.TransferLogsDAL();

        public bool InsertTransferLog(TransferLogs t)
        {
            return _ITransferLogsDAL.InsertTransferLog(t);
        }
    }
}
