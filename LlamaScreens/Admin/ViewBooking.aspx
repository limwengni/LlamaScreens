<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true" CodeBehind="ViewBooking.aspx.cs" Inherits="LlamaScreens.Admin.ViewBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main-content-wrap {
            padding: 5px 10px;
            display: flex;
            height: 100%;
            gap: 15px;
            flex-wrap: wrap;
        }

        .left-content-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px 0;
            min-width: 350px;
            max-width: 836px;
            max-height: 1250px;
            flex: 1;
        }

        .booking-detail-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

            .booking-detail-wrap > div {
                flex: 1;
                min-width: 400px;
            }

        .booking-detail-content-wrap {
            position: relative;
            margin-top: 1em;
        }

        .booking-detail-label {
            position: absolute;
            top: -1em;
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
        }

        .booking-detail-content {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
        }

        .booking-detail-content-wrap-inner {
            display: flex;
        }

            .booking-detail-content-wrap-inner > div {
                flex: 1;
                min-width: 150px;
            }

        .booking-detail-content-wrap-inner-small {
            display: flex;
        }

            .booking-detail-content-wrap-inner-small > div {
                flex: 1;
                min-width: 75px;
            }

        .right-content-wrap {
            padding: 10px;
            display: flex;
            flex-direction: column;
            flex: 1;
            max-width: 700px;
            min-width: 350px;
            min-height: 400px;
        }

        .right-content-title {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            margin: 0;
            padding: 0;
        }

        .right-content {
            flex: 1px;
            display: flex;
            padding: 10px;
            flex-direction: column;
        }

        .ticket-statistics {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

            .ticket-statistics .booking-detail-label {
                width: 100%;
                text-align: center;
            }

            .ticket-statistics .booking-detail-content {
                text-align: center;
            }

        .ticket-list-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            flex: 1;
        }

        .ticket-wrap-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .ticket-list-inner-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: scroll;
            flex: 1;
        }

        .ticket-list {
            display: flex;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.3);
            opacity: 0.6;
            transition: all 0.2s;
            position: relative;
        }

            .ticket-list:hover {
                opacity: 1;
            }

        .ticket-text-wrap {
            display: flex;
            max-width: 300px;
        }

        .ticket-list .booking-detail-content-wrap:nth-of-type(1) {
            min-width: 80px;
            flex: 2;
        }

        .ticket-list .booking-detail-content-wrap:nth-of-type(2) {
            min-width: 60px;
        }

        .ticket-list .booking-detail-content-wrap:nth-of-type(3) {
            min-width: 60px;
        }

        .ticket-list .booking-detail-content-wrap:nth-of-type(4) {
            min-width: 60px;
        }

        .ticket-list .booking-detail-label {
            text-align: left;
        }

        .ticket-list .booking-detail-content {
            text-align: left;
        }


        .booking-detail-content-wrap-inner {
            flex-wrap: wrap;
        }

        .ticket-text-wrap {
            flex: 1;
            max-width: none !important;
            min-width: 300px;
        }

            .ticket-text-wrap .booking-detail-content-wrap-inner {
                flex: 1;
            }

        .ticket-list .booking-detail-content-wrap {
            flex: 1;
        }

        .right-content-title:nth-of-type(2) {
            margin-top: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
        <ItemTemplate>
            <div style="display: flex; flex-direction: column; flex-grow: 1; position: relative; padding: 0;">
                <div class="main-content-wrap up">
                    <div class="left-content-wrap">
                        <p class="right-content-title">Booking Details</p>
                        <div class="booking-detail-wrap down">
                            <div class="booking-detail-content-wrap-inner">
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Booking ID</div>
                                    <div class="booking-detail-content">#<%# Eval("booking_id") %></div>
                                </div>
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Member ID</div>
                                    <div class="booking-detail-content">#<%# Eval("member_id") %></div>
                                </div>
                            </div>

                            <div class="booking-detail-content-wrap-inner">
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Transaction ID</div>
                                    <div class="booking-detail-content">#<%# Eval("transaction_id") %></div>
                                </div>
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">ShowTime ID</div>
                                    <div class="booking-detail-content">#<%# Eval("showtime_id") %></div>
                                </div>
                            </div>

                            <div class="booking-detail-content-wrap-inner">
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Total Ticket</div>
                                    <div class="booking-detail-content"><%# Eval("total_ticket") %></div>
                                </div>
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Total Amount</div>
                                    <div class="booking-detail-content">Rm <%# Eval("amount") %></div>
                                </div>
                            </div>

                            <div class="booking-detail-content-wrap-inner">
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Date Booked</div>
                                    <div class="booking-detail-content"><%# Eval("created_date","{0:dd MMM yyyy}") %></div>
                                </div>
                            </div>


                        </div>
                        <p class="right-content-title">ShowTime Details</p>
                        <div class="booking-detail-wrap down">
                            <div class="booking-detail-content-wrap-inner">
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Movie Title</div>
                                    <div class="booking-detail-content"><%# Eval("movie_title") %></div>
                                </div>
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Venue</div>
                                    <div class="booking-detail-content">No <%# Eval("venue_no") %></div>
                                </div>
                            </div>
                            <div class="booking-detail-content-wrap-inner">

                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Ticket Time</div>
                                    <div class="booking-detail-content"><%# Eval("showtime_date","{0:HH:mm}") %></div>
                                </div>
                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Ticket Date</div>
                                    <div class="booking-detail-content"><%# Eval("showtime_date","{0:dd MMM yyyy}") %></div>
                                </div>
                            </div>
                            <div class="booking-detail-content-wrap-inner">

                                <div class="booking-detail-content-wrap">
                                    <div class="booking-detail-label">Showtime Status</div>
                                    <div class="booking-detail-content"><%# Eval("status") %></div>
                                </div>
                            </div>


                        </div>
                    </div>
                    <div class="right-content-wrap">
                        <p class="right-content-title">Ticket Details</p>
                        <div class="right-content down">
                            <div class="ticket-statistics">
                                <div class="booking-detail-content-wrap-inner">
                                    <div class="booking-detail-content-wrap">
                                        <div class="booking-detail-label">Total Ticket</div>
                                        <div class="booking-detail-content"><%# Eval("total_ticket") %></div>
                                    </div>
                                    <div class="booking-detail-content-wrap">
                                        <div class="booking-detail-label">Kid</div>
                                        <div class="booking-detail-content"><%# Eval("total_kid_tickets") %></div>
                                    </div>
                                    <div class="booking-detail-content-wrap">
                                        <div class="booking-detail-label">Adult</div>
                                        <div class="booking-detail-content"><%# Eval("total_kid_tickets") %></div>
                                    </div>
                                    <div class="booking-detail-content-wrap">
                                        <div class="booking-detail-label">Elder</div>
                                        <div class="booking-detail-content"><%# Eval("total_kid_tickets") %></div>
                                    </div>
                                </div>
                                <div class="ticket-list-wrap">
                                    <p class="ticket-wrap-title">Tickets</p>
                                    <div class="ticket-list-inner-wrap">
                                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                            <ItemTemplate>
                                                <div class="ticket-list">
                                                    <div class="ticket-text-wrap">
                                                        <div class="booking-detail-content-wrap-inner">
                                                            <div class="booking-detail-content-wrap">
                                                                <div class="booking-detail-label"># ID</div>
                                                                <div class="booking-detail-content"><%#Eval("ticket_id") %></div>
                                                            </div>
                                                            <div class="booking-detail-content-wrap">
                                                                <div class="booking-detail-label">Seat</div>
                                                                <div class="booking-detail-content"><%#Eval("seat_id") %></div>
                                                            </div>
                                                            <div class="booking-detail-content-wrap">
                                                                <div class="booking-detail-label">Type</div>
                                                                <div class="booking-detail-content"><%#Eval("seat_type") %></div>
                                                            </div>
                                                            <div class="booking-detail-content-wrap">
                                                                <div class="booking-detail-label">Price</div>
                                                                <div class="booking-detail-content"><%#Eval("default_price") %></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script>
        function fixTableHeight() {

            $('.ticket-list').removeClass('d-flex');
            $('.ticket-list').addClass('d-none');
            $('.ticket-list-inner-wrap').css('max-height', 'none');
            var sourceHeight = $('.ticket-list-inner-wrap').outerHeight(true);
            $('.ticket-list-inner-wrap').css('max-height', sourceHeight + 'px');
            $('.ticket-list').removeClass('d-none');
            $('.ticket-list').addClass('d-flex');

        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
