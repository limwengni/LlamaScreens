using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace LlamaScreens
{
    public partial class AdminChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string errMsg = "";
                if (Request.QueryString["code"] != null) 
                {
                    ChangePasswordPanel.Visible = false;
                    ConfirmChangePanel.Visible = true;

                    ChangePasswordBtnPanel.Visible = false;
                    ConfirmChangeBtnPanel.Visible = true;

                    string code = Request.QueryString["code"];
                    bool valid = false;
                    string details = "";
                    string recipientId = "";

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
                                errMsg = "Uh oh! We couldn't find a matching verification for that code.";
                                RedirectBtnPanel.Visible = true;
                            }
                            else
                            {
                                reader.Read();
                                DateTime createdDate = (DateTime)reader["created_date"];
                                TimeSpan difference = DateTime.Now - createdDate;
                                if (difference.TotalSeconds <= 300)
                                {
                                    valid = true;
                                    details = reader["verification_details"].ToString();
                                    recipientId = reader["recipient_id"].ToString();
                                }
                                else
                                {
                                    errMsg = "Verification Timed Out, A new one will be send to your email again";
                                    ///Sent lagi
                                    createVerification(recipientId);
                                }
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }

                    if (!valid)
                    {
                        ConfirmChangePanel.Visible = false;
                        ConfirmChangeBtnPanel.Visible = false;
                    }
                }
                lblvalid.Text = errMsg;
            }
        }

        protected void RedirectBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminChangePassword.aspx");
        }

        protected void changePassBtn_Click(object sender, EventArgs e)
        {
            string errMsg = "";
            string loginID = textboxid.Text;
            if(loginID == "")
            {
                errMsg = "Please Enter Your Email";
            }
            else
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "SELECT status FROM ADMIN WHERE ADMIN_EMAIL = @id";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@id", loginID);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            errMsg = "Uh oh! We couldn't find a matching account for that email.";
                        }
                        else
                        {
                            reader.Read();
                            if(reader["status"].ToString() == "Locked")
                            {
                                errMsg = "Sorry, you are not allowed to perform this action";
                            }
                            else
                            {
                                //Send
                                createVerification(loginID);
                                errMsg = "Verification Sent To the your Email<br>Please Check Your Email";
                                ChangePasswordPanel.Visible = false;
                                ChangePasswordBtnPanel.Visible = false;
                            }
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            lblvalid.Text = errMsg;
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
                    string query = "SELECT ADMIN_ID FROM ADMIN WHERE ADMIN_EMAIL = @id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", recipientID);
                    SqlDataReader reader = cmd.ExecuteReader();
                    reader.Read();
                    id = reader["ADMIN_ID"].ToString();
                    conn.Close();

                    conn.Open();
                    query = "INSERT INTO VERIFICATION VALUES(@recipient_id, @code, @detail, @date, @status)";
                    cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@recipient_id", id);
                    cmd.Parameters.AddWithValue("@code", code);
                    cmd.Parameters.AddWithValue("@detail", "Admin Change Password");
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

            string link = HttpContext.Current.Request.Url.AbsoluteUri + "?code=" + code;
            string emailContent = @"<!DOCTYPE html>
                <html lang=""en"">
                <head>
                    <meta charset=""UTF-8"">
                    <title>Email Verification</title>
                </head>
                <body>
                    <p>Dear User,</p>
                    <p>Please use the following link to change your password:</p>
                    <a href=""" + link + @""">Your Link</a>
                    <p>If you did not request this code, please ignore this message.</p>
                    <p>Thank you!</p>
                </body>
                </html>";
            var emailSender = new EmailSender("smtp.gmail.com", 587, "lim1227december@gmail.com", "gjxm vojd cwej nlwl");
            emailSender.SendEmail(recipientID, "Llama Cinema Email Verification", emailContent);
        }

        protected void makeOtherExpired(string recipientID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "UPDATE VERIFICATION SET STATUS = @status WHERE RECIPIENT_ID = @id AND VERIFICATION_DETAILS LIKE '%Admin%'";
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

        protected void confirmBtn_Click(object sender, EventArgs e)
        {
            string pass1 = textboxpass.Text.Trim();
            string pass2 = textboxpass2.Text.Trim();

            string errMsg = "";

            if (pass1 == "")
            {
                errMsg = "Please Enter A Password";
                textboxpass2.Text = "";
            }
            else
            {
                if (pass1 != pass2)
                {
                    errMsg = "Password Is Different";
                    textboxpass2.Text = "";
                }
                else
                {
                    if (!System.Text.RegularExpressions.Regex.IsMatch(pass1, @"^(?!.*(?:123|ABC|(\w)\1{2}))(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"))
                    {
                        errMsg = @"Password must have following criteria:<br>
                            - At least 8 characters long<br>
                            - At least 1 uppercase letter (A-Z)<br>
                            - At least 1 lowercase letter (a-z)<br>
                            - At least 1 number (0-9)<br>
                            - At least 1 special character (e.g., ! @ # $ % ^ & *)<br>
                            - Cannot contain sequences like ""123"" or ""ABC""";
                    }
                    else
                    {
                        string hashedPassword = StringUtil.PasswordHandler.hashingPassword(pass1);
                        try
                        {
                            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                            {
                                conn.Open();
                                string query = "UPDATE ADMIN SET ADMIN_PASSWORD = @pass WHERE ADMIN_ID = (SELECT RECIPIENT_ID FROM VERIFICATION WHERE VERIFICATION_CODE = @code AND VERIFICATION_DETAILS LIKE '%Admin%')";
                                SqlCommand cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@code", Request.QueryString["code"].ToString());
                                cmd.Parameters.AddWithValue("@pass", hashedPassword);
                                cmd.ExecuteNonQuery();
                                conn.Close();
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write(ex.Message);
                        }
                        errMsg = "Password is Updated<br>You can now login with your new password";
                        ConfirmChangePanel.Visible = false;
                        ConfirmChangeBtnPanel.Visible = false;
                        DoneBtnPanel.Visible = true;
                    }
                }
            }
            lblvalid.Text = errMsg;


        }

        protected void DoneBtn_Click(object sender, EventArgs e)
        {
            if (Request.Cookies["Llama"] != null)
            {
                HttpCookie cookie = Request.Cookies["Llama"];
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
            Session.Clear();
            Response.Redirect("~/AdminLogin.aspx");
        }
    }
}