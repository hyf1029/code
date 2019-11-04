using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class ConsumeOrdersBLL : IBLL.IConsumeOrdersBLL
    {
        private IDAL.IConsumeOrdersDAL _IConsumeOrdersDAL = new DAL.ConsumeOrdersDAL();
        public DataTable GetPageConsumeOrdersByCondition(int pageSize, int currentIndex, out int recordCount, string mcCardTel)
        {
            return _IConsumeOrdersDAL.GetPageConsumeOrdersByCondition(pageSize, currentIndex, out recordCount, mcCardTel);
        }

        public DataTable GetPageConsumeOrdersSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel, int type)
        {
            return _IConsumeOrdersDAL.GetPageConsumeOrdersSumByCondition(pageSize, currentIndex, out recordCount, beginTime, endTime, mcCardTel,type);
        }

        public DataTable GetPageExchangLogsSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string mcCardTel)
        {
            return _IConsumeOrdersDAL.GetPageExchangLogsSumByCondition(pageSize, currentIndex, out recordCount, beginTime, endTime, mcCardTel);
        }

        public DataTable GetPageFastComsumeSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            return _IConsumeOrdersDAL.GetPageFastComsumeSumByCondition(pageSize, currentIndex, out recordCount, beginTime, endTime, fuhao, gavePoint, mcCardTel, cl_ID, orderCode);
        }

        public DataTable GetPagePointReCashSumByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            return _IConsumeOrdersDAL.GetPagePointReCashSumByCondition(pageSize, currentIndex, out recordCount, beginTime, endTime, fuhao, gavePoint, mcCardTel, cl_ID, orderCode);
        }

        public DataTable GetPageSubintPointByCondition(int pageSize, int currentIndex, out int recordCount, string beginTime, string endTime, string fuhao, string gavePoint, string mcCardTel, int cl_ID, string orderCode)
        {
            return _IConsumeOrdersDAL.GetPageSubintPointByCondition(pageSize, currentIndex, out recordCount,beginTime,endTime,fuhao,gavePoint, mcCardTel,cl_ID,orderCode);
        }

        public bool PointCash(ConsumeOrders co, MemCards m)
        {
            return _IConsumeOrdersDAL.PointCash(co, m);
        }
    }
}
