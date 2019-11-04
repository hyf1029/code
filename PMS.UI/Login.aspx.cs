using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMS.UI
{
    public partial class Login : System.Web.UI.Page
    {
        private IBLL.IUsersBLL _IUsersBLL = new BLL.UsersBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
               
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Model.Users u = _IUsersBLL.ValidateUsers(U_LoginName.Text, U_Password.Text);
            if (u != null)
            {
                Session["Users"] = u;
                Response.Redirect("/Index.aspx");
            }
            else
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "", "alert('用户名或者密码错误')", true);
            }
        }
    }
}