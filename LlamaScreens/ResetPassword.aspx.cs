using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;

namespace LlamaScreens
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void changePasswdBtn_Click(object sender, EventArgs e)
        {
            string conn = System.Configuration.ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString;
            string memberId = Session["MemberId"] as string;
            if (memberId != null)
            {
                String newPassword = newPasswd.Value;
                String retypePassword = newRetypePasswd.Value;
                if (newPassword == retypePassword)
                {
                    try
                    {
                        using (SqlConnection sqlConnection = new SqlConnection(conn))
                        {
                            sqlConnection.Open();

                            string updatePasswd = "UPDATE Member SET member_password = @Password WHERE member_id = @MemberId";

                            using (SqlCommand updateCommand = new SqlCommand(updatePasswd, sqlConnection))
                            {
                                String hashedPassword = StringUtil.PasswordHandler.hashingPassword(newPassword);

                                updateCommand.Parameters.AddWithValue("@Password", hashedPassword);
                                updateCommand.Parameters.AddWithValue("@MemberId", memberId);

                                int rowsAffected = updateCommand.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Password updated successfully
                                    lblMessage.Text = "Password updated successfully";
                                    Response.Redirect("~/login.aspx");
                                }
                                else
                                {
                                    lblMessage.Text = "Failed to update password";
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "An error occurred: " + ex.Message;
                    }
                }
            }
            else
            {
                Console.WriteLine("Invalid to change bacause valid time had passed.");
            }
        }
    }
}