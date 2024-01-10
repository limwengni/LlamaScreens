using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class ViewTransaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = "";
                if (Session["transaction_id"] == null)
                {
                    Response.Redirect("Transaction.aspx");
                }
                else
                {
                    id = Session["transaction_id"].ToString();
                }
                SqlDataSource1.SelectCommand = "SELECT t.transaction_id, t.transaction_method, t.amount, t.created_date, t.status, m.member_username, m.member_id, b.booking_id FROM Booking AS b INNER JOIN Member AS m ON b.member_id = m.member_id INNER JOIN [Transaction] AS t ON b.transaction_id = t.transaction_id WHERE (t.transaction_id = @transac_id)";
                SqlDataSource1.SelectParameters.Add("transac_id", id);
                SqlDataSource1.DataBind();
                SqlDataSource2.SelectCommand = "SELECT [Transaction].transaction_id AS Expr1, Ticket.*, Showtime.showtime_date, Movie.movie_title FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id INNER JOIN [Transaction] ON Booking.transaction_id = [Transaction].transaction_id INNER JOIN Showtime ON Ticket.showtime_id = Showtime.showtime_id INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id WHERE [Transaction].transaction_id = @transac_id";
                SqlDataSource2.SelectParameters.Add("transac_id", id);
                SqlDataSource2.DataBind();
            }
            
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string member_id = rowView["member_id"].ToString();
                LinkButton viewButton = (LinkButton)Repeater1.Controls[0].FindControl("ViewBtn");
                viewButton.CommandArgument = member_id;
            }
        }

        protected void ViewBtn_Command(object sender, CommandEventArgs e)
        {
            Session["member_id"] = e.CommandArgument;
            Response.Redirect("ViewMember.aspx");
        }
    }
}