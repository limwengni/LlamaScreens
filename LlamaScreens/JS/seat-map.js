function updateSeatDetail(element) {
    var currRow = 65;
    var allRow = $(element).find('.seat-row .seat-col:first-of-type');
    for (var i = 0; i < allRow.length; i++) {
        allRow.eq(i).append("<p class='seat-row-alphabet'>" + String.fromCharCode(currRow) + "</p>");
        currRow++;
    }

    var currCol = 1;
    var allLastSeat = $(element).find('.seat-row').eq(allRow.length - 1).find('span');
    for (var i = 0; i < allLastSeat.length; i++) {
        allLastSeat.eq(i).html("<p class='seat-col-number'>" + currCol + "</p>");
        currCol++;
    }
}

function addSeat(total,rowNo,colStart) {
    var seat = "";
    if (total > 0) {
        seat += `<div class="seat-col">`;
        for (var j = 0; j < total; j++) {
            seat += `<span data-row="${String.fromCharCode(rowNo)}" data-col="${colStart + 1}" data-id="${String.fromCharCode(rowNo)  + (colStart + 1)}"></span>`;
            colStart++;
        }
        seat += `</div>`;
    }
    return seat;
}

function createSeatMap(seatDetails) {
    var row = parseInt(seatDetails[0]);
    var left = parseInt(seatDetails[1]);
    var middle = parseInt(seatDetails[2]);
    var right = parseInt(seatDetails[3]);
    var seatMap = "";

    seatMap += `<div class="screen-row">
                    <p>Screen</p>
                </div>`;
    var currRow = 65;
    for (var i = 0; i < row; i++) {
        seatMap += `<div class="seat-row">`;
        seatMap += addSeat(left,currRow,0);
        seatMap += addSeat(middle,currRow,left);
        seatMap += addSeat(right,currRow,left + middle);
        seatMap += `</div>`;
        if ((i + 1) % 5 == 0) {
            seatMap += `<div class="seat-row-break"></div>`;
        }
        currRow++;
    }

    seatMap += `<div class="exit-row">
                    <span></span>
                    <span></span>
                </div>`;

    $('.venue-type-seat-map-wrap')

    return seatMap;
}

function updateSeatMap() {
    var seatMapWrap = $('.venue-type-seat-map-wrap');
    seatMapWrap.each(function (index, element) {
        var seatDetails = $(element).find('.venue-seat-map-detail');
        if (seatDetails.length > 0) {
            seatDetails = seatDetails.eq(0).val().split(',');
            $(element).html(createSeatMap(seatDetails));
            updateSeatDetail(element);
        }
    });
}