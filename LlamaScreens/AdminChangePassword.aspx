<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminChangePassword.aspx.cs" Inherits="LlamaScreens.AdminChangePassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="../img/llama-icon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="../img/llama-icon.png" type="image/x-icon" />
    <title>Llama</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
        crossorigin="anonymous" />
    <link href="Css/admin-default.css" rel="stylesheet" />
    <style>
        html,
        body {
            height: 100%;
        }

        * {
            user-select: none;
        }

        .label {
            padding-bottom: 2px !important;
        }

        .textbox {
            width: 100%;
            height: 20px;
            padding: 5px 6px;
            box-sizing: content-box;
            background-color: transparent;
            border: none;
            outline: none;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3), -2px -2px 5px rgba(253, 253, 253, 0.06);
            caret-color: rgba(255, 255, 255, 0.3);
            color: white;
            font-weight: 500;
            transition: all 0.5s;
        }

            .textbox::placeholder {
                color: white;
                opacity: 0.2;
                transition: all 0.2s;
            }

            .textbox:hover::placeholder,
            .textbox:focus::placeholder {
                opacity: 0.4;
            }

            .textbox:focus {
                box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.2), inset -2px -2px 5px rgba(253, 253, 253, 0.04);
            }

            .textbox::selection {
                background-color: rgba(253, 253, 253, 0.422);
                color: rgba(250, 207, 207);
            }

        .label,
        .loginbtn {
            color: white;
            opacity: 0.6;
            font-weight: 600;
            padding: 0;
        }

        .checkbox {
            padding: 0;
        }

            .checkbox label {
                padding-left: 5px;
                color: white;
                opacity: 0.6;
                font-weight: 600;
                transform: translateY(-1px);
            }

        .loginbtn {
            border-radius: 2px;
            width: 100%;
            margin: auto;
            margin-top: 20px;
            background-color: var(--admin-active-color);
            border: none;
            padding: 5px 10px;
            fill: white;
            transition: all 0.2s;
            opacity: 0.8;
        }

            .loginbtn:hover {
                box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.5), -1px -1px 5px var(--admin-active-color);
                opacity: 1;
                letter-spacing: 0.1em;
            }

            .loginbtn:active {
                box-shadow: inset 2px 2px 5px rgba(0, 0, 0, 0.5), inset -2px -2px 5px var(--admin-active-color);
            }

        .bg::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url(../img/bg.png);
            filter: invert(90%) brightness(35%);
            opacity: 0.1;
        }

        .bg::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            backdrop-filter: brightness(70%) blur(0.55px);
        }

        .validmsg {
            font-size: 0.8em;
            margin-top: 10px;
            text-align: center;
            padding: 0;
            color: white;
            position: relative;
            opacity: 0.6;
            font-weight: 500;
        }
        
        .btn-wrap{
            display:flex;
            justify-content:center;
        }
    </style>
</head>

