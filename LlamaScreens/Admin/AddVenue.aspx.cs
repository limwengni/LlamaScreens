using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class AddVenue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string First_Repeater_Item(int itemIndex)
        {
            return itemIndex == 0 ? "active-seat-map" : "";
        }

        protected void confirmBtn_Click(object sender, EventArgs e)
        {
            int venue_type_id = 0;
            int venue_no = 0;
            if (venueTypeID.Value != "")
            {
                if (int.TryParse(venueTypeID.Value.Trim(), out int result))
                {
                    venue_type_id = result;
                }
            }
            else
            {
                ErrMsg.Text = "Please Select A Venue Type";
            }

            if (Request.Form["venueNoInput"] != "")
            {
                if (int.TryParse(Request.Form["venueNoInput"].Trim(), out int result))
                {
                    venue_no = result;
                }
                    
            }
            else
            {
                //error
                ErrMsg.Text = "Please Enter Venue No";
            }

            if (venue_type_id != 0 && venue_no != 0)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {

                        bool exist = false;

                        conn.Open();
                        String query = "SELECT VENUE_ID FROM VENUE WHERE VENUE_NO = @no";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@no", venue_no);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            exist = true;
                            ErrMsg.Text = "Venue No Already Exist";
                        }
                        conn.Close();

                        if (!exist)
                        {
                            conn.Open();
                            query = "INSERT INTO Venue (venue_type_id, venue_no, created_date, status) VALUES (@venue_type_id, @venue_no, @created_date, @status);SELECT SCOPE_IDENTITY();";
                            cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@venue_type_id", venue_type_id);
                            cmd.Parameters.AddWithValue("@venue_no", venue_no);
                            cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                            cmd.Parameters.AddWithValue("@status", "Active");
                            string venueID = cmd.ExecuteScalar().ToString();
                            conn.Close();

                            //insert into log
                            LogController log = new LogController(Session["adminID"].ToString(), "Created New Venue #" + venueID.ToString());
                            log.createLog();

                            //redirect to venue list
                            Response.Redirect("Venue.aspx");
                        }
                        
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = "Sorry Failed To Add";
                }
            }
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM [VenueType] WHERE VENUE_TYPE_NAME LIKE @id";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "update();", true);
        }
    }
}