using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
   public class ExchangGifts
    {
        public int EG_ID { get; set; }
        public int S_ID { get; set; }
        public string EG_GiftCode { get; set; }
        public string EG_GiftName { get; set; }
        public string EG_Photo { get; set; }
        public int EG_Point { get; set; }
        public int EG_Number { get; set; }
        public int EG_ExchangNum { get; set; }
        public string EG_Remark { get; set; }

    }
}
