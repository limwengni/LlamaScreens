using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using StringUtil;

namespace WebAssignment
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["Llama"] != null)
                {
                    HttpCookie cookie = Request.Cookies["Llama"];
                    if (cookie["role"] != null)
                    {
                        string role = cookie["role"];
                        Session["role"] = role;
                        Session["adminID"] = cookie["adminID"];
                        Session["adminName"] = cookie["adminName"];
                        if (role == "TicketChecker")
                        {
                            Response.Redirect("~/Admin/CheckIn.aspx");
                        }
                        else
                        {
                            Response.Redirect("~/Admin/Dashboard.aspx");
                        }
                    }
                }
                else if (Session["role"] != null)
                {
                    string role = Session["role"].ToString();
                    if (role == "TicketChecker")
                    {
                        Response.Redirect("~/Admin/CheckIn.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/Admin/Dashboard.aspx");
                    }
                }
            }
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            string email = textboxid.Text.Trim();
            string pass = textboxpassword.Text.Trim();

            string msg = "";

            if(email == "")
            {
                msg = "Please Enter your ID";
            }else if(pass == "")
            {
                msg = "Please Enter your password";
            }

            if(msg == "")
            {
                string hashedPass = "";
                string status = "";
                string role = "";
                string adminID = "";
                string adminName = "";
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "SELECT * FROM ADMIN WHERE ADMIN_EMAIL = @email";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@email", email);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            hashedPass = reader["ADMIN_PASSWORD"].ToString();
                            status = reader["STATUS"].ToString();
                            role = reader["ADMIN_ROLE"].ToString();
                            adminID = reader["ADMIN_ID"].ToString();
                            adminName = reader["ADMIN_USERNAME"].ToString();
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }


                if(status != "")
                {
                    if (status == "Locked")
                    {
                        msg = "Uh oh! Sorry Your Account Is Locked.";
                    }
                    else
                    {
                        if (PasswordHandler.verifyPassword(pass,hashedPass))
                        {
                            try
                            {
                                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                                {
                                    string query = "UPDATE ADMIN SET ADMIN_LAST_LOGIN = @date WHERE ADMIN_EMAIL = @email";
                                    SqlCommand cmd = new SqlCommand(query, conn);
                                    cmd.Parameters.AddWithValue("@email", email);
                                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                                    conn.Open();
                                    cmd.ExecuteNonQuery();
                                    conn.Close();
                                }
                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex.Message);
                            }

                            Session["role"] = role;
                            Session["adminID"] = adminID;
                            Session["adminName"] = adminName;
                            if (rememberme.Checked)
                            {
                                HttpCookie cookie = new HttpCookie("Llama");
                                cookie["role"] = role;
                                cookie["adminID"] = adminID;
                                cookie["adminName"] = adminName;
                                cookie.Expires = DateTime.Now.AddDays(30);
                                Response.Cookies.Add(cookie);
                            }

                            if(role == "TicketChecker")
                            {
                                Response.Redirect("~/Admin/CheckIn.aspx");
                            }
                            else
                            {
                                Response.Redirect("~/Admin/Dashboard.aspx");
                            }
                        }
                        else
                        {
                            msg = "Uh oh! Wrong Password.";
                        }
                    }
                }
                else
                {
                    msg = "Uh oh! We couldn't find a match for that ID and Password.";
                }
            }
            errMsg.Text = msg;
        }
    }
}