<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="ViewMovie.aspx.cs" Inherits="LlamaScreens.Admin.ViewMovie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .poster img {
            width: 120px;
            height: 185px;
            border-radius: 5px;
        }

        .banner img {
            width: 328px;
            height: 185px;
            border-radius: 5px;
        }

        .trailer video {
            width: 328px;
            height: 185px;
            border-radius: 5px;
        }

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
            gap: 10px;
            min-width: 350px;
            max-width: 836px;
            max-height: 1250px;
            flex: 1;
        }

        .image-trailer-wrap {
            display: flex;
            padding: 10px;
            gap: 40px 15px;
            flex-wrap: wrap;
        }

            .image-trailer-wrap > div {
                position: relative;
            }

                .image-trailer-wrap > div p {
                    position: absolute;
                    top: 98%;
                    left: 50%;
                    transform: translateX(-50%);
                    font-weight: 600;
                    color: rgba(0, 0, 0, 0.5);
                }

        .movie-detail-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            margin-top: 10px;
        }

            .movie-detail-wrap > div {
                flex: 1;
                min-width: 400px;
            }

        .movie-detail-content-wrap {
            position: relative;
            margin-top: 1em;
        }

        .movie-detail-label {
            position: absolute;
            top: -1em;
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
        }

        .movie-detail-content {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
        }

        .movie-detail-content-wrap-inner {
            display: flex;
        }

            .movie-detail-content-wrap-inner > div {
                flex: 1;
                min-width: 150px;
            }

        .movie-detail-content-wrap-inner-small {
            display: flex;
        }

            .movie-detail-content-wrap-inner-small > div {
                flex: 1;
                min-width: 75px;
            }

        .category-title {
            font-weight: 700;
            font-size: 0.8em;
            color: rgba(0, 0, 0, 0.3);
            padding: 0;
            margin: 0;
            margin-bottom: 10px;
        }

        .category-main-wrap {
            padding: 5px;
            margin-top: 20px;
        }

        .category-wrap {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .category:hover {
            opacity: 1;
        }

        .category {
            padding: 10px;
            min-width: 150px;
            text-align: center;
            border: 1px solid rgba(0, 0, 0, 0.3);
            border-radius: 5px;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.6);
            opacity: 0.7;
            transition: all 0.2s;
            user-select: none;
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

        .edit-btn-wrap {
            display: flex;
            margin-top: auto;
            padding: 0 5px;
        }

            .edit-btn-wrap .btn {
                flex: 1;
            }

        .showtime-statistics {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

            .showtime-statistics .movie-detail-label {
                width: 100%;
                text-align: center;
            }

            .showtime-statistics .movie-detail-content {
                text-align: center;
            }

        .status-wrap {
            padding: 5px;
        }

        .status {
            padding: 10px 30px;
            font-size: 1.1em;
            font-weight: 700;
            color: white;
            text-align: center;
            opacity: 0.5;
        }

            .status:hover {
                opacity: 0.8;
            }

        .upcoming {
            background-color: orange;
        }

        .finished {
            background-color: rgb(99, 99, 99);
        }

        .ongoing {
            background-color: rgb(10, 207, 0);
        }

        .showtime-list-wrap {
            display: flex;
            flex-direction: column;
            padding: 10px;
            flex: 1;
        }

        .showtime-wrap-title {
            margin-top: 20px;
            margin-bottom: 10px;
            font-weight: 700;
            color: rgba(0, 0, 0, 0.3);
            text-align: center;
        }

        .showtime-list-inner-wrap {
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow-y: scroll;
            flex: 1;
        }

        .showtime-list {
            display: flex;
            padding: 15px;
            border-radius: 5px;
            border: 1px solid rgba(0, 0, 0, 0.3);
            opacity: 0.6;
            transition: all 0.2s;
            position: relative;
        }

        .list-status {
            position: absolute;
            font-weight: 600;
            font-size: 0.7em;
            border-radius: 0 0 5px 5px;
            color: green;
            border: 1px solid green;
            border-top: 0px;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            padding: 0 5px;
        }

        .showtime-list:hover {
            opacity: 1;
        }

        .showtime-text-wrap {
            display: flex;
            max-width: 300px;
        }

        .showtime-list .movie-detail-content-wrap:nth-of-type(1) {
            min-width: 100px;
        }

        .showtime-list .movie-detail-content-wrap:nth-of-type(2) {
            min-width: 50px;
        }

        .showtime-list .movie-detail-content-wrap:nth-of-type(3) {
            min-width: 50px;
        }

        .showtime-list .movie-detail-label {
            text-align: left;
        }

        .showtime-list .movie-detail-content {
            text-align: left;
        }

        .showtime-action-wrap {
            flex: 1;
            display: flex;
            justify-content: end;
            align-items: center;
        }

        .showtime-action {
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

            .showtime-action:hover {
                opacity: 1;
            }

                .showtime-action:hover svg {
                    fill: var(--admin-active-color);
                }

            .showtime-action svg {
                width: 20px;
                height: 20px;
                fill: rgba(0, 0, 0, 0.4);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
        <ItemTemplate>
            <div style="display: flex; flex-direction: column; flex-grow: 1; position: relative; padding: 0;">
                <div class="main-content-wrap up">
                    <div class="left-content-wrap">
                        <div class="status-wrap ">
                            <div class="status up ongoing">
                                Ongoing
                            </div>
                        </div>
                        <div class="image-trailer-wrap">
                            <div class="poster">
                                <p>Poster</p>
                                <img src="../Img/Movies/<%# Eval("movie_id")%>/picture.jpg"
                                    alt="" srcset="">
                            </div>
                            <div class="banner">
                                <p>Banner</p>
                                <img src="../Img/Movies/<%# Eval("movie_id")%>/banner.jpg"
                                    alt="" srcset="">
                            </div>
                            <div class="trailer">
                                <p>Trailer</p>
                                <video controls>
                                    <source src="../Img/Movies/<%# Eval("movie_id")%>/trailer.mp4" type="video/mp4">
                                </video>
                            </div>
                        </div>
                        <div class="movie-detail-wrap down">
                            <div class="movie-detail-content-wrap-inner">
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Movie Title</div>
                                    <div class="movie-detail-content"><%# Eval("movie_title") %></div>
                                </div>
                            </div>
                            <div class="movie-detail-content-wrap-inner">
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Released Date</div>
                                    <div class="movie-detail-content"><%# Eval("release_date","{0:dd MMM yyyy}") %></div>
                                </div>
                            </div>
                            <div class="movie-detail-content-wrap-inner">
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Length</div>
                                    <div class="movie-detail-content"><%# Eval("movie_length") %> Minutes</div>
                                </div>
                            </div>
                            <div class="movie-detail-content-wrap-inner">
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Company</div>
                                    <div class="movie-detail-content"><%# Eval("movie_company") %></div>
                                </div>
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Country</div>
                                    <div class="movie-detail-content"><%# Eval("movie_country") %></div>
                                </div>
                            </div>
                            <div class="movie-detail-content-wrap-inner">
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Directors</div>
                                    <div class="movie-detail-content"><%# Eval("movie_director") %></div>
                                </div>
                                <div class="movie-detail-content-wrap">
                                    <div class="movie-detail-label">Actors</div>
                                    <div class="movie-detail-content"><%# Eval("movie_actor") %></div>
                                </div>
                            </div>

                            <div class="category-main-wrap">
                                <p class="category-title">Category - Total <%# Eval("total_category") %></p>
                                <div class="category-wrap">
                                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                                        <ItemTemplate>
                                            <div class="category"><%# Eval("category_name") %></div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="edit-btn-wrap">
                            <asp:Button ID="Edit_Btn" runat="server" CssClass="btn up hover-moreup active-down" Text="Edit Movie Detail" OnCommand="Edit_Btn_Command" />
                        </div>
                    </div>
                    <div class="right-content-wrap">
                        <p class="right-content-title">ShowTime Details</p>
                        <div class="right-content down">
                            <div class="showtime-statistics">
                                <div class="movie-detail-content-wrap-inner">
                                    <div class="movie-detail-content-wrap">
                                        <div class="movie-detail-label">Total ShowTimes</div>
                                        <div class="movie-detail-content">3</div>
                                    </div>
                                    <div class="movie-detail-content-wrap">
                                        <div class="movie-detail-label">ShowTime Available</div>
                                        <div class="movie-detail-content">1</div>
                                    </div>
                                </div>
                                <div class="showtime-list-wrap">
                                    <p class="showtime-wrap-title">Recent Showtime</p>
                                    <div class="showtime-list-inner-wrap">
                                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater2_ItemDataBound">
                                            <ItemTemplate>
                                                <div class="showtime-list">
                                                    <div class="list-status"><%# Eval("status") %></div>
                                                    <div class="showtime-text-wrap">
                                                        <div class="movie-detail-content-wrap-inner">
                                                            <div class="movie-detail-content-wrap">
                                                                <div class="movie-detail-label">Date</div>
                                                                <div class="movie-detail-content"><%#Eval("showtime_date","{0:dd MMM yyyy}") %></div>
                                                            </div>
                                                            <div class="movie-detail-content-wrap">
                                                                <div class="movie-detail-label">Time</div>
                                                                <div class="movie-detail-content"><%#Eval("showtime_date","{0:HH:mm}") %></div>
                                                            </div>
                                                            <div class="movie-detail-content-wrap">
                                                                <div class="movie-detail-label">Venue</div>
                                                                <div class="movie-detail-content">No <%# Eval("venue_no") %></div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="showtime-action-wrap">
                                                        <asp:LinkButton ID="View_Btn" runat="server" CssClass="showtime-action" OnCommand="View_Btn_Command">
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

            $('.showtime-list').removeClass('d-flex');
            $('.showtime-list').addClass('d-none');
            $('.showtime-list-inner-wrap').css('max-height', 'none');
            var sourceHeight = $('.showtime-list-inner-wrap').outerHeight(true);
            $('.showtime-list-inner-wrap').css('max-height', sourceHeight + 'px');
            $('.showtime-list').removeClass('d-none');
            $('.showtime-list').addClass('d-flex');

        }

        fixTableHeight();
        // Resize listener
        $(window).on('resize', fixTableHeight);
    </script>
</asp:Content>
