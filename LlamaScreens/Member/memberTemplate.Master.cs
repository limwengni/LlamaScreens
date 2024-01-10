using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Member
{
    public partial class memberTemplate : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["loggedIn"] == null)
            {
                Response.Redirect("../login.aspx");
            }
        }

        protected bool isLoggedIn()
        {
            return Convert.ToBoolean(Session["loggedIn"]);
        }
    }
}