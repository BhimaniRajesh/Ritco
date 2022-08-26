function ShowProgressBar() {
    $('#Progress_Bar').show();
    $('#div_Container').prop('disabled', true);
}
function HideProgressBar() {
    $('#Progress_Bar').hide();
    $('#div_Container').prop('disabled', false);
}