using MimeKit;
using MailKit.Net.Smtp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LlamaScreens
{
    public class EmailSender
    {
        private readonly string _smtpServer;
        private readonly int _smtpPort;
        private readonly string _smtpUsername;
        private readonly string _smtpPassword;

        public EmailSender(string smtpServer, int smtpPort, string smtpUsername, string smtpPassword)
        {
            _smtpServer = smtpServer;
            _smtpPort = smtpPort;
            _smtpUsername = smtpUsername;
            _smtpPassword = smtpPassword;
        }

        public void SendEmail(string toEmail, string subject, string body)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("Llama Cinema Sdn Bhd", "invoice@llamacinema.com"));
            message.To.Add(new MailboxAddress("", toEmail));
            message.Subject = subject;

            message.Body = new TextPart("html")
            {
                Text = body
            };

            using (var client = new SmtpClient())
            {
                client.Connect(_smtpServer, _smtpPort, false);
                client.Authenticate(_smtpUsername, _smtpPassword);
                client.Send(message);
                client.Disconnect(true);
            }
        }
    }
}