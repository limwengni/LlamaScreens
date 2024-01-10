<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="ViewTransaction.aspx.cs" Inherits="LlamaScreens.Admin.ViewTransaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main-content-wrap {
            display: flex;
            width: 100%;
            height: 100%;
            padding: 15px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .transaction-detail-wrap {
            display: flex;
            padding: 10px 15px;
            flex: 1;
            min-width: 300px;
            max-width: 400px;
            min-height: 500px;
        }

        .transaction-detail-card {
            display: flex;
            flex-direction: column;
            flex: 1;
            position: relative;
            min-height: 200px;
        }

        .transaction-detail-label {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.4);
            font-size: 0.9em;
            user-select: none;
        }

        .transaction-detail-content {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.6);
            user-select: none;
        }

        .transaction-detail-inner-wrap {
            display: flex;
            flex-direction: column;
            position: relative;
            margin-top: 15px;
        }

            .transaction-detail-inner-wrap .transaction-detail-label {
                position: absolute;
                top: -15px;
            }

        .transaction-detail-inner-block {
            display: flex;
            flex: 1;
            padding: 10px;
            flex-wrap: wrap;
            align-content: baseline;
            max-height: 100px;
        }

            .transaction-detail-inner-block .transaction-detail-inner-wrap {
                flex: 1;
                min-width: 150px;
            }

                .transaction-detail-inner-block .transaction-detail-inner-wrap:first-of-type {
                    flex: 2;
                }

        .transaction-detail-user-icon-wrap {
            display: flex;
        }

            .transaction-detail-user-icon-wrap svg {
                width: 15px;
                height: 15px;
                fill: rgba(0, 0, 0, 0.4);
                transition: all 0.2s;
            }

        .transaction-detail-user button {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
            padding: 0;
            min-height: 20px;
            min-width: 140px;
            font-size: 0.9em;
            gap: 10px;
        }

            .transaction-detail-user button:hover svg {
                fill: var(--admin-active-color);
            }

        .transaction-detail-user {
            flex-direction: row;
        }

            .transaction-detail-user .transaction-detail-label {
                top: -17px;
                left: 9px;
            }

            .transaction-detail-user .transaction-detail-content {
                flex: 1;
            }

        .transaction-status-wrap {
            position: absolute;
            font-weight: 700;
            right: 0;
            user-select: none;
        }

        .transaction-detail-card:hover .status-success {
            text-shadow: 0 0 1px greenyellow;
            color: rgb(2, 197, 2);
        }

        .status-success {
            color: rgb(3, 124, 3);
        }

        .transaction-detail-card:hover .status-pending {
            text-shadow: 0 0 1px rgb(255, 126, 20);
            color: rgb(255, 115, 0);
        }

        .status-pending {
            color: rgb(251, 153, 74);
        }


        .transaction-detail-card:hover .status-canceled {
            text-shadow: 0 0 1px rgb(102, 102, 102);
            color: rgb(67, 67, 67);
        }

        .status-canceled {
            color: rgb(68, 68, 68);
        }

        .transaction-detail-ticket-wrap {
            padding: 10px;
            margin-top: 10px;
            display: flex;
            flex-direction: column;
            gap: 5px;
            overflow-y: scroll;
            min-height: 200px;
            flex: 1;
        }

        .transaction-detail-ticket {
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.2);
            padding: 0 5px;
            transition: all 0.2s;
            opacity: 0.5;
        }

            .transaction-detail-ticket .transaction-detail-label {
                font-size: 0.7em;
                top: -0.9em;
            }

            .transaction-detail-ticket .transaction-detail-content {
                font-size: 0.9em;
            }

        .ticket-detail-block {
            display: flex;
            flex: 1;
            gap: 5px;
        }

            .ticket-detail-block .transaction-detail-inner-wrap {
                flex: 1;
            }

        .date-wrap, .time-wrap {
            font-size: 0.9em;
        }

        .time-wrap {
            flex: 0 !important;
        }

            .time-wrap .transaction-detail-label {
                left: 50%;
                transform: translateX(-50%);
            }

        .transaction-detail-ticket:hover {
            border-color: var(--admin-active-color);
            opacity: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
        <ItemTemplate>
            <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
                <div class="main-content-wrap down">
                    <div class="transaction-detail-wrap up">
                        <div class="transaction-detail-card">
                            <div class="transaction-status-wrap">
                                <div class="status-<%# Eval("status").ToString().ToLower() %>"><%# Eval("status") %></div>
                            </div>
                            <div class="transaction-detail-inner-wrap">
                                <span class="transaction-detail-label">Transaction ID</span>
                                <span class="transaction-detail-content">#<%# Eval("transaction_id") %></span>
                            </div>
                            <div class="transaction-detail-inner-wrap">
                                <span class="transaction-detail-label">Issued Date</span>
                                <span class="transaction-detail-content"><%# Eval("created_date", "{0:dd MMM yyyy}" ) %></span>
                            </div>
                            <div class="transaction-detail-inner-block up">
                                <div class="transaction-detail-inner-wrap">
                                    <span class="transaction-detail-label">Booking ID</span>
                                    <span class="transaction-detail-content">#<%# Eval("booking_id") %></span>
                                </div>
                                <div class="transaction-detail-inner-wrap transaction-detail-user">
                                    <span class="transaction-detail-label">For</span>
                                    <span class="transaction-detail-content">
                                        <asp:LinkButton ID="ViewBtn" runat="server" cssclass="btn up hover-moreup active-down" type="button" OnCommand="ViewBtn_Command" style="display: flex; align-items: center; gap: 5px; width: fit-content; padding: 0 20px;">
                                            <%# Eval("member_username") %>
                                            <span class="transaction-detail-user-icon-wrap">
                                                <svg>
                                                    <use xlink:href="#people-circle"></use>
                                                </svg>
                                            </span>
                                        </asp:LinkButton>
                                    </span>
                                </div>
                                <div class="transaction-detail-inner-wrap">
                                    <span class="transaction-detail-label">Amount</span>
                                    <span class="transaction-detail-content">Rm <%# Eval("amount", "{0:0.00}") %></span>
                                </div>
                            </div>
                            <div class="transaction-detail-ticket-wrap up">
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                    <ItemTemplate>
                                        <div class="transaction-detail-ticket">
                                            <div class="ticket-detail-block">
                                                <div class="transaction-detail-inner-wrap">
                                                    <span class="transaction-detail-label">Ticket ID</span>
                                                    <span class="transaction-detail-content">#<%# Eval("ticket_id") %></span>
                                                </div>
                                                <div class="transaction-detail-inner-wrap">
                                                    <span class="transaction-detail-label">Seat ID</span>
                                                    <span class="transaction-detail-content"><%# Eval("seat_id") %></span>
                                                </div>
                                                <div class="transaction-detail-inner-wrap">
                                                    <span class="transaction-detail-label">Seat Type</span>
                                                    <span class="transaction-detail-content"><%# Eval("seat_type") %></span>
                                                </div>
                                            </div>
                                            <div class="ticket-detail-block">
                                                <div class="transaction-detail-inner-wrap">
                                                    <span class="transaction-detail-label">Movie Title</span>
                                                    <span class="transaction-detail-content"><%# Eval("movie_title") %></span>
                                                </div>
                                                <div class="ticket-detail-block">
                                                    <div class="transaction-detail-inner-wrap date-wrap">
                                                        <span class="transaction-detail-label">Date</span>
                                                        <span class="transaction-detail-content"><%# Eval("created_date", "{0:dd MMM yyyy}") %></span>
                                                    </div>
                                                    <div class="transaction-detail-inner-wrap time-wrap">
                                                        <span class="transaction-detail-label">Time</span>
                                                        <span class="transaction-detail-content"><%# Eval("created_date", "{0:HH:mm}") %></span>
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
        </ItemTemplate>

    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script>
        function fixTableHeight() {
            $('.transaction-detail-ticket').addClass('d-none');
            $('.transaction-detail-ticket-wrap').css('max-height', 'none');
            var sourceHeight = $('.transaction-detail-ticket-wrap').outerHeight(true);
            $('.transaction-detail-ticket-wrap').css('max-height', sourceHeight + 'px');
            $('.transaction-detail-ticket').removeClass('d-none');
        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
