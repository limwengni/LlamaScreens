<%@ Page Title="Movie Cashback Promotion" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="LlamaScreens.main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/promotion.css" type="text/css" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/gh/kenwheeler/slick@1.8.1/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/gh/kenwheeler/slick@1.8.1/slick/slick-theme.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="promotion-container p-5">
        <div class="d-flex align-items-center text-light col-12 mx-auto flex-column flex-lg-row gap-3 gap-lg-0 pb-5">
            <div class="h3 ps-0 ps-lg-5 mb-0">Promotions</div>
        </div>
        <div class="image-row">
            <img src="../img/cashback.png" alt="Movie Image 1" />
            <img src="../img/member_points.png" alt="Movie Image 2" />
        </div>

    </div>
</asp:Content>
