using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Venue : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void search_trigger(object sender, EventArgs e)
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource2.SelectParameters.Clear();
            SqlDataSource2.SelectCommand = "SELECT VenueType.venue_type_name, Venue.venue_no FROM Venue INNER JOIN VenueType ON Venue.venue_type_id = VenueType.venue_type_id WHERE Venue.venue_no LIKE @id OR VenueType.venue_type_name LIKE @id ORDER BY Venue.venue_no";
            SqlDataSource2.SelectParameters.Add("id", keyword);
            SqlDataSource2.DataBind();
        }
    }
}