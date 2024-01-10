<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AddAdmin.aspx.cs" Inherits="LlamaScreens.Admin.AddAdmin" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            .main-content-wrap {
                display: flex;
                padding: 10px;
                height: 100%;
                flex-direction: column;
            }

            .input-wrap {
                position: relative;
                margin-top: 30px;
                display: flex;
            }

            .input-container {
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .inputbox {
                flex: 1;
            }

            .create-btn-wrap {
                display: flex;
                margin-top: 20px;
            }

            .create-btn-wrap .btn {
                flex: 1;
            }

            .role-select-wrap {
                margin-top: 20px;
            }

            .role-select-title {
                font-weight: 700;
                color: rgba(0, 0, 0, 0.5);
                opacity: 0.5;
                transition: all 0.2s;
                padding: 0 10px;
                margin: 0;
            }

            .role-select-box {
                padding: 10px;
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }

            .role-select-wrap:hover .role-select-title {
                opacity: 1;
            }

            .role-radio{
                display: none;
            }

            .role-radio + label{
                padding: 5px;
                border-radius: 5px;
                border: 1px solid rgba(0, 0, 0, 0.3);
                min-width: 150px;
                text-align: center;
                font-weight: 600;
                color: rgba(0, 0, 0, 0.7);
                transition: all 0.2s;
                opacity: 0.5;
            }

            .role-radio + label:hover{
                opacity: 1;
            }

            .role-radio:checked + label{
                opacity: 0.6;
                border: 1px solid var(--admin-active-color);
                color: var(--admin-active-color);
            }

            .err-msg{
                color: var(--admin-active-color);
            }

        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div style="display: flex; flex-direction: column; flex-grow: 1; position: relative; padding: 0;">
            <div class="main-content-wrap down">
                <div class="input-container flex-column">
                    <div class="input-wrap">
                        <input id="titleInput" class="inputbox down" type="text" name="nameInput"
                            placeholder="" required title="Fill In Username">
                        <label for="titleInput">Username</label>
                    </div>
                    <asp:Label ID="Username_ErrMsg" CssClass="err-msg" runat="server"></asp:Label>
                    <div class="input-wrap">
                        <input id="emailInput" class="inputbox down" type="text" name="emailInput"
                            placeholder="example@gmail.com" required title="Fill In Email">
                        <label for="emailInput">Email</label>
                    </div>
                        <asp:Label ID="Email_ErrMsg" CssClass="err-msg" runat="server"></asp:Label>
                    <div class="input-wrap">
                        <input id="passwordInput" class="inputbox down" type="text" name="passwordInput"
                            placeholder="********" required title="Fill In Password">
                        <label for="passwordInput">Password</label>
                    </div>
                        <asp:Label ID="Password_ErrMsg" CssClass="err-msg" runat="server"></asp:Label>
                    <div class="role-select-wrap">
                        <p class="role-select-title">Select A Role</p>
                        <div class="role-select-box down">
                            <div class="role-box">
                                <input type="radio" name="role" id="role-radio1" class="role-radio" value="Ticket Checker">
                                <label for="role-radio1">Ticket Checker</label>
                            </div>
                            <div class="role-box">
                                <input type="radio" name="role" id="role-radio2" class="role-radio" value="Admin">
                                <label for="role-radio2">Admin</label>
                            </div>
                            <div class="role-box">

                                <input type="radio" name="role" id="role-radio3" class="role-radio" value="Manager">
                                <label for="role-radio3">Manager</label>
                            </div>
                        </div>
                        <asp:Label ID="Role_ErrMsg" CssClass="err-msg" runat="server"></asp:Label>
                    </div>
                    <div class="create-btn-wrap">
                        <button class="btn up hover-moreup active-down">Create Admin</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
    </asp:Content>