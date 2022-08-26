var ddlOption, txtTyreExp, txtAMC, txtDocument, txtOtherI, txtOtherII, txtVehicle, btnStep1, btnSubmit;

$(document).ready(function () {

});

function nwOpen(mNo) {
    window.open("popupVehicle.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}

function CheckOption() {
    var publisherobj = {};
    ddlOption = $("#" + controlIdPrefix + "ddlOption");
    btnSubmit = $("#" + controlIdPrefix + "btnSubmit");
    var param = { Option: ddlOption.val() };
    $.ajax({
        type: "POST",
        url: "FixedExpenseAdd.aspx/CheckOptionDetails",
        data: JSON.stringify(param),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (response) {
            var objArray = JSON.parse(response.d);
            if (objArray.length != 0) {
                alert("This Option Already Mapped.");
                btnSubmit.prop("disabled", true);
                return false;
            }
            else {
                btnSubmit.prop("disabled", false);
                return true;
            }
        }
    });
}

function Step1Click() {
    ddlOption = $("#" + controlIdPrefix + "ddlOption");
    if (ddlOption.val() == "") {
        alert("Please Select Option.");
        ddlOption.focus();
        return false;
    }
}

function BtnSubmit() {
    txtTyreExp = $("#" + controlIdPrefix + "txtTyreExp");
    txtAMC = $("#" + controlIdPrefix + "txtAMC");
    txtDocument = $("#" + controlIdPrefix + "txtDocument");
    txtOtherI = $("#" + controlIdPrefix + "txtOtherI");
    txtOtherII = $("#" + controlIdPrefix + "txtOtherII");
    txtTyreExp = $("#" + controlIdPrefix + "txtTyreExp");
    txtVehicle = $("#" + controlIdPrefix + "txtVehicle");

    if (txtTyreExp.val() == "") {
        alert("Please Enter Tyre Exp.");
        txtTyreExp.focus();
        return false;
    }
    if (txtAMC.val() == "") {
        alert("Please Enter AMC.");
        txtAMC.focus();
        return false;
    }
    if (txtDocument.val() == "") {
        alert("Please Enter Documents.");
        txtDocument.focus();
        return false;
    }
    if (txtOtherI.val() == "") {
        alert("Please Enter OtherI.");
        txtOtherI.focus();
        return false;
    }
    if (txtOtherII.val() == "") {
        alert("Please Enter OtherII.");
        txtOtherII.focus();
        return false;
    }
    if (txtVehicle.val() == "") {
        alert("Please Select VehicleNo.");
        txtVehicle.focus();
        return false;
    }
}

function x(id) {

    if (!checkVehicle(id))
        return false;

    return true;
}

function checkVehicle(obj) {

    var a;
    a = 1;

    obj.value = obj.value.toUpperCase()

    var test1 = obj.value.substring((obj.value.length - 1), (obj.value.length))
    if (test1 == ",") {
        var s = obj.value.substring(0, (obj.value.length - 1))
    }
    else {
        var s = obj.value
    }

    var loc = s.split(",")

    for (j = 0; j < loc.length; j++) {
        a = 1;
        for (i = 0; i < str.length; i++) {
            if (loc[j].length > 2) {
                if (loc[j] == str[i]) {
                    a = 2
                    break;
                    //return false;
                }
                else {
                    continue
                }
            }
            //  break
        }


        if (a != 2) {
            alert("Please enter valid Vehicle No : " + loc[j])
            obj.focus();
            return false;
        }

    }
    return true;
}
