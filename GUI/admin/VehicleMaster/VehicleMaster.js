
var txtRegisteredState, hdnRegisteredState;

$(document).ready(function () {
    $('#aspnetForm').attr("enctype", "multipart/form-data");
    IntializeControls();
    AutoCompleteByAjax(txtRegisteredState, serviceUrl + "/GetState", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnRegisteredState.attr('id'), 'Invalid State.');
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
});
function EndRequestHandler(sender, args) {
    IntializeControls();
    AutoCompleteByAjax(txtRegisteredState, serviceUrl + "/GetState", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnRegisteredState.attr('id'), 'Invalid State.');
}
function IntializeControls() {
    txtRegisteredState = $("#" + controlIdPrefix + "txtRegisteredState");
    hdnRegisteredState = $("#" + controlIdPrefix + "hdnRegisteredState");

    
}


var txtRegisteredState;
function IsStateExist(obj) {
    var id = $(obj).attr('id');
    txtRegisteredState = obj;
    if (obj.value != "") {
        if (hdnRegisteredState.val() == "") {
            var url = serviceUrl + "/IsStateExist";
            var strdata = "{\"StateCode\":\"" + obj.value + "\"}";
            AjaxRequestWithPostAndJson(url, strdata, checkStateSuccess, errorFunction, false);
        }
        else {

        }
    }
    else {
        return true;
    }
}

function checkStateSuccess(data) {
    if (data.IsStateExistResult.length > 0) {
        $.each(data.IsStateExistResult, function () {
            if (this['IsStateExist'] == "True") {
                hdnRegisteredState.val(this['StateCode']);
            }
            else {
                txtRegisteredState.value = "";
                txtRegisteredState.focus();
                alert("Invalid State.");
                return false;
            }
        });

        return true;
    }
    else {
        txtRegisteredState.value = "";
        txtRegisteredState.focus();
        alert("Invalid State.");
        return false;
    }

}

