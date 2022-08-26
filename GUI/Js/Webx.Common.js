// Author: Suraj Joshi
// Creation Date: 11-Nov-2013

// Further Modified By: Kumar Lachhani
// Modified Date: August 2014

// ===================================================================

// common Client ID prepend String
var controlIdPrefix = "ctl00_MyCPH1_";
// variable to check if AJAX is running or not. used in GlobalAJAXEvents below.
var AJAXState = 0;

$(document).ready(function () {
    $body = $("body");

    $(document).on({
        ajaxStart: function () {
            // show AJAX Loading //
            WebxCommon.ShowAJAXProgressBar();
            // i.e. AJAX request is active and in running state//
            AJAXState = 1;
        },
        ajaxStop: function () {
            // hide AJAX Loading //
            WebxCommon.HideAJAXProgressBar();
            // i.e. AJAX request is complete and in stopped state//
            AJAXState = 0;
        }
    });

    $(function () {
        $.ajaxSetup({
            error: function (x, exception) {
                if (x.status == 403) {
                    alert("Sorry, your session has expired. Please login again to continue");
                    //window.open('http://' + $("#" + hdAppUrl).val() + '/', 'LoginPopUp');
                }
                if (x.status == 0) {
                    alert('Not connected.\n Verify Network.');
                } else if (x.status == 404) {
                    alert('Requested page not found. [404]');
                } else if (x.status == 500) {
                    alert('Internal Server Error Occurred [500]. Please try again later OR Please Contact Support !!\n-----------------------\n' + x.responseText + ' \n----------------------\n ' + exception + ' \n---------------------\n ' + x.status);
                    //alert("Sorry, your session has expired. Please login again to continue");
                    //window.open('http://' + $("#" + hdAppUrl).val() + '/', 'LoginPopUp');
                } else if (x.status == 401) {
                    alert("UnAuthorized Access !! Sorry, your session has expired. Please login again to continue");
                } else if (exception == 'parsererror') {
                    alert('Requested JSON parse failed.');
                } else if (exception == 'timeout') {
                    alert('Time out error.');
                } else if (exception == 'abort') {
                    alert('Ajax request aborted.');
                } else {
                    alert('Oops !! Seems there is some problem with the Application. Please Contact Support !!\n-----------------------\n' + x.responseText + ' \n----------------------\n ' + exception + ' \n---------------------\n ' + x.status);
                    //alert(x.responseText + ' : ' + exception + ' : ' + x.status);
                }
            }
        });
    });

    // jQuery Validations

    $(document).on("blur", ".clsOnBlur", function () {
        $("#aspnetForm").validate().element("#" + $(this).attr('id'));
    });

    //$.validator.methods.dateIN = function (value, element) { try {
    //        var _appleDates = $.datepicker.formatDate("dd/mm/yy", $.datepicker.parseDate("dd/MM/yy", value));
    //        return (!/Invalid|NaN/.test(new Date(_appleDates).toString()));
    //    } catch (e) { return false; };
    //};

    $.validator.addMethod("regex", function (value, element, regexp) {
        var re = new RegExp(regexp);
        return this.optional(element) || re.test(Trim(value));
    }, "Please check your input.");

    $.validator.addMethod("dateIN", function (value, element) {
        var d = Date.parseExact(value, "dd/MM/yyyy");
        if (d !== null) { return true; }
        //return value.match(/^dd?\/dd?\/dd$/);
    }, "Please enter a date in the format dd/mm/yyyy.");

});

// Bind PIE
function BindPIE() {
    if (window.PIE) {
        $('.label').each(function () { PIE.attach(this); });
        $('.btn').each(function () { PIE.attach(this); });
    }
};

// Alphanumeric
function keypress(e) {
    var regex = new RegExp("^[a-zA-Z0-9]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str) || e.charCode == "9" || e.charCode == "0") {
        return true;
    }
    e.preventDefault();
    return false;
}

// Integer
function IntKeypress(e) {
    var regex = new RegExp("^[0-9]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str) || e.charCode == "9" || e.charCode == "0") {
        return true;
    }
    e.preventDefault();
    return false;
}
// Only numbers upto 2 decimal points
function NumKeypress(e) {
    if ($(this).getSelection().length > 0) { }
    else {
        if (e.which == 0 || e.which == 8 || e.which == 9 || e.which == 127) { }
        else if ((e.which != 46 || $(this).val().indexOf('.') != -1) && (e.which < 48 || e.which > 57)) {
            e.preventDefault();
        }
        else {
            if ($(this).val().indexOf('.') != -1 && e.which != 46) {
                if ($(this).val().split(".")[1].length >= 2) { e.preventDefault(); }
            }
        }
    }
}
function numberkeypress(e) {
    if ($(this).getSelection().length > 0) { }
    else {
        if (e.which == 0 || e.which == 8 || e.which == 9 || e.which == 127) { }
        else if ((e.which != 46 || $(this).val().indexOf('.') != -1) && (e.which < 48 || e.which > 57)) {
            e.preventDefault();
        }
        else {
            if ($(this).val().indexOf('.') != -1 && e.which != 46) {
                if ($(this).val().split(".")[1].length >= 2) { e.preventDefault(); }
            }
        }
    }
}


// Disable table after submit
function DisableTbl(tblId) {
    $('[id=' + tblId + '] tr:not(:first-child)').find('input,button,textarea,select,a,img').prop('disabled', true);
}

// AutoComplete with source
var disableACblur = false;
function AutoCompleteBySource(eleId, Source, focus, select, s1, s2, eleVal) {
    $(eleId).autocomplete({
        minLength: 0,
        source: Source,
        focus: function (event, ui) {
            if (focus == 'v') { $(this).val(ui.item.value); }
            else if (focus == 'l') { $(this).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); }
            return false;
        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }
        return $("<li>")
        .append("<a>" + rs1 + " : " + rs2 + "</a>")
        .appendTo(ul);
    };
}

