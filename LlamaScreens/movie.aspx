<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="movie.aspx.cs" Inherits="LlamaScreens.movie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/movie.css" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
        <ItemTemplate>
            <div>
                <div class="movie-banner" style="background-image: url('img/la.jpg')">
                    <div class="w-100">
                        <div class="title"><%# Eval("movie_title") %></div>
                        <div class="sub-title">PG13 Action,Triller - <%# Eval("movie_length")%> minutes</div>
                        <div class="<%= getViewDetails().CompareTo("1") == 0 ? "show" : "collapse" %> movie-details" id="collapseDetails">
                            <div class="card card-body p-0">
                                <table>
                                    <tr>
                                        <tr>
                                            <td>Release Date</td>
                                            <td>Actors</td>
                                            <td>Country</td>
                                        </tr>
                                        <tr>
                                            <td class="view-details-item"><%# Eval("release_date", "{0:dd/M/yyyy}") %></td>
                                            <td class="view-details-item"><%# Eval("movie_actor") %></td>
                                            <td class="view-details-item"><%# Eval("movie_country") %></td>
                                        </tr>
                                    </tr>
                                    <tr>
                                        <tr>
                                            <td>Director</td>
                                            <td>Company</td>
                                        </tr>
                                        <tr>
                                            <td class="view-details-item"><%# Eval("movie_director") %></td>
                                            <td class="view-details-item"><%# Eval("movie_company") %></td>
                                        </tr>
                                    </tr>
                                    <tr>
                                        <tr>
                                            <td>Description</td>
                                        </tr>
                                        <tr>
                                            <td class="view-details-item"><%# Eval("movie_description")%>></td>
                                        </tr>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <a class="view-more-btn" id="view-more" data-bs-toggle="collapse" href="#collapseDetails" role="button" aria-expanded="<%= getViewDetails().CompareTo("1") == 0 ? "true" : "false" %>" aria-controls="collapseDetails"><%= getViewDetails().CompareTo("1") == 0 ? "Less -" : "More Info +" %>
                    </a>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater2_ItemDataBound">
                            <HeaderTemplate>
                                <div class="navbar nav day-slots slots-container">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="Date_Btn" runat="server" CssClass="nav-item text-decoration-none text-white" OnClick="getTimeSlots" UseSubmitBehavior="false">
                                </asp:LinkButton>
                            </ItemTemplate> 
                            <FooterTemplate>
                                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        <div class="time-slots slots-container">
                            <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3" OnItemDataBound="Repeater3_ItemDataBound">
                                <HeaderTemplate>
                                    <div class="row gap-3 px-3">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="Slot_Time" runat="server" OnClick="Slot_Time_Click" CssClass="slot text-decoration-none text-white" UseSubmitBehavior="false">
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                            <div class="pt-3 text-center d-flex flex-column align-items-center">
                                <asp:Button CssClass="btn btn-primary collapse" ID="btnContinue" runat="server" Text="Continue" OnClick="btnContinue_Click" />
                                <span class="w-100 h-100 py-2" style="opacity: 0.8;" id="select-time-text">Please select a available time</span>
                                <div style="background-image: radial-gradient(circle, transparent 0%, #343a40 70%), url(https://th.bing.com/th/id/OIG.XblpgKDHryXPJXOwD55L?pid=ImgGn); width: 400px; height: 400px; background-size: cover; border-radius: 50%;" id="select-time-img">
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        $(document).ready(function () {
            $("#view-more").click(function () {
                if ($(".view-more-btn").hasClass("collapsed")) {
                    $(".movie-banner .title").css({ 'font-size': '1.5em' });
                    $("#view-more").html("More Info +");
                } else {
                    $(".movie-banner .title").css({ 'font-size': '0.8em' });
                    $("#view-more").html("Less -");
                }
            });
        });


    </script>
</asp:Content>

