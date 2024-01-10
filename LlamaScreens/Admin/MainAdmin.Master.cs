using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace LlamaScreens.Admin
{
    public partial class MainAdmin : System.Web.UI.MasterPage
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
                        if (role == "TicketChecker")
                        {
                            Response.Redirect("~/AdminLogin.aspx");
                        }
                        else
                        {
                            Session["role"] = role;
                            Session["adminID"] = cookie["adminID"];
                            Session["adminName"] = cookie["adminName"];

                            string rootPage = getRootPage();
                            if ((rootPage == "Manage Admin" || rootPage == "AdminLog") && role != "Manager")
                            {
                                Response.Redirect("~/Admin/Dashboard.aspx");
                            }
                        }
                    }
                }
                else if (Session["role"] != null)
                {
                    if (Session["role"].ToString() == "TicketChecker")
                    {
                        Response.Redirect("~/AdminLogin.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/AdminLogin.aspx");
                }

                try
                {
                    string status = "";
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        
                        conn.Open();
                        String query = "SELECT status FROM [ADMIN] WHERE ADMIN_ID = @id";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@id", Session["adminID"].ToString());
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            reader.Read();
                            status = reader["status"].ToString();
                        }
                        conn.Close();
                    }

                    if(status == "Locked" || status == "")
                    {
                        signOut();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }

                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "UPDATE ADMIN SET ADMIN_LAST_LOGIN = @date WHERE ADMIN_ID = @id";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@id", Session["adminID"].ToString());
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
            }
        }

        protected string getRole()
        {
            if (Session["role"] != null)
            {
                return Session["role"].ToString();
            }
            return "";
        }

        protected string getName()
        {
            if (Session["adminName"] != null)
            {
                return Session["adminName"].ToString();
            }
            return "";
        }

        protected string getRootPage()
        {
            SiteMapNode currPage = SiteMap.CurrentNode;
            if (currPage != null)
            {
                SiteMapNode parentPage = currPage.ParentNode;
                if (parentPage != null)
                {
                    if (parentPage.Title == "Admin")
                    {
                        return currPage.Title;
                    }
                    return parentPage.Title;
                }
                return "";
            }
            return "";
        }

        protected string getCurrentPage()
        {
            SiteMapNode currNode = SiteMap.CurrentNode;
            if (currNode != null)
            {
                return currNode.Title;
            }
            return "";
        }

        protected void Sign_Out_Btn_Command(object sender, CommandEventArgs e)
        {
            signOut();
        }

        protected void signOut()
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