<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="Transaction.aspx.cs" Inherits="LlamaScreens.Admin.Transaction" %>

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
            padding: 0 35px 0 30px;
            min-width: 520px !important;
        }

            .header span:nth-of-type(1),
            .transactionRow span:nth-of-type(1) {
                width: 40px;
                text-align: left;
            }

            .header span:nth-of-type(2),
            .transactionRow span:nth-of-type(2) {
                width: 350px;
                text-align: left;
            }

            .header span:nth-of-type(3),
            .transactionRow span:nth-of-type(3) {
                width: 150px;
                text-align: left;
            }

            .header span:nth-of-type(4),
            .transactionRow span:nth-of-type(4) {
                text-align: left;
                width: 150px;
            }

            .header span:nth-of-type(5),
            .transactionRow span:nth-of-type(5) {
                min-width: 300px;
                flex: 1;
                text-align: left;
            }

            .header span:nth-of-type(6),
            .transactionRow span:nth-of-type(6) {
                width: 120px;
                display: flex;
                justify-content: center;
                align-items: center;
            }


            .header span:nth-of-type(7),
            .transactionRow span:nth-of-type(7) {
                width: 150px;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
            }

        .transactionTable {
            height: 100%;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .transactionRow {
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

            .transactionRow span::selection {
                background-color: rgba(50, 50, 50, 0.527);
                color: rgb(255, 255, 255);
            }

            .transactionRow:hover {
                color: rgba(0, 0, 0, 0.6);
                background-color: var(--admin-bg-hover);
            }

                .transactionRow:hover .status {
                    opacity: 1;
                }

                .transactionRow:hover .action-icon {
                    fill: rgba(0, 0, 0, 0.4);
                }

        .status {
            padding: 2px;
            min-width: 100px;
            display: flex;
            border-radius: 5px;
            text-align: center;
            justify-content: center;
            user-select: none;
            opacity: 0.6;
            transition: all 0.2s;
        }

        .transactionRow:hover .status-success {
            text-shadow: 0 0 1px greenyellow;
            color: rgb(2, 197, 2);
        }

        .status-success {
            color: rgb(3, 124, 3);
        }

        .transactionRow:hover .status-pending {
            text-shadow: 0 0 1px rgb(255, 126, 20);
            color: rgb(255, 115, 0);
        }

        .status-pending {
            color: rgb(251, 153, 74);
        }


        .transactionRow:hover .status-canceled {
            text-shadow: 0 0 1px rgb(102, 102, 102);
            color: rgb(67, 67, 67);
        }

        .status-canceled {
            color: rgb(68, 68, 68);
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

        .statusbtnwrap {
            display: flex;
            position: relative;
        }

        .checked-label {
            color: var(--admin-active-color);
        }

        .custom-radio label {
            transition: all 0.2s;
            user-select: none;
            cursor: pointer;
            width: 100%;
            font-weight: 700;
        }

        .statusbtnwrap:hover .custom-radio {
            color: rgba(0, 0, 0, 0.4);
        }

        .custom-radio {
            flex: 1;
            text-align: center;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.2);
            transition: all 0.2s;
        }

            .custom-radio label:hover {
                color: var(--admin-active-color);
                opacity: 0.5;
            }

        .statusbtnwrap input {
            display: none;
        }

        .statusbtn-glass {
            position: absolute;
            height: 24px;
            width: 20%;
            left: 10px;
            border-radius: 5px;
            pointer-events: none;
            z-index: 3;
        }

        .transactionTableWrap {
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

        .outerwrap {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            padding: 0 0 10px 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    <div class="outerwrap">
        <div class="wrap" style="padding-top: 15px;">
            <div class="wrap down" style="padding: 15px; display: flex; flex-direction: column; overflow: hidden;">
                <div class="search-wrap tracker">
                    <div style="display: flex; gap: 10px; min-width: 375px;">
                        <div class="search-input-wrap">
                            <svg class="search-icon">
                                <use xlink:href="#search"></use>
                            </svg>
                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Transaction ID"
                                class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                        </div>
                        <asp:Button runat="server" ID="search_btn" class="btn up hover-moreup active-down"
                            Style="font-size: 0.8em; width: 55px; padding: 5px;" Text="Search" OnClick="search_trigger"></asp:Button>
                    </div>
                    <div
                        style="display: flex; justify-content: left; align-items: left; flex: 1; min-width: 290px; padding-left: 20px;">
                        <asp:Label ID="lbltotal" class="searchmsg"
                            Text="Showing 6 results for your transaction search" runat="server"></asp:Label>
                    </div>
                    <div class="up statusbtnwrap"
                        style="display: flex; width: 320px; border-radius: 5px; padding: 5px 10px; flex: 1; min-width: 317px;">
                        <asp:RadioButton ID="radioButton1" runat="server" Text="All" Value="all"
                            GroupName="statusradio" CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" />
                        <asp:RadioButton ID="radioButton2" runat="server" Text="Pending" Value="pending"
                            GroupName="statusradio" CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" />
                        <asp:RadioButton ID="radioButton3" runat="server" Text="Success" Value="success"
                            GroupName="statusradio" CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" />
                        <asp:RadioButton ID="radioButton4" runat="server" Text="Canceled" Value="canceled"
                            GroupName="statusradio" CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" />
                        <div class="statusbtn-glass down"></div>
                    </div>
                </div>
                <div class="tablewrap">
                    <div class="header">
                        <span>No</span><span>Transaction ID</span><span>Amount (RM)</span><span>Method</span><span>Date & Time
                                Issued</span><span>Status</span><span>Actions</span>
                    </div>
                    <div class="up transactionTableWrap">

                        <asp:ScriptManager ID="ScriptManager1" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="transactionTable tablecover">
                            <ContentTemplate>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT * FROM [Transaction] ORDER BY CREATED_DATE DESC"></asp:SqlDataSource>
                                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                                        <ItemTemplate>
                                            <div class="transactionRow up tablerow">
                                                <span><%# Container.ItemIndex+1 %></span>
                                                <span><%# Eval("transaction_id") %></span>
                                                <span><%# Eval("amount", "{0:F2}") %></span>
                                                <span><%# Eval("transaction_method") %></span>
                                                <span><%# String.Format("{0:dd MMM yyyy} - {0:HH:mm}", Eval("created_date")) %></span>
                                                <span>
                                                    <span class="down status status-<%# Eval("status").ToString().ToLower() %>"><%# Eval("status") %></span>
                                                </span>
                                                <span>
                                                    <asp:LinkButton ID="View_Btn" runat="server" CssClass="action-btn btn up hover-moreup active-down" type="button" OnCommand="View_Btn_Command">
                                                <svg class="action-icon">
                                                    <use xlink:href="#view"></use>
                                                </svg>
                                                    </asp:LinkButton>
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="search_textbox" EventName="TextChanged" />
                                <asp:AsyncPostBackTrigger ControlID="search_btn" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="radioButton1" EventName="CheckedChanged" />
                                <asp:AsyncPostBackTrigger ControlID="radioButton2" EventName="CheckedChanged" />
                                <asp:AsyncPostBackTrigger ControlID="radioButton3" EventName="CheckedChanged" />
                                <asp:AsyncPostBackTrigger ControlID="radioButton4" EventName="CheckedChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
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


            $('.transactionRow').removeClass('d-flex');
            $('.transactionRow').addClass('d-none');
            var sourceHeight = $('.transactionTableWrap').outerHeight(true);
            $('.transactionTable').css('max-height', sourceHeight - 20 + 'px');
            $('.transactionRow').removeClass('d-none');
            $('.transactionRow').addClass('d-flex');

            setTimeout(function () {
                var sourceWidth = $('.tracker').width();
                $('.tablewrap').css('min-width', sourceWidth + 'px');
            }, 100);
        }


        fixStatus();
        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);

    </script>
</asp:Content>
