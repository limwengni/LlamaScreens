using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Transaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["transaction_id"].ToString();

                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["transaction_id"] = id;
            Response.Redirect("ViewTransaction.aspx");
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            string status = getStatusValue().Trim();
            if (status == "all")
            {
                status = "%%";
            }
            else
            {
                status = "%" + status  + "%";
            }
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM [Transaction] WHERE TRANSACTION_ID LIKE @id AND STATUS LIKE @status ORDER BY CREATED_DATE DESC";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.SelectParameters.Add("status", status);
            SqlDataSource1.DataBind();
        }

        private string getStatusValue()
        {
            RadioButton[] radioButtons = { radioButton1, radioButton2, radioButton3, radioButton4 };
            foreach (RadioButton radioButton in radioButtons)
            {
                if (radioButton.Checked)
                {
                    return radioButton.Attributes["Value"];
                }
            }
            return "";
        }
    }
}