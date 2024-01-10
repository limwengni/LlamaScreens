<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AdminLog.aspx.cs" Inherits="LlamaScreens.Admin.AdminLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .main-content-wrap {
            padding: 10px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .search {
            width: 100%;
            flex: 1;
            min-width: 200px;
        }

        .search-wrap {
            margin-bottom: 20px;
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

        .content-table {
            display: flex;
            flex-direction: column;
            gap: 5px;
            overflow-y: scroll;
            min-width: 698px;
            flex: 1;
            min-height: 300px;
        }

        .content-list {
            padding: 0 10px;
            display: flex;
            gap: 10px;
        }


        .content-header {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.5);
            margin-bottom: 5px;
            flex-direction: row;
            display: flex;
            padding: 0 10px;
            gap: 10px;
        }


            .content-list > div:nth-of-type(1),
            .content-header > div:nth-of-type(1) {
                min-width: 200px;
            }

            .content-list > div:nth-of-type(2),
            .content-header > div:nth-of-type(2) {
                min-width: 300px;
                flex: 1;
            }

            .content-list > div:nth-of-type(3),
            .content-header > div:nth-of-type(3) {
                min-width: 100px;
            }

            .content-list > div:nth-of-type(4),
            .content-header > div:nth-of-type(4) {
                min-width: 50px;
            }

        .content-list {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.8);
            opacity: 0.5;
            border: 1px solid rgba(0, 0, 0, 0.4);
            transition: all 0.2s;
            border-radius: 5px;
            min-width: 690px;
        }

            .content-list:hover {
                opacity: 0.8;
            }

        .clickable {
            color: rgb(107, 107, 255);
            cursor: pointer;
            text-decoration: none;
        }

            .clickable:hover,
            .clickable:active {
                color: rgb(68, 68, 255);
                text-decoration: underline;
            }

        .content-wrap {
            display: flex;
            flex-direction: column;
            overflow-x: scroll;
            padding-bottom: 5px;
            flex: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
        <div class="main-content-wrap up">
            <div class="search-wrap">
                <div class="search-box-wrap">
                    <div class="search-input-wrap">
                        <svg class="search-icon">
                            <use xlink:href="#search"></use>
                        </svg>
                        <asp:TextBox runat="server" ID="search_textbox" placeholder="Action / Name"
                            class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                    </div>
                    <asp:Button runat="server" ID="search_btn" class="btn up hover-moreup active-down search-btn"
                        Text="Search" OnClick="search_trigger"></asp:Button>
                </div>
                <div class="search-result-wrap">
                    <asp:Label ID="lbltotal" class="searchmsg" Text="Showing 2 results for your search"
                        runat="server"></asp:Label>
                </div>
            </div>
            <div class="content-wrap">
                <div class="content-header">
                    <div>Performed By</div>
                    <div>Action</div>
                    <div>Date</div>
                    <div>Time</div>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="content-table tablecover">
                    <ContentTemplate>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT AdminLog.*, Admin.admin_username FROM AdminLog INNER JOIN Admin ON AdminLog.admin_id = Admin.admin_id ORDER BY CREATED_DATE DESC"></asp:SqlDataSource>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                            <ItemTemplate>
                                <div class="content-list tablerow">
                                    <div>
                                        <asp:LinkButton ID="View_Admin_Btn" runat="server" CssClass="clickable" OnCommand="View_Admin_Btn_Command"><%# Eval("admin_username") %></asp:LinkButton>
                                    </div>
                                    <div><%# Eval("adminlog_message") %></div>
                                    <div><%# Eval("created_date","{0:dd MMM yyyy}") %></div>
                                    <div><%# Eval("created_date","{0:HH:mm}") %></div>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script>
        function fixTableHeight() {
            $('.content-list').removeClass('d-flex');
            $('.content-list').addClass('d-none');
            $('.content-table').css('max-height', 'none');
            var sourceHeight = $('.content-table').outerHeight(true);
            $('.content-table').css('max-height', sourceHeight + 'px');
            $('.content-list').removeClass('d-none');
            $('.content-list').addClass('d-flex');
        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
