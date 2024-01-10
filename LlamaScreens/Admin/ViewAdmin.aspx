<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true" CodeBehind="ViewAdmin.aspx.cs" Inherits="LlamaScreens.Admin.ViewAdmin" %>

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

        .admin-detail-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
        }

            .admin-detail-wrap > div {
                flex: 1;
                min-width: 400px;
            }

        .admin-detail-content-wrap {
            position: relative;
            margin-top: 1em;
        }

        .admin-detail-label {
            position: absolute;
            top: -1em;
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
        }

        .admin-detail-content {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
        }

        .admin-detail-content-wrap-inner {
            display: flex;
        }

            .admin-detail-content-wrap-inner > div {
                flex: 1;
                min-width: 150px;
            }

        .admin-detail-content-wrap-inner-small {
            display: flex;
        }

            .admin-detail-content-wrap-inner-small > div {
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

        .adminlog-statistics {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

            .adminlog-statistics .admin-detail-label {
                width: 100%;
                text-align: center;
            }

            .adminlog-statistics .admin-detail-content {
                text-align: center;
            }

        .adminlog-list-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            flex: 1;
        }

        .adminlog-wrap-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .adminlog-list-inner-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: scroll;
            flex: 1;
        }

        .adminlog-list {
            display: flex;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.3);
            opacity: 0.6;
            transition: all 0.2s;
            position: relative;
        }

            .adminlog-list:hover {
                opacity: 1;
            }

        .adminlog-text-wrap {
            display: flex;
            max-width: 500px;
        }

        .adminlog-list .admin-detail-content-wrap:nth-of-type(1) {
            min-width: 100px;
        }

        .adminlog-list .admin-detail-content-wrap:nth-of-type(2) {
            min-width: 50px;
        }

        .adminlog-list .admin-detail-content-wrap:nth-of-type(3) {
            min-width: 250px;
        }


        .adminlog-list .admin-detail-label {
            text-align: left;
        }

        .adminlog-list .admin-detail-content {
            text-align: left;
        }

        .disable-btn-wrap {
            display: flex;
            margin-top: auto;
            padding: 0 5px;
        }

            .disable-btn-wrap .btn {
                flex: 1;
            }


        .admin-detail-content-wrap-inner {
            flex-wrap: wrap;
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
                        <p class="right-content-title">Admin Details</p>
                        <div class="admin-detail-wrap down">
                            <div class="admin-detail-content-wrap-inner">
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Username</div>
                                    <div class="admin-detail-content"><%# Eval("admin_username") %></div>
                                </div>
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Admin ID</div>
                                    <div class="admin-detail-content">#<%# Eval("admin_id") %></div>
                                </div>
                            </div>
                            <div class="admin-detail-content-wrap-inner">
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Email</div>
                                    <div class="admin-detail-content"><%# Eval("admin_email") %></div>
                                </div>
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Role</div>
                                    <div class="admin-detail-content"><%# Eval("admin_role") %></div>
                                </div>
                            </div>
                            <div class="admin-detail-content-wrap-inner">
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Created Date</div>
                                    <div class="admin-detail-content"><%# Eval("created_date","{0:dd MMM yyyy}") %></div>
                                </div>
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Last Login</div>
                                    <div class="admin-detail-content"><%# Eval("admin_last_login","{0:dd MMM yyyy}") %></div>
                                </div>
                            </div>
                            <div class="admin-detail-content-wrap-inner">
                                <div class="admin-detail-content-wrap">
                                    <div class="admin-detail-label">Status</div>
                                    <div class="admin-detail-content"><%# Eval("status") %></div>
                                </div>
                            </div>
                        </div>
                        <div class="disable-btn-wrap">
                            <asp:Button ID="Status_Btn" runat="server" CssClass="btn up hover-moreup active-down" OnCommand="Status_Btn_Command" UseSubmitBehavior="false"/>
                        </div>
                    </div>
                    <div class="right-content-wrap">
                        <p class="right-content-title">Admin Log</p>
                        <div class="right-content down">
                            <div class="adminlog-statistics">
                                <div class="admin-detail-content-wrap-inner">
                                    <div class="admin-detail-content-wrap">
                                        <div class="admin-detail-label">Total Record</div>
                                        <div class="admin-detail-content"><%# Eval("total_log_record") %></div>
                                    </div>
                                    <div class="admin-detail-content-wrap">
                                        <div class="admin-detail-label">Month Record</div>
                                        <div class="admin-detail-content"><%# Eval("month_log_record") %></div>
                                    </div>
                                    <div class="admin-detail-content-wrap">
                                        <div class="admin-detail-label">Today Record</div>
                                        <div class="admin-detail-content"><%# Eval("today_log_record") %></div>
                                    </div>
                                </div>
                                <div class="adminlog-list-wrap">
                                    <p class="adminlog-wrap-title">Recent Actions</p>
                                    <div class="adminlog-list-inner-wrap">
                                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                            <ItemTemplate>
                                                <div class="adminlog-list">
                                                    <div class="adminlog-text-wrap">
                                                        <div class="admin-detail-content-wrap-inner">
                                                            <div class="admin-detail-content-wrap">
                                                                <div class="admin-detail-label">Date</div>
                                                                <div class="admin-detail-content"><%# Eval("created_date","{0:dd MMM yyyy}") %></div>
                                                            </div>
                                                            <div class="admin-detail-content-wrap">
                                                                <div class="admin-detail-label">Time</div>
                                                                <div class="admin-detail-content"><%# Eval("created_date","{0:HH:mm}") %></div>
                                                            </div>
                                                            <div class="admin-detail-content-wrap">
                                                                <div class="admin-detail-label">Description</div>
                                                                <div class="admin-detail-content"><%# Eval("adminlog_message") %></div>
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

            $('.adminlog-list').removeClass('d-flex');
            $('.adminlog-list').addClass('d-none');
            $('.adminlog-list-inner-wrap').css('max-height', 'none');
            var sourceHeight = $('.adminlog-list-inner-wrap').outerHeight(true);
            $('.adminlog-list-inner-wrap').css('max-height', sourceHeight + 'px');
            $('.adminlog-list').removeClass('d-none');
            $('.adminlog-list').addClass('d-flex');

        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
