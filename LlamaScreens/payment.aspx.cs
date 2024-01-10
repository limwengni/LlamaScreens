using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stripe;

namespace LlamaScreens
{
    public partial class payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ViewDetails"] == null && Session["MovieId"] == null)
            {
                Response.Redirect("movieList.aspx");
            }

            if (Session["loggedIn"] == null)
            {
                Response.Redirect("login.aspx");
            }
            //else
            //{
            //    string id = Session["MovieId"].ToString();

            //    SqlDataSource1.SelectCommand = "SELECT Movie.* FROM Movie WHERE movie_id = '" + id + "'";
            //    SqlDataSource1.DataBind();

            //}

            if (!IsPostBack)
            {
                if (Session["BookingPrice"] != null)
                {
                    string bookingPriceString = Session["BookingPrice"].ToString();
                    if (double.TryParse(bookingPriceString, out double parsedPrice))
                    {
                        lblTotal.Text = string.Format("{0:0.00}", parsedPrice);
                    }
                    double price = double.Parse(bookingPriceString);
                    int point = 0;
                    if (price >= 20)
                    {
                        if (Session["email"] != null)
                        {
                            String memberEmail = Session["email"].ToString();
                            try
                            {
                                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                                {
                                    conn.Open();
                                    string query = "SELECT member_point FROM [MEMBER] WHERE member_email = @email";
                                    SqlCommand cmd = new SqlCommand(query, conn);
                                    cmd.Parameters.AddWithValue("@email", memberEmail);
                                    SqlDataReader reader = cmd.ExecuteReader();
                                    if (reader.HasRows)
                                    {
                                        reader.Read();
                                        point = (int)reader["member_point"];
                                    }
                                    conn.Close();
                                }
                            }
                            catch (Exception ex)
                            {
                                //Err
                            }

                            if (point > 0)
                            {
                                int usedPoint = 0;
                                double discount = 0;

                                double maxDiscount = price * 0.75;
                                int maxPointUseable = (int)Math.Ceiling(maxDiscount / 0.5);

                                if (point >= maxPointUseable)
                                {
                                    usedPoint = maxPointUseable;
                                    discount = maxDiscount;
                                }
                                else
                                {
                                    usedPoint = point;
                                    discount = point * 0.5;
                                }


                                point = point - usedPoint;
                                price = price - discount;
                                Session["BookingPrice"] = price;
                                lblDiscount.Text = string.Format("{0:0.00}", discount);
                                lblTrueTotal.Text = string.Format("{0:0.00}", price);
                                discountPanelMsg.Visible = false;
                                discountPanelMsg2.Visible = true;
                                discountPanel.Visible = true;
                                discountPanel2.Visible = true;
                            }

                            point = point + (int)Math.Ceiling(price * 0.1 / 0.5);
                        }


                    }

                    Session["point"] = point;


                    //lblTotal.Text = Session["BookingPrice"].ToString();
                }

                if (Session["ChildCount"] != null)
                {
                    string childCountString = Session["ChildCount"].ToString();
                    childCount.Text = childCountString;
                }
                else
                {
                    childCount.Text = "0";
                }

                if (Session["AdultCount"] != null)
                {
                    string adultCountString = Session["AdultCount"].ToString();
                    adultCount.Text = adultCountString;

                }
                else
                {
                    adultCount.Text = "0";
                }

                if (Session["SeniorCount"] != null)
                {
                    string seniorCountString = Session["SeniorCount"].ToString();
                    seniorCount.Text = seniorCountString;
                }
                else
                {
                    seniorCount.Text = "0";
                }

                if (Session["Seats"] != null)
                {
                    string seatsString = Session["Seats"].ToString();

                    // Split the seats string by comma and space
                    string[] seatsArray = seatsString.Split(new char[] { ',', ' ' }, StringSplitOptions.RemoveEmptyEntries);

                    // Sort the seats array
                    Array.Sort(seatsArray);

                    // Join the sorted seats back into a string
                    string sortedSeats = string.Join(", ", seatsArray);

                    // Display the rearranged seats
                    seats.Text = sortedSeats;
                }

                // Populate textboxes with session variable values if they exist
                if (Session["NameValue"] != null)
                {
                    holderName.Text = Session["NameValue"].ToString();
                }
                if (Session["CvvValue"] != null)
                {
                    cvv.Text = Session["CvvValue"].ToString();
                }
                if (Session["CardNumberValue"] != null)
                {
                    cardNumber.Text = Session["CardNumberValue"].ToString();
                }
                if (Session["ExpiryDateValue"] != null)
                {
                    exp.Text = Session["ExpiryDateValue"].ToString();
                }

                // Clear session variables after using their values
                Session.Remove("NameValue");
                Session.Remove("CvvValue");
                Session.Remove("CardNumberValue");
                Session.Remove("ExpiryDateValue");

                if (!string.IsNullOrEmpty(holderName.Text) && !string.IsNullOrEmpty(cvv.Text) && !string.IsNullOrEmpty(cardNumber.Text) && !string.IsNullOrEmpty(exp.Text))
                {
                    btnContinue.Enabled = true;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Session["paymentMade"] = false;
            Response.Redirect("main.aspx");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            bool paymentSuccess = false;
            string cardNo = cardNumber.Text.Trim();
            string expiryDate = exp.Text.Trim();
            string name = holderName.Text.Trim(); //no need validate
            string cvvStr = cvv.Text.Trim(); //no need validate

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(cvvStr))
            {
                // Store values in session variables before redirecting
                Session["NameValue"] = name;
                Session["CvvValue"] = cvvStr;
                Session["CardNumberValue"] = cardNo;
                Session["ExpiryDateValue"] = expiryDate;

                ScriptManager.RegisterStartupScript(this, GetType(), "FillFieldsAlert", "alert('Please fill in all required fields.');", true);

                // Re-enable the button
                btnContinue.Enabled = true;

                // Call the JavaScript function to update logos based on card number
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCardLogos", "updateCardLogos('" + cardNo + "');", true);

                return;
            }

            if (IsNumeric(cardNo))
            {
                string sanitizedValue = cardNo.Replace(" ", "").Replace("-", ""); // Remove spaces for length check
                if (sanitizedValue.Length == 16)
                {
                    char firstDigit = sanitizedValue[0];

                    if (char.IsDigit(firstDigit))
                    {
                        int firstDigitValue = int.Parse(firstDigit.ToString());
                        bool validCard = false;

                        if (firstDigitValue == 4 || firstDigitValue == 5) //visa or mastercard
                        {
                            validCard = ValidateCreditCardNumber(sanitizedValue);

                            if (!validCard)
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidCardNo", "alert('Please enter valid card number.');", true);
                                return;
                            }

                            //check expiry date
                            bool isValidExp = ValidateExpiryDate(expiryDate);

                            if (!isValidExp)
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "InvalidExpiryDate", "alert('Please enter valid expiry date.');", true);
                                return;
                            }

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "InvalidCardNo", "alert('Please enter valid card number.');", true);
                            return;
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "InvalidLength", "alert('Please enter your 16-digit card number.');", true);

