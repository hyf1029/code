using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
  public  interface IMemCardsBLL
    {
        /// <summary>
        /// 根据条件给会员进行分页
        /// </summary>
        /// <param name="pageSize"></param>
        /// <param name="currenIndexCoount"></param>
        /// <param name="recordcount"></param>
        /// <param name="mc_CardID"></param>
        /// <param name="mc_Name"></param>
        /// <param name="mc_Mobile"></param>
        /// <param name="cl_ID"></param>
        /// <param name="mc_State"></param>
        /// <returns></returns>
        DataTable GetPageMenCardsByCondition(int pageSize, int currenIndexCoount, out int recordcount, string mc_CardID, string mc_Name, string mc_Mobile, int cl_ID, int mc_State,int sid);
        /// <summary>
        /// 获取最后一个的会员卡号
        /// </summary>
        /// <returns></returns>
        DataTable GetMaxMenCards();
        /// <summary>
        /// 新增会员
        /// </summary>
        /// <param name="mc"></param>
        /// <returns></returns>
        bool InsertMenCards(Model.MemCards mc);
        /// <summary>
        /// 删除会员
        /// </summary>
        /// <param name="mc"></param>
        /// <returns></returns>
        bool DeleteMenCard(Model.MemCards mc);

        /// <summary>
        /// 修改会员
        /// </summary>
        /// <param name="mc"></param>
        /// <returns></returns>
        bool UpdateMenCard(Model.MemCards mc);
        /// <summary>
        /// 获取单个会员信息
        /// </summary>
        /// <returns></returns>
        Model.MemCards GetSingleMenCard(int id);
        /// <summary>
        /// 修改会员状态
        /// </summary>
        /// <param name="mc"></param>
        /// <returns></returns>
        bool UpdateState(Model.MemCards mc);

        /// <summary>
        /// 换卡
        /// </summary>
        /// <param name="mc"></param>
        /// <returns></returns>
        bool NewCard(Model.MemCards mc);
        /// <summary>
        /// 获取密码
        /// </summary>
        /// <returns></returns>
        Model.MemCards GetPwd(string name);

        /// <summary>
        /// 根据会员帐号或者密码查询
        /// </summary>
        /// <param name="cardID"></param>
        /// <param name="tel"></param>
        /// <returns></returns>
        DataTable SearchByTelOrCardID(int MC_CardIDTel);
        /// <summary>
        /// 快速消费
        /// </summary>
        /// <param name="co"></param>
        /// <param name="m"></param>
        /// <returns></returns>
        bool FastConsume(Model.ConsumeOrders co, Model.MemCards m);
        /// <summary>
        /// 减积分
        /// </summary>
        /// <param name="co"></param>
        /// <param name="m"></param>
        /// <returns></returns>
        bool JianPoint(Model.ConsumeOrders co, Model.MemCards m);

        DataTable SearchMenCardByS_ID(int pageSize, int currenIndexCount, out int recordcount, int s_ID);

    }
}

