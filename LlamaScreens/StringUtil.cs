using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net;
using System.Net.Mail;

//For Hashing
using BCrypt.Net;

namespace StringUtil
{
    public class PasswordHandler
    {
        public static String hashingPassword(String inputString)
        {
            return BCrypt.Net.BCrypt.HashPassword(inputString, BCrypt.Net.BCrypt.GenerateSalt(12));
        }

        public static bool verifyPassword(String inputString, String hashPassword)
        {
            return BCrypt.Net.BCrypt.Verify(inputString, hashPassword);
        }

        public static String unhashPassword(String inputString)
        {
            return BCrypt.Net.BCrypt.HashPassword(inputString, BCrypt.Net.BCrypt.GenerateSalt(12));
        }

    }

    public class Email
    {
        public static String sendEmail(String receiverEmail, String title, String Content)
        {
            string senderEmail = "lohtw-wm21@student.tarc.edu.my";
            string password = "dmtk mwsv slxl ihrp";

            MailMessage mail = new MailMessage(senderEmail, receiverEmail);

            mail.Subject = title;
            mail.Body = Content;

            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587); 
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new NetworkCredential(senderEmail, password);

            try
            {
                // Send the email
                smtpClient.Send(mail);
                Console.WriteLine("Email sent successfully!");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to send email: " + ex.Message);
                return ex.Message;
            }
            return "OK";
        }
    }
}