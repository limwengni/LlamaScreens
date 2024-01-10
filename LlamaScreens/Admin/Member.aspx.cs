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
    public partial class Member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["member_id"].ToString();
                string status = rowView["status"].ToString();
                LinkButton lockButton = (LinkButton)e.Item.FindControl("Lock_Btn");
                LinkButton viewButton = (LinkButton)e.Item.FindControl("View_Btn");

                lockButton.CommandArgument = id + ";" + status;
                viewButton.CommandArgument = id;

                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = lockButton.UniqueID;
                trigger.EventName = "Command";
                UpdatePanel1.Triggers.Add(trigger);
            }
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

                        LogController log = new LogController(Session["adminID"].ToString(), "Upateded Member #" + id + " Status To " + newStatus);
                        log.createLog();
                    }
                    search();
                }

                catch (Exception ex)
                {
                    //catch
                }
            }
        }

        protected void View_Btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Session["member_id"] = id;
            Response.Redirect("ViewMember.aspx");
        }

        protected void search()
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            string status = getStatusValue().Trim();
            if (status == "all")
            {
                status = "%%";
            }
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM [Member] WHERE (MEMBER_EMAIL LIKE @id OR MEMBER_USERNAME LIKE @id) AND STATUS LIKE @status";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.SelectParameters.Add("status", status);
            SqlDataSource1.DataBind();
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            search();
        }

        private string getStatusValue()
        {
            RadioButton[] radioButtons = { radioButton1, radioButton2, radioButton3, radioButton4 };
            foreach (RadioButton radioButton in radioButtons)
            {
                if (radioButton.Checked)
                {
                    return radioButton.Attributes["Value"];
                }
            }
            return "all";
        }
    }
}