using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMS.UI
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                Model.Users u = (Model.Users)Session["Users"];
                Label1.Text = u.U_LoginName;
            }
        }

        protected void btnExit_Click(object sender, EventArgs e)
        {
            Application.Clear();
            Response.Redirect("~/Login.aspx");
        }
    }
}