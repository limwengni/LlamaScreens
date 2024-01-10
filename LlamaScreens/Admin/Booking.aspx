<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="LlamaScreens.Admin.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html {
            overflow: hidden;
        }

        .header {
            display: flex;
            font-size: 1.1em;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
            padding: 0 30px;
            min-width: 520px !important;
        }

            .header span:nth-of-type(1),
            .bookingRow span:nth-of-type(1) {
                width: 40px;
                text-align: left;
            }

            .header span:nth-of-type(2),
            .bookingRow span:nth-of-type(2) {
                width: 150px;
                text-align: left;
            }

            .header span:nth-of-type(3),
            .bookingRow span:nth-of-type(3) {
                width: 150px;
                text-align: left;
            }

            .header span:nth-of-type(4),
            .bookingRow span:nth-of-type(4) {
                min-width: 300px;
                flex: 1;
                text-align: left;
            }

            .header span:nth-of-type(5),
            .bookingRow span:nth-of-type(5) {
                width: 150px;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
            }

        .bookingTable {
            height: 100%;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .bookingRow {
            padding: 0 15px;
            display: flex;
            font-weight: 600;
            width: 100%;
            text-align: center;
            color: rgba(0, 0, 0, 0.4);
            max-height: 40px;
            justify-content: center;
            align-items: center;
        }

            .bookingRow span::selection {
                background-color: rgba(50, 50, 50, 0.527);
                color: rgb(255, 255, 255);
            }

            .bookingRow:hover {
                color: rgba(0, 0, 0, 0.6);
                background-color: var(--admin-bg-hover);
            }

                .bookingRow:hover .status {
                    opacity: 1;
                }

                .bookingRow:hover .action-icon {
                    fill: rgba(0, 0, 0, 0.4);
                }

        .action-icon {
            width: 20px;
            height: 20px;
            fill: rgba(0, 0, 0, 0.2);
            transition: all 0.2s;
        }

        .action-btn:hover .action-icon {
            fill: var(--admin-active-color);
        }


        .action-btn {
            width: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 40px;
            padding: 0;
        }

        .bookingTableWrap {
            flex: 1;
            overflow: scroll;
            padding: 10px 15px;
        }

        .tablewrap {
            padding: 2px 10px;
            margin-top: 25px;
            display: flex;
            flex-wrap: wrap;
            flex: 1;
            flex-direction: column;
            min-width: 620px;
            overflow-x: scroll;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
        <div class="wrap" style="padding-top: 15px;">
            <div class="wrap down" style="padding: 15px; display: flex; flex-direction: column; overflow: hidden;">
                <div class="search-wrap tracker">
                    <div style="display: flex; gap: 10px; min-width: 375px;">
                        <div class="search-input-wrap">
                            <svg class="search-icon">
                                <use xlink:href="#search"></use>
                            </svg>
                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Booking ID"
                                class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                        </div>
                        <asp:Button runat="server" ID="search_btn" class="btn up hover-moreup active-down"
                            Style="font-size: 0.8em; width: 55px; padding: 5px;" Text="Search" OnClick="search_trigger"></asp:Button>
                    </div>
                    <div
                        style="display: flex; justify-content: left; align-items: left; flex: 1; min-width: 290px; padding-left: 20px;">
                        <asp:Label ID="lbltotal" class="searchmsg"
                            Text="Showing 6 results for your search" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="tablewrap">
                    <div class="header">
                        <span>No</span><span>Booking ID</span><span>Total Ticket</span><span>Date & Time
                                Booked</span><span>Actions</span>
                    </div>
                    <div class="up bookingTableWrap">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="bookingTable tablecover">
                            <ContentTemplate>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT Booking.booking_id, Booking.created_date, Booking.status, Count(Ticket.ticket_id ) as total_ticket FROM Booking INNER JOIN Ticket ON Booking.booking_id = Ticket.booking_id Group By Booking.booking_id, Booking.created_date, Booking.status ORDER BY Booking.created_date DESC"></asp:SqlDataSource>
                                <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound" DataSourceID="SqlDataSource1">
                                    <ItemTemplate>
                                        <div class="bookingRow up tablerow">
                                            <span><%# Container.ItemIndex + 1 %></span>
                                            <span><%# Eval("booking_id") %></span>
                                            <span><%# Eval("total_ticket") %></span>
                                            <span><%# Eval("created_date","{0:dd MMM yyyy - mm:HH}") %></span>
                                            <span>
                                                <asp:LinkButton ID="View_Btn" runat="server" CssClass="action-btn btn up hover-moreup active-down" type="button" OnCommand="View_Btn_Command">
                                                <svg class="action-icon"><use xlink:href="#view"></use></svg>
                                                </asp:LinkButton>
                                            </span>
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
                </div>
            </div>
        </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script src="../Js/status-radio.js"></script>
    <script>

        function fixTableHeight() {


            $('.bookingRow').removeClass('d-flex');
            $('.bookingRow').addClass('d-none');
            var sourceHeight = $('.bookingTableWrap').outerHeight(true);
            $('.bookingTable').css('max-height', sourceHeight - 20 + 'px');
            $('.bookingRow').removeClass('d-none');
            $('.bookingRow').addClass('d-flex');

            setTimeout(function () {
                var sourceWidth = $('.tracker').width();
                $('.tablewrap').css('min-width', sourceWidth + 'px');
            }, 100);
        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
