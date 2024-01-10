// Search Icon Js

function fixIcon() {
    $('.search').each(function () {
        if ($(this).val().trim() !== '') {
            $(this).prev('.search-icon').hide();
        }
    });
}


$('.search').on('input', function () {
    var inputVal = $(this).val();
    var placeholder = $(this).attr('placeholder');

    if (inputVal !== '' || !placeholder) {
        $('.search-icon').hide();
    } else {
        $('.search-icon').show();
    }
});

function updateLabel() {
    var lblText = $('.searchmsg');
    var item = $('.tablecover .tablerow').length;
    if (item > 0) {
        $('.searchmsg').html("Showing " + item + " results for your search");
    } else {
        $('.searchmsg').html("No Result Found");
    }
    
}
setInterval(updateLabel, 100);

fixIcon();