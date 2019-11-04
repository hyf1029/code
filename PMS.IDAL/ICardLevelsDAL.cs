using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Data;
namespace PMS.IDAL
{
    public interface ICardLevelsDAL
    {
        /// <summary>
        /// 获取会员等级列表
        /// </summary>
        /// <returns></returns>
        DataTable GetCardLevelsList(int pageSize ,int currentIndexCount,out int recordCount,string levelName);
        /// <summary>
        /// 新增会员等级
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>
        bool InsertCardLevel(Model.CardLevels c);
        /// <summary>
        /// 删除会员等级
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>
        bool DeleteCardLevel(Model.CardLevels c);
        /// <summary>
        /// 修改会员等级
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>
        bool UpdateCardLevel(Model.CardLevels c);
        /// <summary>
        /// 获取单个会员等级
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Model.CardLevels GetSingleLCardLevel(int id);

        /// <summary>
        /// 获取所有的等级名称
        /// </summary>
        /// <returns></returns>
        DataTable GetAllCardLevelName();
    }
}
