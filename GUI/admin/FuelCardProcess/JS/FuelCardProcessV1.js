
var txtVehicleNo, hdnVehicleNo, txtTripSheetNo, ddlTripsheetNo, hdnTripSheetNo, lblTripSheetDate, lblFuelCardNo, ddlFuelType, txtCity, hdnCity,
    txtSwappingDate, txtTransactionId, txtQTY, txtRate, lblAmount, txtRemarks;

//$(document).ready(function () {
//    $('#aspnetForm').attr("enctype", "multipart/form-data");
//    //IntializeControls();
//    //AutoCompleteByAjax(txtCity, serviceUrl + "/GetCityList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCity.attr('id'), 'Invalid City entered.');
//    //AutoCompleteByAjax(txtTripSheetNo, serviceUrl + "/GetTripSheetNoList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnTripSheetNo.attr('id'), 'Invalid Trip sheet number entered.');
//    //AutoCompleteByAjax(txtVehicleNo, serviceUrl + "/GetVehicleList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnVehicleNo.attr('id'), 'Invalid Vehicle Number entered.');
//    //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
//});
//function EndRequestHandler(sender, args) {
//    IntializeControls();
//    AutoCompleteByAjax(txtCity, serviceUrl + "/GetCityList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCity.attr('id'), 'Invalid City entered.');
//    //AutoCompleteByAjax(txtTripSheetNo, serviceUrl + "/GetTripSheetNoList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnTripSheetNo.attr('id'), 'Invalid Trip sheet number entered.');
//    AutoCompleteByAjax(txtVehicleNo, serviceUrl + "/GetVehicleList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnVehicleNo.attr('id'), 'Invalid Vehicle Number entered.');
//}


$(document).ready(function () {
    InitializedAutocomplete();

    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

    function EndRequestHandler(sender, args) {
        InitializedAutocomplete();
    }

});

