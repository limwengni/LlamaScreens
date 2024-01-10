using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class template : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected bool isLoggedIn()
        {
            return Convert.ToBoolean(Session["loggedIn"]);
        }

        protected int hasMadePayment()
        {
            bool paymentMade = false;
            if (Session["paymentMade"] != null)
            {
                paymentMade = Convert.ToBoolean(Session["paymentMade"]);
                //clear session variable
                Session["paymentMade"] = null;
                if (paymentMade)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            return -1;
        }
    }
}