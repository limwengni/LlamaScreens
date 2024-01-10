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
    public partial class AddAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string username = "";
                string email = "";
                string passwd = "";
                string role = "";
                if (Request.Form["nameInput"] == null)
                {
                    Username_ErrMsg.Text = "Username cannot be empty";
                }
                else
                {
                    username = Request.Form["nameInput"];
                }

                if (Request.Form["emailInput"] == null)
                {
                    Email_ErrMsg.Text = "Email cannot be empty";
                }
                else
                {
                    email = Request.Form["emailInput"];
                }

                if (Request.Form["passwordInput"] == null)
                {
                    Password_ErrMsg.Text = "Password cannot be empty";
                }
                else
                {
                    passwd = Request.Form["passwordInput"];
                }

                if (Request.Form["role"] == null)
                {
                    Password_ErrMsg.Text = "Please pick a row";
                }
                else
                {
                    role = Request.Form["role"];
                }

                if (username != "" && email != "" && passwd != "" && role != "")
                {
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            string hashedPassword = StringUtil.PasswordHandler.hashingPassword(passwd);

                            string query = "INSERT INTO Admin (admin_username, admin_email, admin_password, admin_role, created_date, status) VALUES (@username, @email, @passwd, @role, @date, @status);SELECT SCOPE_IDENTITY();";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@username", username);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@passwd", hashedPassword);
                            cmd.Parameters.AddWithValue("@role", role);
                            cmd.Parameters.AddWithValue("@date", DateTime.Now);
                            cmd.Parameters.AddWithValue("@status", "Active");
                            conn.Open();
                            string id = cmd.ExecuteScalar().ToString();
                            conn.Close();

                            //insert into log
                            LogController log = new LogController(Session["adminID"].ToString(), "Created New Admin #" + id.ToString());
                            log.createLog();

                            Response.Redirect("ManageAdmin.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                    }
                }
            }
        }
    }
}