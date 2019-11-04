using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class ShopsBLL : IBLL.IShopsBLL
    {
        private IDAL.IShopsDAL _IShopsDAL = new DAL.ShopsDAL();
        public bool DeleteShops(Shops s)
        {
            return _IShopsDAL.DeleteShops(s);
        }

     
        public DataTable GetShopsList(int pageSize, int currentIndexCount, out int recordCount, string s_Name, string s_ContactName, string s_Address)
        {
            return _IShopsDAL.GetShopsList(pageSize,currentIndexCount,out recordCount,s_Name,s_ContactName,s_Address);
        }

        public Shops GetSingleShops(int id)
        {
            return _IShopsDAL.GetSingleShops(id);
        }

        public bool InsertAdminUser(Users u, Shops s)
        {
            return _IShopsDAL.InsertAdminUser(u,s);
        }

        public bool InsertShops(Shops s)
        {
            return _IShopsDAL.InsertShops(s);
        }

        public bool UpdateShops(Shops s)
        {
            return _IShopsDAL.UpdateShops(s);
        }
    }
}
