using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Booking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["booking_id"].ToString();

                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["booking_id"] = id;
            Response.Redirect("ViewBooking.aspx");
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT Booking.booking_id, Booking.created_date, Booking.status, Count(Ticket.ticket_id ) as total_ticket FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id WHERE Booking.booking_id LIKE @id Group By Booking.booking_id, Booking.created_date, Booking.status ORDER BY Booking.created_date DESC";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.DataBind();
        }

    }
}