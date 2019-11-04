using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PMS.Model;

namespace PMS.BLL
{
    public class UsersBLL : IBLL.IUsersBLL
    {
        private IDAL.IUsersDAL _IUsersDAL = new DAL.UsersDAL();
        public bool DeleteUser(Users u)
        {
            return _IUsersDAL.DeleteUser(u);
        }

        public Users GetSingleUser(int id)
        {
            return _IUsersDAL.GetSingleUser(id);
        }

        public DataTable GetUsersList(int pageSize, int currentIndexCount, out int recordCount, string loginName, string realName, string tel,int sid)
        {
            return _IUsersDAL.GetUsersList(pageSize,currentIndexCount,out recordCount,loginName,realName,tel,sid);
        }

        public bool InsertUser(Users u)
        {
            return _IUsersDAL.InsertUser(u);
        }

        public Users SearchUserPwd(int id)
        {
            return _IUsersDAL.SearchUserPwd(id);
        }

        public bool UpdatePersonalInfo(Users u)
        {
            return _IUsersDAL.UpdatePersonalInfo(u);
        }

        public bool UpdatePersonalPwd(Users u)
        {
            return _IUsersDAL.UpdatePersonalPwd(u);
        }

        public bool UpdateUser(Users u)
        {
            return _IUsersDAL.UpdateUser(u);
        }

        public Users ValidateUsers(string userName, string passWord)
        {
            return _IUsersDAL.ValidateUsers(userName,passWord);
        }


    }
}