                    // Re-enable the button
                    btnContinue.Enabled = true;

                    // Call the JavaScript function to update logos based on card number
                    ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCardLogos", "updateCardLogos('" + cardNo + "');", true);

                    return; // Return to prevent further execution
                }

                paymentSuccess = true;
            }
            else
            {
                // Alert the user about non-numeric characters in the card number
                ScriptManager.RegisterStartupScript(this, GetType(), "NonNumericCardNumberAlert", "alert('Card number should contain only digits.');", true);

                // Re-enable the button
                btnContinue.Enabled = true;

                // Call the JavaScript function to update logos based on card number
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCardLogos", "updateCardLogos('" + cardNo + "');", true);
            }

            if (paymentSuccess)
            {
                string sanitizedValue = cardNo.Replace(" ", "").Replace("-", "");
                char firstDigit = sanitizedValue[0];
                int firstDigitValue = int.Parse(firstDigit.ToString());
                string paymentMethod = "";

                if (firstDigitValue == 4) //visa
                {
                    paymentMethod = "Visa";
                }
                else if (firstDigitValue == 5) //mastercard
                {
                    paymentMethod = "Mastercard";
                }

                StripeConfiguration.ApiKey = "sk_test_51OPI6AHnuyridiIuotDeJy7gdquxx8y4gNCyldPLpoRhgaKPNdsLheQVF21zQl0HAQ2XJ2cZ3N4tur0IsuVixAdF007cywHYzM";

                // Retrieve the token from the client
                string tokenId = Request.Form["stripeToken"];
                string customerId = "cus_PDqAdRoRkVEZfE";

                if (double.TryParse(Session["BookingPrice"].ToString(), out double bookingPrice))
                {
                    int priceCents = (int)(bookingPrice * 100); // Convert to cents

                    // Use the token to perform a charge or save the payment method securely
                    var options = new ChargeCreateOptions
                    {
                        Amount = priceCents, // The payment amount in cents
                        Currency = "myr",
                        Customer = customerId,
                        Description = "Payment for movie tickets"
                    };

                    var service = new ChargeService();
                    Charge charge = service.Create(options);

                    // Check if the charge is successful
                    if (charge.Paid)
                    {
                        var payment = service.Get(charge.Id);
                        //string fileName = "receipt.html"; // Replace with your file name
                        //string filePath = Path.Combine(Directory.GetCurrentDirectory(), fileName);
                        var receiptTemplate = System.IO.File.ReadAllText(Server.MapPath("~/receipt.html"));

                        var amountInRM = (double)payment.AmountCaptured / 100;

                        var email = "";
                        var movieTitle = "";

                        //get email
                        if (Session["email"] != null)
                        {
                            email = Session["email"].ToString();
                        }

                        //get movie title
                        if (Session["movieTitle"] != null)
                        {
                            movieTitle = Session["movieTitle"].ToString();
                        }

                        //get customer name and point
                        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                        {
                            connection.Open();

                            string sqlQuery = "SELECT Member.* FROM Member WHERE member_email = @Email";

                            using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                            {
                                command.Parameters.AddWithValue("@Email", email);

                                using (SqlDataReader reader = command.ExecuteReader())
                                {
                                    if (reader.Read())
                                    {
                                        string memberName = reader["member_username"].ToString();
                                        int points = Convert.ToInt32(reader["member_point"]);
                                        int memberId = Convert.ToInt32(reader["member_id"]);
                                        Session["memberName"] = memberName;
                                        Session["points"] = points;
                                        Session["memberId"] = memberId;

                                        var receipt = receiptTemplate
                        .Replace("{{ payment_id }}", payment.Id)
                        .Replace("{{ payment_date }}", DateTime.Now.ToString("MMM d, yyyy h:mm tt", System.Globalization.CultureInfo.InvariantCulture))
                        .Replace("{{ payment_amount }}", string.Format("{0:0.00}", amountInRM))
                        .Replace("{{ payment_type }}", paymentMethod)
                        .Replace("{{ movie_title }}", movieTitle) // **Replace with the movie title for the transaction
                        .Replace("{{ customer_name }}", memberName) // **Replace with the customer name for the transaction
                        .Replace("{{ customer_email }}", email); // **Replace with the customer email for the transaction(need change based on custID later)******

                                        // Send the email message using the EmailSender class
                                        var emailSender = new EmailSender("smtp.gmail.com", 587, "lim1227december@gmail.com", "gjxm vojd cwej nlwl");
                                        emailSender.SendEmail(email, "Llama Cinema Ticket Purchase Receipt", receipt);

                                        reader.Close();
                                    }
                                    //save to transaction and booking tables
                                    string insertQuery = "INSERT INTO [Transaction] (transaction_id, transaction_method, amount, created_date, status) VALUES (@Trans_Id, @Method, @Amount, @Created_date, @Status); SELECT SCOPE_IDENTITY();";

                                    string transactionId = "";

                                    using (SqlCommand insertCommand = new SqlCommand(insertQuery, connection))
                                    {
                                        insertCommand.Parameters.AddWithValue("@Trans_Id", payment.Id);
                                        insertCommand.Parameters.AddWithValue("@Method", paymentMethod);
                                        insertCommand.Parameters.AddWithValue("@Amount", amountInRM);
                                        insertCommand.Parameters.AddWithValue("@Created_date", DateTime.Now);
                                        insertCommand.Parameters.AddWithValue("@Status", "Success");

                                        //try
                                        //{
                                        var result = insertCommand.ExecuteScalar();

                                        //    if (result != DBNull.Value)
                                        //    {
                                        //        transactionId = result.ToString();
                                        //    }
                                        //}
                                        //catch (Exception ex)
                                        //{
                                        //    // Log the exception to a file
                                        //    string logFilePath = Server.MapPath("~/App_Data/ErrorLog.txt");
                                        //    using (StreamWriter sw = System.IO.File.AppendText(logFilePath))
                                        //    {
                                        //        sw.WriteLine("Error inserting into Transaction table: " + ex.Message);
                                        //    }
                                        //}
                                    }




                                    if (transactionId != null)
                                    {
                                        string insertQuery2 = "INSERT INTO Booking (member_id, transaction_id, created_date, status) VALUES (@MemberID, @TransID, @Created_date, @Status); SELECT SCOPE_IDENTITY();";

                                        int bookingId = 0;
                                        using (SqlCommand insertCommand = new SqlCommand(insertQuery2, connection))
                                        {
                                            // Assuming you have retrieved memberId and transactionId
                                            insertCommand.Parameters.AddWithValue("@MemberID", (int)Session["memberId"]);
                                            insertCommand.Parameters.AddWithValue("@TransID", payment.Id);
                                            insertCommand.Parameters.AddWithValue("@Created_date", DateTime.Now);
                                            insertCommand.Parameters.AddWithValue("@Status", "Success");

                                            object result = insertCommand.ExecuteScalar();

                                            if (result != null)
                                            {
                                                Console.WriteLine("Booking data inserted successfully.");
                                                bookingId = Convert.ToInt32(result);
                                            }
                                            else
                                            {
                                                Console.WriteLine("Failed to insert booking data.");
                                            }
                                        }

                                        if (bookingId != 0)
                                        {

                                            int[] seatType = { Convert.ToInt32(Session["ChildCount"]), Convert.ToInt32(Session["AdultCount"]), Convert.ToInt32(Session["SeniorCount"]) };
                                            string[] seatTypeName = { "Kid", "Adult", "Senior" };
                                            string seatsString = Session["Seats"].ToString();

                                            // Split the seats string by comma and space
                                            string[] seatsArray = seatsString.Split(new char[] { ',', ' ' }, StringSplitOptions.RemoveEmptyEntries);

                                            // Sort the seats array
                                            Array.Sort(seatsArray);


                                            string sqlQuery2 = "INSERT INTO Ticket (booking_id, showtime_id, seat_type, seat_id, created_date, status) VALUES (@BookingID, @ShowTimeID, @SeatType, @SeatID, @Created_date, @Status); SELECT SCOPE_IDENTITY();";
                                            int seatIndex = 0;
                                            for (int n = 0; n < seatType.Length; n++)
                                            {
                                                for (int m = 0; m < seatType[n]; m++)
                                                {
                                                    using (SqlCommand cmd = new SqlCommand(sqlQuery2, connection))
                                                    {
                                                        cmd.Parameters.AddWithValue("@BookingID", bookingId);
                                                        cmd.Parameters.AddWithValue("@ShowTimeID", Session["showtimeID"].ToString());
                                                        cmd.Parameters.AddWithValue("@SeatType", seatTypeName[n]);
                                                        cmd.Parameters.AddWithValue("@SeatID", seatsArray[seatIndex++]);
                                                        cmd.Parameters.AddWithValue("@Created_date", DateTime.Now);
                                                        cmd.Parameters.AddWithValue("@Status", "Booked");

                                                        object result = cmd.ExecuteScalar();

                                                        if (result != null)
                                                        {
                                                            Console.WriteLine("Ticket data inserted successfully.");
                                                        }
                                                        else
                                                        {
                                                            Console.WriteLine("Failed to insert ticket data.");
                                                        }
                                                    }
                                                }
                                            }

                                            string query = "UPDATE [MEMBER] SET member_point = @point WHERE member_email = @email";
                                            using (SqlCommand pointCmd = new SqlCommand(query, connection))
                                            {
                                                pointCmd.Parameters.AddWithValue("@email", Session["email"].ToString());
                                                pointCmd.Parameters.AddWithValue("@point", Session["point"]);
                                                int rowsAffected = pointCmd.ExecuteNonQuery();
                                            }
                                        }
                                    }
                                    else
                                    {
                                        // Handle the case where no rows are returned for the given email
                                        Console.WriteLine("No data found for the given email.");
                                    }
                                }
                            }
                        }

                        Session["paymentID"] = payment.Id;
                        Session["paymentAmount"] = string.Format("{0:0.00}", Convert.ToDouble(Session["BookingPrice"]));
                    }

                    // Redirect or perform any actions for successful payment
                    Session["paymentMade"] = true;
                    Response.Redirect("main.aspx");
                }
                else
                {
                    // Handle failed payment
                    Session["paymentMade"] = false;
                    Response.Redirect("main.aspx");
                }
            }
        }

        public bool ValidateCreditCardNumber(string cardNumber)
        {
            cardNumber = cardNumber.Replace(" ", ""); // Remove spaces if present
            int sum = 0;
            bool isSecondDigit = false;

            for (int i = cardNumber.Length - 1; i >= 0; i--)
            {
                int digit = cardNumber[i] - '0';

                if (isSecondDigit)
                {
                    digit *= 2;
                    if (digit > 9)
                    {
                        digit = digit % 10 + 1;
                    }
                }

                sum += digit;
                isSecondDigit = !isSecondDigit;
            }

            return sum % 10 == 0;
        }

        private bool IsNumeric(string str)
        {
            foreach (char c in str)
            {
                if (!char.IsDigit(c) && c != ' ' && c != '-')
                {
                    return false;
                }
            }
            return true;
        }

        public bool ValidateExpiryDate(string expiryDate)
        {
            //split month and year
            string[] parts = expiryDate.Split('/');

            if (parts.Length != 2)
            {
                return false; //incorrect format
            }

            // Parse month and year from the parts
            if (!int.TryParse(parts[0], out int month) || !int.TryParse(parts[1], out int year))
            {
                // Invalid month or year format, return false
                return false;
            }

            // Get current month and year
            int currentMonth = DateTime.Now.Month;
            int currentYear = DateTime.Now.Year % 100; // Get last two digits of the current year

            // Check if the entered year is in the future
            if (year < currentYear || (year == currentYear && month < currentMonth))
            {
                return false;
            }

            return true; // Expiry date is valid
        }
    }
}