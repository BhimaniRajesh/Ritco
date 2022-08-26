

$(document).ready(function () {
    //debugger;
    InitAutoComplete();
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

    function EndRequestHandler(sender, args) {
        InitAutoComplete();

    }
});
function onValidateLocationExist(e) {
    try {
        setTimeout(function () {
            CurrentControlId = $(e); CurrentHiddenControlId = $(e).parent().find("input[type=hidden]");
            if (CurrentControlId.val().trim() != "") {
                var jData = {};
                jData["LocationName"] = CurrentHiddenControlId.val().trim();
                ExecuteAjax(serviceUrl + "/ValidateLocationExist", jData, function (result) {
                    var data = JSON.parse(result.d)[0];
                    if (data.IsExist == false) {
                        CurrentControlId.val("").focus();
                        $("#" + CurrentControlId.attr("id").replace("txt", "hdn")).val("");
                        alert("Invalid Location Name!");
                    }
                    else {
                        CurrentControlId.val(data.Name);
                        $(CurrentHiddenControlId).val(data.Code);
                    }
                }, null, true, "POST");
            }
        }, 200);
    }
    catch (e) {
        alert(e.message);
        return false;
    }
}

function ExecuteAjax(url, data, fnSuccess, fnError, async, type) {
    /// <summary>To make ajax call to get/set data.</summary>
    /// <param name="url" type="String">Url to make ajax call.</param>
    /// <param name="data" type="Json">data to send with ajax call.</param>
    /// <param name="fnSuccess" type="Function">Success function of ajax call.</param>
    /// <param name="fnError" type="Function">Error function of ajax call.</param>
    try {
        //setTimeout(function () {
        $.ajax({
            type: (type != undefined && type != "" ? type : "POST"),
            url: url,
            async: (async != undefined && async ? true : false),
            data: (data != undefined && data != "" && data != "{}" ? JSON.stringify(data) : "{}"),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: (typeof (fnSuccess) == "function" ?
                function (response) {
                    fnSuccess(response);
                }
                :
                function (response) {
                }),
            error: (typeof (fnError) == "function" ?
                function (xhr, ajaxOptions, thrownError) {
                    fnError(xhr, ajaxOptions, thrownError);
                }
                :
                function (xhr, ajaxOptions, thrownError) {
                    alert(thrownError);
                })
        });
        //}, 200);
    } catch (e) {
        throw e;
    }
}


function InitAutoComplete() {

    var tbl = document.getElementById(gvVehicleCPKMID);
    var rows = tbl.rows.length;
    for (var i = 2; i <= rows ; i++) {
        if (i < 10) {
            txtStation = "#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtStation";
            hdnStation = "ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnStation";
        } else {
            txtStation = "#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtStation";
            hdnStation = "ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnStation";
        }
        try {
            AutoCompleteForV1(txtStation, serviceUrl + '/BranchAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
          'prefixText', 'l', 'l', 'l', 'v', 'v', hdnStation, 'No entries found!', 2, null, true);

        } catch (e) {
            //alert(e);
        }
    }
    //var repeater = document.getElementById("gvVehicleCPKM");
    //var inputs = repeater.getElementsByTagName("input");
    //for (var i = 0; i < inputs.length; i++) {

    //    if (inputs[i].type == "text" && inputs[i].id.indexOf("txtStation") > 0) {
    //        var hdnStation = inputs[i].id.replace("txtStation", "hdnStation");

    //        AutoCompleteForV1("#" + inputs[i].id, serviceUrl + '/BranchAutoComplate', 'POST', 'application/json; charset=utf-8', 'json',
    //       'searchText', 'l', 'l', 'l', 'v', 'v', hdnStation, 'No entries found!', 2, '', true);
    //    }
    //}
}


var alpha = "[ A-Za-z]";
var numeric = "[0-9]";
var alphanumeric = "[ A-Za-z0-9]";
var float1 = "^(?:[1-9]\d*|0)?(?:\.\d{2})?$";
var float = "^(?:[1-9]\d*|0)?(?:\.\d{2})?$";
var specialcharacters = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
function ValidAlphaNumeric(e, charVal) {
    var keynum;
    var keyChars = /[\x00\x08]/;
    var validChars = new RegExp(charVal);
    if (window.event) {
        keynum = e.keyCode;
    }
    else if (e.which) {
        keynum = e.which;
    }
    var keychar = String.fromCharCode(keynum);
    if (!validChars.test(keychar) && !keyChars.test(keychar)) {
        return false
    } else {
        return keychar;
    }
}


