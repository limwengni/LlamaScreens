using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class ViewBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = "";
            if (Session["booking_id"] == null)
            {
                Response.Redirect("Booking.aspx");
            }
            else
            {
                id = Session["booking_id"].ToString();
            }

            SqlDataSource1.SelectCommand = "SELECT\r\n    Booking.booking_id,\r\n    Booking.member_id,\r\n    Booking.transaction_id,\r\n    Booking.created_date,\r\n    Showtime.showtime_date,\r\n    Venue.venue_no,\r\n    Movie.movie_title,\r\n    COUNT(Ticket.ticket_id) AS total_ticket,\r\n    SUM(CASE WHEN Ticket.seat_type = 'kid' THEN 1 ELSE 0 END) AS total_kid_tickets,\r\n    SUM(CASE WHEN Ticket.seat_type = 'adult' THEN 1 ELSE 0 END) AS total_adult_tickets,\r\n    SUM(CASE WHEN Ticket.seat_type = 'elder' THEN 1 ELSE 0 END) AS total_elder_tickets,\r\n    [Transaction].amount,\r\n    Showtime.showtime_id,\r\n    Showtime.status\r\nFROM\r\n    Booking\r\n    INNER JOIN [Transaction] ON Booking.transaction_id = [Transaction].transaction_id\r\n    INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id\r\n    INNER JOIN Showtime ON Ticket.showtime_id = Showtime.showtime_id\r\n    INNER JOIN Venue ON Showtime.venue_id = Venue.venue_id\r\n    INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id\r\nWHERE\r\n    Booking.booking_id = @booking_id\r\nGROUP BY\r\n    Booking.booking_id,\r\n    Booking.member_id,\r\n    Booking.transaction_id,\r\n    Booking.created_date,\r\n    Showtime.showtime_date,\r\n    Venue.venue_no,\r\n    Movie.movie_title,\r\n    [Transaction].amount,\r\n    Showtime.showtime_id,\r\n    Showtime.status;";
            SqlDataSource1.SelectParameters.Add("booking_id", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT Ticket.ticket_id, Ticket.seat_type, Ticket.seat_id, Movie.default_price FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id INNER JOIN Showtime ON Ticket.showtime_id = Showtime.showtime_id INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id WHERE Booking.booking_id = @booking_id";
            SqlDataSource2.SelectParameters.Add("booking_id", id);
            SqlDataSource2.DataBind();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {

        }
    }
}