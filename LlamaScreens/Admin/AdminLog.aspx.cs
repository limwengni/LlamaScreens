using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class AdminLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["admin_id"].ToString();

                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Admin_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void View_Admin_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["admin_id"] = id;
            Response.Redirect("ViewAdmin.aspx");
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT AdminLog.*, Admin.admin_username FROM AdminLog INNER JOIN Admin ON AdminLog.admin_id = Admin.admin_id WHERE ADMIN.ADMIN_USERNAME LIKE @id OR ADMINLOG.ADMINLOG_MESSAGE LIKE @id ORDER BY CREATED_DATE DESC";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.DataBind();
        }
    }
}