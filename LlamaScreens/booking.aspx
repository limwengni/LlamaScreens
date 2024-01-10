<%@ Page Language="C#" MasterPageFile="~/bookingHeader.Master" AutoEventWireup="true" CodeBehind="booking.aspx.cs"
    Inherits="LlamaScreens.booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="CSS/booking.css" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>

    <!-- Add an overlay element -->
    <div id="overlay"></div>

    <!-- Popup container -->
    <div id="popup" class="popup-container">
        <!-- Content for seat selection -->
        <div class="popup-header">
            <h2 class="popup-title">Select Seats</h2>
            <button class="close-btn" onclick="closePopOut()"></button>
        </div>

        <div class="seat-container">
            <div class="seat-info">
                <div class="seat-category">
                    <div class="category-name">
                        <label for="childSeats">Child</label>
                    </div>
                    <div class="category-price">
                        RM
                            <asp:Label runat="server" ID="lblChildPrice">0.00</asp:Label>
                    </div>
                </div>
                <div class="quantity-controls">
                    <button class="decrement btn btn-danger">-</button>
                    <input type="number" id="childSeats" value="0" style="text-align: center;" readonly>
                    <button class="increment btn btn-primary">+</button>
                </div>
            </div>
            <div class="seat-info">
                <div class="seat-category">
                    <div class="category-name">
                        <label for="adultSeats">Adult</label>
                    </div>
                    <div class="category-price">
                        RM
                            <asp:Label runat="server" ID="lblAdultPrice">0.00</asp:Label>
                    </div>
                </div>
                <div class="quantity-controls">
                    <button class="decrement btn btn-danger">-</button>
                    <input type="number" id="adultSeats" value="0" style="text-align: center;" readonly>
                    <button class="increment btn btn-primary">+</button>
                </div>
            </div>

            <div class="seat-info">
                <div class="seat-category">
                    <div class="category-name">
                        <label for="seniorSeats">Senior/OKU</label>
                    </div>
                    <div class="category-price">
                        RM
                            <asp:Label runat="server" ID="lblSeniorPrice">0.00</asp:Label>
                    </div>
                </div>
                <div class="quantity-controls">
                    <button class="decrement btn btn-danger">-</button>
                    <input type="number" id="seniorSeats" value="0" style="text-align: center;" readonly>
                    <button class="increment btn btn-primary">+</button>
                </div>
            </div>

            <div class="seat-info">
                <div class="seat-category">
                    <div style="font-size: 35px;">Total</div>
                </div>
                <div class="quantity-controls" style="font-size: 35px;">
                    <div style="margin-left: 30px;">
                        RM
                            <asp:Label runat="server" ID="lblTotal">0.00</asp:Label>
                    </div>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hfChildSeats" runat="server" />
        <asp:HiddenField ID="hfAdultSeats" runat="server" />
        <asp:HiddenField ID="hfSeniorSeats" runat="server" />

        <div style="text-align: center;">
            <asp:Button ID="btnContinue" runat="server" Text="Continue"
                CssClass="btn btn-primary btn-lg me-2 mb-4 mt-3" Style="width: 150px; margin: 0 auto;"
                OnClick="btnContinue_Click" Enabled="false" />
        </div>
    </div>




    <div class="all-container">
        <div class="step-container">
            <div class="col text-center">
                <div class="step">
                    <div class="seat occupied mx-auto" style="height: 30px; width: 35px; margin: 3px; border-top-left-radius: 10px; border-top-right-radius: 10px;"></div>
                    <p>1 Select seats</p>
                </div>
            </div>
            <div class="step-line">></div>
            <div class="col text-center">
                <div class="step" style="color: #808080;">
                    <span><i class="fa fa-credit-card" style="font-size: 36px"></i></span>
                    <p>2 Payment</p>
                </div>
            </div>
            <div class="step-line">></div>
            <div class="col text-center">
                <div class="step" style="color: #808080;">
                    <span><i class="fa fa-check-circle" style="font-size: 36px"></i></span>
                    <p>3 Confirmation</p>
                </div>
            </div>
        </div>

        <div class="movie-container">

            <%--            <asp:Label ID="defaultPrice" runat="server"></asp:Label>--%>

            <div style="color: white; height: 40px">
                <span id="selectedSeatsDisplay" style="display: none; text-align: right;">Selected Seats :</span>
            </div>

            <ul class="showcase">
                <li>
                    <div class="seat"></div>
                    <small>Available</small>
                </li>
                <li>
                    <div class="seat selected"></div>
                    <small>Selected</small>
                </li>
                <li>
                    <div class="seat occupied"></div>
                    <small>Occupied</small>
                </li>
                <li>
                    <div class="seat show-invalid"></div>
                    <small>Invalid</small>
                </li>
            </ul>

            <div style="color: white; margin: 5px 0; display: flex; flex-direction: column;">
                <span style="text-align: center; font-size: 0.5em;">Select Your
                        Seats</span>
                <asp:HiddenField ID="hfSelectedSeatsDisplay" runat="server" />
                <span
                    style="text-align: center; font-size: 0.6em; font-weight: 600;">Atleast 3 Gap for seperated
                        Seats is required !</span>
            </div>

            <div class="container position-relative">
                <div class="venue-type-seat-map-wrap">
                   <input type="hidden" id="venueSeatMapDetailInput" class="venue-seat-map-detail" value="<%= getSeatDetail() %>""/>
                </div>
            </div>
        </div>

        <div class="card-wrap">
            <div class="card-body">
                <div>
                    <span>Seats :</span>
                    <span id="count">0</span>
                    <asp:HiddenField ID="allSeatNo" runat="server" />
                </div>

            </div>
        </div>

        <div class="buttons-container bg-dark text-center mt-4">
            <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn btn-primary btn-lg me-2 mb-4 mt-3"
                Style="width: 150px;" Enabled="False" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger btn-lg mb-4 mt-3"
                OnClick="btnCancel_Click" Style="width: 150px; margin-left: 20px;" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>

