<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="AddVenueType.aspx.cs" Inherits="LlamaScreens.AddVenueType" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <style>
            .venue-type-card {
                display: flex;
                min-width: 300px;
                max-width: 380px;
                height: 420px;
                padding: 10px 20px;
                flex-direction: column;
                font-weight: 600;
                color: rgba(0, 0, 0, 0.4);
                text-align: center;
                transition: all 0.2s;
                user-select: none;
            }

            .venue-type-card:hover {
                color: rgba(0, 0, 0, 0.6);
            }

            .venue-type-seat-map {
                flex: 1;
                display: flex;
                margin: 10px 0;
                overflow: hidden;
                height: 110px;
                overflow-y: scroll;
                overflow-x: scroll;
                opacity: 0.8;
                transform: scale(97%);
                transition: all 0.2s;
            }

            .venue-type-seat-map:hover {
                transform: scale(100%);
            }

            .venue-type-card:hover .venue-type-seat-map {
                opacity: 1;
            }

            .venue-type-seat-map::-webkit-scrollbar {
                width: 0;
                height: 0;
            }

            .venue-type-name {
                font-size: 1em;
            }

            .venue-type-total-seat {
                margin-top: 5px;
                position: relative;
                font-size: 1.5em;
            }

            .venue-type-total-seat-label {
                position: absolute;
                font-size: 0.6rem;
                top: -6px;
                left: 50%;
                transform: translateX(-50%);
            }

            .venue-type-seat-map-wrap {
                display: flex;
                flex: 1;
                flex-direction: column;
                gap: 5px;
                align-items: center;
                justify-content: flex-start;
            }

            .seat-row {
                flex: 1;
                max-height: 12px;
                width: 100%;
                display: flex;
                gap: 12px;
                justify-content: center;
                align-items: center;
                padding: 0 0.8em;
            }

            .seat-row-alphabet {
                position: absolute;
                font-weight: 700;
                font-size: 0.7em;
                top: -0.2em;
                left: -1.1em;
                margin: 0;
                text-align: center;
                width: 12px;
                height: 12px;
            }

            .seat-col-number {
                position: absolute;
                font-weight: 700;
                font-size: 0.7em;
                bottom: -1.1em;
                left: 50%;
                transform: translateX(-50%);
                margin: 0;
                text-align: center;
                height: 12px;
                letter-spacing: -0.5px;
            }

            .seat-col {
                height: 100%;
                display: flex;
                gap: 4px;
                justify-content: center;
                align-items: center;
                position: relative;
            }

            .seat-col span {
                display: flex;
                width: 12px;
                height: 12px;
                background-color: rgba(250, 100, 100, 0.522);
                border-radius: 0.1px 0.1px 2px 2px;
                position: relative;
            }

            .seat-row-break {
                height: 6px;
                width: 80%;
                background-color: transparent;
            }

            .screen-row {
                width: 80%;
                padding-bottom: 20px;
                border-top: 10px solid rgba(0, 0, 0, 0.566);
                position: relative;
            }

            .screen-row p {
                font-size: 0.8em;
                position: absolute;
                top: -5px;
                left: 50%;
                transform: translateX(-50%);
            }

            .exit-row {
                height: 6px;
                width: 80%;
                margin-top: auto;
                box-sizing: content-box;
                padding-top: 12px;
                display: flex;
                justify-content: space-between;
            }

            .exit-row span {
                height: 4px;
                width: 20%;
                background-color: rgba(0, 126, 0, 0.757);
            }


            .input-wrap {
                margin-top: 15px;
                position: relative;
            }

            .main-content-wrap {
                margin-top: 20px;
                position: relative;
                padding: 10px 15px;
                display: flex;
                flex-wrap: wrap;
                justify-content: left;
                gap: 10px;
                align-content: baseline;
            }

            .main-content-wrap:hover .fake-label {
                color: rgba(0, 0, 0, 0.8);
            }

            .seat-design-input-wrap {
                padding: 10px;
                display: flex;
                flex-direction: column;
                gap: 10px;
                align-content: baseline;
                max-width: 400px;
                min-width: 300px;
                flex: 1;
            }

            .seat-design-input-wrap .input-wrap {
                max-width: 400px;
                flex: 1;
                max-height: 40px;
                display: flex;
            }

            .seat-design-input-wrap .inputbox {
                flex: 1;
                height: 30px;
                min-width: 200px;
            }

            .three-input-wrap {
                gap: 10px;
            }

            .three-input-wrap .inputbox {
                min-width: 70px;
            }

            .three-input-wrap>div {
                display: flex;
                flex: 1;
                min-width: 70px;
                position: relative;
            }

            .confirm-btn-wrap {
                margin-top: auto;
            }

            .confirm-btn-wrap .btn {
                width: 100%;
            }

            .seat-design-preview {
                flex: 1;
                max-width: 400px;
                min-width: 300px
            }

            .error-msg {
                font-size: 0.9em;
                font-weight: 600;
                color: rgb(255, 46, 46);
                margin: 0;
                padding: 0 5px;
            }
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
        <div style="display: flex; flex-direction: column; flex-grow: 1; padding: 0 0 10px 0;">
            <div class="main-content-wrap up">
                <p class="fake-label">Seat Design</p>
                <div class="seat-design-preview">
                    <div class="venue-type-content">
                        <div class="up hover-moreup venue-type-card">
                            <div class="venue-type-name">Venue Name</div>
                            <div class="venue-type-seat-map down">
                                <div class="venue-type-seat-map-wrap">
                                    <input type="hidden" class="venue-seat-map-detail" value="7,2,5,3" />
                                </div>
                            </div>
                            <div class="venue-type-total-seat">
                                <span class="venue-type-total-seat-label">Total Seat</span>
                                <span class="venue-type-total-seat-content">0</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="seat-design-input-wrap">
                    <div class="input-wrap no-input-wrap">
                        <input id="venueNameInput" class="inputbox down" type="text" name="venueNameInput"
                            placeholder="Name" required title="Fill In Venue Name" oninput="changeName()">
                        <label for="venueNameInput">Venue Name</label>
                    </div>
                    <div class="input-wrap">
                        <input id="venueRowInput" class="inputbox down" type="number" name="venueRowInput"
                            placeholder="Row Count" required title="Fill In Total Row" max="26" min="1"
                            oninput="changeSeatMap()">
                        <label for="venueRowInput">Row</label>
                    </div>
                    <div class="input-wrap three-input-wrap">
                        <div>
                            <input id="venueLeftInput" class="inputbox down" type="number" name="venueLeftInput"
                                placeholder="Count" required title="Fill In Seat On Left" min="1"
                                oninput="changeSeatMap()">
                            <label for="venueLeftInput">Left</label>
                        </div>
                        <div>
                            <input id="venueMiddleInput" class="inputbox down" type="number" name="venueMiddleInput"
                                placeholder="Count" required title="Fill In Seat On Midde" min="1"
                                oninput="changeSeatMap()">
                            <label for="venueMiddleInput">Middle</label>
                        </div>
                        <div>
                            <input id="venueRightInput" class="inputbox down" type="number" name="venueRightInput"
                                placeholder="Count" required title="Fill In Seat On Right" min="1"
                                oninput="changeSeatMap()">
                            <label for="venueRightInput">Right</label>
                        </div>
                    </div>
                    <asp:Label ID="ErrMsg" cssClass="error-msg" runat="server"></asp:Label>
                    <div class="confirm-btn-wrap">
                        <asp:button runat="server" ID="confirmBtn" class="btn up hover-moreup" text="Add Venue Type" OnCommand="confirmBtn_Command"
                            style="font-size: 0.8em;">
                        </asp:button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>
    <asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">
        <script src="../JS/seat-map.js"></script>
        <script>
            function changeSeatMap() {
                var row = parseInt($('#venueRowInput').val());
                var left = parseInt($('#venueLeftInput').val()) || 0;
                var middle = parseInt($('#venueMiddleInput').val()) || 0;
                var right = parseInt($('#venueRightInput').val()) || 0;
                var totalSeatPerRow = left + middle + right;

                var validMsg = '';
                if (row < 1 || row > 26 || isNaN(row)) {
                    validMsg = 'Sorry, Row must from 1 to 26 only'
                } else {
                    if (totalSeatPerRow > 99) {
                        validMsg = 'Sorry, Maximum Seat per Row is 99';
                    }
                }

                $('.error-msg').html(validMsg);
                if (validMsg == '') {
                    $('.venue-type-total-seat-content').html(totalSeatPerRow * row);
                    var seatMapWrap = $('.venue-type-seat-map-wrap');
                    $(seatMapWrap).html(createSeatMap([row, left, middle, right]));
                    updateSeatDetail(seatMapWrap);
                }
            }

            function changeName() {
                var name = $('#venueNameInput').val().trim();
                if (name == '') {
                    name = '&nbsp;';
                }
                $('.venue-type-name').html(name);
            }
        </script>
    </asp:Content>