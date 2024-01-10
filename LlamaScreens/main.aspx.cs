using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class main : System.Web.UI.Page
    {
        protected int statusOpt = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["statusOpt"] = 0;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "runslider", "slider();", true);
            }
        }

        protected void Book_Btn_Pressed(object sender, CommandEventArgs e)
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["MovieId"] = arg[0];
            Session["ViewDetails"] = arg[1];
            Response.Redirect("~/movie.aspx");
        }

        protected void SelectBtn_Click(Object sender, EventArgs e)
        {
            statusOpt = (int)ViewState["statusOpt"];
            //run setOption thorugh scriptManager
            Button clickedButton = sender as Button;
            if (clickedButton != null)
            {
                string buttonId = ((Button)sender).ID;
                if (buttonId == "showingBtn")
                {
                    statusOpt = 0;
                    Button btn = sender as Button;
                }
                else if (buttonId == "comingBtn")
                {
                    statusOpt = 1;
                }
                ViewState["statusOpt"] = statusOpt;
            }

            if (comingBtn.CssClass.Contains("active"))
            {
                statusOpt = 1;
            }

            string status = "Now Showing";
            if (statusOpt == 1)
            {
                status = "Coming Soon";
            }
            SqlDataSource1.SelectCommand = "SELECT Movie.* FROM Movie WHERE Status = '" + status + "'";

            SqlDataSource1.DataBind();
        }
    

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string movieId = rowView["movie_id"].ToString();

                Button dynamicButton1 = (Button)e.Item.FindControl("BookButton");
                Button dynamicButton2 = (Button)e.Item.FindControl("DetailButton");

                dynamicButton1.CommandArgument = movieId + ";0";
                dynamicButton2.CommandArgument = movieId + ";1";
            }
        }
    }
}