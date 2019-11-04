using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
   public class TransferLogs
    {
        public int TL_ID { get; set; }
        public int S_ID { get; set; }
        public int U_ID { get; set; }
        public int TL_FromMC_ID { get; set; }
        public string TL_FromMC_CardID { get; set; }
        public int TL_ToMC_ID { get; set; }
        public string TL_ToMC_CardID { get; set; }
        public decimal TL_TransferMoney { get; set; }
        public string TL_Remark { get; set; }
        public DateTime TL_CreateTime { get; set; }
    }
}
