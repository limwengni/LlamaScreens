using LlamaScreens.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class AddVenueType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void confirmBtn_Command(object sender, CommandEventArgs e)
        {
            string venueName = "";
            int row = 0;
            int left = 0;
            int middle = 0;
            int right = 0;
            bool valid = true;
            if (Request.Form["venueNameInput"] != null)
            {
                venueName = Request.Form["venueNameInput"].ToString();
                //check if venue name already exist
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT * FROM VenueType WHERE venue_type_name = @venue_name";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@venue_name", venueName);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        ErrMsg.Text = "Venue name already exist";
                        valid = false;
                    }
                    conn.Close();
                }
            }
            else
            {
                ErrMsg.Text = "Please enter venue name";
                valid = false;
            }

            if (Request.Form["venueRowInput"] != null)
            {
                row = Convert.ToInt32(Request.Form["venueRowInput"].ToString());
            }
            else
            {
                ErrMsg.Text = "Please enter number of row";
                valid = false;
            }

            if (Request.Form["venueLeftInput"] != null)
            {
                left = Convert.ToInt32(Request.Form["venueLeftInput"].ToString());
            }
            else
            {
                ErrMsg.Text = "Please enter number of seat in left row";
                valid = false;
            }

            if (Request.Form["venueMiddleInput"] != null)
            {
                middle = Convert.ToInt32(Request.Form["venueMiddleInput"].ToString());
            }
            else
            {
                ErrMsg.Text = "Please enter number of seat in middle row";
                valid = false;
            }

            if (Request.Form["venueRightInput"] != null)
            {
                right = Convert.ToInt32(Request.Form["venueRightInput"].ToString());
            }
            else
            {
                ErrMsg.Text = "Please enter number of seat in right row";
                valid = false;
            }

            if (valid)
            {
                string venueSeat = row + "," + left + "," + middle + "," + right;
                bool hasCopy = false;
                try
                {
                    //see if venue seat already exist
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "SELECT * FROM VenueType WHERE venue_seat = @venueSeat";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@venueSeat", venueSeat);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            //get venue name
                            reader.Read();
                            string venueNameCopy = reader["venue_type_name"].ToString();
                            ErrMsg.Text = "The same seating arrangement already exist under venue name: " + venueNameCopy;
                            hasCopy = true;
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = ex.Message;
                    hasCopy = true;
                }

                if (!hasCopy)
                {
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            conn.Open();
                            string query = "INSERT INTO VenueType (venue_type_name,venue_seat,total_seat,created_date,status) VALUES (@venue_name,@seat,@total,@date,@status);SELECT SCOPE_IDENTITY();";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@venue_name", venueName);
                            cmd.Parameters.AddWithValue("@seat", venueSeat);
                            cmd.Parameters.AddWithValue("@total", row * (left + middle + right));
                            cmd.Parameters.AddWithValue("@date", DateTime.Now);
                            cmd.Parameters.AddWithValue("@status", "Active");
                            string venueTypeID = cmd.ExecuteScalar().ToString();
                            conn.Close();
                            //insert into log
                            LogController log = new LogController(Session["adminID"].ToString(), "Created New Venue Type #" + venueTypeID.ToString());
                            log.createLog();
                            Response.Redirect("Venue.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrMsg.Text = "Failed to add venue type";
                    }
                }
            }
        }
    }
}