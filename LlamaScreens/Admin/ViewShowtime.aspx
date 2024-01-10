<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true" CodeBehind="ViewShowtime.aspx.cs" Inherits="LlamaScreens.Admin.ViewShowtime" %>

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

        .showtime-detail-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

            .showtime-detail-wrap > div {
                flex: 1;
                min-width: 400px;
            }

        .showtime-detail-content-wrap {
            position: relative;
            margin-top: 1em;
        }

        .showtime-detail-label {
            position: absolute;
            top: -1em;
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
        }

        .showtime-detail-content {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
        }

        .showtime-detail-content-wrap-inner {
            display: flex;
        }

            .showtime-detail-content-wrap-inner > div {
                flex: 1;
                min-width: 150px;
            }

        .showtime-detail-content-wrap-inner-small {
            display: flex;
        }

            .showtime-detail-content-wrap-inner-small > div {
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

        .booking-statistics {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

            .booking-statistics .showtime-detail-label {
                width: 100%;
                text-align: center;
            }

            .booking-statistics .showtime-detail-content {
                text-align: center;
            }

        .booking-list-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            flex: 1;
        }

        .booking-wrap-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .booking-list-inner-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: scroll;
            flex: 1;
        }

        .booking-list {
            display: flex;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.3);
            opacity: 0.6;
            transition: all 0.2s;
            position: relative;
        }


            .booking-list:hover {
                opacity: 1;
            }

        .booking-text-wrap {
            display: flex;
            max-width: 300px;
        }

        .booking-list .showtime-detail-content-wrap:nth-of-type(1) {
            min-width: 50px;
        }

        .booking-list .showtime-detail-content-wrap:nth-of-type(2) {
            min-width: 100px;
        }

        .booking-list .showtime-detail-content-wrap:nth-of-type(3) {
            min-width: 80px;
        }

        .booking-list .showtime-detail-label {
            text-align: left;
        }

        .booking-list .showtime-detail-content {
            text-align: left;
        }

        .booking-action-wrap {
            flex: 1;
            display: flex;
            justify-content: end;
            align-items: center;
        }

        .booking-action {
            width: 35px;
            height: 35px;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid rgba(0, 0, 0, 0.3);
            border-radius: 5px;
            opacity: 0.6;
            transition: all 0.2s;
            cursor: pointer;
            background-color: transparent;
            outline: none;
        }

            .booking-action:hover {
                opacity: 1;
            }

                .booking-action:hover svg {
                    fill: var(--admin-active-color);
                }

            .booking-action svg {
                width: 20px;
                height: 20px;
                fill: rgba(0, 0, 0, 0.4);
            }


        .showtime-detail-content-wrap-inner {
            flex-wrap: wrap;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div style="display: flex; flex-direction: column; flex-grow: 1; position: relative; padding: 0;">
                <div class="main-content-wrap up">
                    <div class="left-content-wrap">
                        <p class="right-content-title">Showtime Details</p>
                        <div class="showtime-detail-wrap down">
                            <div class="showtime-detail-content-wrap-inner">
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Showtime ID</div>
                                    <div class="showtime-detail-content">#<%# Eval("showtime_id") %></div>
                                </div>
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Movie ID</div>
                                    <div class="showtime-detail-content">#<%# Eval("movie_id") %></div>
                                </div>
                            </div>
                            <div class="showtime-detail-content-wrap-inner">
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Date</div>
                                    <div class="showtime-detail-content"><%# Eval("showtime_date","{0:dd MMM yyyy}") %></div>
                                </div>
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Time</div>
                                    <div class="showtime-detail-content"><%# Eval("showtime_date","{0:HH:mm}") %></div>
                                </div>
                            </div>
                            <div class="showtime-detail-content-wrap-inner">
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Movie Title</div>
                                    <div class="showtime-detail-content"><%# Eval("movie_title") %></div>
                                </div>
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Movie Length</div>
                                    <div class="showtime-detail-content"><%# Eval("movie_length") %> Minutes</div>
                                </div>
                            </div>
                            <div class="showtime-detail-content-wrap-inner">
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Venue</div>
                                    <div class="showtime-detail-content">No <%# Eval("venue_no") %></div>
                                </div>
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Total Seat</div>
                                    <div class="showtime-detail-content"><%# Eval("total_seat") %></div>
                                </div>
                            </div>
                            <div class="showtime-detail-content-wrap-inner">
                                <div class="showtime-detail-content-wrap">
                                    <div class="showtime-detail-label">Status</div>
                                    <div class="showtime-detail-content"><%# Eval("status") %></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="right-content-wrap">
                        <p class="right-content-title">Booking Details</p>
                        <div class="right-content down">
                            <div class="booking-statistics">
                                <div class="showtime-detail-content-wrap-inner">
                                    <div class="showtime-detail-content-wrap">
                                        <div class="showtime-detail-label">Total Seat</div>
                                        <div class="showtime-detail-content"><%# Eval("total_seat") %></div>
                                    </div>
                                    <div class="showtime-detail-content-wrap">
                                        <div class="showtime-detail-label">Sold</div>
                                        <div class="showtime-detail-content"><%# getTotalSold() %></div>
                                    </div>
                                    <div class="showtime-detail-content-wrap">
                                        <div class="showtime-detail-label">Available</div>
                                        <div class="showtime-detail-content"><%# getRemainingSeat(Eval("total_seat").ToString()) %></div>
                                    </div>
                                </div>
                                <div class="booking-list-wrap">
                                    <p class="booking-wrap-title">Related Booking</p>
                                    <div class="booking-list-inner-wrap">
                                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater2_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="booking-list">
                                                    <div class="booking-text-wrap">
                                                        <div class="showtime-detail-content-wrap-inner">
                                                            <div class="showtime-detail-content-wrap">
                                                                <div class="showtime-detail-label"># ID</div>
                                                                <div class="showtime-detail-content"><%# Eval("booking_id") %></div>
                                                            </div>
                                                            <div class="showtime-detail-content-wrap">
                                                                <div class="showtime-detail-label">Date</div>
                                                                <div class="showtime-detail-content"><%# Eval("created_date","{0:dd MMM yyyy}") %></div>
                                                            </div>
                                                            <div class="showtime-detail-content-wrap">
                                                                <div class="showtime-detail-label">Seat</div>
                                                                <div class="showtime-detail-content"><%# Eval("total_seat") %></div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="booking-action-wrap">
                                                        <asp:LinkButton ID="View_Btn" runat="server" cssClass="booking-action" type="button" OnCommand="View_Btn_Command">
                                                            <svg>
                                                                <use xlink:href="#view"></use>
                                                            </svg>
                                                        </asp:LinkButton>
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

            $('.booking-list').removeClass('d-flex');
            $('.booking-list').addClass('d-none');
            $('.booking-list-inner-wrap').css('max-height', 'none');
            var sourceHeight = $('.booking-list-inner-wrap').outerHeight(true);
            $('.booking-list-inner-wrap').css('max-height', sourceHeight + 'px');
            $('.booking-list').removeClass('d-none');
            $('.booking-list').addClass('d-flex');

        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
