<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="ViewMember.aspx.cs" Inherits="LlamaScreens.Admin.ViewMember" %>

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

        .member-detail-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

            .member-detail-wrap > div {
                flex: 1;
                min-width: 400px;
            }

        .member-detail-content-wrap {
            position: relative;
            margin-top: 1em;
        }

        .member-detail-label {
            position: absolute;
            top: -1em;
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
        }

        .member-detail-content {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
        }

        .member-detail-content-wrap-inner {
            display: flex;
        }

            .member-detail-content-wrap-inner > div {
                flex: 1;
                min-width: 150px;
            }

        .member-detail-content-wrap-inner-small {
            display: flex;
        }

            .member-detail-content-wrap-inner-small > div {
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

        .transaction-statistics {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

            .transaction-statistics .member-detail-label {
                width: 100%;
                text-align: center;
            }

            .transaction-statistics .member-detail-content {
                text-align: center;
            }

        .transaction-list-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            flex: 1;
        }

        .transaction-wrap-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .transaction-list-inner-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: scroll;
            flex: 1;
        }

        .transaction-list {
            display: flex;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.3);
            opacity: 0.6;
            transition: all 0.2s;
            position: relative;
        }



        .received {
            color: green;
            border: 1px solid green;
        }

        .pending {
            color: orange;
            border: 1px solid orange;
        }

        .canceled {
            color: rgb(66, 66, 66);
            border: 1px solid rgb(66, 66, 66);
        }

        .list-status {
            position: absolute;
            font-weight: 600;
            font-size: 0.7em;
            border-radius: 0 0 5px 5px;
            border-top: 0px;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            padding: 0 5px;
        }

        .transaction-list:hover {
            opacity: 1;
        }

        .transaction-text-wrap {
            display: flex;
            flex: 3;
        }

        .transaction-list .member-detail-content-wrap:nth-of-type(1) {
            min-width: 225px;
        }

        .transaction-list .member-detail-content-wrap:nth-of-type(2) {
            min-width: 100px;
            max-width: 100px;
        }

        .transaction-list .member-detail-content-wrap:nth-of-type(3) {
            min-width: 80px;
            max-width: 80px;
        }

        .transaction-list .member-detail-label {
            text-align: left;
        }

        .transaction-list .member-detail-content {
            text-align: left;
        }

        .transaction-action-wrap {
            flex: 1;
            display: flex;
            justify-content: end;
            align-items: center;
        }

        .transaction-action {
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

            .transaction-action:hover {
                opacity: 1;
            }

                .transaction-action:hover svg {
                    fill: var(--admin-active-color);
                }

            .transaction-action svg {
                width: 20px;
                height: 20px;
                fill: rgba(0, 0, 0, 0.4);
            }

        .lock-btn-wrap {
            display: flex;
            margin-top: auto;
            padding: 0 5px;
        }

            .lock-btn-wrap .btn {
                flex: 1;
            }



        .member-detail-content-wrap-inner {
            flex-wrap: wrap;
            gap: 5px;
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
                        <p class="right-content-title">Member Details</p>
                        <div class="member-detail-wrap down">
                            <div class="member-detail-content-wrap-inner">
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Username</div>
                                    <div class="member-detail-content"><%#Eval("member_username") %></div>
                                </div>
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Member ID</div>
                                    <div class="member-detail-content">#<%#Eval("member_id") %></div>
                                </div>
                            </div>
                            <div class="member-detail-content-wrap-inner">
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Email</div>
                                    <div class="member-detail-content"><%# Eval("member_email")%></div>
                                </div>
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Phone No</div>
                                    <div class="member-detail-content"><%# Eval("member_phone_no")%></div>
                                </div>
                            </div>
                            <div class="member-detail-content-wrap-inner">
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Birthday</div>
                                    <div class="member-detail-content"><%# Eval("member_birth_date","{0:dd MMM yyyy}")%></div>
                                </div>
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Points</div>
                                    <div class="member-detail-content"><%# Eval("member_point")%></div>
                                </div>
                            </div>
                            <div class="member-detail-content-wrap-inner">
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Date Joined</div>
                                    <div class="member-detail-content"><%# Eval("created_date","{0:dd MMM yyyy}")%></div>
                                </div>
                                <div class="member-detail-content-wrap">
                                    <div class="member-detail-label">Last Login</div>
                                    <div class="member-detail-content"><%# Eval("member_last_login","{0:dd MMM yyyy}")%></div>
                                </div>
                            </div>
                        </div>
                        <div class="lock-btn-wrap">
                            <asp:Button ID="Lock_Btn" runat="server" CssClass="btn up hover-moreup active-down" Text="Lock Member Account" OnCommand="Lock_Btn_Command" />
                        </div>
                    </div>
                    <div class="right-content-wrap">
                        <p class="right-content-title">Transaction Details</p>
                        <div class="right-content down">
                            <div class="transaction-statistics">
                                <div class="member-detail-content-wrap-inner">
                                    <div class="member-detail-content-wrap">
                                        <div class="member-detail-label">Total Transaction</div>
                                        <div class="member-detail-content"><%# Eval("total_transaction")%></div>
                                    </div>
                                    <div class="member-detail-content-wrap">
                                        <div class="member-detail-label">Transaction Pending</div>
                                        <div class="member-detail-content"><%# Eval("total_transaction_pending")%></div>
                                    </div>
                                    <div class="member-detail-content-wrap">
                                        <div class="member-detail-label">Transaction Canceled</div>
                                        <div class="member-detail-content"><%# Eval("total_transaction_canceled")%></div>
                                    </div>
                                </div>
                                <div class="transaction-list-wrap">
                                    <p class="transaction-wrap-title">Recent Transaction</p>
                                    <div class="transaction-list-inner-wrap">
                                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater2_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="transaction-list">
                                                    <div class="list-status <%# Eval("status").ToString().ToLower()%>"><%# Eval("status").ToString().ToLower()%></div>
                                                    <div class="transaction-text-wrap">
                                                        <div class="member-detail-content-wrap-inner">
                                                            <div class="member-detail-content-wrap">
                                                                <div class="member-detail-label"># ID</div>
                                                                <div class="member-detail-content"><%# Eval("transaction_id")%></div>
                                                            </div>
                                                            <div class="member-detail-content-wrap">
                                                                <div class="member-detail-label">Date</div>
                                                                <div class="member-detail-content"><%# Eval("created_date", "{0:dd MMM yyyy}")%></div>
                                                            </div>
                                                            <div class="member-detail-content-wrap">
                                                                <div class="member-detail-label">Amount</div>
                                                                <div class="member-detail-content"><%# Eval("amount")%></div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="transaction-action-wrap">
                                                        <asp:LinkButton ID="View_Btn" runat="server" CssClass="transaction-action" OnCommand="View_Btn_Command">
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

            $('.transaction-list').removeClass('d-flex');
            $('.transaction-list').addClass('d-none');
            $('.transaction-list-inner-wrap').css('max-height', 'none');
            var sourceHeight = $('.transaction-list-inner-wrap').outerHeight(true);
            $('.transaction-list-inner-wrap').css('max-height', sourceHeight + 'px');
            $('.transaction-list').removeClass('d-none');
            $('.transaction-list').addClass('d-flex');

        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
