<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MainAdmin.Master" AutoEventWireup="true"
    CodeBehind="Dashboard.aspx.cs" Inherits="LlamaScreens.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cardholder {
            gap: 2em;
        }

        .card {
            border-radius: 5px;
            border: none;
            min-width: 200px;
            background-color: var(--admin-bg);
            box-shadow: inset 0.3rem 0.3rem 0.6rem rgb(203, 199, 225), inset -0.2rem -0.2rem 0.5rem rgb(255, 255, 255);
            padding: 0;
            transition: all 0.2s;
        }

            .card:hover {
                box-shadow: inset 0.2rem 0.2rem 0.4rem rgb(203, 199, 225), inset -0.1rem -0.1rem 0.3rem rgb(255, 255, 255);
            }

        .card-icon {
            position: relative;
            width: 100px;
            aspect-ratio: 1;
            fill: white;
            transition: all 0.2s;
        }

        .card:hover .card-icon {
            fill: rgb(218, 210, 253);
            filter: drop-shadow(0.2rem 0.2rem 0.1rem rgb(203, 199, 225)) drop-shadow(-0.1rem -0.1rem 0.1rem rgb(255, 255, 255));
        }

        .icon-holder {
            margin-top: 20px;
        }

        .card-title {
            font-weight: 600;
            opacity: 0.6;
            text-align: center;
            transition: all 0.2s;
        }

        .card:hover .card-title {
            opacity: 0.8;
            text-shadow: 0.02rem 0.02rem 1px rgb(0, 0, 0, 0.6);
        }

        .card-text {
            position: relative;
            text-align: center;
            margin: auto;
            font-weight: 800;
            font-size: 1.5em;
            color: rgba(0, 0, 0, 0.324);
        }

        .maintext,
        .subtext {
            transition: all 0.2s;
        }

        .card:hover .maintext {
            opacity: 0.8;
            text-shadow: 0.02rem 0.02rem 1px rgb(0, 0, 0, 0.6);
        }

        .card:hover .subtext {
            color: rgba(0, 0, 0, 0.692);
            text-shadow: none;
        }

        .card > * {
            user-select: none;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: start;
        }

        .subtext {
            position: absolute;
            left: 100%;
            top: 50%;
            transform: translateY(-50%);
            font-size: 0.6em;
            font-weight: 600;
        }

        .text-holder {
            padding-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
            flex-direction: column;
        }

        .multitext-wrap .text-holder {
            max-width: 120px;
            margin-top: auto;
            padding: 0;
        }

        .multitext-wrap {
            padding: 0 10px;
            padding-top: 10px;
            display: flex;
            justify-content: center;
            margin-top: auto;
        }

        .multitext-inner-wrap {
            flex-grow: 1;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            max-width: 240px;
        }

            .multitext-inner-wrap .text-holder {
                padding: 0;
                max-width: 80px;
            }

        .upper-text {
            font-weight: 600;
            color: rgba(0, 0, 0, 0.324);
            margin: 0;
        }

        .multitext-title {
            padding: 0;
            font-weight: 600;
            color: rgba(0, 0, 0, 0.163);
            margin: 0;
            display: block;
            width: 100%;
            flex-grow: 2;
            text-align: center;
        }

        .graph-wrap {
            overflow-x: scroll;
            flex: 1;
            display: flex;
            flex-wrap: wrap;
            padding: 10px;
        }

            .graph-wrap canvas {
                flex: 1;
                min-width: 300px;
                max-width: 500px;
                min-height: 200px;
                max-height: 300px;
            }

        .graph {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">
    <div class="content container-fluid">
        <div class="row cardholder">
            <div class="col card" style="min-width: 200px;">
                <div class="card-body">
                    <h5 class="card-title">Total Member</h5>
                    <div class="icon-holder d-flex justify-content-center">
                        <svg class="card-icon">
                            <use xlink:href="#user"></use>
                        </svg>
                    </div>
                    <div class="text-holder">
                        <p class="card-text">
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT COUNT(CASE WHEN CONVERT(DATE, created_date) = CONVERT(DATE,GETDATE()) THEN 1 ELSE NULL END) AS total_member_today,  COUNT(CASE WHEN CONVERT(DATE, created_date) &lt; CONVERT(DATE,GETDATE()) THEN 1 ELSE NULL END) AS total_member FROM Member"></asp:SqlDataSource>
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <span class="maintext"><%# Eval("total_member") %></span><span class="subtext">+<%# Eval("total_member_today") %></span>
                                </ItemTemplate>
                            </asp:Repeater>
                        </p>
                    </div>
                </div>
            </div>

            <div class="col card" style="min-width: 280px;">
                <div class="card-body">
                    <h5 class="card-title">Movie</h5>
                    <div class="icon-holder d-flex justify-content-center">
                        <svg class="card-icon" style="width: 64px; height: 64px;">
                            <use xlink:href="#movieicon"></use>
                        </svg>
                    </div>
                    <div class="multitext-wrap">
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT COUNT(movie_id) AS total_movie, COUNT(CASE WHEN status = 'Coming Soon' THEN 1 ELSE NULL END) AS total_movie_upcoming, COUNT(CASE WHEN status = 'Now Showing' THEN 1 ELSE NULL END) AS total_movie_ongoing FROM Movie"></asp:SqlDataSource>
                        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                            <ItemTemplate>
                                <div class="text-holder">
                                    <p class="upper-text">Total</p>
                                    <p class="card-text"><span class="maintext"><%# Eval("total_movie") %></span></p>
                                </div>
                                <div class="multitext-inner-wrap">
                                    <div class="text-holder">
                                        <p class="upper-text">Ongoing</p>
                                        <p class="card-text"><span class="maintext"><%# Eval("total_movie_ongoing") %></span></p>
                                    </div>
                                    <div class="text-holder">
                                        <p class="upper-text">Upcoming</p>
                                        <p class="card-text"><span class="maintext"><%# Eval("total_movie_upcoming") %></span></p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <div class="col card" style="min-width: 220px;">
                <div class="card-body">
                    <h5 class="card-title">Venue</h5>
                    <div class="icon-holder d-flex justify-content-center">
                        <svg class="card-icon" style="width: 64px; height: 64px;">
                            <use xlink:href="#seat"></use>
                        </svg>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT COUNT(Venue.venue_id) AS total_venue, COUNT(Venue.venue_type_id) AS total_venue_type FROM Venue INNER JOIN VenueType ON Venue.venue_type_id = VenueType.venue_type_id"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource3">
                        <ItemTemplate>
                            <div class="multitext-wrap">
                                <div class="text-holder">
                                    <p class="upper-text">Total</p>
                                    <p class="card-text"><span class="maintext"><%# Eval("total_venue") %></span></p>
                                </div>
                                <div class="text-holder">
                                    <p class="upper-text">Venue Type</p>
                                    <p class="card-text"><span class="maintext"><%# Eval("total_venue_type") %></span></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="col card" style="min-width: 340px;">
                <div class="card-body">
                    <h5 class="card-title">Showtime</h5>
                    <div class="icon-holder d-flex justify-content-center">
                        <svg class="card-icon" style="width: 64px; height: 64px;">
                            <use xlink:href="#showtimeicon"></use>
                        </svg>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT COUNT(*) AS total_showtime, COUNT(CASE WHEN status = 'Finished' THEN 1 ELSE NULL END) AS total_showtime_finished, COUNT(CASE WHEN status = 'Available' AND CAST(showtime_date AS TIME) &lt;= CAST(GETDATE() AS TIME) AND CAST(showtime_date AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE NULL END) AS total_showtime_now_showing, COUNT(CASE WHEN status = 'Available' AND CAST(showtime_date AS TIME) &gt; CAST(GETDATE() AS TIME) AND CAST(showtime_date AS DATE) = CAST(GETDATE() AS DATE) THEN 1 ELSE NULL END) AS total_showtime_not_started FROM Showtime"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource4">
                        <ItemTemplate>
                            <div class="multitext-wrap">
                                <div class="text-holder">
                                    <p class="upper-text">Total</p>
                                    <p class="card-text"><span class="maintext"><%# Eval("total_showtime") %></span></p>
                                </div>
                                <div class="multitext-inner-wrap">
                                    <p class="multitext-title">Today Showtime</p>
                                    <div class="text-holder">
                                        <p class="upper-text">Finished</p>
                                        <p class="card-text"><span class="maintext"><%# Eval("total_showtime_finished") %></span></p>
                                    </div>
                                    <div class="text-holder">
                                        <p class="upper-text">Rolling</p>
                                        <p class="card-text"><span class="maintext"><%# Eval("total_showtime_now_showing") %></span></p>
                                    </div>
                                    <div class="text-holder">
                                        <p class="upper-text">Remaining</p>
                                        <p class="card-text"><span class="maintext"><%# Eval("total_showtime_not_started") %></span></p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="col card" style="min-width: 380px;">
                <div class="card-body">
                    <h5 class="card-title">Ticket</h5>
                    <div class="icon-holder d-flex justify-content-center">
                        <svg class="card-icon" style="width: 64px; height: 64px;">
                            <use xlink:href="#ticket"></use>
                        </svg>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:Llamadb %>" SelectCommand="SELECT
   COALESCE (
        (
            SELECT COUNT(ticket_id) FROM Ticket
        ),
0
   ) as total_sold,
    COALESCE (
        (
            SELECT SUM(VenueType.total_seat)
            FROM VenueType
            INNER JOIN Venue ON Venue.venue_type_id = VenueType.venue_type_id
            INNER JOIN Showtime ON Venue.venue_id = Showtime.venue_id
            WHERE CAST(Showtime.showtime_date AS DATE) = CAST(GETDATE() AS DATE)
        ),
        0
    ) AS total_seat_today,
    COALESCE (
        (
            SELECT COUNT(T.ticket_id)
            FROM Ticket AS T
            INNER JOIN Showtime ON T.showtime_id = Showtime.showtime_id
            WHERE T.status = 'Sold' AND CAST(Showtime.showtime_date AS DATE) = CAST(GETDATE() AS DATE)
        ), 
        0
    ) AS total_sold_today,
    COALESCE (
        (
            SELECT COUNT(T.ticket_id)
            FROM Ticket AS T
            INNER JOIN Showtime ON T.showtime_id = Showtime.showtime_id
            WHERE T.status &lt;&gt; 'Sold' AND CAST(Showtime.showtime_date AS DATE) = CAST(GETDATE() AS DATE)
        ),
        0
    ) AS total_not_sold_today;
"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater5" runat="server" DataSourceID="SqlDataSource5">
                        <ItemTemplate>
                            <div class="multitext-wrap">
                                <div class="text-holder">
                                    <p class="upper-text">Total Sold</p>
                                    <p class="card-text"><span class="maintext"><%# Eval("total_sold") %></span></p>
                                </div>
                                <div class="multitext-inner-wrap">
                                    <p class="multitext-title">Ticket Today</p>
                                    <div class="text-holder">
                                        <p class="upper-text">Generated</p>
                                        <p class="card-text">
                                            <span class="maintext"><%# Eval("total_seat_today") %></span>
                                        </p>
                                    </div>
                                    <div class="text-holder">
                                        <p class="upper-text">Available</p>
                                        <p class="card-text">
                                            <span class="maintext"><%# Eval("total_not_sold_today") %></span>
                                        </p>
                                    </div>
                                    <div class="text-holder">
                                        <p class="upper-text">Sold</p>
                                        <p class="card-text">
                                            <span class="maintext"><%# Eval("total_sold_today") %></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="graph-wrap down">
                <div class="graph">
                    <canvas id="transactionChart"></canvas>
                </div>
                <div class="graph">
                    <canvas id="transactionChart2"></canvas>
                </div>
                <div class="graph">
                    <canvas id="transactionChart3"></canvas>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="javascript" runat="server">

    <script>
        // Sample data for the graph (replace this with your actual data)
        var months = <%= SerializedLatestMonths %>;
        var totalAmounts = <%= SerializedTotalTransactionAmount %>;
        var totalAmounts2 = <%= SerializedTotalTicketSold %>;
        var totalAmounts3 = <%= SerializedTotalShowtimeCreated %>;

        // Get the canvas element
        var ctx = document.getElementById('transactionChart').getContext('2d');
        var ctx2 = document.getElementById('transactionChart2').getContext('2d');
        var ctx3 = document.getElementById('transactionChart3').getContext('2d');

        // Create the chart
        var transactionChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: 'Total Transaction Amount',
                    data: totalAmounts,
                    backgroundColor: 'rgb(139 ,0, 255, 0.5)',
                    borderColor: 'rgb(139 0 255)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Total Transaction Amount Over Months',
                        font: {
                            size: 18
                        }
                    }
                }
            }
        });

        var transactionChart2 = new Chart(ctx2, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: 'Total Ticket Sold',
                    data: totalAmounts2,
                    backgroundColor: 'rgb(139 ,0, 255, 0.5)',
                    borderColor: 'rgb(139 0 255)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Total Ticket Sold Over Months',
                        font: {
                            size: 18
                        }
                    }
                }
            }
        });

        var transactionChart3 = new Chart(ctx3, {
            type: 'line',
            data: {
                labels: months,
                datasets: [{
                    label: 'Total Showtime Created',
                    data: totalAmounts3,
                    backgroundColor: 'rgb(139 ,0, 255, 0.5)',
                    borderColor: 'rgb(139 0 255)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Total Showtime Created Over Months',
                        font: {
                            size: 18
                        }
                    }
                }
            }
        });
    </script>
</asp:Content>
