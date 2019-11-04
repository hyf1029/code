using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
    public class CardLevels
    {
        public int CL_ID { get; set; }
        public string CL_LevelName { get; set; }
        public string CL_NeedPoint { get; set; }
        public double CL_Point { get; set; }
        public double CL_Percent { get; set; }
    }
}