/* Description : AutoComplete using Ajax

eleId : ID of the Textbox Control for which auto complete needs to be invoked
url : Web service url
type : GET/POST
contentType : Content Type
dataType : Data Type
prefixText : prefix name used as a parameter i.e. searchText or prefixText or prefix
focus : on focus event,(v for value/code, l for name, Blank for Value : Name format) to be displayed in the Textbox Control for which auto complete needs to be invoked
select : on selection event, (v for value/code, l for name, Blank for Value : Name format) to be displayed in the Textbox Control for which auto complete needs to be invoked
         and also set the value/code in the control having control-id given in eleVal parameter
s1 : left Part before : Auto Ecomplete listing i.e. C00000 in C00000 : ABC Customer
s2 : right Part after : Auto Ecomplete listing i.e. ABC Customer in C00000 : ABC Customer
    We can remove s2 by passing its value as null when calling this function
eleVal : ID of the Control in which selection value needs to be store
alertMsg : Message text that will be appeared when no match found
*/

function AutoCompleteByAjaxV2(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, eleVal, alertMsg, additionalFiler) {
    $(eleId).autocomplete({
        minLength: 2,
        source: function (request, response) {

            var requestData, serviceUrl;
            type = type.toUpperCase();
            if (type == "POST") {

                requestData = "{";
                requestData += "\"" + prefixText + "\":" + "\"" + request.term + "\"" + ",";
                for (var i = 0; i < additionalFiler.length; i++) {
                    var filter = additionalFiler[i].split(':');
                    requestData += "\"" + filter[0] + "\":" + "\"" + filter[1] + "\"" + ((i + 1 == additionalFiler.length) ? "" : ",");
                }
                requestData += "}";

                serviceUrl = url;
            }
            else
                serviceUrl = url + "?" + prefixText + "=" + request.term;

            $.ajax({
                type: type,
                contentType: contentType,
                url: url,
                dataType: dataType,
                data: requestData,
                success: function (data) {
                    var retOut;
                    try {
                       
                        if (data.d != null && data.d != undefined && data.d.length != 0)
                            retOut = jQuery.parseJSON(data.d);
                        else
                            retOut = data;
                    }
                    catch (e) { retOut = data.d; }
                    if (retOut.length != 0) {
                        response($.map(retOut, function (item) {
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        alert(alertMsg);
                        $(eleId).val('');
                    }
                }
            })
        },
        open: function (event, ui) { disableACblur = true; return false; },
        close: function (event, ui) { disableACblur = false; return false; },
        focus: function (event, ui) {
            //if (focus == 'v') { $(this).val(ui.item.value); }
            //else if (focus == 'l') { $(this).val(ui.item.label); }
            //else { $(this).val(ui.item.label + " : " + ui.item.value); }
            //return false;
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
            return false;

        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }

        var rs2String = (rs2 == undefined || rs2 == null) ? '' : " : " + rs2;

        return $("<li>")
        .append("<a>" + rs1 + rs2String + "</a>")
        .appendTo(ul);
    };
}

function GetFormatedResponseData(data)
{
    var retOut;
    try {
        if (data.d != null && data.d != undefined && data.d.length != 0)
            retOut = jQuery.parseJSON(data.d);
        else
            retOut = data.d;
    }
    catch (e) { retOut = data.d; }
    return retOut;
}
// AutoComplete using Ajax
function AutoCompleteByAjaxVer1(eleId, url, type, contentType, dataType, prefixText, minLength, focus, select, s1, s2, eleVal, alertMsg, additionalFiltersArr, showAlert) {

    $(eleId).autocomplete({
        minLength: 3,
        source: function (request, response) {
            // alert('here ' + request.term);
            // alert('here ' + url);
            //  alert('here ' + eleId);

            var requestData = {};
            requestData.prefixText = request.term;

            if (!(WebxConvert.IsObjectUndefinedOrNull(additionalFiltersArr))) {
                for (var i = 0; i < additionalFiltersArr.length; i++) {
                    // requestData[additionalFiltersArr[i][0]] = additionalFiltersArr[i][1];
                }
            }
            requestData = JSON.stringify(requestData);
            $.ajax({
                minLength: minLength,
                type: type,
                contentType: contentType,
                url: url,
                dataType: dataType,
                data: requestData,
                //data: "{ '" + prefixText + "': '" + request.term + "'}",
                success: function (data) {
                    //alert(JSON.stringify(data));
                    if (data.d.length != 0) {
                        //   alert('in func');
                        var retOut = jQuery.parseJSON(data.d);
                        // alert('json obj ' + retOut);
                        response($.map(retOut, function (item) {
                            //   alert('n ' + item.Name); //yeh alert bhi aaya
                            //   alert('v ' + item.Value);
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        if (showAlert)
                            alert(alertMsg);
                        $(eleId).val('');
                    }
                }
            })
        },
        open: function (event, ui) { disableACblur = true; return false; },
        close: function (event, ui) { disableACblur = false; return false; },
        focus: function (event, ui) {
            if (focus == 'v') { $(this).val(ui.item.value); }
            else if (focus == 'l') { $(this).val(ui.item.label); }
            else if (focus == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); }
            return false;
        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'vl') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }
            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }
        return $("<li>")
        .append("<a>" + rs1 + " : " + rs2 + "</a>")
        .appendTo(ul);
    };
}

function AutoCompleteByAjax(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, eleVal, alertMsg) {
    $(eleId).autocomplete({
        minLength: 3,
        source: function (request, response) {

            var requestData, serviceUrl;
            type = type.toUpperCase();
            if (type == "POST") {
                requestData = request.term;
                serviceUrl = url;
            } else
                serviceUrl = url + "?" + prefixText + "=" + request.term;

            $.ajax({
                type: type,
                contentType: contentType,
                url: url,
                dataType: dataType,
                data: JSON.stringify(requestData),
                success: function (data) {

                    var retOut;
                    try {
                        if (data.d != null && data.d != undefined && data.d.length != 0)
                            retOut = jQuery.parseJSON(data.d);
                        else
                            retOut = data;
                    } catch (e) {
                        retOut = data.d;
                    }
                   

                    if (retOut.length != 0) {
                        response($.map(retOut, function (item) {
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        alert(alertMsg);
                        $(eleId).val('');
                    }
                }
            })
        },
        open: function(event, ui) {
            disableACblur = true;
            return false;
        },
        close: function(event, ui) {
            disableACblur = false;
            return false;
        },
        focus: function(event, ui) {
            //if (focus == 'v') { $(this).val(ui.item.value); }
            //else if (focus == 'l') { $(this).val(ui.item.label); }
            //else { $(this).val(ui.item.label + " : " + ui.item.value); }
            //return false;

            if (select == 'v') {
                $(this).val(ui.item.value);
                $("#" + eleVal).val(ui.item.value);
            } else if (select == 'l') {
                $(this).val(ui.item.label);
                $("#" + eleVal).val(ui.item.value);
            } else {
                $(this).val(ui.item.label + " : " + ui.item.value);
                $("#" + eleVal).val(ui.item.value);
            }
            return false;
        },
        select: function (event, ui) {

            if (select == 'v') {
                $(this).val(ui.item.value);
                $("#" + eleVal).val(ui.item.value);
            } else if (select == 'l') {
                $(this).val(ui.item.label);
                $("#" + eleVal).val(ui.item.value);
            } else {
                $(this).val(ui.item.label + " : " + ui.item.value);
                $("#" + eleVal).val(ui.item.value);
            }
            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }

        var rs2String = (rs2 == undefined || rs2 == null) ? '' : " : " + rs2;

        return $("<li>")
        .append("<a>" + rs1 + rs2String + "</a>")
        .appendTo(ul);
    };
}



// Convert date to 'MMM dd, yy' format
function convertDate(d) {
    var day = d.getDate();
    if (day < 10) {
        day = '0' + day;
    }
    var year = d.getFullYear();
    var month = d.getMonth();
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var currentMonth = months[month];
    return (currentMonth + ' ' + day + ', ' + year);
}

// DatePicker User control DatePicker load
function LoadOnCallBack(ObjID, DtFormat, IsFutureDt, IsPastDt, DtImg, systemDate, sysDateFormat) {
    var currentDate = Date.parseExact(systemDate, sysDateFormat);
    ObjID.datepicker({
        //defaultDate: "-1m",
        dateFormat: DtFormat,
        changeMonth: true,
        changeYear: true,
        numberOfMonths: 1,
        showOn: "both",
        buttonImage: DtImg,
        buttonImageOnly: true,
        maxDate: ((IsFutureDt != 'True') ? currentDate : null),
        minDate: ((IsPastDt != 'True') ? currentDate : null),
        onClose: function () {
            this.focus();
        }
    });
}


// DatePicker User control check date validation
function chkDatePickerDt11(txtDate, DtFormat, IsFutureDt, IsPastDt) {
    try {
        if (txtDate.value != "") {



            var d = txtDate.value.split('/')
            var aa = (d[0] + '/' + d[1] + '/' + d[2]);
            if (!isDate(aa, 'MM/dd/yyyy')) {
                txtDate.value = '';
                throw ("Invalid date");
            }

            var selectedDate = formatDate(new Date(d[0] + '/' + d[1] + '/' + d[2]), DtFormat);//Date.parseExact(txtDate.value, DtFormat);

            if (selectedDate == null) {
                txtDate.value = '';
                txtDate.focus();
                throw ("Please Enter " + " Date in " + DtFormat + " Format");
                throw ("Date is not allowed");
                return;
            }

            var currentDate = formatDate(new Date(Date.now()), DtFormat)//Date.today();

            var i = selectedDate.localeCompare(currentDate);
            if (i > 0 && IsFutureDt == 'False') {
                txtDate.focus();
                throw ("Future Date is not allowed");
                return;
            }

            if (i < 0 && IsPastDt == 'False') {
                txtDate.focus();
                throw ("Past Date is not allowed");
                return;
            }
        }
    } catch (e) {
        txtDate.focus();
        alert(e);
    }
}


// DatePicker User control check date validation
function chkDatePickerDtTT(txtDate, DtFormat, IsFutureDt, IsPastDt) {
    try {
        if (txtDate.value != "") {

            var d = txtDate.value.split('/')
            var aa = (d[0] + '/' + d[1] + '/' + d[2]);
            if (!isDate(aa, 'MM/dd/yyyy')) {
                txtDate.value = '';
                throw ("Invalid date");
            }

            //var selectedDate = formatDate(new Date(d[0] + '/' + d[1] + '/' + d[2]), DtFormat);//Date.parseExact(txtDate.value, DtFormat);
			var selectedDate = formatDate(new Date(d[1]+'/'  + d[0] +  '/' + d[2]), DtFormat);

            if (selectedDate == null) {
                txtDate.value = '';
                txtDate.focus();
                throw ("Please Enter " + " Date in " + DtFormat + " Format");
                throw ("Date is not allowed");
                return;
            }

            // var currentDate = formatDate(new Date(Date.now()), DtFormat)//Date.today();

            // var i = selectedDate.localeCompare(currentDate);
            // if (i > 0 && IsFutureDt == 'False') {
                // txtDate.focus();
                // throw ("Future Date is not allowed");
                // return;
            // }

            // if (i < 0 && IsPastDt == 'False') {
                // txtDate.focus();
                // throw ("Past Date is not allowed");
                // return;
            // }
			
			var selectedDt = new Date(d[2] + '-' + d[1] + '-' + d[0]).setHours(0, 0, 0, 0);
            var todayDt = new Date().setHours(0, 0, 0, 0);;

            if ( selectedDt > todayDt && IsFutureDt == 'False') {
                txtDate.focus();
                throw ("Future Date is not allowed");
                return;
            }

            if (selectedDt < todayDt && IsPastDt == 'False') {
                txtDate.focus();
                throw ("Past Date is not allowed");
                return;
            }
			
			
        }
    } catch (e) {
        txtDate.focus();
        alert(e);
    }
}

// DatePicker User control check date validation
function chkDatePickerDt(txtDate, DtFormat, IsFutureDt, IsPastDt) {
    try {
        if (txtDate.value != "") {

            var selectedDate = Date.parseExact(txtDate.value, DtFormat);

            if (selectedDate == null) {
                txtDate.value = '';
                txtDate.focus();
                alert("Please Enter " + " Date in " + DtFormat + " Format");
                alert("Date is not allowed");
                return;
            }

            var currentDate = Date.today();

            var i = selectedDate.compareTo(currentDate);
            if (i > 0 && IsFutureDt == 'False') {
                txtDate.focus();
                alert("Future Date is not allowed");
                return;
            }

            if (i < 0 && IsPastDt == 'False') {
                txtDate.focus();
                alert("Past Date is not allowed");
                return;
            }
        }
    } catch (e) {
        txtDate.focus();
        alert(e);
    }
}

// DatePicker User control check date validation
function validateDatePickerDate(txtDate, DtFormat, IsFutureDt, IsPastDt, currDate) {
    try {
        if (!WebxConvert.IsObjectNullOrEmpty(txtDate.value)) {

            var selectedDate = Date.parseExact(txtDate.value, DtFormat);

            if (WebxConvert.IsObjectNullOrEmpty(selectedDate)) {
                txtDate.value = '';
                txtDate.focus();
                alert("Please Enter Date in " + DtFormat + " Format");
                return false;
            }

            var currentDate = Date.parseExact(currDate, DtFormat);

            var i = selectedDate.compareTo(currentDate);
            if (i > 0 && IsFutureDt == 'False') {
                alert("Future Date is not allowed");
                txtDate.value = '';
                txtDate.focus();
                return false;
            }

            if (i < 0 && IsPastDt == 'False') {
                alert("Past Date is not allowed");
                txtDate.value = '';
                txtDate.focus();
                return false;
            }
        }

        return true;

    } catch (e) {
        txtDate.focus();
        alert(e);
        return false;
    }
}

// Required field alert
function reqField(ele, fname) {
    if (ele.val() == "") {
        alert('Please fill ' + fname + '...'); setTimeout(function () { ele.val(''); ele.focus(); }, 2); return false;
    }
    return true;
}

jQuery.fn.getSelection = function () {
    if (this.lengh == 0) return -1;
    var s = $(this).getSelectionStart();
    var e = $(this).getSelectionEnd();
    return this[0].value.substring(s, e);
}

jQuery.fn.getSelectionStart = function () {
    if (this.lengh == 0) return -1;
    input = this[0];

    var pos = input.value.length;

    if (input.createRange) {
        var r = document.selection.createRange().duplicate();
        r.moveEnd('character', input.value.length);
        if (r.text == '')
            pos = input.value.length;
        pos = input.value.lastIndexOf(r.text);
    } else if (typeof (input.selectionStart) != "undefined")
        pos = input.selectionStart;

    return pos;
}

jQuery.fn.getSelectionEnd = function () {
    if (this.lengh == 0) return -1;
    input = this[0];

    var pos = input.value.length;

    if (input.createRange) {
        var r = document.selection.createRange().duplicate();
        r.moveStart('character', -input.value.length);
        if (r.text == '')
            pos = input.value.length;
        pos = input.value.lastIndexOf(r.text);
    } else if (typeof (input.selectionEnd) != "undefined")
        pos = input.selectionEnd;

    return pos;
}



var WebxCommon = {

    invokeWebxAJAXRequest: function (url, type, contentType, dataType, data, successFunction, useGlobalAJAXEvents, asyncRequest) {
        try {
            //debugger;
            // alert('in AJAX function');

            // it will be true by default
            var globalSetup = true;
            var asyncSetup = true;

            // needed for JS overloading technique
            if (!(WebxConvert.IsObjectUndefined(useGlobalAJAXEvents))) {
                globalSetup = useGlobalAJAXEvents;
            }

            if (!(WebxConvert.IsObjectUndefined(asyncRequest))) {
                asyncSetup = asyncRequest;
            }

            if (!globalSetup) {
                AJAXState = 1;
            } // if event is NOT global then we have to set it explicitly

            $.ajax({
                type: type,
                contentType: contentType,
                url: url,
                dataType: dataType,
                data: data,
                global: globalSetup,
                async: asyncSetup,
                success: successFunction
            });
        }
        catch (err) {

        }
    },

    getDDLSelectedItemText: function (CntrlIDWithoutPrefix) {
        var CntrlID = controlIdPrefix + CntrlIDWithoutPrefix;
        return $("#" + CntrlID + " :selected").text();
    },

    getDDLSelectedItemValue: function (CntrlIDWithoutPrefix) {
        var CntrlID = controlIdPrefix + CntrlIDWithoutPrefix;
        return $("#" + CntrlID + " option:selected").val();
    },

    getRBLSelectedItemValue: function (CntrlIDWithoutPrefix) {
        var CntrlID = controlIdPrefix + CntrlIDWithoutPrefix;
        return $("#" + CntrlID + " input:checked").val();
    },

    BindDropDownList: function (objddlWithoutPrefix, jsonToBind) {
        var CntrlID = controlIdPrefix + objddlWithoutPrefix;
        if (!WebxConvert.IsObjectNullOrEmpty(jsonToBind)) {
            $("#" + CntrlID + "").empty();
            $.each(jsonToBind, function (i, item) {
                $("#" + CntrlID + "").append($("<option></option>").val
                (item[valueField]).html(item[displayField]));
            });
        }
    },

    getJSONObject: function (jsonData, keytoSearch) {

    },

    getValueFromJSONObject: function (jsonData, keytoSearch, valuetoSearch) {

    },

    IsObjectVisible: function (objectID) {
        try {
            var CntrlID = controlIdPrefix + objectID;

            if (
                ($("#" + CntrlID + "").css("display") == "block") ||
                ($("#" + CntrlID + "").css("display") == "inline") ||
                ($("#" + CntrlID + "").css("display") == "inline-block") ||
                ($("#" + CntrlID + "").css("display") == "inline") ||
                ($("#" + CntrlID + "").css("display") == "block") ||
                ($("#" + CntrlID + "").css("display") == "list-item") ||
                ($("#" + CntrlID + "").css("display") == "run-in") ||
                ($("#" + CntrlID + "").css("display") == "inline-block") ||
                ($("#" + CntrlID + "").css("display") == "table") ||
                ($("#" + CntrlID + "").css("display") == "inline-table") ||
                ($("#" + CntrlID + "").css("display") == "table-row-group") ||
                ($("#" + CntrlID + "").css("display") == "table-header-group") ||
                ($("#" + CntrlID + "").css("display") == "table-footer-group") ||
                ($("#" + CntrlID + "").css("display") == "table-row") ||
                ($("#" + CntrlID + "").css("display") == "table-column-group") ||
                ($("#" + CntrlID + "").css("display") == "table-column") ||
                ($("#" + CntrlID + "").css("display") == "table-cell") ||
                ($("#" + CntrlID + "").css("display") == "table-caption") ||
                ($("#" + CntrlID + "").css("display") == "inherit") ||
                ($("#" + CntrlID + "").css("display") == "compact") ||
                ($("#" + CntrlID + "").css("display") == "")
                ) {
                return true;
            }
            else {
                return false;
            }
        }
        catch (err) {
            return false;
        }
    },

    show: function (objectID, IsPrefixRequired, displayProperty) {
        var CntrlID;
        if (IsPrefixRequired) {
            CntrlID = controlIdPrefix + objectID;
        }
        else {
            CntrlID = objectID;
        }

        // setting default value
        var dispProp = 'inline';

        if (!(WebxConvert.IsObjectUndefined(displayProperty))) {
            dispProp = displayProperty;
        }
        else {
            dispProp = 'inline';
        }

        $("#" + CntrlID + "").css('display', dispProp);
    },

    hide: function (objectID, IsPrefixRequired) {
        var CntrlID;
        if (IsPrefixRequired) {
            CntrlID = controlIdPrefix + objectID;
        }
        else {
            CntrlID = objectID;
        }

        $("#" + CntrlID + "").css('display', 'none');
    },

    ToggleDisability: function (objectID, flag) {
        var CntrlID = controlIdPrefix + objectID;
        $("#" + CntrlID + "").prop('disabled', flag);
    },

    setDDLSelectedIndex: function (obj, index) {
        var CntrlID = controlIdPrefix + obj;
        $("#" + CntrlID + " :nth-child(" + index + ")").prop('selected', true);
    },

    setRBLSelectedIndex: function (obj, index) {
        //alert(obj);
        var CntrlID = controlIdPrefix + obj;
        // alert(CntrlID);
        // $(".clsradio input:nth-child(5)").attr("checked", "checked");
        $("#" + CntrlID + " input:nth-child(" + index + ")").prop("checked", true);
    },

    selectDDLByValue: function (obj, value) {
        //alert(obj);
        var CntrlID = controlIdPrefix + obj;
        // alert(CntrlID);
        $("#" + CntrlID + " option:eq(" + value + ")").prop("selected", true);
    },

    selectRBLByValue: function (obj, value) {
        //alert(obj);
        var CntrlID = controlIdPrefix + obj;
        // alert(CntrlID);
        $("#" + CntrlID + "").find("input[value='" + value + "']").prop("checked", true);

    },

    addItemToDropDown: function (objDropDown, text, value) {
        var CntrlID = controlIdPrefix + objDropDown;
        $("#" + CntrlID + "").append($("<option></option>").val(value).html(text));
    },

    disableTableContents: function (tblId) {
        $('[id=' + tblId + ']').find('input,button,textarea,select,a,img').prop('disabled', true);
    },

    getDDLSelectedIndex: function (obj, index) {
        var CntrlID = controlIdPrefix + obj;
        return $("#" + CntrlID + "").prop('selectedIndex');
    },

    // function will compare source date with target date
    // returns true if source > target
    compareDates: function (sourceDate, targetDate, format) {

        var dateFormat = '';
        if (!(WebxConvert.IsObjectUndefined(format))) {
            dateFormat = format;
        }
        else {
            dateFormat = 'dd/MM/yyyy';
        }

        var objSourceDate = Date.parseExact(sourceDate, dateFormat);
        var objTargetDate = Date.parseExact(targetDate, dateFormat);

        if (objSourceDate > objTargetDate) {
            return true;
        }

        return false;
    },

    disableCopyPaste: function (objectID, IsPrefixRequired) {

        var CntrlID;
        if (IsPrefixRequired) {
            CntrlID = controlIdPrefix + objectID;
        }
        else {
            CntrlID = objectID;
        }

        $("#" + CntrlID).bind("paste", function (e) {
            return false;
        });
        // Restricting the Cut from textbox
        $("#" + CntrlID).bind("cut", function (e) {
            return false;
        });
        // Restricting the Copy from textbox
        $("#" + CntrlID).bind("copy", function (e) {
            return false;
        });
        // Restricting the drag and drop any value into textbox
        $("#" + CntrlID).bind("drop", function (e) {
            return false;
        });
    },

    // To use below function, add ProgressBarJS User control in the page and give 'AJAXloadingContainer' ID to your Container //
    ShowAJAXProgressBar: function () {
        $('#Progress_Bar').show();
        $('#AJAXloadingContainer').prop('disabled', true);
    },

    HideAJAXProgressBar: function () {
        $('#Progress_Bar').hide();
        $('#AJAXloadingContainer').prop('disabled', false);
    },

    validateHHTime: function (objControl, timeFormat) {
        if (!WebxConvert.IsObjectNullOrEmpty(objControl.val())) {
            var mode = '';
            if (!(WebxConvert.IsObjectUndefined(timeFormat))) {
                mode = timeFormat;
            }
            else {
                mode = '24HR';
            }

            if (objControl.val().length < 2) {
                alert("Please Enter valid Time in HH format");
                objControl.val('');
                objControl.focus();
                return false;
            }

            if (mode == '24HR') {
                if ((WebxConvert.objectToInt(objControl.val(), 0) > 23) || (WebxConvert.objectToInt(objControl.val(), 0) == 0)) {
                    alert("Please Enter valid Time in HH and should be between 01 to 23");
                    objControl.val('');
                    objControl.focus();
                    return false;
                }
            }
            else {
                if (objControl.val().length < 2) {
                    alert("Please Enter valid Time in HH i.e. 05, 06 etc");
                    objControl.val('');
                    objControl.focus();
                    return false;
                }
                if ((WebxConvert.objectToInt(objControl.val(), 0) > 12) || (WebxConvert.objectToInt(objControl.val(), 0) == 0)) {
                    alert("Please Enter valid Time in HH and should be between 01 to 12");
                    objControl.val('');
                    objControl.focus();
                    return false;
                }
            }
        }

        return true;
    },

    validateMMTime: function (objControl) {
        if (!WebxConvert.IsObjectNullOrEmpty(objControl.val())) {
            if (objControl.val().length < 2) {
                alert("Please Enter valid Time in MM format");
                objControl.val('');
                objControl.focus();
                return false;
            }
            if ((WebxConvert.objectToInt(objControl.val(), 0) > 59) || (WebxConvert.objectToInt(objControl.val(), 0) < 0)) {
                alert("Please Enter valid Time in MM and should be between 0 to 59");
                objControl.val('');
                objControl.focus();
                return false;
            }
        }

        return true;
    },

    selectDDLByText: function (obj, text, IsPrefixRequired) {

        var CntrlID;
        if (!(WebxConvert.IsObjectUndefined(IsPrefixRequired))) {
            if (IsPrefixRequired) {
                CntrlID = controlIdPrefix + obj;
            }
            else {
                CntrlID = obj;
            }
        }
        else {
            CntrlID = controlIdPrefix + obj;
        }

        $("#" + CntrlID + " option:contains(" + text + ")").attr('selected', 'selected');
    },

    convertDateToMMddyyyy: function (str) {
        if (!WebxConvert.IsObjectNullOrEmpty(str)) {
            var arrDate = new Array();
            arrDate = str.split('/');
            return arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
        }
        else {
            return '';
        }
    },

    disableDatePicker: function (objSelector) {
        $(objSelector).datepicker('disable');
    },

    destroyDatePicker: function (objSelector) {
        $(objSelector).datepicker('disable');
    },

    // The function will be used to Search JSON object i.e. filter JSON as per the params passed
    //EXAMPLE SNIPPET : var selectedObjs = SearchJSONLinq({
    //    select: "TripsheetNo,ExpenseID,ExpenseHeader,LegCode,LegDesc,ActualAmt,StdAmt,TotalActualAmt,TotalStandardAmt",
    //    from: objJSON,
    //    where: [{ "KEY": "ExpenseID", "OPERATOR": "=", "VALUE": "'06'" }, { "KEY": "ExpenseID", "OPERATOR": "=", "VALUE": "'08'" }],
    //    conditions: [{ "Condition1": "0", "CONDITION": "Or", "Condition2": "1" }]
    //});
    SearchJSONLinq: function (s) {
        var returnObj = new Array();
        var cntr = 0;
        $.each(s.from, function (bb) {
            var ifConditions = new Array();
            $.each(s.where, function (cnt) {
                ifConditions[cnt] = new Object();
                var where = "";
                if (s.where[cnt].OPERATOR.indexOf("=") == 0)
                    where = "==";
                if (s.where[cnt].VALUE.indexOf("'") > -1)
                    ifConditions[cnt] = eval("'" + eval("s.from[bb]." + (eval("s.where[" + cnt + "].KEY"))) + "'" + where + eval("s.where[" + cnt + "].VALUE"));
                else
                    ifConditions[cnt] = eval(eval("s.from[bb]." + (eval("s.where[" + cnt + "].KEY"))) + where + eval("s.where[" + cnt + "].VALUE"));
            });
            var comparedOutput = true;
            $.each(s.conditions, function (cnt) {
                var condition = "";
                switch (s.conditions[cnt].CONDITION.toUpperCase()) {
                    case "AND":
                        condition = "&&";
                        break;
                    case "OR":
                        condition = "||";
                        break;
                }
                comparedOutput = comparedOutput && eval("ifConditions[" + s.conditions[cnt].Condition1 + "]" + condition + "ifConditions[" + s.conditions[cnt].Condition2 + "]");
            });
            if (comparedOutput) {
                var result = {};
                var cols = s.select.split(",");
                for (var cnt = 0; cnt < cols.length; cnt++) {
                    result[cols[cnt]] = eval("s.from[bb]." + cols[cnt]);
                }
                returnObj.push(result);
            }
        });
        return returnObj;
    },

    AjaxRequestWithPostAndJsonV2: function (url, data, successFunction, useGlobalAJAXEvents) {
        var globalSetup = true;
        // needed for JS overloading technique
        if (!(WebxConvert.IsObjectUndefined(useGlobalAJAXEvents))) {
            globalSetup = useGlobalAJAXEvents;
        }

        WebxCommon.invokeWebxAJAXRequest(url, "POST", "application/json; charset=utf-8", "json", data, successFunction, globalSetup, true);
    },

    SyncAjaxRequestWithPostAndJsonV2: function (url, data, successFunction) {
        WebxCommon.invokeWebxAJAXRequest(url, "POST", "application/json; charset=utf-8", "json", data, successFunction, true, false);
    }
}

function TimePicker_LoadOnCallBack(objId) {
    $('#' + objId).timepicker({
        timeFormat: 'HH:mm',
        interval: 10//interval in minute between two data        
    });
}

function CheckValidSelection(control, caller, allowZero) {
    return CheckValidNumberInputJquey(control, caller, allowZero, 'Select');
}


function CheckValidSelectionV2(control, caller, IsSelectIncluded) {
    var isSelect = true;
    if (!(WebxConvert.IsObjectUndefined(IsSelectIncluded))) {
        isSelect = IsSelectIncluded;
    }
    
    if (isSelect) {
        if (control.prop('selectedIndex') <= 0) { // if select is there then index will be 0 so not allowed
            alert("Please Select " + caller);
            control.focus();
            return false;
        }
    }
    else {
        if (control.prop('selectedIndex') < 0) { // if select is not there then index will be -1
            alert("Please Select " + caller);
            control.focus();
            return false;
        }
    }

    return true;
}

function CheckValidNumberInputJquey(control, caller, allowZero, selectEnter) {
    if (control.val().trim() == '') {
        control.select();
        if (selectEnter == 'Select') {
            alert('Please Select ' + caller);
        }
        else {
            alert('Please Enter ' + caller);
        }
        control.focus();
        return false;
    }
    else if (parseFloat(control.val().trim()) == 0 && !allowZero) {
        control.select();
        if (selectEnter == 'Select') {
            alert('Please Select ' + caller);
        }
        else {
            alert('Please Enter ' + caller);
        }
        control.focus();
        return false;
    }
    return true;
}

function CheckValidInput(control, caller) {
    if (control.val().trim() == '') {
        control.select();
        alert('Please Enter ' + caller);
        return false;
    }
    return true;
}

function CheckValidInputDate(control, caller) {
    if (control.val().trim() == '') {
        control.select();
        alert('Please Select ' + caller + ' Date');
        return false;
    }
    else if (!isValidDate(control.val().trim(), caller)) {
        control.select();
        control.val('');
        return false;
    }
    return true;
}

function CheckFromToDate(fromDate, toDate) {
    var ToDay = new Date();
    var MinDate = new Date("01/01/1950");
    var FromDate = document.getElementById(fromDate);
    var ToDate = document.getElementById(toDate);
    var FD = new Date(DateString(FromDate.value));
    var TD = new Date(DateString(ToDate.value));

    var regex = new RegExp("^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$");

    if (FromDate.value == "") {
        alert("Please enter From Date");
        FromDate.focus();
        return false;
    }
    else if (regex.test(FromDate.value) == false) {
        alert("The date format should be : dd/mm/yyyy");
        FromDate.focus();
        return false;
    }
    else if (ToDate.value == "") {

        alert("Please enter To Date");
        ToDate.focus();
        return false;
    }
    else if (regex.test(ToDate.value) == false) {
        alert("The date format should be : dd/mm/yyyy");
        ToDate.focus();
        return false;
    }
    else if (TD > ToDay) {
        alert("To Date should be Less than Today");
        ToDate.focus();
        return false;
    }
    else if (TD < MinDate) {
        alert("To Date should be Greater than 01/01/1950");
        ToDate.focus();
        return false;
    }
    else if (FD > TD) {
        alert("To Date should be Greater than From Date");
        ToDate.focus();
        return false;
    }
}

function DateString(str) {
    var arrDate = new Array();
    arrDate = str.split('/');
    return arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
}

// created seperate version with different name due to function name conflict i.e. CheckFromToDate (which is already exists in common.js)
function validateRPTDate(FromDate, ToDate, currentDate) {
    var ToDay = Date.parseExact(currentDate, "dd/MM/yyyy");
    var MinDate = new Date("01/01/1950");
    var FD = Date.parseExact(FromDate.val(), "dd/MM/yyyy");
    var TD = Date.parseExact(ToDate.val(), "dd/MM/yyyy");

    var regex = new RegExp("^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$");

    if (WebxConvert.IsObjectNullOrEmpty(FromDate.val())) {
        alert("Please enter From Date");
        FromDate.focus();
        return false;
    }
    else if (!regex.test(FromDate.val())) {
        alert("The date format should be : dd/mm/yyyy");
        FromDate.focus();
        return false;
    }
    else if (WebxConvert.IsObjectNullOrEmpty(ToDate.val())) {

        alert("Please enter To Date");
        ToDate.focus();
        return false;
    }
    else if (regex.test(ToDate.val()) == false) {
        alert("The date format should be : dd/mm/yyyy");
        ToDate.focus();
        return false;
    }
    else if (TD > ToDay) {
        alert("To Date should be Less than Today");
        ToDate.focus();
        return false;
    }
    else if (TD < MinDate) {
        alert("To Date should be Greater than 01/01/1950");
        ToDate.focus();
        return false;
    }
    else if (FD > TD) {
        alert("To Date should be Greater than From Date");
        ToDate.focus();
        return false;
    }

    return true;
}

//Setting async to false means that the statement you are calling has to complete before the next statement in your function can be called.
//If you set async: true then that statement will begin it's execution and the next statement will be called regardless of whether the async statement has completed yet.
function AjaxRequest(url, type, contentType, dataType, data, successFunction, errorFunction, async) {
    $.ajax({
        type: type,
        contentType: contentType,
        url: url,
        data: data,
        dataType: dataType,
        success: successFunction,
        error: errorFunction,
        async: async
    });
}
function AjaxRequestWithPostAndJson(url, data, successFunction, errorFunction, async) {
    AjaxRequest(url, "POST", "application/json; charset=utf-8", "json", data, successFunction, errorFunction, async)
}
function errorFunction(request, status, error) {
}

// Input Formate - dd MMM yyyy HH : MM
// OutPut Formate - dd MMM yyyy
// Use Convert Date Formate 
function GetDateFormate(dateVal) {
    var d = new Date(dateVal);
    var day = d.getDate();
    if (day < 10) {
        day = '0' + day;
    }
    var year = d.getFullYear();
    var month = d.getMonth();
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    var currentMonth = months[month];
    return (day + ' ' + currentMonth + ' ' + year)
}

function ShowDataInJqGrid(gridId, menuId, data, source, columns, exportFileName, reportWidth, pagesizeoptions, autoResize) {

    var dataAdapter = new $.jqx.dataAdapter(source);
    $('#' + gridId).jqxGrid(
    {
        width: reportWidth,
        source: dataAdapter,
        autoheight: true,
        pageable: true,
        altrows: true,
        filterable: true,
        sortable: true,
        autoshowfiltericon: true,
        selectionmode: 'multiplecellsextended',
        columns: columns,
        ready: function () {
            $('#' + gridId).jqxGrid({ pagesizeoptions: pagesizeoptions });
        }
    });

    if (autoResize)
        $('#' + gridId).jqxGrid('autoresizecolumns');

    // create context menu  // height: 87
    var contextMenu = $('#' + menuId).jqxMenu({ width: 150, height: 120, autoOpenPopup: false, mode: 'popup', theme: exampleTheme });
    $('#' + gridId).on('contextmenu', function () {
        return false;
    });

    // handle context menu clicks.
    $('#' + menuId).on('itemclick', function (event) {
        var args = event.args;
        var exportTo = $.trim($(args).attr('export-type'));
        $('#' + gridId).jqxGrid('exportdata', exportTo, exportFileName);
    });

    $('#' + gridId).on('rowclick', function (event) {
        if (event.args.rightclick) {
            $('#' + gridId).jqxGrid('selectrow', event.args.rowindex);
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
            return false;
        }
        return false;
    });
}
/************************************************************************************************
Author :- Sandeep Maurya related to error () on 16 Dec 2016 10:24 PM
Desc :- To compare 2 dates with all the combination of tense
*************************************************************************************************/

function IsCompareDateTense(DateValue1, DateValue2,tense) {
    if (DateValue2 == "")
        DateValue2 = GetCurrentDate();
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];
    if (tense == 'PastNPresent') {
        if (Date.parse(DateValue1) <= Date.parse(DateValue2))
            return true;
        else
            return false;
    }
    else if(tense == 'Past'){
        if (Date.parse(DateValue1) < Date.parse(DateValue2))
            return true;
        else
            return false;
    }
    else if (tense == 'Future') {
        if (Date.parse(DateValue1) > Date.parse(DateValue2))
            return true;
        else
            return false;
    }
    else if (tense == 'FutureNPresent') {
        if (Date.parse(DateValue1) >= Date.parse(DateValue2))
            return true;
        else
            return false;
    }
    else if (tense == 'Present') {
        if (Date.parse(DateValue1) == Date.parse(DateValue2))
            return true;
        else
            return false;
    }
}


//common Autocomplete method for GST Master
function AutoCompleteForV1(eleId, url, type, contentType, dataType, prefixText, focus, select, s1, s2, EvalOrtext, eleVal, alertMsg, minPrefixLength, additionalData, disableNotFoundAlert) {
    $(eleId).autocomplete({
        minLength: minPrefixLength,
        source: function (request, response) {

            var requestData, svcUrl;

            type = type.toUpperCase();
            if (type == "POST") {
                requestData = "{'" + prefixText + "': '" + request.term + "'";

                if (additionalData != undefined && additionalData != null) {
                    var addData = additionalData.split(',');
                    for (var i = 0; i < addData.length; i++) {
                        var keyval = addData[i].split('=');
                        requestData += (", '" + keyval[0] + "': '" + $('#' + keyval[1]).val() + "'");
                    }
                }
                requestData += "}";
                svcUrl = url;
            }
            else {
                svcUrl = url + "?" + prefixText + "=" + request.term;
            }

            $.ajax({
                type: type,
                contentType: contentType,
                url: svcUrl,
                dataType: dataType,
                data: requestData,
                success: function (data) {
                    if (data.d.length != 0) {
                        var retOut;
                        try {
                            retOut = jQuery.parseJSON(data.d);
                        } catch (e) { retOut = data.d; }

                        response($.map(retOut, function (item) {
                            return {
                                label: item.Name,
                                value: item.Value
                            }
                        }));
                    } else {
                        if (disableNotFoundAlert == undefined || disableNotFoundAlert == null || disableNotFoundAlert == false) {
                            alert(alertMsg);
                        }
                        $(eleId).val("");
                        $("#" + eleVal).val('');
                    }
                },
                error: function (errormessage) {
                    alert(errormessage.message);
                }
            })
        },
        open: function (event, ui) { disableACblur = true; return false; },
        close: function (event, ui) { disableACblur = false; return false; },
        focus: function (event, ui) {
            if (focus == 'v') { $(this).val(ui.item.value); }
            else if (focus == 'l') { $(this).val(ui.item.label); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); }
            return false;
        },
        select: function (event, ui) {
            if (select == 'v') { $(this).val(ui.item.value); $("#" + eleVal).val(ui.item.value); }
            else if (select == 'l') { $(this).val(ui.item.label); $("#" + eleVal).val(ui.item.value); }
            else { $(this).val(ui.item.label + " : " + ui.item.value); $("#" + eleVal).val(ui.item.value); }

            if (EvalOrtext == 'v') { $("#" + eleVal).val(ui.item.value); }
            else { $("#" + eleVal).val(ui.item.label); }

            return false;
        }
    })
    .data("ui-autocomplete")._renderItem = function (ul, item) {
        var rs1, rs2;
        if (s1 == 'v') { rs1 = item.value; }
        else if (s1 == 'l') { rs1 = item.label; }
        if (s2 == 'v') { rs2 = item.value; }
        else if (s2 == 'l') { rs2 = item.label; }
        return $("<li>")
        .append("<a>" + rs1 + " : " + rs2 + "</a>")
        .appendTo(ul);
    };
}


/************************************************************************************************
Author :- Sandeep Maurya related to error () on 16 Dec 2016 10:24 PM
Desc :- To get current date in  26/12/2016 format
*************************************************************************************************/
function GetCurrentDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!

    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd
    }
    if (mm < 10) {
        mm = '0' + mm
    }
    return today = dd + '/' + mm + '/' + yyyy;
}
