using FluentEmail.Core;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void verifyBtn_Click(object sender, EventArgs e)
        {
            string conn = System.Configuration.ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString;
            if (recoveryEmail.Value != null)
            {
                string receiverEmail = recoveryEmail.Value;

                using (SqlConnection sqlConnection = new SqlConnection(conn))
                {
                    sqlConnection.Open();
                    string query = "SELECT member_id FROM Member WHERE member_Email = @Email";

                    using (SqlCommand sqlCommand = new SqlCommand(query, sqlConnection))
                    {
                        sqlCommand.Parameters.AddWithValue("@Email", receiverEmail);

                        object result = sqlCommand.ExecuteScalar();
                        if (result != null)
                        {
                            string memberId = result.ToString();

                            Session["MemberId"] = memberId;

                            try
                            {
                                string senderEmail = "loowk-wm21@student.tarc.edu.my";

                                MailMessage verificationMail = new MailMessage(senderEmail, receiverEmail);

                                verificationMail.Subject = "Password Recovery from Llama Cinema";
                                verificationMail.Body = "<h3>Please click the button link below to verify that you are the user and proceed to password reset page.</h3><br><br>" +
                                        "<a href=\"https://localhost:44316/ResetPassword.aspx\" style=\"color:white;border:1px solid black;background-color:black;padding: 15px 10px;\">Reset Password</a>";
                                verificationMail.IsBodyHtml = true;

                                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
                                smtpClient.EnableSsl = true;
                                smtpClient.UseDefaultCredentials = false;
                                smtpClient.Credentials = new NetworkCredential(senderEmail, "yrwt hgli mvlg ihux");

                                smtpClient.Send(verificationMail);
                                lblMessage.Text = "Email sent successfully";
                            }
                            catch (Exception ex)
                            {
                                lblMessage.Text = "Email failed to send: " + ex.Message;
                            }
                        }
                        else
                        {
                            lblMessage.Text = "You are not part of our member, Please Register first";
                        }
                    }

                }
            }
        }
    }
}