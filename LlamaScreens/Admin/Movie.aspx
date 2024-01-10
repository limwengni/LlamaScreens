<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="Movie.aspx.cs" Inherits="LlamaScreens.Admin.Movie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .btn {
            width: 200px;
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

            .custom-radio label:hover {
                color: var(--admin-active-color);
                opacity: 0.5;
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

        .movie-img {
            width: 120px;
            height: 185px;
            border-radius: 5px;
        }

        .movie-table-row div,
        .movie-table,
        .movie-table-header div {
            flex: 1;
            text-align: center;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.4);
            user-select: none;
            transition: all 0.2s;
        }

            .movie-table-row div:nth-of-type(1),
            .movie-table-header div:nth-of-type(1) {
                min-width: 140px;
                max-width: 140px;
                padding: 10px;
            }

            .movie-table-row div:nth-of-type(2),
            .movie-table-header div:nth-of-type(2) {
                padding: 10px 10px 10px 20px;
                text-align: left;
            }

            .movie-table-row div:nth-of-type(3),
            .movie-table-header div:nth-of-type(3) {
                min-width: 50px;
                max-width: 150px;
                padding: 10px;
            }

        .movie-table {
            padding: 20px;
            flex-direction: column;
            overflow-y: scroll;
            max-height: 600px;
            max-width: 100%;
            display: flex;
            gap: 10px;
        }

        .movie-table-row {
            min-height: 205px;
            min-width: 500px;
            border-radius: 5px;
            overflow: hidden;
            transition: all 0.2s;
        }

            .movie-table-row:hover div {
                color: rgba(0, 0, 0, 0.656) !important;
            }

            .movie-table-row:hover {
                background-color: var(--admin-bg-hover);
            }

        .img-down {
            position: relative;
            padding: 0 !important;
            max-width: 120px !important;
            min-width: 120px !important;
            filter: brightness(95%);
            transition: all 0.2s;
            opacity: 0.8;
        }

            .img-down:hover {
                filter: brightness(100%);
                opacity: 1;
            }

        .movie-table .btn {
            width: 40px;
            height: 40px;
        }

        .action svg {
            width: 20px;
            height: 20px;
            fill: rgba(0, 0, 0, 0.3);
            transition: all 0.2s;
        }

        .movie-table-row:hover .action svg {
            fill: rgba(0, 0, 0, 0.6);
        }

        .action .btn:hover svg {
            fill: var(--admin-active-color);
        }

        .action .btn:nth-of-type(3):hover svg {
            fill: rgb(255, 98, 98);
        }

        .action .btn {
            padding: 0;
            justify-content: center;
            align-items: center;
            display: flex;
        }

        .description span:nth-of-type(1) {
            justify-self: start;
            margin-top: 5px;
            margin-bottom: 15px;
            font-size: 0.8em;
            font-weight: 700;
            width: 100px;
            margin-right: auto;
            text-align: center;
            border-radius: 5px;
            padding: 2px 0;
        }

        .description span:nth-of-type(4) {
            font-size: 0.8em;
            flex-grow: 1;
            max-height: 93px;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .Now.Showing {
            background-color: rgb(175, 249, 63);
        }

        .Coming.Soon {
            background-color: rgb(255, 176, 30);
        }

        .Finished {
            background-color: rgb(162, 162, 162);
        }

        .canceled {
            background-color: rgb(255, 124, 124);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1;">
        <div class="row" style="justify-content: start; gap: 5px 10px; padding: 10px 0;">
            <asp:Button runat="server" ID="add_btn" class="btn up hover-moreup active-down" Text="Add New Movie" PostBackUrl="AddMovie.aspx" UseSubmitBehavior="false"></asp:Button>
        </div>
        <div class="row wrap down"
            style="border-radius: 5px; display: flex; flex-direction: column; padding: 20px;">
            <div class="d-flex flex-column h-100">
                <div class="d-flex justify-content-center" style="flex-wrap: wrap; gap: 10px; align-items: center;">
                    <div style="display: flex; gap: 10px; flex: 1; min-width: 375px;">
                        <div class="search-input-wrap">
                            <svg class="search-icon">
                                <use xlink:href="#search"></use>
                            </svg>
                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Movie Title...."
                                class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                        </div>
                        <asp:Button runat="server" ID="search_btn" class="btn up hover-moreup active-down"
                            Style="font-size: 0.8em; width: 55px; padding: 5px;" Text="Search" OnClick="search_trigger"></asp:Button>
                    </div>
                    <div
                        style="display: flex; justify-content: center; align-items: center; flex: 1; min-width: 290px;">
                        <asp:Label ID="lbltotal" class="searchmsg" Text="Showing 6 results for your movie search"
                            runat="server"></asp:Label>
                    </div>
                    <div class="up statusbtnwrap"
                        style="display: flex; width: 320px; border-radius: 5px; padding: 5px 10px; flex: 1; min-width: 317px;">
                        <asp:RadioButton ID="radioButton1" runat="server" Text="All" Value="all"
                            CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" GroupName="statusradio"/>
                        <asp:RadioButton ID="radioButton2" runat="server" Text="Showing" Value="Now Showing"
                            CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" GroupName="statusradio"/>
                        <asp:RadioButton ID="radioButton3" runat="server" Text="Soon" Value="Coming Soon"
                            CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" GroupName="statusradio"/>
                        <asp:RadioButton ID="radioButton4" runat="server" Text="Finished" Value="Finished"
                            CssClass="custom-radio" OnCheckedChanged="search_trigger" AutoPostBack="true" GroupName="statusradio"/>
                        <div class="statusbtn-glass down"></div>
                    </div>
                </div>
                <div class="d-flex flex-column" style="padding-top: 30px; height: 100%; max-height: 100%;">
                    <div class="d-flex movie-table-header" style="padding: 5px 20px;">
                        <div style="padding: 0;">Picture</div>
                        <div style="padding: 0 10px 0 20px;">Description</div>
                        <div style="padding: 0 10px 0 10px;">Actions</div>
                    </div>
                    <div class="movie-table-wrap" style="flex-grow: 1;">
                        <asp:ScriptManager ID="ScriptManager1" runat="server" />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="movie-table up tablecover">
                            <ContentTemplate>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT Movie.* FROM Movie"></asp:SqlDataSource>
                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                                    <ItemTemplate>
                                        <div class="d-flex movie-table-row up hover-moreup tablerow">
                                            <div>
                                                <div class="img-down hover-moreup">
                                                    <img class="movie-img"
                                                        src="../Img/Movies/<%# Eval("movie_id")%>/picture.jpg">
                                                </div>
                                            </div>
                                            <div class="description" style="display: flex; flex-direction: column;">
                                                <span class="status-wrap <%# Eval("status") %>"><%# Eval("status") %></span>
                                                <span><%# Eval("movie_title") %></span>
                                                <span><%# Eval("release_date", "{0:dd/M/yyyy}") %></span>
                                                <span><%# Eval("movie_description") %></span>
                                            </div>
                                            <div class="action"
                                                style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 15px;">
                                                <asp:LinkButton ID="Edit_Btn" runat="server" CssClass="btn up active-down" OnCommand="Edit_Btn_Command">
                                                        <svg> <use xlink:href="#edit"></use></svg>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="View_Btn" runat="server" CssClass="btn up active-down" OnCommand="View_Btn_Command">
                                                        <svg> <use xlink:href="#view"></use></svg>
                                                </asp:LinkButton>
                                            </div>
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
            $('.movie-table-row').removeClass('d-flex');
            $('.movie-table-row').addClass('d-none');
            var sourceHeight = $('.movie-table-wrap').outerHeight(true);
            $('.movie-table').css('max-height', sourceHeight + 'px');
            $('.movie-table-row').removeClass('d-none');
            $('.movie-table-row').addClass('d-flex');
        }

        function cutDescription() {
            var maxLength = 1280;
            var textElements = $('.description span:nth-of-type(4)');
            textElements.each(function () {
                var text = $(this).text();
                if (text.length > maxLength) {
                    var truncatedText = text.substring(0, maxLength) + ' ...';
                    $(this).text(truncatedText);
                }
            });
        }

        // Format Description (add ...)
        cutDescription();
        // Set proper height
        fixTableHeight();
        // Resize listener

        $(window).on('resize', fixTableHeight);
    </script>

</asp:Content>
