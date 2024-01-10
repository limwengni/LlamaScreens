using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class booking : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                Session["BookingPrice"] = lblTotal.Text.Trim();
            }


            if (Session["MovieId"] == null || Session["date"] == null || Session["time"] == null)
            {
                Response.Redirect("movieList.aspx");

            }

            /** dynamic seats... **/
            string id = Session["MovieId"].ToString();

            //get showtimeID
            string date = Session["date"].ToString();
            string time = Session["time"].ToString();



            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    string query = "SELECT default_price FROM Movie WHERE movie_id = @id";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);
                        connection.Open();
                        double defaultPrice = Convert.ToDouble(command.ExecuteScalar());
                        Session["defaultPrice"] = defaultPrice;
                        connection.Close();
                    }

                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            if (DateTime.TryParse(date + " " + time, out DateTime inputDate))
            {
                string query2 = "SELECT showtime_id FROM Showtime WHERE movie_id = @id AND showtime_date = CAST(@showtimeDate AS DATETIME)";
                int showtimeID;

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {

                    using (SqlCommand command = new SqlCommand(query2, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);
                        command.Parameters.AddWithValue("@showtimeDate", inputDate);
                        connection.Open();
                        showtimeID = Convert.ToInt32(command.ExecuteScalar());
                        Session["showtimeID"] = showtimeID;
                        connection.Close();
                    }
                }
            }
        }

        protected string getSeatDetail()
        {
            string seatDetail = "";
            if (Session["showtimeID"] != null)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    string query2 = "SELECT VENUE_SEAT FROM VENUETYPE WHERE VENUE_TYPE_ID = (SELECT VENUE_TYPE_ID FROM VENUE WHERE VENUE_ID = (SELECT venue_id FROM Showtime WHERE Showtime_id = @id))";

                    using (SqlCommand command = new SqlCommand(query2, connection))
                    {
                        command.Parameters.AddWithValue("@id", Session["showtimeID"].ToString());
                        connection.Open();
                        seatDetail = Convert.ToString(command.ExecuteScalar());
                        connection.Close();
                    }
                }
            }

            return seatDetail;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("main.aspx");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            //int seatCount = Convert.ToInt32(hfSeatCount.Value);
            int childCount = Convert.ToInt32(hfChildSeats.Value);
            int adultCount = Convert.ToInt32(hfAdultSeats.Value);
            int seniorCount = Convert.ToInt32(hfSeniorSeats.Value);

            string seats = allSeatNo.Value;

            double adultPrice = Convert.ToDouble(Session["defaultPrice"]);
            double childPrice = adultPrice * 40 / 100;
            double seniorPrice = adultPrice * 70 / 100;

            Session["ChildCount"] = childCount;
            Session["AdultCount"] = adultCount;
            Session["SeniorCount"] = seniorCount;
            Session["Seats"] = seats;

            lblTotal.Text = ((childCount * childPrice) + (adultCount * adultPrice) + (seniorCount * seniorPrice)).ToString("0.00");

            Session["BookingPrice"] = lblTotal.Text.Trim();

            Response.Redirect("payment.aspx");

        }

        protected string getOccupiedSeat()
        {
            if (Session["showtimeID"] != null)
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    string query3 = "SELECT seat_id from Ticket WHERE showtime_id = @ShowtimeId";
                    using (SqlCommand command = new SqlCommand(query3, connection))
                    {
                        command.Parameters.AddWithValue("@ShowtimeId", Session["showtimeID"].ToString());
                        try
                        {
                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.HasRows)
                            {
                                StringBuilder seatDetails = new StringBuilder();

                                while (reader.Read())
                                {
                                    seatDetails.Append(Convert.ToString(reader["seat_id"]) + ",");
                                }

                                // Remove the trailing comma
                                seatDetails.Length--;

                                // Set the value of the hidden input field
                                return seatDetails.ToString();
                            }

                            reader.Close();
                        }
                        catch (Exception ex)
                        {
                            // Handle exceptions here
                            Response.Write(ex.Message);
                        }
                    }
                }
            }
            return "";
        }

        public class MOVIE
        {
            public string movie_id { get; set; }
            public string movie_title { get; set; }
            public string movie_image { get; set; }
            public string movie_description { get; set; }
            public string movie_length { get; set; }
            public string movie_director { get; set; }
            public string movie_actor { get; set; }
            public string movie_country { get; set; }
            public string movie_company { get; set; }
            public double default_price { get; set; }
            public string release_date { get; set; }
            public string created_date { get; set; }
            public string status { get; set; }
        }
    }
}