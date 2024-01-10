using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class AddShowtime : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM [MOVIE] WHERE MOVIE_TITLE LIKE @id OR MOVIE_ID LIKE @id";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "update();", true);
        }

        

        protected void btnCreateShowtime_Click(object sender, EventArgs e)
        {
            string movie = movieInput.Text.Trim();
            string venue = venueInput.Text.Trim();
            bool hasDateTime = true;
            DateTime datetime = new DateTime();
            if (movie == "")
            {
                ErrMsg.Text = "Please Select A Movie";
            }

            if (venue == "")
            {
                ErrMsg.Text = "Please Select A Venue";
            }

            if (DateTime.TryParse(date.Text.Trim(), out DateTime dateResult) && DateTime.TryParse(time.Text.Trim(), out DateTime timeResult))
            {
                datetime = DateTime.Parse(date.Text.Trim() + " " + time.Text.Trim());
            }
            else
            {
                ErrMsg.Text = "Please fill in the date and time slot";
                hasDateTime = false;
            }
            
            if (movie != "" && venue != "" && hasDateTime)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        //find movie id
                        string query = "SELECT movie_id FROM Movie WHERE movie_title = @movie";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movie", movie);
                        conn.Open();
                        string movieID = cmd.ExecuteScalar().ToString();
                        conn.Close();

                        //find venue id
                        query = "SELECT venue_id FROM Venue WHERE venue_no = @venue";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@venue", venue);
                        conn.Open();
                        string venueID = cmd.ExecuteScalar().ToString();
                        conn.Close();

                        if (movieID == "" || venueID == "")
                        {
                            ErrMsg.Text = "Movie or Venue not found";
                            return;
                        }

                        //insert showtime
                        query = "INSERT INTO Showtime (movie_id,venue_id,showtime_date,created_date,status) VALUES (@movieID,@venueID,@date,@createdDate,@status);SELECT SCOPE_IDENTITY();";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movieID", movieID);
                        cmd.Parameters.AddWithValue("@venueID", venueID);
                        cmd.Parameters.AddWithValue("@date", datetime);
                        cmd.Parameters.AddWithValue("@createdDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@status", "Available");

                        conn.Open();
                        string showtimeID = cmd.ExecuteScalar().ToString();
                        conn.Close();

                        query = "UPDATE MOVIE SET STATUS = 'Now Showing' WHERE MOVIE_ID = @movie AND STATUS = 'Finished'";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movie", movieID); 
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        //insert into log
                        LogController log = new LogController(Session["adminID"].ToString(), "Created New Showtime #" + showtimeID.ToString());
                        log.createLog();

                        Response.Redirect("Showtime.aspx");
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = ex.Message;
                }
            }
        }

        protected void date_TextChanged(object sender, EventArgs e)
        {
            venueInput.Text = "";
            DateTime datetime = DateTime.MinValue;
            if (DateTime.TryParse(date.Text.Trim(), out DateTime dateResult) && DateTime.TryParse(time.Text.Trim(), out DateTime timeResult))
            {
                datetime = dateResult.Date.Add(timeResult.TimeOfDay);
                Response.Write(datetime);
            }
            if(datetime != DateTime.MinValue)
            {
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectCommand = @"SELECT VENUE.*, VENUETYPE.*
                    FROM [VENUE]
                    LEFT JOIN [VENUETYPE] ON VENUE.VENUE_TYPE_ID = VENUETYPE.VENUE_TYPE_ID
                    WHERE VENUE.VENUE_ID NOT IN (
                        SELECT DISTINCT VENUE_ID
                        FROM SHOWTIME
                        WHERE SHOWTIME_DATE <= @datetime
                        AND DATEADD(hour, 2, SHOWTIME_DATE) >= @datetime
                    ) ORDER BY CAST(VENUE.VENUE_NO AS INT) ASC;";
                SqlDataSource2.SelectParameters.Add("datetime", datetime.ToString());
                SqlDataSource2.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "", "update();", true);
            }
        }
    }
}