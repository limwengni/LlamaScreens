using Org.BouncyCastle.Cms;
using Stripe.BillingPortal;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace LlamaScreens.Admin
{
    public class LogController
    {
        private string id;
        private string action;
        public LogController(string id, string action) {
            this.id = id;
            this.action = action;
        }

        public bool createLog()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    conn.Open();
                    string query = "INSERT INTO AdminLog (admin_id,adminlog_message,created_date) VALUES (@id,@message,@date)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@id", this.id);
                    cmd.Parameters.AddWithValue("@message", action);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
    }
}
