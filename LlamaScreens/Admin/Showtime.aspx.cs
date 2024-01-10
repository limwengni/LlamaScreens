using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Showtime : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["showtime_id"].ToString();

                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["showtime_id"] = id;
            Response.Redirect("ViewShowtime.aspx");
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
            SqlDataSource1.SelectCommand = "SELECT Showtime.showtime_id, Showtime.showtime_date, Showtime.status, Movie.movie_title FROM Showtime INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id WHERE(Showtime.showtime_id LIKE @id OR Movie.movie_title LIKE @id) AND Showtime.status LIKE @status ORDER BY Showtime.showtime_date DESC";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.SelectParameters.Add("status", status);
            SqlDataSource1.DataBind();
        }

        private string getStatusValue()
        {
            RadioButton[] radioButtons = { radioButton1, radioButton2, radioButton3 };
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