<asp:Content ID="scripts" ContentPlaceHolderID="scripts" runat="server">
    <script src="../JS/seat-map.js"></script>
    <script>

        function updateSeatStatus(selectedSeat, occupiedSeat) {
            $(`span.occupied`).removeClass('occupied');
            occupiedSeat.forEach(seatID => {
                $(`span[data-id="${seatID}"]`).addClass('occupied');
            });

            $(`span.selected`).removeClass('selected');
            selectedSeat.forEach(seatID => {
                $(`span[data-id="${seatID}"]`).addClass('selected');
            });
        }

        function checkRowExist(arr, currRow) {
            return Object.keys(arr).some(key => key === currRow);
        }

        function checkGaps(arr, currRow) {
            if (arr.length > 1) {
                var count = 0;
                var maxValue = Math.max(...arr);
                var minValue = Math.min(...arr);
                var currGap = 0;
                for (let i = minValue + 1; i < maxValue; i++) {
                    if (arr.includes(i) || occupiedSeat.indexOf(currRow + i) !== -1) {
                        if (currGap < 3 && currGap > 0) {
                            return false;
                        } else {
                            currGap = 0;
                        }
                    } else {
                        currGap++;
                    }
                }

                if (currGap < 3 && currGap > 0) {
                    return false;
                }
            }
            return true;
        }


        function covertToSelectedSeat(selectedSeatDetail) {
            selectedSeat = [];
            var valueStr = "";
            for (key in selectedSeatDetail) {
                selectedSeatDetail[key].forEach(value => {
                    selectedSeat.push(key + value);
                    valueStr += key + value + ',';
                });
            }
            valueStr = valueStr.slice(0, -1);
            $('#<%= allSeatNo.ClientID %>').val(valueStr);
        }

        function checkValid() {
            for (key in selectedSeatDetail) {
                if (!checkGaps(selectedSeatDetail[key], key)) {
                    return false;
                }
            }
            return true;
        }

        function removeSeat(row, col) {
            selectedSeatDetail[row] = removeItemOnce(selectedSeatDetail[row], col);
        }

        function removeItemOnce(arr, value) {
            var index = arr.indexOf(value);
            if (index > -1) {
                arr.splice(index, 1);
            }
            return arr;
        }


        var occupiedSeat = "<%= getOccupiedSeat() %>";
        occupiedSeat = occupiedSeat.split(',');
        var selectedSeat = [];
        var selectedSeatDetail = {};

        updateSeatMap();
        updateSeatStatus(selectedSeat, occupiedSeat);


        $('.seat-col span').click(function () {
            if (!$(this).hasClass('selected') && !$(this).hasClass('occupied')) {
                if (checkRowExist(selectedSeatDetail, $(this).data('row'))) {
                    selectedSeatDetail[$(this).data('row')].push($(this).data('col'));
                } else {
                    selectedSeatDetail[$(this).data('row')] = [$(this).data('col')];
                }
            } else {
                $(this).removeClass('show-invalid');
                $(this).removeClass('selected');
                removeSeat($(this).data('row'), $(this).data('col'));
            }
            covertToSelectedSeat(selectedSeatDetail);
            updateSeatStatus(selectedSeat, occupiedSeat);
            $('#count').html(selectedSeat.length);
            if (checkValid()) {
                $('.venue-type-seat-map-wrap .show-invalid').removeClass('show-invalid');
                $('#<%= btnNext.ClientID %>').prop('disabled', false);
            } else {
                $('.venue-type-seat-map-wrap .selected').addClass('show-invalid');
                $('#<%= btnNext.ClientID %>').prop('disabled', true);
            }

            if (selectedSeat.length == 0) {
                $('#<%= btnNext.ClientID %>').prop('disabled', true);
            }

            updateSelectedCount();
        });

        const container = document.querySelector('.container');
        const seats = document.querySelectorAll('.seat-row span:not(.occupied)');
        const count = document.getElementById('count');
        const lblChildPrice = document.getElementById('<%= lblChildPrice.ClientID %>');
        const lblAdultPrice = document.getElementById('<%= lblAdultPrice.ClientID %>');
        const lblSeniorPrice = document.getElementById('<%= lblSeniorPrice.ClientID %>');
        const total = document.getElementById('<%= lblTotal.ClientID %>');
        const selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');

        //*******************need to change later***********************
        // set price here
        var defaultPrice = parseFloat('<%= Session["defaultPrice"] %>');
        var formattedPrice = defaultPrice.toFixed(2);
        let ticketPrice = formattedPrice;
        //*******************need to change later***********************

        var btnNext = document.getElementById('<%= btnNext.ClientID %>');
        var btnContinue = document.getElementById('<%= btnContinue.ClientID %>');

        document.getElementById('<%= hfChildSeats.ClientID %>').value = 0;
        document.getElementById('<%= hfAdultSeats.ClientID %>').value = 0;
        document.getElementById('<%= hfSeniorSeats.ClientID %>').value = 0;

        var childPrice = ticketPrice * 40 / 100; //6.0
        var adultPrice = ticketPrice * 100 / 100;  //15.0
        var seniorPrice = ticketPrice * 70 / 100; //10.5

        lblChildPrice.innerText = childPrice.toFixed(2);
        lblAdultPrice.innerText = adultPrice.toFixed(2);
        lblSeniorPrice.innerText = seniorPrice.toFixed(2);

        function updateSelectedCount() {
            const selectedSeats = document.querySelectorAll('.seat-row .selected');
            const selectedSeatsCount = selectedSeats.length;

            var childCount = parseInt(document.getElementById('childSeats').value);
            var adultCount = parseInt(document.getElementById('adultSeats').value);
            var seniorCount = parseInt(document.getElementById('seniorSeats').value);

            var childPrice = ticketPrice * 40 / 100; //6.0
            var adultPrice = ticketPrice * 100 / 100;  //15.0
            var seniorPrice = ticketPrice * 70 / 100; //10.5

            var totalPrice = (childCount * childPrice) + (adultCount * adultPrice) + (seniorCount * seniorPrice);

            count.innerText = selectedSeatsCount;
            total.innerText = totalPrice.toFixed(2);

            document.getElementById('<%= hfChildSeats.ClientID %>').value = childCount;
            document.getElementById('<%= hfAdultSeats.ClientID %>').value = adultCount;
            document.getElementById('<%= hfSeniorSeats.ClientID %>').value = seniorCount;


        }



        document.getElementById('<%= btnNext.ClientID %>').addEventListener('click', function () {
            event.preventDefault();
            document.getElementById('popup').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';

            // Disable scrolling on the background page
            document.body.style.overflow = 'hidden';
        });

        function closePopOut() {
            event.preventDefault();
            document.getElementById('popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';

            // Disable scrolling on the background page
            document.body.style.overflow = 'auto';
        }

        function updateDecrementButton(inputField) {
            const decrementButton = inputField.parentElement.querySelector('.decrement');
            const currentValue = parseInt(inputField.value);

            if (currentValue === 0) {
                decrementButton.disabled = true;
            } else {
                decrementButton.disabled = false;
            }
        }

        function decrementSeats(inputField) {
            const currentValue = parseInt(inputField.value);
            if (currentValue > 0) {
                inputField.value = currentValue - 1;
            }
            validateSeatCounts();
            updateSelectedCount();
            updateDecrementButton(inputField);
        }

        function incrementSeats(inputField) {
            const currentValue = parseInt(inputField.value);
            const seatType = inputField.id;
            inputField.value = currentValue + 1;
            if (validateSeatCounts()) {
                updateSelectedCount();
                updateDecrementButton(inputField);
            } else {
                inputField.value = currentValue;
            }
            // Add handling for seat count validation error here if needed
        }

        function validateSeatCounts() {
            var childCount = parseInt(document.getElementById('childSeats').value);
            var adultCount = parseInt(document.getElementById('adultSeats').value);
            var seniorCount = parseInt(document.getElementById('seniorSeats').value);

            var selectedSeatsCount = document.querySelectorAll('.seat-row .selected').length;

            // Calculate the total seats chosen
            var totalChosenSeats = childCount + adultCount + seniorCount;
            // Ensure that the total chosen seats do not exceed the total selected seats
            if (totalChosenSeats > selectedSeatsCount) {
                window.alert("The total number of child, adult, and senior seats cannot exceed the total selected seats.");
                return false; // Return false if validation fails
            }
            console.log(totalChosenSeats);
            // Disable button if the total chosen seats is less than the total selected seats
            if (totalChosenSeats < selectedSeatsCount) {
                btnContinue.disabled = true;
            } else {
                btnContinue.disabled = false;
            }

            return true; // Return true if validation passes
        }



        // Event listeners for increment and decrement buttons
        document.querySelectorAll('.increment').forEach(button => {
            button.addEventListener('click', function () {
                event.preventDefault();
                const inputField = this.parentNode.querySelector('input');
                incrementSeats(inputField);
            });
        });

        document.querySelectorAll('.decrement').forEach(button => {
            button.addEventListener('click', function () {
                event.preventDefault();
                const inputField = this.parentNode.querySelector('input');
                decrementSeats(inputField);
            });
        });

        // Disable all decrement buttons initially for inputs with 0 value
        document.querySelectorAll('.decrement').forEach(button => {
            const inputField = button.parentNode.querySelector('input');
            const currentValue = parseInt(inputField.value);
            if (currentValue === 0) {
                button.disabled = true;
            }
        });






    </script>
</asp:Content>
