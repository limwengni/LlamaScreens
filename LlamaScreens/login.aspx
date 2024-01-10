<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs"
    Inherits="LlamaScreens.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login page</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="CSS/login.css" type="text/css" />
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
        rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<script type="text/javascript">
    function EndRequestHandler(sender, args) {
        const loginForm = document.getElementById("login-form");
        const registerForm = document.getElementById("register-form");
        const inputs = document.querySelectorAll(".detailInput input");
        const labels = document.querySelectorAll(".detailInput label");
        const options = document.querySelectorAll(".option");
        options.forEach((option) => {
            option.addEventListener("click", function (e) {
                const loginForm = document.getElementById("login-form");
                const registerForm = document.getElementById("register-form");

                options.forEach((opt) => opt.classList.remove("active"));
                this.classList.add("active");

                if (this.id === "login-btn") {
                    inputs.forEach((ipt) => {
                        if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                            ipt.required = true;
                        } else {
                            ipt.required = false;
                        }
                    });
                    loginForm.classList.remove("slideout");
                    registerForm.classList.add("slideout");

                    setTimeout(() => {
                        registerForm.classList.add("d-none");
                        loginForm.classList.remove("d-none");
                    }, 300);
                } else {
                    inputs.forEach((ipt) => {
                        if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                            ipt.required = false;
                        } else {
                            ipt.required = true;
                        }
                    });
                    registerForm.classList.remove("slideout");
                    loginForm.classList.add("slideout");

                    setTimeout(() => {
                        loginForm.classList.add("d-none");
                        registerForm.classList.remove("d-none");
                    }, 300);
                }
            });
        });

        if (document.getElementById("login-btn").classList.contains("active")) {
            loginForm.classList.remove("d-none");
            registerForm.classList.add("d-none");
            inputs.forEach((ipt) => {
                if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                    ipt.required = true;
                } else {
                    ipt.required = false;
                }
            });
        } else {
            loginForm.classList.add("d-none");
            registerForm.classList.remove("d-none");
            inputs.forEach((ipt) => {
                if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                    ipt.required = false;
                } else {
                    ipt.required = true;
                }
            });
        }

        labels.forEach((label) => {
            label.innerHTML = label.innerText
                .split("")
                .map(
                    (letter, idx) => `<span style="
        transition-delay: ${idx * 50}ms
      ">${letter}</span>`
                )
                .join("");
        });

        
    }
    function load() {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
    }
