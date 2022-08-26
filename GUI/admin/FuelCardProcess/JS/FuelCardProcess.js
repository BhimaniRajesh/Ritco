
var txtVehicleNo, hdnVehicleNo, txtTripSheetNo, hdnTripSheetNo, lblTripSheetDate, lblFuelCardNo, ddlFuelType, txtCity, hdnCity,
    txtSwappingDate, txtTransactionId, txtQTY, txtRate, lblAmount, txtRemarks;

$(document).ready(function () {
    $('#aspnetForm').attr("enctype", "multipart/form-data");
    IntializeControls();
    AutoCompleteByAjax(txtCity, serviceUrl + "/GetCityList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCity.attr('id'), 'Invalid City entered.');
    AutoCompleteByAjax(txtTripSheetNo, serviceUrl + "/GetTripSheetNoList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnTripSheetNo.attr('id'), 'Invalid Trip sheet number entered.');
    AutoCompleteByAjax(txtVehicleNo, serviceUrl + "/GetVehicleList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnVehicleNo.attr('id'), 'Invalid Vehicle Number entered.');
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
});
function EndRequestHandler(sender, args) {
    IntializeControls();
    AutoCompleteByAjax(txtCity, serviceUrl + "/GetCityList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnCity.attr('id'), 'Invalid City entered.');
    AutoCompleteByAjax(txtTripSheetNo, serviceUrl + "/GetTripSheetNoList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnTripSheetNo.attr('id'), 'Invalid Trip sheet number entered.');
    AutoCompleteByAjax(txtVehicleNo, serviceUrl + "/GetVehicleList", "POST", "application/json; charset=utf-8", "json", "prefix", 'l', 'l', 'l', 'v', hdnVehicleNo.attr('id'), 'Invalid Vehicle Number entered.');
}
function IntializeControls() {
    txtVehicleNo = $("#" + controlIdPrefix + "txtVehicleNo");
    hdnVehicleNo = $("#" + controlIdPrefix + "hdnVehicleNo");

    txtTripSheetNo = $("#" + controlIdPrefix + "txtTripSheetNo");
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
function GetTripSheetDetail() {

    if (txtTripSheetNo.val() != "" && lblTripSheetDate.text() == "") {
        var url = serviceUrl + "/GetTripSheetDetail";

        var strdata = "{\"TripSheetNo\":\"" + txtTripSheetNo.val() + "\",\"VehicleNo\":\"" + txtVehicleNo.val() + "\"}";
        AjaxRequestWithPostAndJson(url, strdata, function success(data) {
			 debugger;
if (data.GetTripSheetDetailResult!=null) {
                lblTripSheetDate.text(data.GetTripSheetDetailResult[0].TripSheetDateTime);
                lblFuelCardNo.text(data.GetTripSheetDetailResult[0].FuelCardNo);
            }
            
        }, errorInMasterFunction, false);
    }
}

function errorInMasterFunction(request, status, error) {

    alert(request.responseText);
    txtTripSheetNo.val("");
    lblTripSheetDate.text("");
}

function CalculateAmount() {
    var QTY = txtQTY.val();
    var Rate = txtRate.val();

    if (QTY.toString() != "" && Rate.toString() != "") {
        lblAmount.text(QTY * Rate);
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
                        jData["TripSheetNo"] = txtTripSheetNo.val();
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
                                txtTripSheetNo.val("");
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
    try {
        if (txtVehicleNo.val().trim() == "") {
            alert("Please Enter Vehicle No.!");
            txtVehicleNo.focus();
            return false;
        }
        if (txtTripSheetNo.val().trim() == "") {
            alert("Please Enter Trip Sheet No.!");
            txtTripSheetNo.focus();
            return false;
        }
        if (txtCity.val().trim() == "") {
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


        if (txtTransactionId.val().trim() == "") {
            alert("Please Enter Transaction Id.!");
            txtTransactionId.focus();
            return false;
        }
        if (txtQTY.val().trim() == "") {
            alert("Please Enter Quantity.!");
            txtQTY.focus();
            return false;
        }
        if (parseFloat(txtQTY.val()) == 0) {
            alert("Quantity must be greater than 0.!");
            txtQTY.focus();
            return false;
        }
        if (parseFloat(txtRate.val().trim()) == 0) {
            alert("Rate must be greater than 0.!");
            txtRate.focus();
            return false;
        }
        if (txtRemarks.val().trim() == "") {
            alert("Please Enter Remarks.!");
            txtRemarks.focus();
            return false;
        }
    } catch (e) {
        alert(e.message);
        return false;
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