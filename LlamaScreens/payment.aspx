<%@ Page Language="C#" MasterPageFile="~/bookingHeader.Master" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="LlamaScreens.payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="CSS/payment.css" type="text/css" />
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>"></asp:SqlDataSource>

    <asp:Panel runat="server" CssClass="step-container">
        <asp:Panel runat="server" CssClass="col text-center">
            <asp:Panel runat="server" CssClass="step completed">
                <asp:Panel runat="server" CssClass="seat occupied mx-auto"></asp:Panel>
                <p>1 Select seats</p>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel runat="server" CssClass="step-line">></asp:Panel>
        <asp:Panel runat="server" CssClass="col text-center">
            <asp:Panel runat="server" CssClass="step completed">
                <span><i class="fa fa-credit-card" style="font-size: 36px"></i></span>
                <p>2 Payment</p>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel runat="server" CssClass="step-line">></asp:Panel>
        <asp:Panel runat="server" CssClass="col text-center">
            <asp:Panel runat="server" CssClass="step" Style="color: #808080;">
                <span><i class="fa fa-check-circle" style="font-size: 36px"></i></span>
                <p>3 Confirmation</p>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel runat="server" CssClass="container">
        <asp:Panel runat="server" CssClass="row">
            <asp:Panel runat="server" CssClass="col-lg-6 pt-4">
                <asp:Panel runat="server" CssClass="booking-details container pt-5">
                    <asp:Panel runat="server" CssClass="card bg-dark border-0 text-light ">
                        <asp:Panel runat="server" CssClass="card-body">
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Movie</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text"><%= Session["movieTitle"] %></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Date</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text"><%= Session["date"] %></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Time</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text"><%= Session["time"] %></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Seats</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text">
                                        <asp:Label runat="server" CssClass="card-text" ID="seats" Text=""></asp:Label></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Adults</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text">
                                        <asp:Label runat="server" CssClass="card-text" ID="adultCount" Text="0.00"></asp:Label></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Senior/OKU</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text">
                                        <asp:Label runat="server" CssClass="card-text" ID="seniorCount" Text="0.00"></asp:Label></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Children</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    <p class="card-text">
                                        <asp:Label runat="server" CssClass="card-text" ID="childCount" Text="0.00"></asp:Label></p>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row">
                                <asp:Panel runat="server" CssClass="col-5 border-end" ID="discountPanelMsg">
                                    <p class="card-text">Total</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col-5 border-end" Visible="false" ID="discountPanelMsg2">
                                    <p class="card-text">Sub Total</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    RM
                                    <asp:Label runat="server" CssClass="card-text" ID="lblTotal" Text="0.00"></asp:Label>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row" ID="discountPanel" Visible="false">
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Point Discount</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    RM
                                    <asp:Label runat="server" CssClass="card-text" ID="lblDiscount" Text="0.00"></asp:Label>
                                </asp:Panel>
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="row" ID="discountPanel2" Visible="false"> 
                                <asp:Panel runat="server" CssClass="col-5 border-end">
                                    <p class="card-text">Total</p>
                                </asp:Panel>
                                <asp:Panel runat="server" CssClass="col ps-3">
                                    RM
                                    <asp:Label runat="server" CssClass="card-text" ID="lblTrueTotal" Text="0.00"></asp:Label>
                                </asp:Panel>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel runat="server" CssClass="col-lg-6">
                <asp:Panel runat="server" CssClass="payment-options container py-5 text-white">
                    <p class="text-center mb-4">We accept payment from:</p>
                    <asp:Panel runat="server" CssClass="row mx-auto" Style="width: fit-content;">
                        <asp:Panel runat="server" CssClass="col-6">
                            <asp:Panel runat="server" CssClass="card bg-white border-light px-5 py-3 d-flex align-items-center justify-content-center" Style="height: 70px;">
                                <asp:Image runat="server" ID="imgMastercard" ImageUrl="img/mc_logo.png" AlternateText="Mastercard" CssClass="logo-img" Style="width: auto; height: auto;" />
                            </asp:Panel>
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="col-6">
                            <asp:Panel runat="server" CssClass="card bg-white border-light px-5 py-3 d-flex align-items-center justify-content-center" Style="height: 70px;">
                                <asp:Image runat="server" ID="imgVisa" ImageUrl="img/visa_logo2.png" AlternateText="Visa" CssClass="logo-img" Style="width: auto; height: auto;" />
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                </asp:Panel>

                <asp:Panel runat="server" CssClass="carousel-test container">
                    <asp:Panel runat="server" CssClass="inv-card">
                        <asp:Panel runat="server" CssClass="card py-3 px-5 bg-transparent text-light mb-5">
                            <asp:Panel runat="server" CssClass="card-body position-relative px-3">
                                <asp:Panel runat="server" CssClass="card-side front">
                                    <asp:Panel runat="server" CssClass="visa pe-3 pt-3">
                                    </asp:Panel>
                                    <asp:Panel runat="server" CssClass="row pt-5">
                                        <asp:Panel runat="server" CssClass="col">
                                            <asp:TextBox runat="server" CssClass="card-number-input" ID="cardNumber" placeholder="**** **** **** ****"
                                                MinLength="19" MaxLength="19" name="card-number" oninput="checkFields();"></asp:TextBox>
                                        </asp:Panel>
                                    </asp:Panel>
                                    <asp:Panel runat="server" CssClass="row pt-3">
                                        <asp:Panel runat="server" CssClass="col">
                                            <asp:Image runat="server" ImageUrl="img/credit-card-chip.png" alt="chip" Width="50" />
                                        </asp:Panel>
                                    </asp:Panel>
                                    <asp:Panel runat="server" CssClass="row pt-2">
                                        <asp:Panel runat="server" CssClass="col-6">
                                            <asp:TextBox runat="server" CssClass="card-holder-input" ID="holderName" placeholder="Enter holder name" name="holder-name"></asp:TextBox>
                                        </asp:Panel>
                                        <asp:Panel runat="server" CssClass="col-3">
                                            <asp:TextBox runat="server" ID="exp" placeholder="MM/YY" Size="6" MinLength="5" MaxLength="5" name="exp"
                                                oninput="checkFields();"></asp:TextBox>
                                        </asp:Panel>
                                        <asp:Panel runat="server" CssClass="col-3 d-flex justify-content-end">
                                            <asp:TextBox runat="server" TextMode="Password" ID="cvv" placeholder="000" Size="1" MinLength="3" MaxLength="3" name="cvv"></asp:TextBox>
                                        </asp:Panel>
                                    </asp:Panel>
                                </asp:Panel>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                </asp:Panel>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>


    <asp:Panel runat="server" CssClass="buttons-container bg-dark text-center mt-4">
        <asp:Button ID="btnContinue" runat="server" Text="Continue" CssClass="btn btn-primary btn-lg me-2 mb-4 mt-3" Style="width: 150px;" OnClick="btnContinue_Click" Enabled="false" />
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger btn-lg mb-4 mt-3" OnClick="btnCancel_Click" Style="width: 150px; margin-left: 20px;" />
    </asp:Panel>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $(document).ready(function () {
            var cardNum = $('[id$=cardNumber]');
            var expDate = $('[id$=exp]');

            var emptyImg = '<div class="visa pe-3 pt-3"><img src="/" alt="" width="70" class="logo-img"></div>';
            var visaImg = '<div class="visa pe-3 pt-3"><img src="img/visa_logo2.png" alt="VISA" width="70" height="30" class="logo-img"></div>';
            var mastercardImg = '<div class="visa pe-3 pt-3"><img src="img/mc_logo.png" alt="Mastercard" width="70" height="50" class="logo-img"></div>';

            cardNum.on('input', function (e) {
                var sanitizedValue = this.value.replace(/[^0-9]/gi, '');

                // Check if input is empty
                if (sanitizedValue === '') {
                    $('.visa').replaceWith(emptyImg); // Display default Visa image
                    return;
                }

                // Check the first digit to determine the card type
                var firstDigit = sanitizedValue.charAt(0);

                // Determine the card type based on the first digit
                var cardType = getCardType(firstDigit);

                // Replace the card image in the template
                var cardImage;
                if (cardType === 'mastercard') {
                    cardImage = mastercardImg;
                } else if (cardType === 'visa') {
                    cardImage = visaImg;
                } else {
                    cardImage = emptyImg;
                }
                $('.visa').replaceWith(cardImage);

                // Format the card number with spaces
                var formattedValue = sanitizedValue.replace(/(\d{4})/g, '$1 ').trim();
                this.value = formattedValue;
            });

            expDate.on('keyup', function (e) {
                if (this.value == this.lastValue) return;
                var caretPosition = this.selectionStart;
                var sanitizedValue = this.value.replace(/[^0-9]/gi, '');
                var parts = [];
                for (var i = 0, len = sanitizedValue.length; i < len; i += 2) {
                    parts.push(sanitizedValue.substring(i, i + 2));
                }
                for (var i = caretPosition - 1; i >= 0; i--) {
                    var c = this.value[i];
                    if (c < '0' || c > '9') {
                        caretPosition--;
                    }
                }
                caretPosition += Math.floor(caretPosition / 2);
                this.value = this.lastValue = parts.join('/');
                this.selectionStart = this.selectionEnd = caretPosition;
            });

            function getCardType(firstDigit) {
                // Implement logic to determine the card type based on the first digit
                // For simplicity, let's assume Visa starts with 4, Mastercard starts with 5
                if (firstDigit === '4') {
                    return 'visa';
                } else if (firstDigit === '5') {
                    return 'mastercard';
                } else {
                    return 'other';
                }
                // Add more conditions for other card types if needed
            }

        });

        function checkFields() {
            var cardNumberValue = document.getElementById('<%= cardNumber.ClientID %>').value.trim();
            var expDateValue = document.getElementById('<%= exp.ClientID %>').value.trim();
            var btnContinue = document.getElementById('<%= btnContinue.ClientID %>');

            if (cardNumberValue !== '' && expDateValue !== '') {
                btnContinue.disabled = false;
            } else {
                btnContinue.disabled = true;
            }
        }

        function updateCardLogos(cardNum) {
            var firstDigit = cardNum.charAt(0);

            var cardType = getCardType(firstDigit);

            var cardImage;
            if (cardType === 'mastercard') {
                cardImage = '<div class="visa pe-3 pt-3"><img src="img/mc_logo.png" alt="Mastercard" width="70" height="50" class="logo-img"></div>';
            } else if (cardType === 'visa') {
                cardImage = '<div class="visa pe-3 pt-3"><img src="img/visa_logo2.png" alt="Visa" width="70" height="30" class="logo-img"></div>';
            } else {
                cardImage = '<div class="visa pe-3 pt-3"><img src="/" alt="" width="70" class="logo-img"></div>';
            }

            $('.visa').replaceWith(cardImage);
        }

        function getCardType(firstDigit) {
            if (firstDigit === '4') {
                return 'visa';
            } else if (firstDigit === '5') {
                return 'mastercard';
            } else {
                return 'other';
            }
        }

        // Function to handle actions on page load or when the error occurs
        function handlePageLoadOrError() {
            var cardNum = document.getElementById('<%= cardNumber.ClientID %>').value.trim();
            if (cardNum !== '') {
                updateCardLogos(cardNum);
            }
        }

        // Call the handlePageLoadOrError function when the document is ready
        $(document).ready(function () {
            handlePageLoadOrError();
        });

        // Create a Stripe instance with your publishable API key
        var stripe = Stripe('pk_test_51OPI6AHnuyridiIuz0gvlktR63muo7p3r6d5kOsuTIrgn0QA5J72H0LmsHTuUx1giK6gpvXjUBvrAbVG02MzH37F00Yf06cCJe');

        // Create an instance of elements
        var elements = stripe.elements();

        // Create an instance of the card Element
        var card = elements.create('card');

        // Mount the card Element to the DOM
        card.mount('#card-element');

        // Handle form submission
        var form = document.getElementById('payment-form');
        form.addEventListener('submit', function (event) {
            event.preventDefault();

            stripe.createToken(card).then(function (result) {
                if (result.error) {
                    // Display error to the user
                    alert(result.error.message);
                } else {
                    // Send the token to your server
                    fetch('/your-server-side-endpoint', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ token: result.token.id })
                    }).then(function (response) {
                        // Handle server response
                    });
                }
            });
        });
    </script>

</asp:Content>