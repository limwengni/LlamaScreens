<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AddVenue.aspx.cs" Inherits="LlamaScreens.Admin.AddVenue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .top-button-wrap {
            display: flex;
            padding-top: 10px;
            gap: 15px;
        }

            .top-button-wrap .btn {
                width: 180px;
            }

        .full-content-wrap {
            margin-top: 20px;
            height: 100%;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

            .full-content-wrap > div {
                display: flex;
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                position: relative;
            }

        .content-wrap-title {
            position: absolute;
            top: -25px;
            left: 20px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.4);
            transition: all 0.2s;
        }

        .venue-type-content-wrap:hover .content-wrap-title,
        .venue-content-outer-wrap:hover .content-wrap-title {
            color: rgba(0, 0, 0, 0.6);
        }

        .venue-content-inner-wrap {
            overflow-y: scroll;
            min-height: 100px;
            padding: 5px;
            flex: 1;
        }

        .venue-content-outer-wrap {
            height: 100%;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .venue-type-content {
            display: flex;
            width: 100%;
            align-items: center;
            gap: 15px;
            overflow-x: scroll;
            padding: 2px;
        }

            .venue-type-content::-webkit-scrollbar {
                width: 3px;
                height: 3px;
            }

        .venue-type-card {
            display: flex;
            min-width: 180px;
            max-width: 180px;
            height: 220px;
            padding: 10px 20px;
            flex-direction: column;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.4);
            text-align: center;
            transition: all 0.2s;
            user-select: none;
        }

            .venue-type-card:hover {
                color: rgba(0, 0, 0, 0.6);
            }

        .venue-type-seat-map {
            flex: 1;
            display: flex;
            margin: 10px 0;
            overflow: hidden;
            height: 110px;
            overflow-y: scroll;
            overflow-x: scroll;
            opacity: 0.5;
            transform: scale(97%);
            transition: all 0.2s;
        }

            .venue-type-seat-map:hover {
                transform: scale(100%);
            }

        .venue-type-card:hover .venue-type-seat-map {
            opacity: 1;
        }

        .venue-type-seat-map::-webkit-scrollbar {
            width: 0;
            height: 0;
        }

        .venue-type-name {
            font-size: 1em;
        }

        .venue-type-total-seat {
            margin-top: 5px;
            position: relative;
            font-size: 1.5em;
        }

        .venue-type-total-seat-label {
            position: absolute;
            font-size: 0.6rem;
            top: -6px;
            left: 50%;
            transform: translateX(-50%);
        }

        .venue-type-seat-map-wrap {
            display: flex;
            flex: 1;
            flex-direction: column;
            gap: 2.5px;
            align-items: center;
            justify-content: flex-start;
        }

        .seat-row {
            flex: 1;
            max-height: 6px;
            width: 100%;
            display: flex;
            gap: 6px;
            justify-content: center;
            align-items: center;
            padding: 0 0.4em;
        }

        .seat-col {
            height: 100%;
            display: flex;
            gap: 1px;
            justify-content: center;
            align-items: center;
        }

            .seat-col span {
                display: flex;
                width: 6px;
                height: 6px;
                background-color: rgba(250, 100, 100, 0.522);
                border-radius: 0.1px 0.1px 2px 2px;
            }

        .seat-row-break {
            height: 2px;
            width: 80%;
            background-color: transparent;
        }

        .screen-row {
            width: 80%;
            padding-bottom: 10px;
            border-top: 3px solid rgba(0, 0, 0, 0.566);
        }

        .exit-row {
            height: 3px;
            width: 80%;
            margin-top: auto;
            box-sizing: content-box;
            padding-top: 6px;
            display: flex;
            justify-content: space-between;
        }

            .exit-row span {
                height: 2px;
                width: 20%;
                background-color: rgba(0, 126, 0, 0.757);
            }



        .venue-content {
            display: flex;
            flex-wrap: wrap;
            gap: 10px 15px;
        }

        .venue-card {
            max-height: 80px;
            padding: 5px 10px;
            width: 200px;
            display: flex;
            flex-direction: column;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.4);
            text-align: center;
            justify-content: center;
            align-items: center;
            transition: all 0.2s;
            position: relative;
            user-select: none;
        }

            .venue-card:hover {
                color: rgba(0, 0, 0, 0.5);
            }

                .venue-card:hover b {
                    opacity: 1;
                }

        .venue-no {
            font-size: 0.7em;
            word-spacing: -3px;
        }

            .venue-no b {
                font-weight: 700;
                font-size: 1.2rem;
                transition: all 0.2s;
                opacity: 1;
            }

        .venue-card-line {
            width: 70%;
            height: 2px;
            margin-bottom: 5px;
            transition: all 0.2s;
        }

        .venue-card:hover .venue-card-line {
            width: 80%;
        }

        .venue-type {
            flex: 1;
        }

        .venue-edit-btn,
        .venue-status {
            position: absolute;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: all 0.2s;
            cursor: pointer;
            width: 20px;
            height: 20px;
        }

        .venue-edit-btn {
            right: 0;
            top: 0;
            opacity: 0.1;
            border-radius: 0 5px 0 0;
        }

            .venue-edit-btn:hover {
                opacity: 0.8;
            }

                .venue-edit-btn:hover svg {
                    fill: var(--admin-active-color);
                }

            .venue-edit-btn svg {
                transition: all 0.2s;
                width: 15px;
                height: 15px;
                fill: rgb(0, 0, 0);
            }

        .venue-status {
            bottom: 0px;
            right: 0px;
        }

            .venue-status > div {
                width: 7px;
                height: 7px;
                border-radius: 50%;
                transition: all 0.2s;
            }

        .venue-card:hover .venue-status-available {
            background-color: rgb(13, 173, 2, 0.5);
            box-shadow: 0 0 2px rgb(13, 173, 2, 0.5);
        }

        .venue-card:hover .venue-status-inuse {
            background-color: rgb(255, 116, 17, 0.5);
            box-shadow: 0 0 2px rgb(255, 116, 17, 0.5);
        }

        .venue-card:hover .venue-status-unavailable {
            background-color: rgb(45, 45, 45, 0.5);
            box-shadow: 0 0 2px rgb(45, 45, 45, 0.5);
        }

        .venue-status-available,
        .status-available {
            background-color: rgb(13, 173, 2, 0.3);
        }

        .venue-status-inuse,
        .status-inuse {
            background-color: rgb(255, 116, 17, 0.3);
        }

        .venue-status-unavailable,
        .status-unavailable {
            background-color: rgba(45, 45, 45, 0.3);
        }

        .search-box-wrap {
            display: flex;
            gap: 10px;
            min-width: 375px;
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



        .venue-type-content-wrap {
            flex-direction: column;
            gap: 10px
        }

        .venue-content-inner-wrap {
            padding: 30px 10px 10px 10px;
            overflow: unset !important;
        }

        .input-container {
            flex-wrap: wrap;
            gap: 25px 10px;
            flex-direction: column;
            display: flex;
            justify-content: center;
        }

        .input-wrap {
            position: relative;
            flex: 1;
            min-width: 250px;
            justify-content: center;
            align-items: baseline;
            display: flex;
            max-width: 250px;
        }

            .input-wrap:hover .selected-venue-title {
                color: rgba(0, 0, 0, 0.5);
            }

        .selected-venue-title {
            padding: 0;
            margin: 0;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.2);
            text-align: center;
            position: absolute;
            top: -23px;
            width: 100%;
            transition: all 0.2s;
        }

        .inputbox {
            min-width: 200px;
        }

        .confirm-btn-wrap {
            display: flex;
            justify-content: center;
            align-items: center;
        }

            .confirm-btn-wrap .btn {
                min-width: 200px;
                max-width: 500px;
            }

        .venue-content-outer-wrap {
            width: fit-content !important;
            height: fit-content !important;
        }

        .no-input-wrap {
            justify-content: center;
            align-items: center;
        }

            .no-input-wrap label {
                left: 50% !important;
                transform: translateX(-50%) !important;
            }

        .screen-row p {
            display: none;
        }

        .seat-row-alphabet {
            position: absolute;
            font-weight: 700;
            font-size: 0.4em;
            top: -0.3em;
            left: -1.4em;
            margin: 0;
            text-align: center;
            width: 12px;
            height: 12px;
        }

        .seat-col-number {
            position: absolute;
            font-weight: 700;
            font-size: 0.4em;
            bottom: -1.6em;
            left: 50%;
            transform: translateX(-50%);
            margin: 0;
            text-align: center;
            height: 12px;
            letter-spacing: -0.5px;
        }

        .seat-col, .seat-col span {
            position: relative;
        }

        .active-seat-map {
            background-color: var(--admin-bg-hover);
        }

            .active-seat-map .venue-type-seat-map, .selected-venue-type-card .venue-type-seat-map {
                opacity: 1 !important;
            }

        .errMsgMeh {
            font-weight: 600;
            color: black;
            opacity: 0.8;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
        <div class="top-button-wrap">
            <button id="addtype_btn" class="btn up hover-moreup active-down" type="button"
                onclick=" window.location.href = 'AddVenueType.aspx';">
                New Venue Type
            </button>
        </div>
        <div class="full-content-wrap">
            <div class="venue-type-content-wrap down">
                <p class="content-wrap-title">Select a VenueType</p>
                <div class="search-wrap">
                    <div class="search-box-wrap">
                        <div class="search-input-wrap">
                            <svg class="search-icon">
                                <use xlink:href="#search"></use>
                            </svg>
                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Venue Type"
                                class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                        </div>
                        <asp:Button runat="server" ID="search_btn"
                            class="btn up hover-moreup active-down search-btn" Text="Search" OnClick="search_trigger"></asp:Button>
                    </div>
                    <div class="search-result-wrap">
                        <asp:Label ID="lbltotal" class="searchmsg"
                            Text="Showing 6 results for your venue type search" runat="server"></asp:Label>
                    </div>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="venue-type-content tablecover">
                    <ContentTemplate>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT * FROM [VenueType]"></asp:SqlDataSource>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                            <ItemTemplate>
                                <div class="up hover-moreup venue-type-card tablerow">
                                    <div class="venue-type-name"><%# Eval("venue_type_name") %></div>
                                    <div class="venue-type-seat-map down">
                                        <div class="venue-type-seat-map-wrap">
                                            <input type="hidden" class="venue-seat-map-detail" value="<%# Eval("venue_seat") %>" />
                                        </div>
                                    </div>
                                    <div class="venue-type-total-seat">
                                        <input type="hidden" id="venue-type-id" name="venue-type-id" value="<%# Eval("venue_type_id") %>" />
                                        <span class="venue-type-total-seat-label">Total Seat</span>
                                        <%# Eval("total_seat") %>
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
            <div class="venue-content-outer-wrap up">
                <p class="content-wrap-title">New Venue Details</p>
                <div class="venue-content-inner-wrap">
                    <div class="input-container">
                        <div class="input-wrap">
                            <p class="selected-venue-title">Selected Venue</p>
                            <div class="up hover-moreup venue-type-card selected-venue-type-card">
                                <div class="venue-type-name">Venue Type Name</div>
                                <div class="venue-type-seat-map down">
                                    <div class="venue-type-seat-map-wrap">
                                        <input type="hidden" class="venue-seat-map-detail" />
                                    </div>
                                </div>
                                <div class="venue-type-total-seat">
                                    <input type="hidden" id="venue-type-id" name="venue-type-id" />
                                    <span class="venue-type-total-seat-label">Total Seat</span>
                                    0
                                </div>
                            </div>
                        </div>
                        <div class="input-wrap no-input-wrap">
                            <asp:HiddenField runat="server" ID="venueTypeID"></asp:HiddenField>
                            <input id="venueNoInput" class="inputbox down" type="number" name="venueNoInput"
                                placeholder="No" title="Fill In Venue No" max="100" min="1">
                            <label for="venueNoInput">Venue No</label>
                        </div>
                        <div class="input-wrap">
                            <div class="confirm-btn-wrap">
                                <asp:Button runat="server" ID="confirmBtn" class="btn up hover-moreup" OnClick="confirmBtn_Click"
                                    Text="Add Venue" Style="font-size: 0.8em;"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:Label ID="ErrMsg" runat="server" Text="" CssClass="errMsgMeh"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script src="../JS/seat-map.js"></script>
    <script>
        function update() {

            updateSeatMap();
            $('.venue-type-content .venue-type-card').click(function () {
                $('.selected-venue-type-card').html($(this).html());
                $('.venue-type-card').removeClass('active-seat-map');
                $(this).addClass('active-seat-map');

                $('#content_venueTypeID').val($(this).find('#venue-type-id').val());
            });
        }
        
        update();
    </script>

</asp:Content>
