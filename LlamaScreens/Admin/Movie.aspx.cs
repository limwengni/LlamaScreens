using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Movie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["movie_id"].ToString();

                LinkButton editButton = (LinkButton)e.Item.FindControl("Edit_Btn");
                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");
                editButton.CommandArgument = id;
                viewButton.CommandArgument = id;
            }
        }

        protected void Edit_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["movie_id"] = id;
            Response.Redirect("EditMovie.aspx");
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["movie_id"] = id;
            Response.Redirect("ViewMovie.aspx");
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
                status = "%" + status + "%";
            }
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM Movie WHERE MOVIE_TITLE LIKE @id AND STATUS LIKE @status";
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