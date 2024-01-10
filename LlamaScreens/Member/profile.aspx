<%@ Page Title="" Language="C#" MasterPageFile="~/Member/memberTemplate.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="LlamaScreens.Member.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../CSS/profile.css" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jsbarcode/3.11.6/JsBarcode.all.js" integrity="sha512-wkHtSbhQMx77jh9oKL0AlLBd15fOMoJUowEpAzmSG5q5Pg9oF+XoMLCitFmi7AOhIVhR6T6BsaHJr6ChuXaM/Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"
        SelectCommand="SELECT [member_username], [member_email], [member_phone_no], 
        [member_birth_date], [member_point], [created_date] FROM [Member] WHERE ([member_email] = @member_email)">
        <SelectParameters>
            <asp:SessionParameter Name="member_email" SessionField="email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="container-fluid min-vh-100">
        <div class="row flex-fill">
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT
    m.movie_id,
    m.movie_title,
    m.movie_director,
    t.seat_type,
    t.seat_id,
    t.ticket_id,
    t.booking_id,
    t.status,
    s.showtime_id,
    s.showtime_date,
    v.venue_no
FROM
    movie m
INNER JOIN
    showtime s ON m.movie_id = s.movie_id
INNER JOIN
    ticket t ON s.showtime_id = t.showtime_id
INNER JOIN
    booking b ON t.booking_id = b.booking_id
INNER JOIN
    venue v ON s.venue_id = v.venue_id
