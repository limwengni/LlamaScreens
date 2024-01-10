using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class ViewMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = "";
            if (Session["member_id"] == null)
            {
                Response.Redirect("Member.aspx");
            }
            else
            {
                id = Session["member_id"].ToString();
            }

            SqlDataSource1.SelectCommand = "SELECT Member.member_id, Member.member_username, Member.member_email, Member.member_password, Member.member_phone_no, Member.member_point, Member.member_birth_date, Member.member_last_login, Member.created_date, Member.status, COUNT([Transaction].transaction_id) AS total_transaction, SUM(CASE WHEN [Transaction].status = 'Pending' THEN 1 ELSE 0 END) AS total_transaction_pending, SUM(CASE WHEN [Transaction].status = 'Canceled' THEN 1 ELSE 0 END) AS total_transaction_canceled FROM Member LEFT OUTER JOIN Booking ON Member.member_id = Booking.member_id LEFT OUTER JOIN [Transaction] ON Booking.transaction_id = [Transaction].transaction_id WHERE Member.member_id = @member_id GROUP BY Member.member_id, Member.member_username, Member.member_email, Member.member_password, Member.member_phone_no, Member.member_point, Member.member_birth_date, Member.member_last_login, Member.created_date, Member.status";
            SqlDataSource1.SelectParameters.Add("member_id", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT [Transaction].transaction_id, [Transaction].transaction_method, [Transaction].amount, [Transaction].created_date, [Transaction].status FROM Booking INNER JOIN Member ON Booking.member_id = Member.member_id INNER JOIN [Transaction] ON Booking.transaction_id = [Transaction].transaction_id WHERE (Member.member_id = @member_id) ORDER BY [Transaction].created_date DESC";
            SqlDataSource2.SelectParameters.Add("member_id", id);
            SqlDataSource2.DataBind();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["member_id"].ToString();
                string status = rowView["status"].ToString();
                Button lockButton = (Button)e.Item.FindControl("Lock_Btn");
                lockButton.Text = (status != "Locked" ? "Lock" : "Unlock") + " Member Account";
                lockButton.CommandArgument = id + ";" + status;
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["transaction_id"].ToString();
                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");

                viewButton.CommandArgument = id;
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {

            string id = e.CommandArgument.ToString();
            Session["transaction_id"] = id;
            Response.Redirect("ViewTransaction.aspx");
        }

        protected void Lock_Btn_Command(object sender, CommandEventArgs e)
        {
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            string id = arg[0];
            string newStatus = "";
            if (arg[1] != "Not Verified")
            {
                if (arg[1] == "Verified")
                {
                    newStatus = "Locked";
                }
                else
                {
                    newStatus = "Verified";
                }

                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "UPDATE [Member] SET status = @status WHERE member_id = @id; SELECT SCOPE_IDENTITY();";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@status", newStatus);
                        cmd.Parameters.AddWithValue("@id", id);
                        string memberID = cmd.ExecuteScalar().ToString();
                        conn.Close();

                        LogController log = new LogController(Session["adminID"].ToString(), "Upateded Member #" + memberID.ToString() + " Status To " + newStatus);
                        log.createLog();
                    }
                    Response.Redirect(Request.Url.ToString());
                }

                catch (Exception ex)
                {
                    //catch
                }
            }
        }
    }
}