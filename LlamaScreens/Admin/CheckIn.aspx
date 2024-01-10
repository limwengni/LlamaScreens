<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckIn.aspx.cs" Inherits="LlamaScreens.Admin.CheckIn" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Llama Admin</title>


        <link rel="icon" href="../img/llama-icon.png" type="image/x-icon" />
        <link rel="shortcut icon" href="../img/llama-icon.png" type="image/x-icon" />


        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous" />


        <link href="../Css/admin-default.css" rel="stylesheet" />


        <link href="../Css/admin-nav.css" rel="stylesheet" />


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <style>
            body {
                background-color: transparent;
            }

            .main-wrap {
                display: flex;
                height: 100vh;
                width: 100vw;
                position: relative;
            }

            .bg {
                position: absolute;
                width: 100%;
                height: 100%;
                background-color: #212529;
                z-index: -1;
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

            .left-wrap,
            .right-wrap {
                flex: 1;
                min-width: 300px;
                padding: 50px 20px;
                display: flex;
                flex-direction: column;
                gap: 20px;
                justify-content: flex-start;
                align-items: center;
            }

            .content-box {
                display: flex;
                flex-direction: column;
                width: 500px;
            }

            .content-box p {
                margin: 0;
                color: white;
                text-align: center;
                font-weight: 600;
                opacity: 0.9;
            }

            .input-wrap {
                display: flex;
                flex-direction: column;
                background-color: #6c6c6c57;
                padding: 20px;
                border-radius: 20px;
            }

            .input-wrap label {
                color: white;
                opacity: 0.6;
                font-weight: 600;
            }

            .input-inner-wrap {
                display: flex;
                gap: 10px;
            }

            .input-inner-wrap input {
                padding: 2px 10px;
                font-weight: 500;
                background-color: transparent;
                border: none;
                outline: 0;
                opacity: 0.8;
                transition: all 0.2s;
            }

            .input-inner-wrap input::placeholder {
                color: white;
                opacity: 0.5;
            }

            .input-inner-wrap input:first-of-type {
                flex: 1;
                background-color: #d1d1d143;
                color: white;
            }

            .input-inner-wrap input:last-of-type {
                min-width: 90px;
                background-color: var(--admin-active-color);
                color: white;
                opacity: 0.8;
            }

            .input-inner-wrap input:hover {
                opacity: 1;
            }

            .btn-wrap {
                display: flex;
                gap: 10px;
                margin-top: 50px;
                flex-direction: row;
            }

            .btn-box {
                flex: 1;
                min-width: 100px;
                background-color: var(--admin-active-color);
                color: white;
                opacity: 0.8;
                border: none;
                outline: 0;
                font-size: 1.1em;
                font-weight: 600;
                border-radius: 5px;
                padding: 10px 5px;
            }

            .btn-box:hover {
                opacity: 1;
            }

            .details-wrap {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .col {
                display: flex;
                flex-direction: column;
            }

            .col p {
                opacity: 0.4;
                font-size: 0.8em;
            }

            .col span {
                opacity: 1;
                color: white;
                text-align: center;
                font-weight: 700;
            }

            .detail-box {
                background-color: #6c6c6c57;
                padding: 10px 20px;
                border-radius: 20px;
            }

            .seperator {
                height: 1px;
                background-color: transparent;
                width: 100%;
                margin: 10px 0;
            }

            .logout {
                position: absolute;
                border: none;
                outline: 0;
                font-weight: 600;
                background-color: var(--admin-active-color);
                color: white;
                left: 50%;
                transform: translateX(-50%);
                width: 90px;
                text-align: center;
                padding: 2px;
                border-radius: 0 0 5px 5px;
                opacity: 0.8;
                transition: all 0.2s;
            }

            .logout:hover {
                opacity: 1;
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="bg">


            </div>
            <div class="main-wrap">
                <asp:Button ID="logout" runat="server" Text="Log Out" class="logout" Onclick="logout_Click" />
                <div class="left-wrap">
                    <div class="content-box">
                        <div class="input-wrap">
                            <label>Enter Booking ID</label>
                            <div class="input-inner-wrap">
                                <asp:TextBox ID="TextBox1" runat="server" placeholder="bookingID" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
                                <asp:Button ID="Button1" runat="server" Text="Enter" />
                            </div>
                        </div>
                    </div>
                    <asp:Panel ID="Panel2" runat="server" Visible="false">
                        <div class="content-box">
                        <p>Successfully Checked In</p>
                            </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel3" runat="server" Visible="false">
                        <div class="content-box">
                        <p>No Booking Found</p>
                            </div>
                    </asp:Panel>
                    <asp:Panel ID="Panel1" runat="server" Visible="false">
                        <div class="content-box detail-box">
                            <p>Booking Details</p>
                            <div class="details-wrap">
                                <div class="row">
                                    <div class="col">
                                        <p>Movie Title</p>
                                        <asp:Label ID="title" runat="server" Text="Movie Title"></asp:Label>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col">
                                        <p>Date</p>
                                        <asp:Label ID="date" runat="server" Text="MM/DD/YYYY"></asp:Label>
                                    </div>
                                    <div class="col">
                                        <p>Time</p>
                                        <asp:Label ID="time" runat="server" Text="HH:MM"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="seperator"></div>
                            <div class="details-wrap">
                                <div class="row">
                                    <div class="col">
                                        <p>Total Seats</p>
                                        <asp:Label ID="total" runat="server" Text="10"></asp:Label>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col">
                                        <p>Adult</p>
                                        <asp:Label ID="adult" runat="server" Text="2"></asp:Label>
                                    </div>
                                    <div class="col">
                                        <p>Kid</p>
                                        <asp:Label ID="kid" runat="server" Text="7"></asp:Label>
                                    </div>
                                    <div class="col">
                                        <p>Senior/OKU</p>
                                        <asp:Label ID="senior" runat="server" Text="1"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="seperator"></div>
                            <div class="details-wrap">
                                <div class="row">
                                    <div class="col">
                                        <p>Venue No</p>
                                        <asp:Label ID="venue" runat="server" Text="1"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="content-box btn-wrap">
                            <asp:Button ID="Button2" runat="server" Text="Check In" class="btn-box" OnClick="Button2_Click" />
                            <asp:Button ID="Button3" runat="server" Text="Cancel" class="btn-box" OnClick="Button3_Click" />
                        </div>
                    </asp:Panel>
                    
                </div>
            </div>
        </form>
    </body>

    </html>