function AmontCalculation(e) {
    var CurrentRow = $(e).closest('tr');

    var txtBaseRate = $(e).closest('tr').find('input[id*="txtBaseRate"]');
    var txtGSTper = $(e).closest('tr').find('input[id*="txtGSTper"]');
    var txtGSTAmount = $(e).closest('tr').find('input[id*="txtGSTAmount"]');
    var txtNetAmount = $(e).closest('tr').find('input[id*="txtNetAmount"]');
    var hdnGSTAmount = $(e).closest('tr').find('input[id*="hdnGSTAmount"]');
    var hdnNetAmount = $(e).closest('tr').find('input[id*="hdnNetAmount"]');
    var rbGSTCredit = $(e).closest('tr').find('input[id*="rbGSTCredit"]');
    // var hdnNetAmount = $(e).closest('tr').find('input[id*="hdnNetAmount"]');
    if (txtBaseRate.val() != '' && txtGSTper.val() != '') {
        if (rbGSTCredit.prop("checked")) {
            var GAmount = (parseFloat(txtBaseRate.val()) * parseFloat(txtGSTper.val())) / 100
            txtGSTAmount.val(parseFloat(GAmount).toFixed(2));
            hdnGSTAmount.val(parseFloat(GAmount).toFixed(2));
            txtNetAmount.val(parseFloat(GAmount + parseFloat(txtBaseRate.val())).toFixed(2));
            hdnNetAmount.val(parseFloat(GAmount + parseFloat(txtBaseRate.val())).toFixed(2));
        } else {
            var GAmount = (parseFloat((parseFloat(txtBaseRate.val()) * parseFloat(txtGSTper.val()))).toFixed(2)) / 100
            txtGSTAmount.val("0");
            hdnGSTAmount.val("0");
            txtNetAmount.val(parseFloat(txtBaseRate.val()).toFixed(2));
            hdnNetAmount.val(parseFloat(txtBaseRate.val()).toFixed(2));
        }
    }


}

function ValidRow(e) {
    var CurrentRow = $(e).closest('tr');
    var txtStation = $(e).closest('tr').find('input[id*="txtStation"]');
    var txtFromDate = $(e).closest('tr').find('input[id*="txtFromDate"]');
    var txtToDate = $(e).closest('tr').find('input[id*="txtToDate"]');
    var txtBaseRate = $(e).closest('tr').find('input[id*="txtBaseRate"]');
    var txtGSTper = $(e).closest('tr').find('input[id*="txtGSTper"]');
    var txtGSTAmount = $(e).closest('tr').find('input[id*="txtGSTAmount"]');
    var txtNetAmount = $(e).closest('tr').find('input[id*="txtNetAmount"]');

    if (txtStation.val() == '') {
        alert("Please enter Station !");
        txtStation.focus();
        return false;
    }
    else if (txtFromDate.val() == '') {
        alert("Please From date !");
        txtFromDate.focus();
        return false;

    }
    else if (txtToDate.val() == '') {
        alert("Please To date !");
        txtToDate.focus();
        return false;

    }
    else if (txtBaseRate.val() == '') {
        alert("Please enter Base rate !");
        txtFromDate.focus();
        return false;

    }
    else if (txtGSTper.val() == '') {
        alert("Please enter gst Percentage!");
        txtGSTper.focus();
        return false;

    }
    return true;
}


function validateFloatKeyPress(el, evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    var number = el.value.split('.');
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    //just one dot
    if(number.length>1 && charCode == 46){
         return false;
    }
    //get the carat position
    var caratPos = getSelectionStart(el);
    var dotPos = el.value.indexOf(".");
    if( caratPos > dotPos && dotPos>-1 && (number[1].length > 3)){
        return false;
    }
    return true;
}

//thanks: http://javascript.nwbox.com/cursor_position/
function getSelectionStart(o) {
	if (o.createTextRange) {
		var r = document.selection.createRange().duplicate()
		r.moveEnd('character', o.value.length)
		if (r.text == '') return o.value.length
		return o.value.lastIndexOf(r.text)
	} else return o.selectionStart
}