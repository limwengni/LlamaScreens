using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Threading;
using System.Configuration;
using System.Data.SqlClient;

namespace LlamaScreens
{
    public class Global : System.Web.HttpApplication
    {
        private Timer dailyTimer;
        private Timer showTimeTimer;
        protected void Application_Start(object sender, EventArgs e)
        {
            dailyTimer = new Timer(DailyFunction, null, TimeSpan.Zero, TimeSpan.FromDays(1));
            showTimeTimer = new Timer(ShowTimeFunction, null, TimeSpan.Zero, TimeSpan.FromMinutes(10));
        }

        private void DailyFunction(object state)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    string query = "UPDATE MOVIE SET STATUS = 'Now Showing' WHERE RELEASE_DATE <= GETDATE() ";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    query = "UPDATE MOVIE SET STATUS = 'Finished' WHERE MOVIE_ID NOT IN (SELECT DISTINCT MOVIE_ID FROM SHOWTIME WHERE SHOWTIME_DATE > DATEADD(day, 5, GETDATE())) AND STATUS = 'Now Showing'";
                    cmd = new SqlCommand(query, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                //Err
            }
        }

        private void ShowTimeFunction(object state)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                {
                    string query = "UPDATE SHOWTIME SET STATUS = 'Ended' WHERE SHOWTIME_DATE < GETDATE() AND STATUS != 'Ended'";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            catch (Exception ex)
            {
                //Err
            }
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {
            dailyTimer.Dispose();
            showTimeTimer.Dispose();
        }
    }
}