using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
    public class Shops
    {
        
        public int S_ID { get; set; }
        public string S_Name { get; set; }
        public int S_Category { get; set; }
        public string S_ContactName { get; set; }
        public string S_ContactTel { get; set; }
        public string S_Address { get; set; }
        public string S_Remark { get; set; }
        public bool S_IsHasSetAdmin { get; set; }
        public DateTime S_CreateTime { get; set; }
    }
}
