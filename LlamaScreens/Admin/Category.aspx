<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="Category.aspx.cs" Inherits="LlamaScreens.Admin.Category" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .categoryitem {
            padding: 5px 40px 5px 10px;
            width: 250px;
            height: 70px;
            text-align: center;
            color: rgba(0, 0, 0, 0.3);
            font-size: 1.1em;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            user-select: none;
        }

            .categoryitem:hover {
                background-color: var(--admin-bg-hover);
            }

                .categoryitem:hover .category-name,
                .categoryitem:hover .category-name::placeholder {
                    color: rgba(0, 0, 0, 0.5);
                }


                .categoryitem:hover button {
                    fill: rgba(0, 0, 0, 0.5);
                }

        .categoryaction {
            position: absolute;
            width: 35px;
            height: 70px;
            right: 0;
            top: 0;
            display: flex;
            flex-direction: column;
        }

            .categoryaction button {
                border: none;
                outline: 0;
                width: 35px;
                height: 35px;
                background-color: transparent;
                display: flex;
                justify-content: center;
                align-items: center;
                fill: rgba(0, 0, 0, 0.3);
                transition: all 0.2s;
                flex: 1;
            }

        .category-name {
            border: none;
            outline: 0;
            background-color: transparent;
            padding: 0;
            margin: 0;
            text-align: center;
            color: rgba(0, 0, 0, 0.3);
            font-weight: 700;
            transition: all 0.2s;
            cursor: default;
            width: 100%;
        }

            .category-name::placeholder {
                color: rgba(0, 0, 0, 0.3);
                font-weight: 700;
                transition: all 0.2s;
            }

        .categoryaction button:hover {
            fill: var(--admin-active-color);
        }

        .categoryaction > button:nth-of-type(1) {
            border-radius: 0 5px 5px 0;
        }

        .categoryaction > button:nth-of-type(2) {
            border-radius: 0 5px 0 0;
        }

        .categoryaction > button:nth-of-type(3):hover {
            fill: rgb(255, 73, 73);
        }

        .categoryaction > button:nth-of-type(3) {
            border-radius: 0 0 5px 0;
        }

        .categoryaction svg {
            width: 20px;
            height: 20px;
        }

        .hide {
            display: none !important;
        }

        .tablecover {
            padding: 0 10px;
            margin-top: 25px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 30px 0 10px 0;">
        <div style="position: relative; display: flex; align-items: center; gap: 10px;">
            <asp:TextBox ID="Category_Input" runat="server" CssClass="inputbox down" title="Fill In Category Name" placeholder="Category" />
            <label for="categoryInput">New Category Name</label>
            <asp:Button ID="Add_Category_Btn" runat="server" CssClass="btn up hover-moreup active-down" Text="Add Category" OnCommand="Add_Category_Btn_Command" />
        </div>
        <div class="wrap" style="padding-top: 15px;">
            <div class="wrap down" style="padding: 15px;">
                <div class="search-wrap">
                    <div style="display: flex; gap: 10px; min-width: 375px;">
                        <div class="search-input-wrap">
                            <svg class="search-icon">
                                <use xlink:href="#search"></use>
                            </svg>
                            <asp:TextBox runat="server" ID="search_textbox" placeholder="Category Name...."
                                class="search halfup hover-up active-up focus-up customselect" OnTextChanged="search_trigger"></asp:TextBox>
                        </div>
                        <asp:Button runat="server" ID="search_btn" class="btn up hover-moreup active-down"
                            Style="font-size: 0.8em; width: 55px; padding: 5px;" Text="Search" OnClick="search_trigger"></asp:Button>
                    </div>
                    <div
                        style="display: flex; justify-content: left; align-items: left; flex: 1; min-width: 290px; padding-left: 20px;">
                        <asp:Label ID="lbltotal" class="searchmsg" Text="Showing 6 results for your category search"
                            runat="server"></asp:Label>
                    </div>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" Class="tablecover">
                    <ContentTemplate>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT * FROM [Category]"></asp:SqlDataSource>
                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemDataBound="Repeater1_ItemDataBound">
                            <ItemTemplate>
                                <div class="categoryitem up hover-moreup tablerow">
                                    <asp:TextBox ID="Category_Name" runat="server" CssClass="category-name"/>
                                    <div class="categoryaction up hover-moreup">
                                        <button class="edit-btn" type="button">
                                            <svg>
                                                <use xlink:href="#edit"></use>
                                            </svg>
                                        </button>
                                        <asp:LinkButton ID="Confirm_Btn" runat="server" CssClass="confirm-btn hide" type="button" OnCommand="Confirm_Btn_Command">
                                        <svg>
                                            <use xlink:href="#confirm"></use>
                                        </svg>
                                        </asp:LinkButton>
                                        <button class="cancel-btn hide" type="button">
                                            <svg>
                                                <use xlink:href="#cancel"></use>
                                            </svg>
                                        </button>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="search_textbox" EventName="TextChanged" />
                        <asp:AsyncPostBackTrigger ControlID="search_btn" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:HiddenField runat="server" ID="EditingCat"/>
                <asp:HiddenField runat="server" ID="CurrCat"/>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    <script src="../Js/search.js"></script>
    <script>
        function finishEdit(e) {
            var inputElement = $(e).closest('.categoryitem').find('.category-name');
            var actionWrap = $(e).closest('.categoryaction');
            inputElement.removeClass('down')
            actionWrap.find('.confirm-btn').addClass('hide');
            actionWrap.find('.cancel-btn').addClass('hide');
            actionWrap.find('.edit-btn').removeClass('hide');
            inputElement.prop('readonly', true);
        }

        function update() {
            $('.edit-btn').on('click', function () {
                $('.category-name.down').val($('#content_EditingCat').val());
                $('.category-name').prop('readonly', true);
                $('.category-name').removeClass('down');
                $('.confirm-btn').addClass('hide');
                $('.cancel-btn').addClass('hide');
                $('.edit-btn').removeClass('hide');

                var inputElement = $(this).closest('.categoryitem').find('.category-name');
                var actionWrap = $(this).closest('.categoryaction');
                inputElement.addClass('down')
                $('#content_EditingCat').val(inputElement.val());
                actionWrap.find('.confirm-btn').removeClass('hide');
                actionWrap.find('.cancel-btn').removeClass('hide');
                $(this).addClass('hide');
                inputElement.removeAttr('readonly').focus();
            });

            $('.category-name').on('input', function () {
                $('#content_CurrCat').val($(this).val());
            });

            $('.confirm-btn').on('click', function () {
                $('#content_EditingCat').val() = $('.category-name.down').val();
                finishEdit(this);
            });

            $('.cancel-btn').on('click', function () {
                finishEdit(this);
            });
        }

        update();
    </script>
</asp:Content>
