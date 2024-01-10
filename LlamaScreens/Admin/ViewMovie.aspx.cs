using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class ViewMovie : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = "";
            if (Session["movie_id"] == null)
            {
                Response.Redirect("Movie.aspx");
            }
            else
            {
                id = Session["movie_id"].ToString();
            }
            SqlDataSource1.SelectCommand = "SELECT Movie.movie_id, Movie.movie_title, Movie.movie_description, Movie.movie_length, Movie.movie_director, Movie.movie_actor, Movie.movie_country, Movie.movie_company, Movie.default_price, Movie.release_date, Movie.created_date, Movie.status, SUM(Category.category_id) AS total_category FROM Movie LEFT OUTER JOIN MovieCategoryBridge ON Movie.movie_id = MovieCategoryBridge.movie_id LEFT OUTER JOIN Category ON MovieCategoryBridge.category_id = Category.category_id WHERE (Movie.movie_id = @movie_id) GROUP BY Movie.movie_id, Movie.movie_title, Movie.movie_description, Movie.movie_length, Movie.movie_country, Movie.movie_actor, Movie.movie_director, Movie.movie_company, Movie.default_price, Movie.release_date, Movie.created_date, Movie.status";
            SqlDataSource1.SelectParameters.Add("movie_id", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT Venue.venue_no, Showtime.showtime_id, Showtime.movie_id, Showtime.venue_id, Showtime.showtime_date, Showtime.created_date, Showtime.status FROM Venue INNER JOIN Showtime ON Venue.venue_id = Showtime.venue_id INNER JOIN Movie ON Showtime.movie_id = Movie.movie_id WHERE (Movie.movie_id = @movie_id)";
            SqlDataSource2.SelectParameters.Add("movie_id", id);
            SqlDataSource2.DataBind();

            SqlDataSource3.SelectCommand = "SELECT Category.category_name FROM MovieCategoryBridge INNER JOIN Category ON MovieCategoryBridge.category_id = Category.category_id WHERE(MovieCategoryBridge.movie_id = @movie_id)";
            SqlDataSource3.SelectParameters.Add("movie_id", id);
            SqlDataSource3.DataBind();
            
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["showtime_id"].ToString();

                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");
                viewButton.CommandArgument = id;
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["movie_id"].ToString();

                Button editButton = (Button)e.Item.FindControl("Edit_Btn");
                editButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["showtime_id"] = id;
            Response.Redirect("ViewShowtime.aspx");
        }

        protected void Edit_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["movie_id"] = id;
            Response.Redirect("EditMovie.aspx");
        }
    }
}