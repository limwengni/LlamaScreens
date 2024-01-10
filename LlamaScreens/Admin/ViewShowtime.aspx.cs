using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class ViewShowtime : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = "";
            if (Session["showtime_id"] == null)
            {
                Response.Redirect("Showtime.aspx");
            }
            else
            {
                id = Session["showtime_id"].ToString();
            }
            SqlDataSource1.SelectCommand = "SELECT Showtime.showtime_id, Showtime.movie_id, Showtime.showtime_date, Movie.movie_title, Movie.movie_length, Venue.venue_no, VenueType.total_seat, Showtime.status FROM Showtime INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id INNER JOIN Venue ON Showtime.venue_id = Venue.venue_id INNER JOIN VenueType ON Venue.venue_type_id = VenueType.venue_type_id WHERE Showtime.showtime_id = @showtimeID";
            SqlDataSource1.SelectParameters.Add("showtimeID", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT Booking.booking_id, Booking.created_date, COUNT(Ticket.ticket_id) AS total_seat FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id WHERE Ticket.showtime_id = @showtimeID GROUP BY Booking.booking_id, Booking.created_date;";
            SqlDataSource2.SelectParameters.Add("showtimeID", id);
            SqlDataSource2.DataBind();
        }

        protected int getTotalSold()
        {
            int total = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    String query = "SELECT Count(Ticket.ticket_id) AS total_seat FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id WHERE Booking.showtime_id = @showtimeID GROUP BY Booking.booking_id, Booking.created_date, Booking.status";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@showtimeID", Session["showtime_id"].ToString());
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        total += int.Parse(reader["total_seat"].ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                //error
            }

            return total;
        }

        protected int getRemainingSeat(string totalSeat)
        {
            int total = int.Parse(totalSeat);
            int sold = getTotalSold();
            return total - sold;
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["booking_id"].ToString();
                Repeater repeater = (Repeater)Repeater1.Controls[0].FindControl("Repeater2");
                LinkButton viewButton = (LinkButton)repeater.Controls[0].FindControl("View_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            Session["booking_id"] = e.CommandArgument;
            Response.Redirect("ViewBooking.aspx");
        }
    }
}