using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
  public  interface ITransferLogsBLL
    {
        /// <summary>
        /// 添加转账记录
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        bool InsertTransferLog(Model.TransferLogs t);
    }
}
