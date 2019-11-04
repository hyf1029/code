using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
  public  class ExchangLogs
    {
        public int EL_ID { get; set; }
        public int S_ID { get; set; }
        public int U_ID { get; set; }
        public int MC_ID { get; set; }
        public string MC_CardID { get; set; }
        public string MC_Name { get; set; }
        public int EG_ID { get; set; }
        public string EG_GiftCode { get; set; }
        public string EG_GiftName { get; set; }
        public int EL_Number { get; set; }
        public int EL_Point { get; set; }
        public DateTime EL_CreateTime { get; set; }

    }
}
