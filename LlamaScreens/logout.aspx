<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="LlamaScreens.Img.logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container pt-5">
        <div class="row">
            <div class="col-md-12">
                <div class="jumbotron text-light text-center">
                    <h1>Logged Out</h1>
                    <p>You have been logged out.</p>
                    <p><a href="main.aspx" class="btn btn-primary btn-lg">Back to Main Page</a></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
