using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens
{
    public partial class AccountVerification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["code"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    // get code from url
                    string code = Request.QueryString["code"];
                    string recipientId = "";
                    bool hasCode = false;
                    // check if code is valid
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            conn.Open();
                            string query = "SELECT * FROM VERIFICATION WHERE VERIFICATION_CODE = @code";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@code", code);
                            SqlDataReader reader = cmd.ExecuteReader();
                            if (!reader.HasRows)
                            {
                                Msg.Text = "Uh oh! We couldn't find a matching verification for that code.";
                            }
                            else
                            {
                                reader.Read();
                                DateTime createdDate = (DateTime)reader["created_date"];
                                TimeSpan difference = DateTime.Now - createdDate;
                                if (difference.TotalSeconds <= 300)
                                {
                                    recipientId = reader["recipient_id"].ToString();
                                    hasCode = true;
                                }
                                else
                                {
                                    Msg.Text = "Verification Timed Out, A new one will be send to your email again";
                                    ///Sent lagi
                                    createVerification(recipientId);
                                }
                            }
                            conn.Close();

                            if (hasCode)
                            {
                                conn.Open();
                                query = "UPDATE VERIFICATION SET STATUS = @status WHERE VERIFICATION_CODE = @code";
                                cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@code", code);
                                cmd.Parameters.AddWithValue("@status", "Verified");
                                cmd.ExecuteNonQuery();
                                conn.Close();

                                conn.Open();
                                query = "UPDATE MEMBER SET STATUS = @status WHERE MEMBER_ID = @id";
                                cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@id", recipientId);
                                cmd.Parameters.AddWithValue("@status", "Verified");
                                cmd.ExecuteNonQuery();
                                conn.Close();

                                Msg.Text = "Verification Successful! You can now login to your account.";
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                }
            }
        }

        protected void createVerification(string recipientID)
        {
            makeOtherExpired(recipientID);
            string code = generateVerificationCode();
            string id = "";
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO VERIFICATION VALUES(@recipient_id, @code, @detail, @date, @status)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@recipient_id", recipientID);
                    cmd.Parameters.AddWithValue("@code", code);
                    cmd.Parameters.AddWithValue("@detail", "Customer Email Verification");
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    cmd.Parameters.AddWithValue("@status", "Pending");
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            string link = "https://localhost:44316/AccountVerification.aspx?code=" + code;
            string emailContent = @"<!DOCTYPE html>
                <html lang=""en"">
                <head>
                    <meta charset=""UTF-8"">
                    <title>Email Verification</title>
                </head>
                <body>
                    <p>Dear Customer,</p>
                    <p>Please use the following link to verify your account:</p>
                    <a href=""" + link + @""">Your Link</a>
                    <p>If you did not request this code, please ignore this message.</p>
                    <p>Thank you!</p>
                </body>
                </html>";
            var emailSender = new EmailSender("smtp.gmail.com", 587, "lim1227december@gmail.com", "gjxm vojd cwej nlwl");
            emailSender.SendEmail(recipientID, "Llama Cinema Email Verification", emailContent);
        }

        protected string generateVerificationCode()
        {
            Random random = new Random();
            int length = 6;

            string chars = "0123456789";
            string generatedCode = "";

            bool unique = false;

            while (!unique)
            {
                char[] code = new char[length];

                for (int i = 0; i < length; i++)
                {
                    code[i] = chars[random.Next(chars.Length)];
                }

                generatedCode = new string(code);

                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "SELECT VERIFICATION_ID FROM VERIFICATION WHERE VERIFICATION_CODE = @code";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@code", generatedCode);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            unique = true;
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            return generatedCode;
        }

        protected void makeOtherExpired(string recipientID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "UPDATE VERIFICATION SET STATUS = @status WHERE RECIPIENT_ID = @id AND VERIFICATION_DETAILS LIKE '%Customer%'";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", recipientID);
                    cmd.Parameters.AddWithValue("@status", "Expired");
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}