using LlamaScreens.Admin;
using MailKit;
using Org.BouncyCastle.Tls;
using Stripe;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Member
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
                try
                {
                    string conn = System.Configuration.ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString;

                    using (SqlConnection sqlConnection = new SqlConnection(conn))
                    {
                        sqlConnection.Open();
                        string query = "SELECT member_id FROM Member WHERE member_Email = @Email";

                        using (SqlCommand sqlCommand = new SqlCommand(query, sqlConnection))
                        {
                            sqlCommand.Parameters.AddWithValue("@Email", Session["email"]);

                            object result = sqlCommand.ExecuteScalar();
                            if (result != null)
                            {
                                string memberId = result.ToString();
                                Session["MemberId"] = memberId;
                            }
                        }

                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

        }
        protected void confirmation_Click(object sender, EventArgs e)
        {
            String newUsername = Request.Form["editUsername"].ToString();
            String newDOB = Request.Form["editDOB"];
            String newEmail = Request.Form["editEmail"].ToString();
            String newPhone = Request.Form["editPhone"].ToString();
            string usernameErr = "";
            string emailErr = "";
            string phoneErr = "";

            //regex
            //username
            if (newUsername == null || newUsername == "")
            {
                usernameErr = "Username cannot be empty";
            }
            //email
            if (newEmail == null || newEmail == "")
            {
                emailErr = "Email cannot be left empty.";
            }
            else if (!IsValidEmail(newEmail))
            {
                emailErr = "Invalid Email Format.";
            }
            else if (IsDuplicateEmail(newEmail))
            {
                emailErr = "Email already exists.";
            }

            //phone
            if (newPhone == null || newPhone == "")
            {
                phoneErr = "Phone cannot be left empty.";
            }
            else if (!System.Text.RegularExpressions.Regex.IsMatch(newPhone, @"^[0-9]{10,11}$"))
            {
                phoneErr = "Invalid Phone Format.";
            }

            if (usernameErr == "" && emailErr == "" && phoneErr == "")
            {

                string conn = System.Configuration.ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString;
                string memberId = Session["MemberId"] as string;
                if (memberId != null)
                {

                    try
                    {
                        using (SqlConnection sqlConnection = new SqlConnection(conn))
                        {
                            sqlConnection.Open();

                            string query = "UPDATE Member SET member_username = @Username, " +
                            "member_birth_date = @DOB, member_email = @Email, member_phone_no = @Phone " +
                            "WHERE member_id = @MemberId";

                            using (SqlCommand updateCommand = new SqlCommand(query, sqlConnection))
                            {
                                updateCommand.Parameters.AddWithValue("@Username", newUsername);
                                updateCommand.Parameters.AddWithValue("@DOB", newDOB);
                                updateCommand.Parameters.AddWithValue("@Email", newEmail);
                                updateCommand.Parameters.AddWithValue("@Phone", newPhone);
                                updateCommand.Parameters.AddWithValue("@MemberId", memberId);

                                int rowsAffected = updateCommand.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    Session["email"] = newEmail;
                                    Repeater1.DataBind();
                                }
                                else
                                {
                                    ClientScript.RegisterStartupScript(GetType(), "showalert", "alert('No rows were updated');", true);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(GetType(), "showalert", $"alert('Error: {ex.Message}');", true);
                    }
                }
                else
                {
                    Console.WriteLine("Invalid to change bacause valid time had passed.");
                }
            }
        }

        protected void BindData()
        {
            Repeater1.DataBind();
        }

        protected bool IsDuplicateEmail(string email)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string memberId = Session["MemberId"] as string;
                    string query = "SELECT * FROM Member WHERE member_email = @email AND member_id != @id";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@id", memberId);
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