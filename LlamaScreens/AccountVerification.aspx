<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="AccountVerification.aspx.cs" Inherits="LlamaScreens.AccountVerification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="text-center py-5 w-100" style="color: white;">
        <h1 class="text-center">Account Verification</h1>
        <p class="text-center">
            <asp:Label ID="Msg" runat="server" Text=""></asp:Label>
        </p>
        <div class="d-flex w-100 justify-content-center">
            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-primary" NavigateUrl="~/Login.aspx">Login</asp:HyperLink>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