<body class="bg-dark">

    <svg style="display: none;">
        <symbol id="login" viewBox="0 0 512 512">
            <path
                d="M217.9 105.9L340.7 228.7c7.2 7.2 11.3 17.1 11.3 27.3s-4.1 20.1-11.3 27.3L217.9 406.1c-6.4 6.4-15 9.9-24 9.9c-18.7 0-33.9-15.2-33.9-33.9l0-62.1L32 320c-17.7 0-32-14.3-32-32l0-64c0-17.7 14.3-32 32-32l128 0 0-62.1c0-18.7 15.2-33.9 33.9-33.9c9 0 17.6 3.6 24 9.9zM352 416l64 0c17.7 0 32-14.3 32-32l0-256c0-17.7-14.3-32-32-32l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32l64 0c53 0 96 43 96 96l0 256c0 53-43 96-96 96l-64 0c-17.7 0-32-14.3-32-32s14.3-32 32-32z" />
        </symbol>
        <symbol id="error" viewBox="0 0 512 512">
            <path
                d="M256 48a208 208 0 1 1 0 416 208 208 0 1 1 0-416zm0 464A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM175 175c-9.4 9.4-9.4 24.6 0 33.9l47 47-47 47c-9.4 9.4-9.4 24.6 0 33.9s24.6 9.4 33.9 0l47-47 47 47c9.4 9.4 24.6 9.4 33.9 0s9.4-24.6 0-33.9l-47-47 47-47c9.4-9.4 9.4-24.6 0-33.9s-24.6-9.4-33.9 0l-47 47-47-47c-9.4-9.4-24.6-9.4-33.9 0z" />
        </symbol>

    </svg>

    <form id="form1" runat="server" class="d-flex h-100 justify-content-center bg">
        <div class="d-flex align-items-center" style="z-index: 1;">
            <div class="container-fluid" style="padding-bottom: 200px;">
                <div class="row justify-content-center" title="Joy + Smile = Happy">
                    <div class="row" style="width: 128px;">
                        <img class="icon" src="../img/llama-icon.png" title="Llama say 'Meow'" style="width: 100%;">
                    </div>
                    <span class="row text-white d-flex justify-content-center" style="opacity: 0.8;">
                        <span class="row justify-content-center" style="font-weight: 600;">Change Password
                        </span>
                        <span class="row justify-content-center"
                            style="transform: translateY(-8px); font-size: 0.9em;">...
                        </span>
                    </span>
                </div>
                <div class="row"
                    style="min-height: 280px; background-color: rgb(33, 37 ,41); box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5),-3px -3px 5px rgba(255, 255, 255, 0.05); border-radius: 2px;">
                    <div class="row text-white justify-content-center"
                        style="font-size: 0.6em; font-weight: 600; opacity: 0.2; margin: 5px auto 10px auto;">
                        Admin Change Password
                    </div>
                    <div class="row justify-content-center"
                        style="box-sizing: content-box; width: 250px; margin: 0 auto; gap: 10px; padding: 10px 10px 30px 10px;">


                        <asp:Panel runat="server" ID="ChangePasswordPanel">
                            <div class="row" style="margin: 0 auto;">
                                <div class="row" style="margin: 0 auto;">
                                    <asp:Label ID="lblid" runat="server" Text="Email" AssociatedControlID="textboxid"
                                        class="label"></asp:Label>
                                </div>
                                <div class="row" style="margin: 0 auto;">
                                    <asp:TextBox ID="textboxid" runat="server" placeholder="Email" class="textbox">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel runat="server" ID="ConfirmChangePanel" Visible="false">
                            <div class="row" style="margin: 0 auto;">
                                <div class="row" style="margin: 0 auto;">
                                    <asp:Label ID="Label1" runat="server" Text="Password" AssociatedControlID="textboxid"
                                        class="label"></asp:Label>
                                </div>
                                <div class="row" style="margin: 0 auto;">
                                    <asp:TextBox ID="textboxpass" runat="server" class="textbox" TextMode="Password">
                                    </asp:TextBox>
                                </div>
                            </div>
                            <div class="row" style="margin: 0 auto;">
                                <div class="row" style="margin: 0 auto;">
                                    <asp:Label ID="Label2" runat="server" Text="Confirm Password" AssociatedControlID="textboxid"
                                        class="label"></asp:Label>
                                </div>
                                <div class="row" style="margin: 0 auto;">
                                    <asp:TextBox ID="textboxpass2" runat="server" class="textbox" TextMode="Password">
                                    </asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>


                        <div class="row" style="margin: 0 auto;">
                            <div class="row" style="margin: 0 auto; padding: 0;">
                                <asp:Label ID="lblvalid" runat="server" class="validmsg"></asp:Label>
                            </div>

                            <div class="row" style="margin: 0 auto;">
                                <asp:Panel runat="server" ID="ChangePasswordBtnPanel" CssClass="btn-wrap">
                                    <asp:Button runat="server" ID="changePassBtn" CssClass="loginbtn" Text="Change Password" OnClick="changePassBtn_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="ConfirmChangeBtnPanel" Visible="false" CssClass="btn-wrap">
                                    <asp:Button runat="server" ID="confirmBtn" CssClass="loginbtn" Text="Confirm Change" OnClick="confirmBtn_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="RedirectBtnPanel" Visible="false" CssClass="btn-wrap">
                                    <asp:Button runat="server" ID="RedirectBtn" CssClass="loginbtn" Text="Try Again" OnClick="RedirectBtn_Click" />
                                </asp:Panel>
                                <asp:Panel runat="server" ID="DoneBtnPanel" Visible="false" CssClass="btn-wrap">
                                    <asp:Button runat="server" ID="DoneBtn" CssClass="loginbtn" Text="Ok" OnClick="DoneBtn_Click" />
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div
                style="position: absolute; bottom: 0; left: 0; display: flex; justify-content: center; width: 100%; color: white; opacity: 0.4; font-weight: 500; font-size: 0.7em; padding: 10px 0;">
                Copyright Reserved © 2023 Llama Cinemas All Rights Reserved.
            </div>
        </div>
    </form>
</body>

</html>
