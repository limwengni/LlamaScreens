using System;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;

namespace LlamaScreens.Admin
{
    public partial class CheckIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["Llama"] != null)
                {
                    HttpCookie cookie = Request.Cookies["Llama"];
                    if (cookie["role"] != null)
                    {
                        string role = cookie["role"];
                        if (role != "TicketChecker")
                        {
                            Response.Redirect("~/AdminLogin.aspx");
                        }
                        else
                        {
                            Session["role"] = role;
                            Session["adminID"] = cookie["adminID"];
                            Session["adminName"] = cookie["adminName"];
                        }
                    }
                }
                else if (Session["role"] != null)
                {
                    if (Session["role"].ToString() != "TicketChecker")
                    {
                        Response.Redirect("~/AdminLogin.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/AdminLogin.aspx");
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            String bookingID = TextBox1.Text.Trim();
            if (bookingID != "")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "UPDATE Ticket SET Status = 'Checked In' WHERE booking_id = @bookingID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@bookingId", bookingID);
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                Panel2.Visible = true;
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            Panel2.Visible = false;
            String bookingID = TextBox1.Text.Trim();
            bool found = false;
            if (bookingID != "")
            {
                String[] seatType = { "Adult", "Kid", "Senior" };
                int[] seatCount = new int[3];
                int totalCount = 0;
                int showtimeID = 0;
                int venueNo = 0;
                String movieTitle = "";
                DateTime showTimeDate = DateTime.Now;
                for (int i = 0; i < seatType.Length; i++)
                {
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            string query = "SELECT COUNT(*) FROM Ticket WHERE booking_id = @bookingId AND seat_type = @seatType";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@bookingId", bookingID);
                            cmd.Parameters.AddWithValue("@seatType", seatType[i]);
                            conn.Open();
                            object result = cmd.ExecuteScalar();
                            if (result != null)
                            {
                                seatCount[i] = Convert.ToInt32(result);
                                totalCount += seatCount[i];
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                }

                if (totalCount > 0)
                {
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            string query = "SELECT SHOWTIME_ID FROM Ticket WHERE booking_id = @bookingId GROUP BY SHOWTIME_ID";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@bookingId", bookingID);
                            conn.Open();
                            object result = cmd.ExecuteScalar();
                            showtimeID = Convert.ToInt32(result);


                            query = "SELECT showtime_date, VENUE_ID FROM Showtime WHERE showtime_id = @showtimeID";
                            cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@showtimeID", showtimeID);
                            SqlDataReader reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                venueNo = Convert.ToInt32(reader["VENUE_ID"]);
                                showTimeDate = Convert.ToDateTime(reader["showtime_date"]);
                            }
                            conn.Close();
                            conn.Open();
                            query = "SELECT MOVIE_TITLE FROM MOVIE WHERE MOVIE_ID = (SELECT movie_ID from Showtime WHERE showtime_id = @showtimeID)";
                            cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@showtimeID", showtimeID);
                            reader = cmd.ExecuteReader();
                            while (reader.Read())
                            {
                                movieTitle = Convert.ToString(reader["MOVIE_TITLE"]);
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }


                    found = true;
                    total.Text = totalCount.ToString();
                    adult.Text = seatCount[0].ToString();
                    kid.Text = seatCount[1].ToString();
                    senior.Text = seatCount[2].ToString();
                    venue.Text = venueNo.ToString();
                    date.Text = showTimeDate.ToString("dd MMM yyyy");
                    time.Text = showTimeDate.ToString("hh:mm tt");
                    title.Text = movieTitle;
                }

            }

            if (!found)
            {
                Panel1.Visible = false;
                Panel3.Visible = true;
            }
            else
            {
                Panel1.Visible = true;
                Panel3.Visible = false;
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = false;
            TextBox1.Text = "";
        }

        protected void logout_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["Llama"] != null)
            {
                HttpCookie cookie = Request.Cookies["Llama"];
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            Session.Clear();
            Response.Redirect("~/AdminLogin.aspx");
        }
    }
}