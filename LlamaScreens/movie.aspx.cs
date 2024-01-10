using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LlamaScreens.Admin;

namespace LlamaScreens
{
    public partial class movie : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["ViewDetails"] == null && Session["MovieId"] == null)
            {
                Response.Redirect("movieList.aspx");
            }
            else
            {
                string id = Session["MovieId"].ToString();

                SqlDataSource1.SelectCommand = "SELECT Movie.* FROM Movie WHERE movie_id = '" + id + "'";
                SqlDataSource1.DataBind();

            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["movie_id"].ToString();
                string movieTitle = rowView["movie_title"].ToString();
                Session["movieTitle"] = movieTitle;
                //unique showtime date
                SqlDataSource2.SelectCommand = "SELECT DISTINCT CONVERT(date, showtime_date) AS showtime FROM Showtime WHERE movie_id = @id AND showtime_date >= GETDATE()";
                SqlDataSource2.SelectParameters.Clear();
                SqlDataSource2.SelectParameters.Add("id", DbType.String, id);
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = Session["MovieId"].ToString();
                DateTime showtime = DateTime.Parse(rowView["showtime"].ToString());

                LinkButton dynamicButton1 = (LinkButton)e.Item.FindControl("Date_Btn");
                // day -- today, tomorrow, day after tomorrow
                string day = showtime.ToString("dddd");

                //date -- 06-DEC
                string date = showtime.ToString("dd-MMM");
                dynamicButton1.Text = "<p class='day m-0'>" + day + "</p><p class='date m-0'>" + date + "</p>";
                dynamicButton1.CommandArgument = id + ";" + showtime;

                if (e.Item.ItemIndex == 0 && !IsPostBack)
                {
                    //set timeslots
                    dynamicButton1.CssClass += " active";
                    SqlDataSource3.SelectCommand = "SELECT showtime_id, showtime_date FROM Showtime WHERE movie_id = @id AND CONVERT(date, showtime_date) = CONVERT(date, @showtime)";
                    SqlDataSource3.SelectParameters.Clear();
                    SqlDataSource3.SelectParameters.Add("id", DbType.String, id);
                    SqlDataSource3.SelectParameters.Add("showtime", DbType.DateTime, showtime.ToString());
                    SqlDataSource3.DataBind();

                }
                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = dynamicButton1.UniqueID;
                trigger.EventName = "Click";
                PostBackTrigger trigger2 = new PostBackTrigger();
                trigger2.ControlID = dynamicButton1.UniqueID;
                UpdatePanel panel = (UpdatePanel)Repeater1.Controls[0].FindControl("UpdatePanel1");
                panel.Triggers.Add(trigger);
                panel.Triggers.Add(trigger2);
            }


        }

        protected void getTimeSlots(object sender, EventArgs e)
        {
            //make all date button inactive
            Repeater repeater = (Repeater)Repeater1.Controls[0].FindControl("Repeater2");
            foreach (RepeaterItem item in repeater.Items)
            {
                LinkButton linkBtn = (LinkButton)item.FindControl("Date_Btn");
                linkBtn.CssClass = linkBtn.CssClass.Replace(" active", "");
            }
            //make selected date button active
            LinkButton btn = (LinkButton)sender;
            btn.CssClass += " active";
            string[] args = btn.CommandArgument.ToString().Split(';');
            string id = args[0];
            string date = args[1];
            DateTime showtime = DateTime.Parse(date);
            SqlDataSource3.SelectCommand = "SELECT showtime_id, showtime_date FROM Showtime WHERE movie_id = @id AND CONVERT(date, showtime_date) = CONVERT(date, @showtime)";
            SqlDataSource3.SelectParameters.Clear();
            SqlDataSource3.SelectParameters.Add("id", DbType.String, id);
            SqlDataSource3.SelectParameters.Add("showtime", DbType.DateTime, showtime.ToString());
            SqlDataSource3.DataBind();
        }

        protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                DateTime showtime = DateTime.Parse(rowView["showtime_date"].ToString());
                string id = rowView["showtime_id"].ToString();

                //check if timeslot is full
                int total = 0;
                int count = 0;
                //showtime -> venue -> venueType get total seat
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT total_seat FROM VenueType WHERE venue_type_id = (SELECT venue_type_id FROM Venue WHERE venue_id = (SELECT venue_id FROM Showtime WHERE showtime_id = @showtime_id))";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@showtime_id", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            total = Convert.ToInt32(reader["total_seat"].ToString());
                        }
                    }
                    conn.Close();

                    //get count of seat taken
                    conn.Open();
                    query = "SELECT COUNT(*) AS count FROM Ticket WHERE showtime_id = @showtime_id";
                    cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@showtime_id", id);
                    reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["count"].ToString());
                        }
                    }
                    conn.Close();
                }

                LinkButton dynamicButton = (LinkButton)e.Item.FindControl("Slot_Time");
                if (count >= total)
                {
                    //disable button
                    dynamicButton.Enabled = false;
                    dynamicButton.CssClass = "full";
                }
                //time -- 12:00 PM
                string time = showtime.ToString("hh:mm tt");
                dynamicButton.Text = "<p class='time m-0'>" + time + "</p>";
                dynamicButton.CommandArgument = showtime.ToString();
            }
        }

        protected string getViewDetails()
        {
            return Session["ViewDetails"].ToString();
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {

        }

        //get first distinct showtime from repeater2

        protected void Slot_Time_Click(object sender, EventArgs e)
        {
            if (Convert.ToBoolean(Session["loggedIn"]))
            {
                LinkButton clickedBtn = (LinkButton)sender;
                DateTime showtime = DateTime.Parse(clickedBtn.CommandArgument);
                Session["date"] = showtime.ToString("dd MMM yyyy");
                Session["time"] = showtime.ToString("hh:mm tt");
                Response.Redirect("booking.aspx");
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}