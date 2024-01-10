using Stripe.Terminal;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string id = rowView["category_id"].ToString();
                string name = rowView["category_name"].ToString();

                TextBox nameInput = (TextBox)e.Item.FindControl("Category_Name");
                LinkButton confirmButton = (LinkButton)e.Item.FindControl("Confirm_Btn");
                nameInput.Text = name;
                nameInput.ReadOnly = true;
                confirmButton.CommandArgument = id + ";" + e.Item.ItemIndex;


                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = confirmButton.UniqueID;
                trigger.EventName = "Command";
                UpdatePanel1.Triggers.Add(trigger);
            }
        }

        protected void Confirm_Btn_Command(object sender, CommandEventArgs e)
        {
            try
            {
                string[] arg = new string[2];
                arg = e.CommandArgument.ToString().Split(';');
                string id = arg[0];
                int index = Convert.ToInt32(arg[1]);
                TextBox nameInput = (TextBox)Repeater1.Items[index].FindControl("Category_Name");
                string newName = CurrCat.Value.Trim();
                if (newName != "")
                {
                    bool exist = false;
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "SELECT * FROM Category WHERE category_name LIKE @name";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@name", newName);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            exist = true;
                        }
                        conn.Close();
                    }

                    if (!exist)
                    {
                        int affectedrow = 0;
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            conn.Open();
                            string query = "UPDATE Category SET category_name = @name WHERE category_id = @id";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@name", newName);
                            cmd.Parameters.AddWithValue("@id", id);
                            affectedrow = cmd.ExecuteNonQuery();
                            conn.Close();
                        }

                        if (affectedrow != 0)
                        {
                            LogController log = new LogController(Session["adminID"].ToString(), "Updated Category #" + id);
                            log.createLog();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //catch
                Response.Write(ex.Message);
            }
            search();
        }

        protected void Add_Category_Btn_Command(object sender, CommandEventArgs e)
        {
            string msg = "";
            try
            {
                if (Category_Input.Text.Trim() != "")
                {
                    bool exist = false;
                    string name = Category_Input.Text;
                    //Check if name is already in database
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        conn.Open();
                        string query = "SELECT * FROM Category WHERE category_name = @name";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@name", name);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            exist = true;
                            msg = "Already Exist";
                        }
                        conn.Close();
                    }

                    if (!exist) {
                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            conn.Open();
                            string query = "INSERT INTO Category (category_name,created_date) VALUES (@name, @date);SELECT SCOPE_IDENTITY();";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@name", name);
                            cmd.Parameters.AddWithValue("@date", DateTime.Now);
                            string categoryID = cmd.ExecuteScalar().ToString();
                            conn.Close();
                            //insert into log
                            LogController log = new LogController(Session["adminID"].ToString(), "Created New Category #" + categoryID.ToString());
                            log.createLog();
                        }
                        
                    }
                }
                else
                {
                    msg = "Cannot Empty";
                }
            }
            catch (Exception ex)
            {
                msg = "Database Failed";
            }
            Category_Input.Attributes["placeholder"] = msg;
            Category_Input.Text = "";
            search();
        }

        protected void search_trigger(object sender, EventArgs e)
        {
            search();
        }

        protected void search()
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";
            SqlDataSource1.SelectParameters.Clear();
            SqlDataSource1.SelectCommand = "SELECT * FROM [Category] WHERE CATEGORY_NAME LIKE @id";
            SqlDataSource1.SelectParameters.Add("id", keyword);
            SqlDataSource1.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "", "update();", true);
        }
    }
}