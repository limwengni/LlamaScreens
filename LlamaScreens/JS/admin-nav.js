function resetPhoneNav() {
    var screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

    if (screenWidth < 768) {
        $('#sidebar-nav').addClass("phone-nav");
    } else {
        $('#sidebar-nav').removeClass("phone-nav");
        $('#sidebar-nav').removeClass("open");
        $('#sidebar-nav').removeClass("close");
        $('#toggle-checkbox').prop("checked", false);

    }
}

$(document).ready(function () {
    resetPhoneNav();
});

window.addEventListener('resize', resetPhoneNav);

$(".navigation-toggle").click(function () {
    if ($('#sidebar-nav').hasClass("open")) {
        $('#sidebar-nav').removeClass("open");
        $('#sidebar-nav').addClass("close");
    } else {
        $('#sidebar-nav').removeClass("close");
        $('#sidebar-nav').addClass("open");
        $('body').css('overflow', 'hidden');
    }
});