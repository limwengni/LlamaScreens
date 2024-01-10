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
    public partial class ViewAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin_id"] == null)
            {
                Response.Redirect("~/Admin/ManageAdmin.aspx");
            }
            string id = Session["admin_id"].ToString();

            SqlDataSource1.SelectCommand = "SELECT Admin.admin_id, Admin.admin_username, Admin.admin_email, Admin.admin_password, Admin.admin_role, Admin.admin_last_login, Admin.created_date, Admin.status, COUNT(AdminLog.admin_id) AS total_log_record, COUNT(CASE WHEN DATEPART(MONTH, AdminLog.created_date) = DATEPART(MONTH, GETDATE()) THEN 1 ELSE NULL END) AS month_log_record, COUNT(CASE WHEN CONVERT(DATE, AdminLog.created_date) = CONVERT(DATE, GETDATE()) THEN 1 ELSE NULL END) AS today_log_record FROM Admin LEFT OUTER JOIN AdminLog ON Admin.admin_id = AdminLog.admin_id WHERE(Admin.admin_id = @admin_id) GROUP BY Admin.admin_id, Admin.admin_username, Admin.admin_email, Admin.admin_password, Admin.admin_role, Admin.admin_last_login, Admin.created_date, Admin.status";
            SqlDataSource1.SelectParameters.Add("admin_id", id);
            SqlDataSource1.DataBind();

            SqlDataSource2.SelectCommand = "SELECT AdminLog.* FROM AdminLog WHERE AdminLog.admin_id = @admin_id ORDER BY CREATED_DATE DESC";
            SqlDataSource2.SelectParameters.Add("admin_id", id);
            SqlDataSource2.DataBind();
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["admin_id"].ToString();
                string status = rowView["status"].ToString();
                Button statusButton = (Button)e.Item.FindControl("Status_Btn");
                
                statusButton.CommandArgument = id + ";" + status;
                if (id != Session["adminID"].ToString())
                {
                    statusButton.Text = (status != "Locked" ? "Lock" : "Unlock") + " Admin Account";
                }
                else
                {
                    statusButton.Text = "You Cannot Lock Yourself";
                }
            }
        }

        protected void Status_Btn_Command(object sender, CommandEventArgs e)
        {
            try
            {
                string[] arg = new string[2];
                arg = e.CommandArgument.ToString().Split(';');
                string id = arg[0];
                string newStatus = "";
                if(id != Session["adminID"].ToString()) {
                    if (arg[1] == "Active")
                    {
                        newStatus = "Locked";
                    }
                    else
                    {
                        newStatus = "Active";
                    }

                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "UPDATE [ADMIN] SET status = @status WHERE ADMIN_ID = @id";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@status", newStatus);
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        //insert into log
                        if(newStatus == "Active")
                        {
                            newStatus = "Unlock";
                        }
                        else
                        {
                            newStatus = "Lock";
                        }
                        LogController log = new LogController(Session["adminID"].ToString(), newStatus + " Admin Account #" + id);
                        log.createLog();
                    }
                    Response.Redirect("~/Admin/ViewAdmin.aspx");
                }
            }
            catch (Exception ex)
            {
                //catch
            }
        }
    }
}