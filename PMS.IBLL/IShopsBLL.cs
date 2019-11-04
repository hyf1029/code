using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
    public interface IShopsBLL
    {
        /// <summary>
        /// 获取店铺列表
        /// </summary>
        /// <returns></returns>
        DataTable GetShopsList(int pageSize, int currentIndexCount, out int recordCount, string s_Name, string s_ContactName, string s_Address);
        /// <summary>
        /// 添加店铺
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        bool InsertShops(Model.Shops s);
        /// <summary>
        /// 删除店铺
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        bool DeleteShops(Model.Shops s);
        /// <summary>
        /// 修改店铺
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        bool UpdateShops(Model.Shops s);
        /// <summary>
        /// 获取单个店铺
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Model.Shops GetSingleShops(int id);


        bool InsertAdminUser(Model.Users u, Model.Shops s);
    }
}
