<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AddShowtime.aspx.cs" Inherits="LlamaScreens.Admin.AddShowtime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        p {
            padding: 0;
            margin: 0;
        }

        .main-content-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .wrap-title {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.5);
            padding: 0;
            margin: 0;
        }

        .movie-content-wrap {
            display: flex;
            flex-direction: column;
        }

        .movie-wrap {
            padding: 10px;
            display: flex;
            gap: 10px;
            flex-direction: column;
        }

        .movie-card {
            display: flex;
            padding: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.5);
            opacity: 0.8;
            gap: 10px;
            max-width: 302px;
            transition: all 0.2s;
            user-select: none;
        }

        .movie-img-wrap {
            flex: 1;
            justify-content: center;
            align-items: center;
            display: flex;
        }

        .movie-img {
            width: 72px;
            height: 111px;
            border-radius: 5px;
        }

        .movie-box-wrap {
            display: flex;
            gap: 10px;
            min-width: 400px;
            overflow-x: scroll;
            padding: 5px;
        }

        .movie-card p {
            font-weight: 600;
        }

        .movie-title {
            min-width: 200px;
            word-wrap: wrap;
            margin-top: 5px;
            line-height: 0.9em;
        }

        .movie-length,
        .movie-released {
            font-size: 0.8em;
        }

        .movie-card:hover {
            opacity: 1;
            background-color: var(--admin-bg-hover);
        }

        .gap {
            height: 10px;
        }

        .venue-card {
            padding: 5px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.5);
            min-width: 150px;
            max-width: 150px;
            text-align: center;
            justify-content: center;
            align-items: center;
            display: flex;
            flex-direction: column;
            opacity: 0.8;
            user-select: none;
        }

            .venue-card:hover {
                opacity: 1;
                background-color: var(--admin-bg-hover);
            }

        .venue-wrap {
            padding: 10px;
            display: flex;
            min-width: 400px;
            overflow-x: scroll;
            gap: 10px;
        }

        .venue-id {
            display: none;
        }

        .venue-type {
            font-weight: 600;
            font-size: 0.9em;
            color: rgba(0, 0, 0, 0.4);
        }

        .venue-divider {
            width: 80%;
            height: 1px;
            margin: 5px 0;
            display: flex;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .showtime-input-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .input-wrap {
            position: relative;
            flex: 1;
            min-width: 200px;
            display: flex;
        }

        .inputbox {
            flex: 1;
        }

        .input-container {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

        .search-box-wrap {
            display: flex;
            gap: 10px;
            min-width: 375px;
            flex-wrap: wrap;
        }

        .search-btn {
            font-size: 0.8em;
            width: 55px;
            padding: 5px;
        }

        .search-result-wrap {
            display: flex;
            justify-content: left;
            align-items: left;
            flex: 1;
            min-width: 290px;
            padding-left: 20px;
        }

        .create-btn-wrap {
            display: flex;
            margin-top: 20px;
        }

            .create-btn-wrap .btn {
                flex: 1;
            }

        .errMsg {
            font-weight: 600;
            color: black;
            opacity: 0.8;
            text-align: center;
            padding-top: 10px;
        }

        .disabledInput{
            pointer-events: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
        <div class="main-content-wrap">
            <div class="movie-content-wrap">
                <p class="wrap-title">Select Movie</p>
                <div class="movie-wrap down">
                    <div class="search-wrap">
                        <div class="search-box-wrap">
                            <div class="search-input-wrap">
                                <svg class="search-icon">
                                    <use xlink:href="#search"></use>
                                </svg>
                                <asp:TextBox runat="server" ID="search_textbox" placeholder="Movie Name / ID"
                                    class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                            </div>
                            <asp:Button runat="server" ID="search_btn"
                                class="btn up hover-moreup active-down search-btn" Text="Search" OnClick="search_trigger"></asp:Button>
                        </div>
                        <div class="search-result-wrap">
                            <asp:Label ID="lbltotal" class="searchmsg" Text="Showing 3 results for your search"
                                runat="server"></asp:Label>
                        </div>
                    </div>
                    <asp:ScriptManager ID="ScriptManager1" runat="server" />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="movie-box-wrap tablecover">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT * FROM [Movie]"></asp:SqlDataSource>
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <div class="movie-card up hover-moreup active-down tablerow">
                                        <div class="movie-img-wrap">
                                            <img class="movie-img"
                                                src="../Img/Movies/<%# Eval("movie_id") %>/picture.jpg"
                                                draggable="false">
                                        </div>
                                        <div class="movie-text-wrap">
                                            <p class="movie-released"><%# Eval("release_date", "{0:d}") %></p>
                                            <p class="movie-length"><%# Eval("movie_length") %> Minutes</p>
                                            <p class="movie-title"><%# Eval("movie_title") %></p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="search_textbox" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="search_btn" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="gap"></div>
                <p class="wrap-title">Select Available Venue (Date & Time is Required)</p>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" Class="venue-wrap down">
                        <ContentTemplate>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="venue-card up hover-moreup active-down">
                            <div class="venue-id"><%# Eval("venue_id") %></div>
                            <div class="venue-no"><%# Eval("venue_no") %></div>
                            <div class="venue-divider"></div>
                            <div class="venue-type"><%# Eval("venue_type_name")%> (<%# Eval("total_seat") %>)</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                            </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="date" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="time" EventName="TextChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                <div class="gap"></div>
                <div class="showtime-input-wrap">
                    <div class="input-container">
                        <div class="input-wrap">
                            <asp:TextBox ID="movieInput" runat="server" CssClass="inputbox down disabledInput" TabIndex="-1"
                                TextMode="SingleLine" title="Selected Movie" placeholder="Select From Above"></asp:TextBox>
                            <asp:Label AssociatedControlID="movieInput" ID="lblMovie" runat="server" Text="Selected Movie"></asp:Label>
                        </div>
                        <div class="input-wrap">
                            <asp:TextBox ID="venueInput" runat="server" CssClass="inputbox down disabledInput" TabIndex="-1"
                                TextMode="SingleLine" title="Selected Venue" placeholder="Select From Below"></asp:TextBox>
                            <asp:Label AssociatedControlID="venueInput" ID="lblVenue" runat="server" Text="Selected Venue"></asp:Label>
                        </div>
                    </div>
                    <div class="input-container">
                        <div class="input-wrap">
                            <asp:TextBox ID="date" runat="server" CssClass="inputbox dateInput down" OnTextChanged="date_TextChanged"
                                TextMode="Date" title="Fill In Showtime Date" AutoPostBack="true"></asp:TextBox>
                            <asp:Label AssociatedControlID="date" ID="lblDate" runat="server" Text="Select Showtime Date"></asp:Label>
                        </div>
                        <div class="input-wrap">
                            <asp:TextBox ID="time" runat="server" CssClass="inputbox dateInput down" OnTextChanged="date_TextChanged"
                                TextMode="Time" title="Fill In Showtime Time" AutoPostBack="true"></asp:TextBox>
                            <asp:Label AssociatedControlID="time" ID="lblTime" runat="server" Text="Select Time"></asp:Label>
                        </div>
                    </div>
                </div>
                <asp:Label ID="ErrMsg" runat="server" CssClass="errMsg"></asp:Label>
                <div class="gap"></div>
                <div class="create-btn-wrap">

                    <asp:Button ID="btnCreateShowtime" runat="server" CssClass="btn up hover-moreup active-down" Text="Create Showtime" Onclick="btnCreateShowtime_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script>
        
        var venueInput = $('#content_venueInput');
        var movieInput = $('#content_movieInput');

        function changeVenue(e) {
            venueInput.val($(e).find('.venue-no').eq(0).html());
        }
        function changeMovie(e) {
            movieInput.val($(e).find('.movie-title').eq(0).html());
        }

        function update() {
            $('.venue-card').on('click', function () {
                changeVenue(this);
            });
            $('.movie-card').on('click', function () {
                changeMovie(this);
            });
        }

        update();
    </script>
</asp:Content>