</script>
<body onload="load()">
    <div class="container-fluid overflow-hidden">
        <div
            class="row text-white"
            style="height: 100vh; backdrop-filter: brightness(70%)" draggable="false">
            <div class="col-12 col-md-8 col-lg-5 p-0 left-card">
                <div class="w-100 h-100">
                    <div class="py-5 px-5">
                        <a class="text-decoration-none text-white h1" href="main.aspx" draggable="false">
                            <img src="img/llama-icon.png" alt="Logo" draggable="false" width="70" />LLama Cinema</a>
                    </div>
                    <div class="selection d-flex w-100 justify-content-center gap-5">
                        <div class="option active" id="login-btn">Login</div>
                        <div class="option" id="register-btn">Register</div>
                    </div>
                    <div class="p-2 overflow-hidden" style="height: inherit">
                        <form class="position-relative" id="form1" runat="server">
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="d-block form-input" id="login-form">
                                        <asp:Label
                                            Style="user-select: none;"
                                            runat="server"
                                            Text="Log in"
                                            Font-Overline="False"
                                            Font-Size="XX-Large"
                                            ID="ctl08"
                                            Font-Bold="True"></asp:Label>
                                        <div class="detailInput">
                                            <input type="text" id="login-email" name="login-email" />
                                            <label for="login-email">Email address</label>
                                        </div>
                                        <div class="detailInput">
                                            <input type="password" id="login-passwd" name="login-passwd" />
                                            <label for="login-passwd">Password</label>
                                        </div>
                                        <div>
                                            <asp:Label ID="ErrMsg" runat="server"></asp:Label>
                                        </div>
                                        <asp:Button CssClass="lgnBtn" ID="Login_Btn" Text="Login" runat="server" OnClick="ClickEv" UseSubmitBehavior="False" />
                                        <asp:Button
                                            ID="resetPassword"
                                            runat="server"
                                            Text="Forget Password?"
                                            CssClass="forgetPassBtn"
                                            PostBackUrl="~/ForgetPassword.aspx" />
                                    </div>
                                    <div class="d-none form-input" id="register-form">
                                        <asp:Label
                                            Style="user-select: none;"
                                            runat="server"
                                            Text="Register"
                                            Font-Overline="False"
                                            Font-Size="XX-Large"
                                            ID="Label1"
                                            Font-Bold="True"></asp:Label>
                                        <div class="detailInput">
                                            <input type="text" id="username" name="reg-username" />
                                            <label for="username">Username</label>
                                            <asp:Label ID="usernameErrMsg" runat="server"></asp:Label>
                                        </div>
                                        <div class="detailInput">
                                            <input type="text" id="email" name="reg-email" />
                                            <label for="email">Email address</label>
                                            <asp:Label ID="emailErrMsg" runat="server"></asp:Label>
                                        </div>

                                        <div class="detailInput d-flex">
                                            <div
                                                class="col-2 me-2"
                                                style="border: 3px white solid; border-radius: 10%; text-align: center;">
                                                <img
                                                    src="img/msiaFlag.jpg"
                                                    alt="flag"
                                                    style="border-radius: 100%; height: 20px; width: 20px" />
                                                +60
                                            </div>
                                            <div class="col-5 pe-3">
                                                <input type="text" id="phonenum" name="reg-phone" />
                                                <label for="phonenum" style="left: auto">Phone Number</label>
                                                <asp:Label ID="phoneErrMsg" runat="server"></asp:Label>
                                            </div>

                                            <div class="col-5 pe-2">
                                                <input
                                                    type="text"
                                                    id="birthdate" name="reg-birthdate"
                                                    onclick="openDatePicker()"
                                                    onblur="checkIfEmpty()" />
                                                <label
                                                    id="lblBirthDate"
                                                    for="birthdate"
                                                    style="left: auto">Birth Date</label>
                                                <asp:Label ID="birthErrMsg" runat="server"></asp:Label>
                                            </div>
                                        </div>

                                        <div class="detailInput d-flex">
                                            <div class="col-6 pe-3">
                                                <input type="password" id="passwd" name="reg-passwd" />
                                                <label for="passwd">Password</label>
                                                <asp:Label ID="passwdErrMsg" runat="server"></asp:Label>

                                            </div>
                                            <div class="col-6">
                                                <input type="password" id="retypepasswd" name="reg-repasswd" />
                                                <label for="retypepasswd" style="left: auto">Retype Password</label>
                                                <asp:Label ID="repasswdErrMsg" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                        <asp:Button CssClass="signupBtn" ID="Sign_Up_Btn" Text="Sign up" runat="server" OnClick="ClickEvReg" UseSubmitBehavior="False" />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="Login_Btn" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="Sign_Up_Btn" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </form>
                        <div class="pt-4"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    const inputs = document.querySelectorAll(".detailInput input");
    const labels = document.querySelectorAll(".detailInput label");
    const options = document.querySelectorAll(".option");
    inputs[0].required = true;
    inputs[1].required = true;
    labels.forEach((label) => {
        label.innerHTML = label.innerText
            .split("")
            .map(
                (letter, idx) => `<span style="
        transition-delay: ${idx * 50}ms
      ">${letter}</span>`
            )
            .join("");
    });

    //check which option is active then show which form no jquery
    //document.addEventListener("DOMContentLoaded", function () {
    //const loginForm = document.getElementById("login-form");
    //const registerForm = document.getElementById("register-form");

    //if (document.getElementById("login-btn").classList.contains("active")) {
    //    loginForm.classList.remove("d-none");
    //    registerForm.classList.add("d-none");
    //} else {
    //    loginForm.classList.add("d-none");
    //    registerForm.classList.remove("d-none");
    //}
    //});



    options.forEach((option) => {
        option.addEventListener("click", function (e) {
            const loginForm = document.getElementById("login-form");
            const registerForm = document.getElementById("register-form");

            options.forEach((opt) => opt.classList.remove("active"));
            this.classList.add("active");

            if (this.id === "login-btn") {
                inputs.forEach((ipt) => {
                    if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                        ipt.required = true;
                    } else {
                        ipt.required = false;
                    }
                });
                loginForm.classList.remove("slideout");
                registerForm.classList.add("slideout");

                setTimeout(() => {
                    registerForm.classList.add("d-none");
                    loginForm.classList.remove("d-none");
                }, 300);
            } else {
                inputs.forEach((ipt) => {
                    if (ipt.id == "login-email" || ipt.id == "login-passwd") {
                        ipt.required = false;
                    } else {
                        ipt.required = true;
                    }
                });
                registerForm.classList.remove("slideout");
                loginForm.classList.add("slideout");

                setTimeout(() => {
                    loginForm.classList.add("d-none");
                    registerForm.classList.remove("d-none");
                }, 300);
            }
        });
    });
</script>
<script>
    function openDatePicker() {
        var dateInput = document.getElementById("birthdate");
        dateInput.type = "date";
        dateInput.click();
    }

    function checkIfEmpty() {
        var dateInput = document.getElementById("birthdate");

        if (dateInput.value.trim() === "") {
            dateInput.type = "text";
        }
    }
</script>
</html>
