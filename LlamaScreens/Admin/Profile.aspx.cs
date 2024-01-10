using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["adminID"] == null)
            {
                Response.Redirect("../adminLogin.aspx");
            }
            string id = Session["adminID"].ToString();
            
            SqlDataSource1.SelectCommand = "SELECT Admin.admin_id, Admin.admin_username, Admin.admin_email, Admin.admin_password, Admin.admin_role, Admin.admin_last_login, Admin.created_date, Admin.status, COUNT(AdminLog.admin_id) AS total_log_record, COUNT(CASE WHEN DATEPART(MONTH, AdminLog.created_date) = DATEPART(MONTH, GETDATE()) THEN 1 ELSE NULL END) AS month_log_record, COUNT(CASE WHEN CONVERT(DATE, AdminLog.created_date) = CONVERT(DATE, GETDATE()) THEN 1 ELSE NULL END) AS today_log_record FROM Admin LEFT OUTER JOIN AdminLog ON Admin.admin_id = AdminLog.admin_id WHERE(Admin.admin_id = @admin_id) GROUP BY Admin.admin_id, Admin.admin_username, Admin.admin_email, Admin.admin_password, Admin.admin_role, Admin.admin_last_login, Admin.created_date, Admin.status";
            SqlDataSource1.SelectParameters.Add("admin_id", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT AdminLog.* FROM AdminLog WHERE AdminLog.admin_id = @admin_id ORDER BY CREATED_DATE DESC";
            SqlDataSource2.SelectParameters.Add("admin_id", id);
            SqlDataSource2.DataBind();
        }

    }
}