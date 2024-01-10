<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="movieList.aspx.cs"
    Inherits="LlamaScreens.movieList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/movieList.css" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="contianer p-5">
        <div class="d-flex align-items-center text-light col-11 mx-auto flex-column flex-lg-row gap-3 gap-lg-0 pb-5">
            <div class="h3 ps-0 ps-lg-5 mb-0">Movies</div>
            <div class="options d-flex mx-auto gap-5 mb-3 my-lg-0">
                <asp:Button CssClass="option active" ID="showingBtn" runat="server" Text="Now Showing" OnClick="SelectBtn_Click" />
                <asp:Button CssClass="option" ID="comingBtn" runat="server" Text="Coming Soon" OnClick="SelectBtn_Click" />
            </div>
            <div class="search">
                <div class="input-group">
                    <div class="form-outline">
                        <asp:TextBox ID="Search" class="form-control" runat="server" OnTextChanged="SelectBtn_Click" AutoPostBack="True" />
                    </div>
                    <asp:LinkButton ID="SelectBtn" CssClass="btn btn-primary" runat="server" OnClick="SelectBtn_Click"><i class="fas fa-search"></i></asp:LinkButton>
                </div>
            </div>
        </div>
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="Select Movie.* From Movie Where Movie.Status = 'Now Showing'"></asp:SqlDataSource>
                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                    <ItemTemplate>
                        <div class="col-12 col-md-4 col-lg-11 mx-auto">
                            <div class="card mb-3 bg-transparent border-0">
                                <div class="row g-0">
                                    <div class="col-lg-2 d-flex">
                                        <img class="img-fluid mx-auto"
                                            src="Img/Movies/<%# Eval("movie_id") %>/picture.jpg"
                                            draggable="false" style="height: 300px; width: 200px;">
                                    </div>
                                    <div class="col-lg-8 pe-0 pe-lg-5">
                                        <div class="card-body py-0">
                                            <p class="card-title text-center text-lg-start"><%# Eval("movie_title") %></p>
                                            <p class="card-text d-none d-lg-block"><%# Eval("movie_description") %></p>
                                        </div>
                                    </div>
                                    <div class="col-lg d-flex flex-column justify-content-center gap-3 pb-5 align-items-center align-items-lg-end">
                                        <asp:Button class="book-btn" ID="BookButton" runat="server" Text="Book Now"
                                            OnCommand="Book_Btn_Pressed" />
                                        <asp:Button class="details-btn" ID="DetailButton" runat="server" Text="View Details"
                                            OnCommand="Book_Btn_Pressed" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="showingBtn" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="comingBtn" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="SelectBtn" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        $(document).ready(function () {
            $(".option").click(function () {
                $(".option").removeClass("active");
                $(this).addClass("active");
            });

            var option = <%=statusOpt%>;
            if (option == 1) {
                $(".option").removeClass("active");
                $("#ContentPlaceHolder1_comingBtn").addClass("active");
            }
        });
    </script>
</asp:Content>