WHERE
    b.member_id = @MemberId;">
                <SelectParameters>
                    <asp:SessionParameter Name="MemberId" SessionField="memberId" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div class="col-2 p-0 position-fixed" id="side-nav">
                <div
                    class="d-flex flex-column align-items-center align-items-sm-start text-white min-vh-100 bg-dark">
                    <div class="align-items-center pl-1 w-100 position-relative">
                        <img class="imageBg" src="../Img/Bg.png" alt="bg" draggable="false" />
                        <img class="iconProfilePic" src="../Img/Bg.png" draggable="false"
                            alt="bg" />
                    </div>
                    <ul
                        class="nav nav-pills ps-2 pt-1 pb-5 flex-column align-items-center w-100"
                        id="menu">
                        <li
                            class=" bg-transparent sidebarItem align-middle active py-2"
                            id="profileBtn">
                            <span
                                class="ms-1 d-none d-sm-inline fs-4 text-white">Profile</span>
                        </li>
                        <li
                            class=" bg-transparent sidebarItem align-middle py-2"
                            id="ticketBtn">
                            <span class="ms-1 d-none d-sm-inline fs-4 text-white">My Ticket</span>
                        </li>
                    </ul>
                </div>
            </div>
            <%--profile settings--%>
            <div class="col-12 py-3 h-100" id="profileSettings" style="background-color: #383F45;">
                <h2 class="text-white ps-5">Profile Settings</h2>
                <div class="m-3">
                    <div class="card border-0 text-white border rounded m-3 p-3">
                        <div class="d-flex flex-row">
                            <div class="me-3">
                                <img class="profilePic"
                                    src="../Img/Bg.png" alt="profile pic" draggable="false" />
                            </div>
                            <div>
                                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                    <ItemTemplate>
                                        <p class="m-0 py-1"><%# Eval("member_username") %></p>
                                        <p class="m-0 py-1">Member since <%# Eval("created_date")%></p>
                                        </div>
                        </div>
                    </div>

                    <%--Edit profile--%>
                                        <div id="displayInfo" class="card border-0 text-white border-rounded m-3 p-3">
                                            <h3>My Profile
                            <button id="editBtn" type="button">Edit</button>
                                            </h3>
                                            <div class="row mt-3">
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Username</label>
                                                    <h5><%# Eval("member_username") %></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Date of Birth</label>
                                                    <h5><%# Eval("member_birth_date", "{0:dd/M/yyyy}")%></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Email address</label>
                                                    <h5><%# Eval("member_email") %></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Phone number</label>
                                                    <h5><%# Eval("member_phone_no") %></h5>
                                                </div>
                                            </div>
                                        </div>
                                        <%-- Edit Info --%>

                                        <div id="editInfo" class="card border-0 text-white border rounded m-3 p-3 d-none">
                                            <h3>My Profile
                            <button id="backBtn" type="button">X</button>
                                            </h3>
                                            <div class="row mt-3">
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData" for="editUsername">Username</label><br />
                                                    <h5>
                                                        <input class="editInput" id="editUsername" name="editUsername" type="text" value="<%# Eval("member_username") %>" /></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Date of Birth</label><br />
                                                    <h5>
                                                        <input class="editInput" id="editDOB" name="editDOB" type="date" value='<%# Eval("member_birth_date", "{0:yyyy-MM-dd}") %>' /></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Email address</label><br />
                                                    <h5>
                                                        <input class="editInput" id="editEmail" name="editEmail" type="text" value="<%# Eval("member_email") %>" /></h5>
                                                </div>
                                                <div class="col-6 ps-5 pt-2">
                                                    <label class="labelForData">Phone number</label><br />
                                                    <h5>
                                                        <input class="editInput" id="editPhone" name="editPhone" type="text" value="<%# Eval("member_phone_no") %>" /></h5>
                                                </div>
                                            </div>
                                            <button class="mt-4" id="saveBtn" type="button">Save</button>
                                            <%--modal confirmation --%>
                                            <div class="modal fade w-100 text-black" id="modelWindow" role="dialog">
                                                <div class="modal-dialog modal-sm vertical-align-center">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Confirmation</h4>
                                                        </div>
                                                        <div class="modal-body">
                                                            Confirm to edit?
                                    <asp:Button ID="confirmBtn" runat="server" Text="Yes" OnClick="confirmation_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--Edit profile end--%>
                                        <div class="row border-0 card text-white border rounded m-3 p-3">
                                            <div class="col-4 ps-5 pt-2">
                                                <h4>Membership point awarded : </h4>
                                            </div>
                                            <div class="col-2 ps-5 pt-2">
                                                <h3><%# Eval("member_point") %> point</h3>
                                            </div>
                                        </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                        <%--profile settings--%>
                        <%--ticket viewing--%>
                        <div class="d-none col-12 py-3" id="ticketDisplay" style="background-color: #383F45; padding-left: 9em;">
                            <h2 class="text-white ps-5">My Ticket</h2>
                            <div class="row">
                                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                                    <ItemTemplate>
                                        <div class="col-12">
                                            <div class="col-10 px-5 mx-auto">
                                                <div class="cardWrap d-flex">
                                                    <div class="ticket col-8">
                                                        <h1 class="pt-3">Llama <span>Cinema</span></h1>
                                                        <div class="title">
                                                            <h2><%# Eval("movie_title") %></h2>
                                                            <span>movie</span>
                                                        </div>
                                                        <div class="name">
                                                            <h2><%# Eval("venue_no") %></h2>
                                                            <span>venue</span>
                                                        </div>
                                                        <div class="seat">
                                                            <h2><%# Eval("seat_type") %></h2>
                                                            <span>seat type</span>
                                                        </div>
                                                        <div class="time">
                                                            <h2><%# Eval("showtime_date", "{0:HH:mm}") %></h2>
                                                            <span>time</span>
                                                        </div>

                                                    </div>
                                                    <div class="ticket col-4">
                                                        <div class="status text-center pt-4"<h3><%# Eval("status") %></h3></div>
                                                        <div class="number">
                                                            <h3><%# Eval("seat_id") %></h3>
                                                            <span>seat</span>
                                                        </div>
                                                        <div class="barcode-wrapper">
                                                            <img id="barcode-<%# Container.ItemIndex %>"/>
                                                            <script>
                                                                //barcode generator
                                                                JsBarcode("#barcode-<%# Container.ItemIndex %>", "<%# Eval("ticket_id","{0:0000}") %>", {
                                                                    format: "CODE128",
                                                                    width: 4,
                                                                    height: 40,
                                                                    displayValue: false
                                                                });
                                                            </script>
                                                        </div>
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
                <%--ticket viewing--%>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        const selected = document.querySelectorAll(".sidebarItem");

        selected.forEach((sidebarItem) => {
            sidebarItem.addEventListener("click", function (e) {
                const profile = document.getElementById("profileSettings");
                const ticket = document.getElementById("ticketDisplay");

                selected.forEach((item) => item.classList.remove("active"));
                this.classList.add("active");

                if (this.id === "profileBtn") {
                    ticket.classList.add("d-none");
                    profile.classList.remove("d-none");
                } else if (this.id === "ticketBtn") {
                    profile.classList.add("d-none");
                    ticket.classList.remove("d-none");
                }
            });
        });

        //get side nav width and set it to the left padding of the content on resize
        $(document).ready(function () {
            var sideNav = document.getElementById("side-nav");
            var content = document.getElementById("profileSettings");
            var ticket = document.getElementById("ticketDisplay");

            content.style.paddingLeft = sideNav.offsetWidth + "px";
            ticket.style.paddingLeft = sideNav.offsetWidth + "px";

            window.addEventListener("resize", function () {
                content.style.paddingLeft = sideNav.offsetWidth + "px";
                ticket.style.paddingLeft = sideNav.offsetWidth + "px";
            });
        });
    </script>
    <script>
        const edit = document.getElementById("editBtn");
        const back = document.getElementById("backBtn");
        const displayInfo = document.getElementById("displayInfo");
        const editInfo = document.getElementById("editInfo");

        edit.addEventListener("click", function (e) {
            displayInfo.classList.add("d-none");
            editInfo.classList.remove("d-none");
        });

        back.addEventListener("click", function (e) {
            editInfo.classList.add("d-none");
            displayInfo.classList.remove("d-none");
        });
    </script>
    <script>
        $('#saveBtn').click(function () {
            $('#modelWindow').modal('show');
        });
    </script>
</asp:Content>
