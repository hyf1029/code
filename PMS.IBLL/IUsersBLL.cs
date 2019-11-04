using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PMS.IBLL
{
  public  interface IUsersBLL
    {
        /// <summary>
        /// 获取用户列表
        /// </summary>
        /// <returns></returns>
        DataTable GetUsersList(int pageSize, int currentIndexCount, out int recordCount, string loginName, string realName, string tel,int sid);
        /// <summary>
        /// 添加用户
        /// </summary>
        /// <returns></returns>
        bool InsertUser(Model.Users u);
        /// <summary>
        /// 删除用户
        /// </summary>
        /// <returns></returns>
        bool DeleteUser(Model.Users u);
        /// <summary>
        /// 修改用户
        /// </summary>
        /// <returns></returns>
        bool UpdateUser(Model.Users u);
        /// <summary>
        /// 获取单个用户
        /// </summary>
        /// <returns></returns>
        Model.Users GetSingleUser(int id);
        /// <summary>
        /// 验证用户名和密码
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="passWord"></param>
        /// <returns></returns>
        Model.Users ValidateUsers(string userName, string passWord);

        /// <summary>
        /// 修改个人密码
        /// </summary>
        /// <param name="u"></param>
        /// <returns></returns>
        bool UpdatePersonalInfo(Model.Users u);
        /// <summary>
        /// 查看用户密码
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        Model.Users SearchUserPwd(int id);
        /// <summary>
        /// 修改个人密码
        /// </summary>
        /// <param name="u"></param>
        /// <returns></returns>
        bool UpdatePersonalPwd(Model.Users u);

    }
}
