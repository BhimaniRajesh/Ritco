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

function PanelShowHide(PanelId) {
   
    var pnl = document.getElementById(PanelId);
    if (pnl.style.display == "none") {
        pnl.style.display = "block";
        pnl.style.visibility = "visible";
    }
    else {
        pnl.style.display = "none";
        pnl.style.visibility = "hidden";
    }
    
}
function Disable(reportViewerID) {
    var exportList = document.getElementById(reportViewerID + '_ctl01_ctl05_ctl00');
    exportList.options.length = 0;
    exportList.innerHTML = '';
    appendOption(exportList, 'Select a format', '');
    appendOption(exportList, 'Excel', 'EXCEL');
    appendOption(exportList, 'PDF', 'PDF');
    appendOption(exportList, 'CSV', 'CSV');
}
function appendOption(listCtrl, optionText, optionValue) {
    var newOption = document.createElement('option');
    newOption.text = optionText;
    newOption.value = optionValue;
    try {
        listCtrl.add(newOption, null);
    }
    catch (ex) {
        listCtrl.add(newOption);
    }
}

function DateString(str) {
    var arrDate = new Array();
    arrDate = str.split('/');
    return arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
}

function BirthDate(id) {
    var dob = document.getElementById(id);
    var DOB = new Date(DateString(dob.value));
    var ToDay = new Date();
    var diff = ToDay.getFullYear() - DOB.getFullYear()

    if (dob.value == "") {
        //alert("Please Fill Date of Birth.")
        //dob.focus();

    }
    else {
        check_DD_MM_YYYY(id);
        if (DOB >= ToDay) {
            alert("Birth Date must be less than Today.");
            dob.focus();
            return false;
        }
        else if (diff < 18) {
            alert("Age must be minimum 18 years.");
            dob.focus();
            return false;
        }
        else if (diff > 70) {
            alert("Age must be less than 70  years.")
            dob.focus();
            return false;

        }
    }
}

function JoiningDate(id) {
    var doj = document.getElementById(id);
    var DOJ = new Date(DateString(doj.value));
    var ToDay = new Date();
    var diff = ToDay.getFullYear() - DOJ.getFullYear()

    if (doj.value == "") {
        //        alert("Please Fill Date of Joining...");
        //doj.focus();
        //return false;
    }
    else {
        check_DD_MM_YYYY(id);
        if (DOJ >= ToDay) {
            alert("Joining Date should be less than or equal to Today.");
            doj.focus();
            return false;
        }
        else
            if (diff > 50) {
            alert("Joining Date should not be greater than 50  years from Today.");
            doj.focus();
            return false;
        }
    }
}

function check_DD_MM_YYYY(id) {
    var regex = new RegExp("^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$");
    var txtDateId = document.getElementById(id);
    if (!regex.test(txtDateId.value)) {
        alert("Please Fill Date in DD/MM/YYYY.");
        txtDateId.focus();
        return false;
    }
}
