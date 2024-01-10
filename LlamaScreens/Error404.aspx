<%@ Page Title="" Language="C#" MasterPageFile="~/template.Master" AutoEventWireup="true" CodeBehind="Error404.aspx.cs" Inherits="LlamaScreens.Error404" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .wrap{
            display: flex;
            padding: 40px;
            flex-direction: column;
            align-items: center;
        }

        .wrap{
            color: white;
            opacity: 0.8;
        }

        .btn{
            background: transparent;
            outline: none;
            border: 2px solid #a479cf;
            color: #a479cf;
            font-weight: 700;
            transition: all 0.2s;
            margin-top:30px;
        }

        .btn:hover{
            filter: drop-shadow(-1px -1px 1px #a479cf70) drop-shadow(1px 1px 1px #00000070);
            
            border: 2px solid #a479cf;
            color: #a479cf;
        }

        h1,h6{
            margin: 0;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="wrap">
        <div style="background-image: radial-gradient(circle, transparent 0%, #343a40 70%), url(https://th.bing.com/th/id/OIG.XblpgKDHryXPJXOwD55L?pid=ImgGn); width: 400px; height: 400px; background-size: cover; border-radius: 50%;" id="select-time-img">
                                </div>
        <h1>404 - Page Not Found</h1>
        <h6>Sorry the page you looking for is not available</h6>
        <asp:Button ID="BackButton" runat="server" Text="Back To Main Page" cssClass="btn" OnClick="Back_Click"/>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