function InitializedAutocomplete() {

    var txtCity, hdnCity, txtVehicleNo, hdnVehicleNo;
    var tbl = document.getElementById(gvVehicleCPKMID);
    var rows = tbl.rows.length;
    for (var i = 2; i <= rows ; i++) {
        if (i < 10) {
            txtCity = "#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtCity";
            hdnCity = "ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnCity";
            txtVehicleNo = "#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtVehicleNo";
            hdnVehicleNo = "ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnVehicleNo";
        } else {
            txtVehicleNo = "#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtVehicleNo";
            hdnVehicleNo = "ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnVehicleNo";
            txtCity = "#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtCity";
            hdnCity = "ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnCity";
        }
        try {

            AutoCompleteByAjax(txtCity, serviceUrl + "/GetCityList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCity, 'Invalid City entered.');
            //AutoCompleteByAjax(txtTripSheetNo, serviceUrl + "/GetTripSheetNoList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnTripSheetNo.attr('id'), 'Invalid Trip sheet number entered.');
            AutoCompleteByAjax(txtVehicleNo, serviceUrl + "/GetVehicleList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, 'Invalid Vehicle Number entered.');

        } catch (e) {
            // alert(e);
        }
    }
}



function Bindtripsheet(e) {
    if (txtVehicleNo.val() == '') {
        alert("Please select Vehicle No.");
        false;
    }
    var param = { VehicleNo: txtVehicleNo.val() };
    $.ajax({
        type: "POST",
        url: "FuelCardProcess.aspx/GetTripsheetList",
        data: JSON.stringify(param),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (r) {
            var ddlTripsheetNo = $("[id*=ddlTripsheetNo]");
            ddlTripsheetNo.empty().append('<option selected="selected" value="0">Please select</option>');
            $.each(r.d, function () {
                ddlTripsheetNo.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
        }
    });

}

function BindFuelWallet(e) {
    if (txtVehicleNo.val() == '') {
        alert("Please select Vehicle No.");
        false;
    }
    var param = { VehicleNo: txtVehicleNo.val() };
    $.ajax({
        type: "POST",
        url: "FuelCardProcess.aspx/GetFuelWalletList",
        data: JSON.stringify(param),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (r) {
            var ddlFuelWallet = $("[id*=ddlFuelWallet]");
            ddlFuelWallet.empty().append('<option selected="selected" value="0">Please select</option>');
            $.each(r.d, function () {
                ddlFuelWallet.append($("<option></option>").val(this['Value']).html(this['Text']));
            });
        }
    });

}

function IntializeControls() {
    txtVehicleNo = $("#" + controlIdPrefix + "txtVehicleNo");
    hdnVehicleNo = $("#" + controlIdPrefix + "hdnVehicleNo");
    ddlTripsheetNo = $("#ddlTripsheetNo");
    //txtTripSheetNo = $("#" + controlIdPrefix + "txtTripSheetNo");
    hdnTripSheetNo = $("#" + controlIdPrefix + "hdnTripSheetNo");
    lblTripSheetDate = $("#" + controlIdPrefix + "lblTripSheetDate");
    lblFuelCardNo = $("#" + controlIdPrefix + "lblFuelCardNo");

    ddlFuelType = $("#" + controlIdPrefix + "ddlFuelType");
    txtCity = $("#" + controlIdPrefix + "txtCity");
    hdnCity = $("#" + controlIdPrefix + "hdnCity");

    txtSwappingDate = $("#" + controlIdPrefix + "txtSwappingDate");
    txtTransactionId = $("#" + controlIdPrefix + "txtTransactionId");
    txtQTY = $("#" + controlIdPrefix + "txtQTY");
    txtRate = $("#" + controlIdPrefix + "txtRate");

    lblAmount = $("#" + controlIdPrefix + "lblAmount");
    txtRemarks = $("#" + controlIdPrefix + "txtRemarks");

}
function GetTripSheetDetail(e) {
    var ddlTripsheetNo = $(e).closest('tr').find('select[id*="ddlTripsheet"]');
    var hdnTripsheetNo = $(e).closest('tr').find('input[id*="hdnTripsheetNo"]');
    var txtVehicleNo = $(e).closest('tr').find('input[id*="txtVehicleNo"]');
    var lblTripsheetDate = $(e).closest('tr').find('span[id*="lblTripsheetDate"]');
    var hdnTripsheetDate = $(e).closest('tr').find('input[id*="hdnTripsheetDate"]');
    var lblFuelCardNo = $(e).closest('tr').find('span[id*="lblFuelCardNo"]');
    var hdnFuelCardNo = $(e).closest('tr').find('input[id*="hdnFuelCardNo"]');
    var hdnFuelWallet = $(e).closest('tr').find('input[id*="hdnFuelWallet"]');

    if (ddlTripsheetNo.val() != "") {
        var url = serviceUrl + "/GetTripSheetDetail";
        var strdata = "{\"TripSheetNo\":\"" + ddlTripsheetNo.val() + "\",\"VehicleNo\":\"" + txtVehicleNo.val() + "\"}";
        AjaxRequestWithPostAndJson(url, strdata, function success(data) {

            if (data.GetTripSheetDetailResult != null) {
                lblTripsheetDate.text(data.GetTripSheetDetailResult[0].TripSheetDateTime);
                hdnTripsheetDate.val(data.GetTripSheetDetailResult[0].TripSheetDateTime);
                //lblFuelCardNo.text(data.GetTripSheetDetailResult[0].FuelCardNo);
                //hdnFuelCardNo.val(data.GetTripSheetDetailResult[0].FuelCardNo);
                hdnTripsheetNo.val(ddlTripsheetNo.val());
                //hdnFuelWallet.val(data.GetTripSheetDetailResult[0].FuelAccCode);
            }

        }, errorInMasterFunction, false);
    }
}

function errorInMasterFunction(request, status, error) {

    alert(request.responseText);
    // txtTripSheetNo.val("");
    lblTripSheetDate.text("");
}

function CalculateAmount(e) {
    var txtRate = $(e).closest('tr').find('input[id*="txtRate"]');
    var txtQty = $(e).closest('tr').find('input[id*="txtQty"]');
    var hdnAmount = $(e).closest('tr').find('input[id*="hdnAmount"]');
    var txtAmount = $(e).closest('tr').find('input[id*="txtAmount"]');

    var QTY = txtQty.val();
    var Rate = txtRate.val();

    if (QTY.toString() != "" && Rate.toString() != "") {
        txtAmount.val(Math.round(parseFloat(QTY) * parseFloat(Rate)).toFixed(2));
        hdnAmount.val(Math.round(parseFloat(QTY) * parseFloat(Rate)).toFixed(2));
    }
    if (QTY.toString() != "" && Rate.toString() != "") {

        var r = confirm("Your Amount is " + hdnAmount.val());
        if (r == true) {

        } else {
            txtQty.val(0);
            txtRate.val(0);
			txtAmount.val("0");
            hdnAmount.val("0");
            //txtAmount.val(Math.round(parseFloat(QTY) * parseFloat(Rate)).toFixed(2));
            //hdnAmount.val(Math.round(parseFloat(QTY) * parseFloat(Rate)).toFixed(2));
        }
    }

}



function SubmitClick() {


    if (Validate()) {
        var url = serviceUrl + "/InsertFuelCardProcessDetail";
        /*  if (txtTripSheetNo.val() != "" && txtVehicleNo.val() != "") {
            var urlCheck = serviceUrl + "/CheckFuelCardAlreadyAdded";
 
             var strdata = "{\"TripSheetNo\":\"" + txtTripSheetNo.val() + "\",\"VehicleNo\":\"" + txtVehicleNo.val() + "\"}";
             AjaxRequestWithPostAndJson(urlCheck, strdata, function success(data) {
 
                 if (data.CheckFuelCardAlreadyAddedResult == "False") {
                  */
        if (confirm("Are you sure you want to submit data.?")) {
            var jData = {};
            jData["VehicleNo"] = txtVehicleNo.val();
            jData["TripSheetNo"] = ddlTripsheetNo.val();
            jData["FuelCardNo"] = lblFuelCardNo.text();
            jData["FuelType"] = ddlFuelType.val();
            jData["City"] = hdnCity.val();
            jData["SwappingDate"] = moment(txtSwappingDate.val(), "DD/MM/YYYY").format('DD MMM YYYY');
            jData["TransactionId"] = txtTransactionId.val();
            jData["QTY"] = txtQTY.val();
            jData["Rate"] = txtRate.val();
            jData["Amount"] = lblAmount.text();
            jData["Remarks"] = txtRemarks.val();
            jData["EntryBy"] = CurrentUser;


            AjaxRequestWithPostAndJson(url, JSON.stringify(jData), function success(data) {

                if (data.IsSuccess == true) {

                    txtVehicleNo.val("");
                    ddlTripsheetNo.val(0);
                    lblFuelCardNo.text("");
                    ddlFuelType.val("Diesel");
                    txtCity.val("");
                    hdnCity.val("");
                    txtTransactionId.val("");
                    txtQTY.val("");
                    txtSwappingDate.val("");
                    txtRate.val("");
                    lblAmount.text("");
                    txtRemarks.val("");
                    lblTripSheetDate.text("");

                    // alert("Fuel card process data are inserted.!");
                    window.location.href = "FuelCardProcessDone.aspx";
                }
            }, errorInMasterFunction, false);
        }
        /* 
                       } else {
                           alert(data.CheckFuelCardAlreadyAddedResult);
                           return false;
                       }
       
                   }, errorInMasterFunction, false);
             } else {
                   return false;
               }
               */

    }

}

function Validate() {
    var txtCity, hdnCity, txtVehicleNo, hdnVehicleNo;
    var tbl = document.getElementById(gvVehicleCPKMID);
    var rows = tbl.rows.length;
    for (var i = 2; i <= rows ; i++) {
        if (i < 10) {
            txtCity = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtCity");
            txtVehicleNo = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtVehicleNo");
            ddlTripsheetNo = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnVehicleNo");
            txtSwappingDate = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtCPKMDate_txtDate");
            txtTransactionId = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtTransactionId");
            txtQTY = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtQTY");
            txtRate = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtRate");
            txtRemarks = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtRemarks");
        } else {
            txtVehicleNo = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtVehicleNo");
            hdnVehicleNo = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnVehicleNo");
            txtCity = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtCity");
            hdnCity = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnCity");
            ddlTripsheetNo = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_ddlTripsheetNo");
            txtSwappingDate = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtCPKMDate_txtDate");
            txtTransactionId = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtTransactionId");
            txtQTY = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtQTY");
            txtRate = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtRate");
            txtRemarks = $("#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtRemarks");
        }

        try {
            if (txtVehicleNo.val() == "") {
                alert("Please Enter Vehicle No.!");
                txtVehicleNo.focus();
                return false;
            }
            if (ddlTripsheetNo.val() == "0") {
                alert("Please Select Trip Sheet No.!");
                ddlTripsheetNo.focus();
                return false;
            }
            if (txtCity.val() == "") {
                alert("Please Enter City.!");
                txtCity.focus();
                return false;
            }
            var voo = true;
            voo = isValidDate(txtSwappingDate.val(), 'Swapping Date');
            if (!voo) {
                txtSwappingDate.val("");
                txtSwappingDate.focus();
                return false;
            }
            if (txtTransactionId.val() == "") {
                alert("Please Enter Transaction Id.!");
                txtTransactionId.focus();
                return false;
            }
            if (txtQTY.val() == "") {
                alert("Please Enter Quantity.!");
                txtQTY.focus();
                return false;
            }
            if (parseFloat(txtQTY.val()) == 0) {
                alert("Quantity must be greater than 0.!");
                txtQTY.focus();
                return false;
            }
            if (parseFloat(txtRate.val()) == 0) {
                alert("Rate must be greater than 0.!");
                txtRate.focus();
                return false;
            }
            if (txtRemarks.val() == "") {
                alert("Please Enter Remarks.!");
                txtRemarks.focus();
                return false;
            }
        } catch (e) {
            alert(e.message);
            return false;
        }
    }
    return true;
}

function isValidDate(dateStr, str) {
    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/; // requires 4 digit year
    var matchArray = dateStr.match(datePat); // is the format ok?
    if (matchArray == null) {
        alert("Please Enter " + str + " Date in dd/mm/yyyy Format");
        return false;
    }

    month = matchArray[3]; // parse date into variables
    day = matchArray[1];
    year = matchArray[4];


    if (month < 1 || month > 12) { // check month range
        alert("In " + str + "Date Month must be between 1 and 12.");
        return false;
    }

    if (day < 1 || day > 31) {
        alert("In " + str + "Day must be between 1 and 31.");
        return false;
    }

    if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31) {
        alert("In " + str + "Month " + month + " doesn't have 31 days!")
        return false
    }

    if (month == 2) { // check for february 29th
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));

        if (day > 29 || (day == 29 && !isleap)) {
            alert("In " + str + "February " + year + " doesn't have " + day + " days!");
            return false;
        }
    }
    return true; // date is valid
}

function CheckCity(ctrl) {
    if ($(ctrl).val() != "") {
        var jData = {};
        jData["City"] = $(ctrl).val();

        var url = "FuelCardProcess.aspx/CheckCity";

        AjaxRequestWithPostAndJson(url, JSON.stringify(jData), function success(data) {
            var dtcity = JSON.parse(data.d);
            if (dtcity.length > 0) {
                $(ctrl).val(dtcity[0].CityName)
                $("#" + $(ctrl).attr("id").replace("txtCity", "hdnCity")).val(dtcity[0].CityCode);
            } else {
                $(ctrl).val("");
                $("#" + $(ctrl).attr("id").replace("txtCity", "hdnCity")).val("");
                alert("Invalid City !!");
            }
        }, errorInMasterFunction, false);
    }
}