<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AddMovie.aspx.cs" Inherits="LlamaScreens.Admin.AddMovie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .custom2 {
            overflow-y: scroll;
        }

        @media screen and (max-width: 768px) {
            .custom2 {
                overflow: scroll;
            }
        }

        .requiredMsg {
            position: absolute;
            top: 0px;
            left: 25px;
            font-weight: 600;
            font-size: 0.8em;
            color: var(--admin-active-color);
        }

        .file-input-wrap {
            padding: 10px 20px;
        }

            .file-input-wrap > div {
                padding: 5px;
            }

        .movie-img {
            width: 120px;
            height: 185px;
            border-radius: 5px;
            opacity: 0.8;
            transition: all 0.1s;
            background-size: cover;
        }

        .movie-picture-wrap:hover .movie-img {
            opacity: 1;
        }

        .movie-img-big {
            width: 100%;
            height: 185px;
            border-radius: 5px;
            opacity: 0.8;
            transition: all 0.1s;
            background-size: cover;
        }

        .movie-picture-big-wrap:hover .movie-img-big {
            opacity: 1;
        }

        .movie-trailer {
            width: 100%;
            height: 100%;
            border-radius: 5px;
            opacity: 0.8;
            transition: all 0.1s;
        }

        .movie-trailer-label{
            padding: 10px;
        }

        .movie-trailer-wrap:hover .movie-img-big {
            opacity: 1;
        }

        .movie-picture-wrap,
        .movie-picture-big-wrap,
        .movie-trailer-wrap {
            position: relative;
        }

        .picture-icon {
            position: absolute;
            top: 45%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 25px;
            height: 25px;
            fill: rgba(0, 0, 0, 0.4);
            transition: all 0.2s;
        }

        .file-title {
            position: absolute;
            padding: 0;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.4);
            top: 55%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .movie-picture-wrap:hover .picture-icon,
        .movie-picture-big-wrap:hover .picture-icon,
        .movie-trailer-wrap:hover .picture-icon {
            fill: var(--admin-active-color);
        }

        .file-input-wrap input {
            display: none;
        }

        .file-input-wrap label {
            cursor: pointer;
        }

        .movie-trailer-wrap .movie-trailer {
            transition: all 0.2s;
            position: absolute;
        }

        .movie-trailer-wrap .picture-icon {
            z-index: 999;
        }

        .input-wrap {
            position: relative;
            margin-top: 35px;
        }

        .inputbox {
            min-width: 300px;
            max-width: 600px;
            width: 100%;
            resize: none;
        }



        .fake-input {
            position: relative;
        }

        .fake-label {
            top: -25px;
            left: 50%;
            transform: translateX(-50%);
        }

        .smallInput {
            min-width: 200px;
        }

        .input-container {
            display: flex;
            align-content: baseline;
        }

        .input-container-row {
            min-width: 300px;
            max-width: 600px;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            align-content: baseline;
        }

            .input-container-row .input-wrap {
                flex-grow: 1;
            }

        .small-wrap {
            height: 34px;
        }

        .categoryBox {
            min-width: 400px;
            max-width: 600px;
            height: 100%;
        }

        .categorybox {
            padding: 15px;
        }

        .categoryBoxTitle {
            font-weight: 700;
            color: rgba(0, 0, 0, 0.6);
            margin: 0;
        }

        .selectedCategoryBox .btn,
        .availableCategoryBox .btn {
            width: 100px;
            height: 40px;
        }

        .selectedCategoryBox,
        .availableCategoryBox {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            padding: 5px;
        }

            .selectedCategoryBox .btn:hover,
            .availableCategoryBox .btn:hover {
                background-color: var(--admin-bg-hover);
            }

        .confirm-btn-wrap {
            padding: 20px;
        }

            .confirm-btn-wrap .btn:hover {
                opacity: 0.8;
            }

            .confirm-btn-wrap .btn {
                font-size: 1.1em !important;
                background-color: var(--admin-active-color);
                color: white;
                opacity: 0.6;
                width: 120px;
            }

        .errMsg {
            color: red;
            padding: 10px 0 0 25px;
            font-weight: 600;
            opacity: 0.8;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <input type="hidden" id="submit" value="0" />
    <div style="display: flex; flex-direction: column; flex-grow: 1; position: relative;">
        <p class="requiredMsg">All File & Field Is Required !!!</p>
        <div class="row up flex-column" style="justify-content: start; padding: 10px 0;">
            <asp:Label ID="ErrMsg" runat="server" CssClass="errMsg"></asp:Label>
            <div class="d-flex file-input-wrap"
                style="gap: 10px 15px; height: fit-content; flex-wrap: wrap; margin-bottom: 20px;">
                <div class="movie-picture-wrap up" style="width: 130px; height: 195px;">
                    <svg class="picture-icon">
                        <use xlink:href="#picture"></use>
                    </svg>
                    <p class="file-title">Poster</p>
                    <asp:Label runat="server" AssociatedControlID="pictureInput" CssClass="movie-img down" ID="lblPictureInput" />
                    <asp:FileUpload ID="pictureInput" runat="server" accept=".jpg,.jpeg,.png" />
                </div>
                <div class="movie-picture-big-wrap up"
                    style="flex: 2; height: 195px; min-width: 300px; max-width: 340px;">
                    <svg class="picture-icon">
                        <use xlink:href="#picture"></use>
                    </svg>
                    <p class="file-title">Banner</p>
                    <asp:Label runat="server" AssociatedControlID="bigpictureInput" CssClass="movie-img-big down" ID="lblBigPictureInput" />
                    <asp:FileUpload ID="bigpictureInput" runat="server" accept=".jpg,.jpeg,.png" />
                </div>
                <div class="movie-trailer-wrap up"
                    style="flex: 2; height: 195px; min-width: 300px; max-width: 340px;">
                    <svg class="picture-icon" onclick="triggerFileInput()">
                        <use xlink:href="#video"></use>
                    </svg>
                    <p class="file-title">Trailer</p>
                    <asp:Label runat="server" AssociatedControlID="trailerInput" CssClass="down wrap movie-trailer-label" ID="lblTrailerInput" Style="position: relative;">
                        <video id="movieTrailer" class="movie-trailer" controls runat="server"></video>
                    </asp:Label>
                    <asp:FileUpload ID="trailerInput" runat="server" accept="video/mp4" />
                </div>
            </div>
            <div class="d-flex text-input" style="flex: 1; padding: 0 20px 0 20px;">
                <div class="d-flex" style="flex: 1; flex-wrap: wrap; gap: 0 30px; align-content: baseline;">
                    <div class="input-container flex-column">
                        <div class="input-wrap">
                            <asp:TextBox ID="titleInput" CssClass="inputbox down" runat="server"
                                placeholder="Movie title" title="Fill In Movie Title"></asp:TextBox>
                            <asp:Label AssociatedControlID="titleInput" runat="server">Title</asp:Label>
                        </div>
                        <div class="input-wrap">
                            <asp:TextBox ID="descriptionInput" CssClass="inputbox down" runat="server"
                                placeholder="Desc" title="Fill In Movie Description" TextMode="MultiLine" Rows="6" Columns="100"></asp:TextBox>
                            <asp:Label AssociatedControlID="descriptionInput" runat="server">Description</asp:Label>
                        </div>
                    </div>
                    <div class="input-container-row" style="gap: 0 20px; max-width: 500px;">
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="lengthInput" CssClass="inputbox smallInput down" runat="server"
                                placeholder="In Minutes" title="Fill In Movie Length In Minutes" type="number" TextMode="Number"></asp:TextBox>
                            <asp:Label AssociatedControlID="lengthInput" runat="server">Movie Length</asp:Label>
                        </div>
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="date" CssClass="inputbox dateInput smallInput down" runat="server"
                                title="Fill In Movie Release Date" type="date"></asp:TextBox>
                            <asp:Label AssociatedControlID="date" runat="server">Release Date</asp:Label>
                        </div>
                        <div class="input-wrap">
                            <asp:TextBox ID="directorInput" CssClass="inputbox down" runat="server"
                                placeholder="Directors" title="Fill In Movie Directors"></asp:TextBox>
                            <asp:Label AssociatedControlID="directorInput" runat="server">Directors</asp:Label>
                        </div>
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="companyInput" CssClass="inputbox smallInput down" runat="server"
                                placeholder="Company" title="Fill In Movie Company"></asp:TextBox>
                            <asp:Label AssociatedControlID="companyInput" runat="server">Company</asp:Label>
                        </div>
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="countryInput" CssClass="inputbox smallInput down" runat="server"
                                placeholder="Country" title="Fill In Movie Country"></asp:TextBox>
                            <asp:Label AssociatedControlID="countryInput" runat="server">Country</asp:Label>
                        </div>
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="actorInput" CssClass="inputbox smallInput down" runat="server"
                                placeholder="Actors" title="Fill In Movie Actors"></asp:TextBox>
                            <asp:Label AssociatedControlID="actorInput" runat="server">Actors</asp:Label>
                        </div>
                        <div class="input-wrap small-wrap">
                            <asp:TextBox ID="priceInput" CssClass="inputbox smallInput down" runat="server"
                                placeholder="Price" title="Fill In Default Price"></asp:TextBox>
                            <asp:Label AssociatedControlID="priceInput" runat="server">Price</asp:Label>
                        </div>
                    </div>

                    <div class="d-flex" style="width: 100%;">
                        <div class="input-wrap w-100 fake-input" style="height: fit-content;">
                            <p class="fake-label">Category</p>
                            <div class="categorybox down">
                                <div class="d-flex" style="flex-wrap: wrap; gap: 10px;">
                                    <div
                                        style="display: flex; gap: 10px; flex: 1; min-width: 175px; align-items: center; flex-wrap: wrap;">
                                        <div class="search-input-wrap">
                                            <svg class="search-icon">
                                                <use xlink:href="#search"></use>
                                            </svg>
                                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Category Name" class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger" AutoPostBack="true">
                                            </asp:TextBox>
                                        </div>
                                        <asp:Button runat="server" ID="search_btn"
                                            class="btn up hover-moreup active-down" Style="font-size: 0.8em; width: 55px; padding: 5px;"
                                            Text="Search" OnClick="search_trigger" UseSubmitBehavior="false"></asp:Button>
                                    </div>
                                    <div
                                        style="display: flex; justify-content: left; align-items: center; flex: 1; min-width: 290px; padding-left: 30px;">
                                        <asp:Label ID="lbltotal" class="searchmsg" runat="server">
                                        </asp:Label>
                                    </div>
                                    <div
                                        style="display: flex; position: relative; justify-content: center; align-items: center; gap: 10px;">
                                        <asp:TextBox ID="categoryInput" runat="server" CssClass="inputbox up hover-moreup"
                                            TextMode="SingleLine" placeholder="New Category Name" OnTextChanged="addCategory" AutoPostBack="true"
                                            Title="Fill In Category Name" Style="height: 34px; font-size: 0.9em; min-width: 120px;">
                                        </asp:TextBox>
                                        <asp:Button runat="server" ID="Add_Category_Btn"
                                            class="btn up hover-moreup active-down" Text="Add New Category"
                                            Style="font-size: 0.8em;" OnClick="addCategory" UseSubmitBehavior="false"></asp:Button>
                                    </div>
                                </div>

                                <div class="selectedCategory down"
                                    style="margin-top: 10px; padding: 10px 15px; overflow: hidden;">
                                    <p class="categoryBoxTitle">Selected Category</p>
                                    <asp:ScriptManager ID="ScriptManager1" runat="server" />
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="selectedCategoryBox">
                                        <ContentTemplate>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
                                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater_ItemDataBound">
                                                <ItemTemplate>
                                                    <asp:Button runat="server" ID="btn" class="btn up hover-moreup active-down" UseSubmitBehavior="false"
                                                        OnCommand="Category_Btn_Pressed_Reverse"></asp:Button>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                                <div class="searchCategory down"
                                    style="margin-top: 10px; padding: 10px 15px; overflow: hidden;">
                                    <p class="categoryBoxTitle">Available Category</p>
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" Class="availableCategoryBox tablecover">
                                        <ContentTemplate>
                                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
                                            <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2" OnItemDataBound="Repeater_ItemDataBound">
                                                <ItemTemplate>
                                                    <asp:Button runat="server" ID="btn" class="btn up hover-moreup active-down tablerow" UseSubmitBehavior="false"
                                                        OnCommand="Category_Btn_Pressed"></asp:Button>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="search_textbox" EventName="TextChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="search_btn" EventName="Click" />
                                            <asp:AsyncPostBackTrigger ControlID="categoryInput" EventName="TextChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="Add_Category_Btn" EventName="Click" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="confirm-btn-wrap">
            <asp:Button runat="server" ID="confirmBtn" class="btn up hover-moreup" OnClick="Form_Submission"
                Text="Confirm" Style="font-size: 0.8em;"></asp:Button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script>
        if ($('.movie-trailer').src == null) {
            $('.movie-trailer').css('display', 'none');
        }

        $('#content_pictureInput').change(function () {
            var input = this;
            var url = $(this).val();
            var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
            if (input.files && input.files[0] && (ext == "png" || ext == "jpeg" || ext == "jpg")) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('.movie-img').css('background-image', 'url(' + e.target.result + ')');
                }
                reader.readAsDataURL(input.files[0]);
            }
            else {
                $('.movie-img').css('background-image', 'none');
            }
        });

        $('#content_bigpictureInput').change(function () {
            var input = this;
            var url = $(this).val();
            var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
            if (input.files && input.files[0] && (ext == "png" || ext == "jpeg" || ext == "jpg")) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('.movie-img-big').css('background-image', 'url(' + e.target.result + ')');
                }
                reader.readAsDataURL(input.files[0]);
            }
            else {
                $('.movie-img-big').css('background-image', 'none');
            }
        });

        $('#content_trailerInput').change(function () {
            var input = this;
            var url = $(this).val();
            var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
            if (input.files && input.files[0] && (ext == "mp4")) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('.movie-trailer').css('display', 'block');
                    $('.movie-trailer').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
            else {
                $('.movie-trailer').css('display', 'none');
            }
        });
        function triggerFileInput() {
            document.getElementById('trailerInput').click();
        }
    </script>

</asp:Content>
