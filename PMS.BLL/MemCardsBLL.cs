using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class MemCardsBLL : IBLL.IMemCardsBLL
    {
        private IDAL.IMemCardsDAL _IMemCardsDAL = new DAL.MemCardsDAL();

        public bool DeleteMenCard(MemCards mc)
        {
            return _IMemCardsDAL.DeleteMenCard(mc);
        }

        public bool FastConsume(ConsumeOrders co, MemCards m)
        {
            return _IMemCardsDAL.FastConsume(co,m);
        }

        public DataTable GetMaxMenCards()
        {
            return _IMemCardsDAL.GetMaxMenCards();
        }

        public DataTable GetPageMenCardsByCondition(int pageSize, int currenIndexCoount, out int recordcount, string mc_CardID, string mc_Name, string mc_Mobile, int cl_ID, int mc_State,int sid)
        {
            return _IMemCardsDAL.GetPageMenCardsByCondition(pageSize,currenIndexCoount,out recordcount,mc_CardID,mc_Name,mc_Mobile,cl_ID,mc_State,sid);
        }

        public MemCards GetPwd(string name)
        {
            return _IMemCardsDAL.GetPwd(name);
        }

        public MemCards GetSingleMenCard(int id)
        {
            return _IMemCardsDAL.GetSingleMenCard(id);
        }

        public bool InsertMenCards(MemCards mc)
        {
            return _IMemCardsDAL.InsertMenCards(mc);
        }

        public bool JianPoint(ConsumeOrders co, MemCards m)
        {
            return _IMemCardsDAL.JianPoint(co, m);
        }

        public bool NewCard(MemCards mc)
        {
            return _IMemCardsDAL.NewCard(mc);
        }

        public DataTable SearchByTelOrCardID(int MC_CardIDTel)
        {
            return _IMemCardsDAL.SearchByTelOrCardID(MC_CardIDTel);
        }

        public DataTable SearchMenCardByS_ID(int pageSize, int currenIndexCount, out int recordcount, int s_ID)
        {
            return _IMemCardsDAL.SearchMenCardByS_ID(pageSize,currenIndexCount,out recordcount,s_ID);
        }

        public bool UpdateMenCard(MemCards mc)
        {
            return _IMemCardsDAL.UpdateMenCard(mc);
        }

        public bool UpdateState(MemCards mc)
        {
            return _IMemCardsDAL.UpdateState(mc);
        }
    }
}
