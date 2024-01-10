function fixStatus() {
    $('.statusbtn-glass').css('width', $('.custom-radio').width());
    var checked = $('.custom-radio input:checked').attr('id');
    if (checked === undefined) {
        checked = "content_radioButton1";
    }
    if (checked == "content_radioButton1") {
        $('.statusbtn-glass').css('left', '10px');
    } else if (checked == "content_radioButton2") {
        $('.statusbtn-glass').css('left', ($('.checked-label').width()) + 10 + 'px');
    } else if (checked == "content_radioButton3") {
        $('.statusbtn-glass').css('left', ($('.checked-label').width() * 2) + 10 + 'px');
    } else if (checked == "content_radioButton4") {
        $('.statusbtn-glass').css('left', ($('.checked-label').width() * 3) + 10 + 'px');
    } else {
        $('.statusbtn-glass').css('left', ($('.checked-label').width() * 4) + 10 + 'px');
    }
    $('label').removeClass('checked-label');
    $('label[for="' + checked + '"]').addClass('checked-label');
    
}

function statusChange() {
    $('label').removeClass('checked-label');
    $('.statusbtn-glass').css('width', $('.custom-radio').width());
    if ($(this).is(':checked')) {
        $('label[for="' + $(this).attr('id') + '"]').addClass('checked-label');
        if ($(this).attr('id') == "content_radioButton1") {
            $('.statusbtn-glass').css('left', '10px');
        } else if ($(this).attr('id') == "content_radioButton2") {
            $('.statusbtn-glass').css('left', ($('.statusbtn-glass').width()) + 10 + 'px');
        } else if ($(this).attr('id') == "content_radioButton3") {
            $('.statusbtn-glass').css('left', ($('.statusbtn-glass').width() * 2) + 10 + 'px');
        } else if ($(this).attr('id') == "content_radioButton4") {
            $('.statusbtn-glass').css('left', ($('.statusbtn-glass').width() * 3) + 10 + 'px');
        } else {
            $('.statusbtn-glass').css('left', ($('.statusbtn-glass').width() * 4) + 10 + 'px');
        }
    }
}

function fixTimeout(){
    setTimeout(fixStatus, 100);
}

// Set Default to All Status
$('label[for="content_radioButton1"]').addClass('checked-label');
fixStatus();

// Set Event Listener for status radio btn
$('.custom-radio input').change(statusChange);
$(window).on('resize', fixTimeout);
