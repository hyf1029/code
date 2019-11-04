using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class CardLevelsBLL : IBLL.ICardLevelsBLL
    {
        private IDAL.ICardLevelsDAL _ICardLevelsDAL = new DAL.CardLevelsDAL();

        public bool DeleteCardLevel(CardLevels c)
        {
            return _ICardLevelsDAL.DeleteCardLevel(c);
        }

        public DataTable GetAllCardLevelName()
        {
            return _ICardLevelsDAL.GetAllCardLevelName();
        }

        public DataTable GetCardLevelsList(int pageSize, int currentIndexCount, out int recordCount, string levelName)
        {
            return _ICardLevelsDAL.GetCardLevelsList(pageSize,currentIndexCount,out recordCount,levelName);
        }

        public CardLevels GetSingleLCardLevel(int id)
        {
            return _ICardLevelsDAL.GetSingleLCardLevel(id);
        }

        public bool InsertCardLevel(CardLevels c)
        {
            return _ICardLevelsDAL.InsertCardLevel(c);
        }

        public bool UpdateCardLevel(CardLevels c)
        {
            return _ICardLevelsDAL.UpdateCardLevel(c);
        }
    }
}
