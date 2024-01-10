﻿<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ForgetPassword.aspx.cs" Inherits="LlamaScreens.ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forget Password</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="CSS/ForgetPassword.css" type="text/css" />

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container-fluid overflow-hidden">
        <div class="row text-white" style="height: 100vh; backdrop-filter: brightness(70%)" draggable="false">
            <div class="col-12 col-md-6 col-lg-5 ms-auto p-0 right-card">
                <div class="w-100 h-100">
                    <div class="p-5 overflow-hidden" style="height: inherit">
                        <a href="login.aspx" style="text-decoration: none; color: white;">< Back</a>
                        <form class="position-relative" id="form1" runat="server">
                            <asp:Label runat="server" Text="Forget Password" Font-Overline="False" Font-Size="XX-Large" ID="forgetPasswd" Font-Bold="True"></asp:Label>
                            <img class="ps-2" src="Img/surprise.png" id="forgetPasswdIcon" draggable="false" />
                            <div class="p-5">
                                <p style="font-size: 1.1em;">We will send a link to your email that can reset your password if you have forgotten your password.</p>
                                <p style="color: whitesmoke; filter: opacity(0.7);">Please enter your email address below for recovery.</p>
                            </div>
                            <div class="px-5">
                                <div class="detailInput m-auto">
                                    <input type="text" id="recoveryEmail" name="recoveryEmail" runat="server" required />
                                    <label for="recoveryEmail">Email address</label>
                                </div>
                            </div>
                            <div class="px-5">
                                <div class="pt-5 ps-4 verificationBtn">
                                    <asp:Button Text="Send verification link" runat="server" ID="verifyBtn" CssClass="verifyBtnCss" OnClick="verifyBtn_Click" />
                                    <br />
                                    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    const inputs = document.querySelectorAll('.detailInput input');
    const labels = document.querySelectorAll('.detailInput label');

    labels.forEach(label => {
        label.innerHTML = label.innerText
            .split('')
            .map((letter, idx) => `<span style="
        transition-delay: ${idx * 50}ms
      ">${letter}</span>`)
            .join('');
    });
</script>
</html>