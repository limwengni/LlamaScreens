using Org.BouncyCastle.Cms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Org.BouncyCastle.Crypto.Engines.SM2Engine;

namespace LlamaScreens
{
    public partial class login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            //if(IsPostBack){
            //    if (Request.QueryString["option"] != null)
            //    {
            //        onOption = Request.QueryString["option"];
            //    }

            //    if(onOption == "register"){
            //        Register_Option_Btn.CssClass = "option active";
            //        Login_Option_Btn.CssClass = "option";
            //    }else{
            //        Register_Option_Btn.CssClass = "option";
            //        Login_Option_Btn.CssClass = "option active";
            //    }
            //}
            // Register the JavaScript function during Page_Load
        }
        protected void ClickEv(object sender, EventArgs e)
        {
            string err = "";
            string email = Request.Form.Get("login-email");
            string passwd = Request.Form.Get("login-passwd");
            if (email == null || passwd == null || email == "" || passwd == null)

            {
                err = "Email and Password cannot be left empty.";
            }
            else
            {
                //email validation
                if (!IsValidEmail(email))
                {
                    err = "Invalid Email Format.";
                }

                if (err == "")
                {
                    try
                    {

                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            conn.Open();
                            //use parameterized query to prevent sql injection
                            string query = "SELECT * FROM [MEMBER] WHERE  member_email = @email";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@email", email);
                            SqlDataReader reader = cmd.ExecuteReader();
                            if (!reader.HasRows)
                            {
                                err = "Invalid email or password.";

                            }
                            else
                            {
                                //get password from reader
                                reader.Read();
                                string hashedPassword = reader["member_password"].ToString();
                                //compare password
                                if (!StringUtil.PasswordHandler.verifyPassword(passwd, hashedPassword))
                                {
                                    err = "Invalid email or password.";

                                }
                                else
                                {
                                    if (reader["status"].ToString() == "Not Verified")
                                    {
                                        err = "Please verify your email first.";
                                    }
                                    else
                                    {

                                        Session["LoggedIn"] = true;
                                        Session["email"] = email;
                                        Response.Redirect("~/main.aspx");
                                    }
                                }
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        //Err
                    }
                }
            }
            ErrMsg.Text = err;
        }

        protected void ClickEvReg(object sender, EventArgs e)
        {
            //reset all err text
            Label usernameErrMsg = (Label)FindControl("usernameErrMsg");
            usernameErrMsg.Text = "";
            Label emailErrMsg = (Label)FindControl("emailErrMsg");
            emailErrMsg.Text = "";
            Label phoneErrMsg = (Label)FindControl("phoneErrMsg");
            phoneErrMsg.Text = "";
            Label dobErrMsg = (Label)FindControl("birthErrMsg");
            dobErrMsg.Text = "";
            Label passwdErrMsg = (Label)FindControl("passwdErrMsg");
            passwdErrMsg.Text = "";
            Label confPasswdErrMsg = (Label)FindControl("repasswdErrMsg");
            confPasswdErrMsg.Text = "";
            
            string username = Request.Form.Get("reg-username");
            string email = Request.Form.Get("reg-email");
            string phone = Request.Form.Get("reg-phone");
            string dobString = Request.Form.Get("reg-birthdate");
            string passwd = Request.Form.Get("reg-passwd");
            string confPasswd = Request.Form.Get("reg-repasswd");
            string usernameErr = "";
            string emailErr = "";
            string phoneErr = "";
            string dobErr = "";
            string passwdErr = "";
            string confPasswdErr = "";
            DateTime dob = DateTime.Today;
            //regex
            //username
            if (username == null || username == "")
            {
                usernameErr = "Username cannot be left empty.";
            }
            //email
            if (email == null || email == "")
            {
                emailErr = "Email cannot be left empty.";
            }
            else if (!IsValidEmail(email))
            {
                emailErr = "Invalid Email Format.";
            }
            else if (IsDuplicateEmail(email))
            {
                emailErr = "Email already exists.";
            }

            //phone
            if (phone == null || phone == "")
            {
                phoneErr = "Phone cannot be left empty.";
            }
            else if (!System.Text.RegularExpressions.Regex.IsMatch(phone, @"^[0-9]{10,11}$"))
            {
                phoneErr = "Invalid Phone Format.";
            }

            try
            {
                dob = DateTime.Parse(dobString);
            }
            catch (Exception ex)
            {
                dobErr = "Invalid Date of Birth.";
            }

            //password
            if (passwd == null || passwd == "")
            {
                passwdErr = "Password cannot be left empty.";
            }
            else if (!System.Text.RegularExpressions.Regex.IsMatch(passwd, @"^(?!.*(?:123|ABC|(\w)\1{2}))(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\d\s]).{8,}$"))
            {
                passwdErr = "Password must be at least 8 characters long and contain at least 1 uppercase, 1 lowercase, 1 number and 1 special character.";
            }

            if (confPasswd == null || confPasswd == "")
            {
                confPasswdErr = "Confirm Password cannot be left empty.";
            }
            else if (confPasswd != passwd)
            {
                confPasswdErr = "Confirm Password does not match Password.";
            }

            if (usernameErr == "" && emailErr == "" && phoneErr == "" && dobErr == "" && passwdErr == "" && confPasswdErr == "")
            {
                try
                {
                    DateTime today = DateTime.Today;
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {

                        string hashedPassword = StringUtil.PasswordHandler.hashingPassword(passwd);

                        conn.Open();
                        //use parameterized query to prevent sql injection
                        string query = "INSERT INTO [MEMBER] (member_username, member_email, member_password, member_phone_no, member_point, member_birth_date, created_date, status)"
                            + " VALUES (@username, @email,@passwd, @phone, @point, @dob, @cd, @status);SELECT SCOPE_IDENTITY();";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@passwd", hashedPassword);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@point", 0);
                        cmd.Parameters.AddWithValue("@dob", dob);
                        cmd.Parameters.AddWithValue("@cd", today);
                        cmd.Parameters.AddWithValue("@status", "Not Verified");
                        string id = cmd.ExecuteScalar().ToString();
                        conn.Close();

                        string code = generateVerificationCode();

                        conn.Open();
                        query = "INSERT INTO VERIFICATION VALUES(@recipient_id, @code, @detail, @date, @status)";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@recipient_id", id);
                        cmd.Parameters.AddWithValue("@code", code);
                        cmd.Parameters.AddWithValue("@detail", "Customer Email Verification");
                        cmd.Parameters.AddWithValue("@date", DateTime.Now);
                        cmd.Parameters.AddWithValue("@status", "Pending");
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        //go to account verification page
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
                        emailSender.SendEmail(email, "Llama Cinema Email Verification", emailContent);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "redirect", "alert('Account has been created. Please verify your email first.'); document.getElementById('login-btn').click();", true);

                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            else
            {
                if (usernameErr != "")
                {
                    usernameErrMsg.Text = usernameErr;
                }

                if (emailErr != "")
                {
                    emailErrMsg.Text = emailErr;
                }

                if (phoneErr != "")
                {
                    phoneErrMsg.Text = phoneErr;
                }

                if (dobErr != "")
                {
                    dobErrMsg.Text = dobErr;
                }

                if (passwdErr != "")
                {
                    passwdErrMsg.Text = passwdErr;
                }

                if (confPasswdErr != "")
                {
                    confPasswdErrMsg.Text = confPasswdErr;
                }
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

        protected bool IsDuplicateEmail(string email)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "SELECT * FROM [MEMBER] WHERE member_email = @email";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@email", email);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        return true;
                    }
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            return false;
        }

        protected bool IsValidEmail(string email)
        {
            var trimmedEmail = email.Trim();

            if (trimmedEmail.EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == trimmedEmail;
            }
            catch
            {
                return false;
            }
        }

    }
}