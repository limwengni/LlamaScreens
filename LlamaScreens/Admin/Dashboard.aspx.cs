using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string totalMember()
        {
            return "";
        }

        protected string SerializedLatestMonths
        {
            get
            {
                string[] months = getLatestMonths();
                //remove nulls
                for (int i = 0; i < months.Length; i++)
                {
                    if (months[i] == null)
                    {
                        months[i] = "";
                    }
                }
                return new JavaScriptSerializer().Serialize(months);
            }
        }

        protected string SerializedTotalTransactionAmount
        {
            get
            {
                string[] totalTransactionAmount = getTotalTransactionAmount();
                //remove nulls
                for (int i = 0; i < totalTransactionAmount.Length; i++)
                {
                    if (totalTransactionAmount[i] == null)
                    {
                        totalTransactionAmount[i] = "0";
                    }
                }
                return new JavaScriptSerializer().Serialize(totalTransactionAmount);
            }
        }

        protected string SerializedTotalTicketSold
        {
            get
            {
                string[] totalTicketSold = getTotalTicketSold();
                //remove nulls
                for (int i = 0; i < totalTicketSold.Length; i++)
                {
                    if (totalTicketSold[i] == null)
                    {
                        totalTicketSold[i] = "0";
                    }
                }
                return new JavaScriptSerializer().Serialize(totalTicketSold);
            }
        }

        protected string SerializedTotalShowtimeCreated
        {
            get
            {
                string[] totalShowtimeCreated = getTotalShowtimeCreated();
                //remove nulls
                for (int i = 0; i < totalShowtimeCreated.Length; i++)
                {
                    if (totalShowtimeCreated[i] == null)
                    {
                        totalShowtimeCreated[i] = "0";
                    }
                }
                return new JavaScriptSerializer().Serialize(totalShowtimeCreated);
            }
        }

        protected string[] getLatestMonths()
        {
            string[] months = new string[5];
            for (int i = 0; i < 5; i++)
            {
                months[i] = DateTime.Now.AddMonths(-i).ToString("MMM");
            }
            return months;
        }

        protected string[] getTotalTransactionAmount()
        {
            try
            {
                string[] months = getLatestMonths();
                string query = "SELECT SUM(amount) FROM [Transaction] WHERE MONTH(created_date) in (";
                for (int i = 0; i < months.Length; i++)
                {
                    query += DateTime.ParseExact(months[i], "MMM", CultureInfo.InvariantCulture).Month + ",";
                }
                query = query.Substring(0, query.Length - 1);
                query += ") GROUP BY MONTH(created_date)";
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {

                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    string[] amount = new string[5];
                    int i = 0;
                    while (reader.Read())
                    {
                        amount[i] = reader[0].ToString();
                        i++;
                    }
                    return amount;
                }
            }
            catch (Exception ex)
            {
                //
            }
            string[] str = { "1", "2", "3", "4", "5" };
            return str;
        }

        protected string[] getTotalTicketSold()
        {
            try
            {
                string[] months = getLatestMonths();
                string query = "SELECT COUNT(ticket_id) FROM Ticket WHERE MONTH(created_date) in (";
                for (int i = 0; i < months.Length; i++)
                {
                    query += DateTime.ParseExact(months[i], "MMM", CultureInfo.InvariantCulture).Month + ",";
                }
                query = query.Substring(0, query.Length - 1);
                query += ") GROUP BY MONTH(created_date)";
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {

                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    string[] amount = new string[5];
                    int i = 0;
                    while (reader.Read())
                    {
                        amount[i] = reader[0].ToString();
                        i++;
                    }
                    return amount;
                }
            }
            catch (Exception ex)
            {
                //
            }
            string[] str = { "1", "2", "3", "4", "5" };
            return str;
        }

        protected string[] getTotalShowtimeCreated()
        {
            try
            {
                string[] months = getLatestMonths();
                string query = "SELECT COUNT(showtime_id) FROM Showtime WHERE MONTH(created_date) in (";
                for (int i = 0; i < months.Length; i++)
                {
                    query += DateTime.ParseExact(months[i], "MMM", CultureInfo.InvariantCulture).Month + ",";
                }
                query = query.Substring(0, query.Length - 1);
                query += ") GROUP BY MONTH(created_date)";
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {

                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    string[] amount = new string[5];
                    int i = 0;
                    while (reader.Read())
                    {
                        amount[i] = reader[0].ToString();
                        i++;
                    }
                    return amount;
                }
            }
            catch (Exception ex)
            {
                //
            }
            string[] str = { "1", "2", "3", "4", "5" };
            return str;
        }

    }
}