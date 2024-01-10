<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="LlamaScreens.main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/main.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/gh/kenwheeler/slick@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/gh/kenwheeler/slick@1.8.1/slick/slick-theme.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-0 bg-dark">
        <div id="main-carousel" class="main-carousel carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#main_carousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#main_carousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#main_carousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <!-- Wrapper for slides -->
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="5000">
                    <img src="img/la.jpg" class="d-block w-100" alt="carousel-1">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>First slide label</h5>
                        <p>Some representative placeholder content for the first slide.</p>
                    </div>
                </div>
                <div class="carousel-item" data-bs-interval="5000">
                    <img src="img/chicago.jpg" class="d-block w-100" alt="carousel-2">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Second slide label</h5>
                        <p>Some representative placeholder content for the second slide.</p>
                    </div>
                </div>
                <div class="carousel-item" data-bs-interval="5000">
                    <img src="img/ny.jpg" class="d-block w-100" alt="carousel-3">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Third slide label</h5>
                        <p>Some representative placeholder content for the third slide.</p>
                    </div>
                </div>
            </div>
            <!-- Left and right controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#main-carousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#main-carousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <div class="container-fluid py-3">
            <div class="navbar navbar-dark navbar-expand-lg bg-transparent showtime-list px-5">
                <div class="title h2">Showtimes</div>
                <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#showtime-dropdown" aria-controls="showtime-dropdown" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse ms-auto" id="showtime-dropdown">
                    <ul class="navbar-nav d-flex justify-content-around flex-row gap-5 pe-5 ms-auto">
                        <li class="nav-item">
                            <asp:Button CssClass="nav-link active" ID="showingBtn" runat="server" Text="Now Showing" OnClick="SelectBtn_Click" UseSubmitBehavior="false" />
                        </li>
                        <li class="nav-item">
                            <asp:Button CssClass="nav-link" ID="comingBtn" runat="server" Text="Coming Soon" OnClick="SelectBtn_Click" UseSubmitBehavior="false" />
                        </li>
                    </ul>
                </div>
            </div>
            <hr style="border: 1px solid grey;" />
            <asp:ScriptManager ID="sm" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="Select Movie.* From Movie Where Movie.Status = 'Now Showing'"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                        <HeaderTemplate>
                            <div class="movie-list-wrapper">
                                <div class="movie-slider">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div>
                                <div class="card card-body w-75 h-100">
                                    <div class="position-relative overflow-hidden" style="width: 200px; aspect-ratio: 2/3;">
                                        <img class="img-fluid h-100 w-100" src="Img/Movies/<%# Eval("movie_id") %>/picture.jpg" draggable="false">
                                        <div class="overview">
                                            <div class="title"><%# Eval("movie_title") %></div>
                                            <asp:Button CssClass="book-btn" ID="BookButton" runat="server" Text="Book Now" OnCommand="Book_Btn_Pressed" />
                                            <asp:Button CssClass="details-btn" ID="DetailButton" runat="server" Text="View Details" OnCommand="Book_Btn_Pressed" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            </div>
                    </div>
                        </FooterTemplate>
                    </asp:Repeater>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="showingBtn" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="comingBtn" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script type="text/javascript" src="//cdn.jsdelivr.net/gh/kenwheeler/slick@1.8.1/slick/slick.min.js"></script>

    <script>
        slider();

        function slider() {
            $('.movie-slider').slick({
                slidesToShow: 4,
                slidesToScroll: 1,
                centerMode: true,
                autoplay: false,
                autoplaySpeed: 2000,
                responsive: [
                    {
                        breakpoint: 1200,
                        settings: {
                            slidesToShow: 2,
                            slidesToScroll: 2,
                        }
                    },
                    {
                        breakpoint: 600,
                        settings: {
                            slidesToShow: 1,
                            slidesToScroll: 1
                        }
                    }]
            });
        }

        //press option change active
        $('.showtime-list .nav-link').click(function () {
            $('.showtime-list .nav-link').removeClass('active');
            $(this).addClass('active');
        });

    </script>
</asp:Content>
