﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.Model
{
   public class Users
    {
        public int U_ID { get; set; }
        public int S_ID { get; set; }
        public string U_LoginName { get; set; }
        public string U_Password { get; set; }
        public string U_RealName { get; set; }
        public string U_Sex { get; set; }
        public string U_Telephone { get; set; }
        public int U_Role { get; set; }
        public bool U_CanDelete { get; set; }
    }
}
