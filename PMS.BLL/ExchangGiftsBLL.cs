using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class ExchangGiftsBLL : IBLL.IExchangGiftsBLL
    {
        private IDAL.IExchangGiftsDAL _IExchangGiftsDAL = new DAL.ExchangGiftsDAL();

        public bool DeleteGift(ExchangGifts g)
        {
            return _IExchangGiftsDAL.DeleteGift(g);
        }

        public ExchangGifts GetSingleGift(int eg_ID)
        {
            return _IExchangGiftsDAL.GetSingleGift(eg_ID);
        }

        public bool InsertGift(ExchangGifts g)
        {
            return _IExchangGiftsDAL.InsertGift(g);
        }

        public DataTable P_GetPageExchangeGiftsByCondition(int pageIndex, int currentCountindex, out int recordCount, string eg_GiftCode, string eg_GiftName, int sid)
        {
            return _IExchangGiftsDAL.P_GetPageExchangeGiftsByCondition(pageIndex, currentCountindex,out recordCount, eg_GiftCode, eg_GiftName,sid);
        }

        public bool UpdateGift(ExchangGifts g)
        {
            return _IExchangGiftsDAL.UpdateGift(g);
        }
    }
}
