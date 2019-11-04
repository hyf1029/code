using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
    public interface IExchangGiftsBLL
    {
        /// <summary>
        /// 根据条件给礼品进行分页
        /// </summary>
        /// <param name="pageIndex"></param>
        /// <param name="currentCountindex"></param>
        /// <param name="recordCount"></param>
        /// <param name="eg_GiftCode"></param>
        /// <param name="eg_GiftName"></param>
        /// <returns></returns>
        DataTable P_GetPageExchangeGiftsByCondition(int pageIndex, int currentCountindex, out int recordCount, string eg_GiftCode, string eg_GiftName, int sid);

        /// <summary>
        /// 新增礼品
        /// </summary>
        /// <param name="g"></param>
        /// <returns></returns>
        bool InsertGift(Model.ExchangGifts g);
        /// <summary>
        /// 删除礼品
        /// </summary>
        /// <param name="g"></param>
        /// <returns></returns>
        bool DeleteGift(Model.ExchangGifts g);
        /// <summary>
        /// 修改礼品
        /// </summary>
        /// <param name="g"></param>
        /// <returns></returns>
        bool UpdateGift(Model.ExchangGifts g);
        /// <summary>
        /// 获取单个礼品
        /// </summary>
        /// <param name="eg_ID"></param>
        /// <returns></returns>
        Model.ExchangGifts GetSingleGift(int eg_ID);
    }
}


