
var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
var FRM_Name = "ctl00_MyCPH1_"

//********************************
function Customer_Location_Blur(Obj, Mode, Acct_Y_N) {
    if (Obj.value == "") {
        return false;
    }
    var Search_Char = "~"
    if (Obj.value.indexOf(Search_Char) == -1) {
        alert("Invalid  " + Mode + "  Name~Code Format");
        Obj.focus();
        return false
    }
    Obj.value = Obj.value.toUpperCase()
    var Code_ID = Obj;

    var Code_Value = Code_ID.value;
    Code_Value_Arr = Code_Value.split("~");

    var Code_Value_0 = Code_Value_Arr[0]
    var Code_Value_1 = Code_Value_Arr[1]

    if (Code_Value_1 == "")
        return false;

    var findobj = false;
    findobj = GetXMLHttpObject();

    if (findobj) {
        //alert("Hi..1")
        //alert(Code_Value_1)
        //alert(Mode)
        var strpg = "../CheckExist.aspx?Mode=" + Mode + "&Code=" + Code_Value_1 + "&sid=" + Math.random();
        findobj.open("GET", strpg, true);
        findobj.onreadystatechange = function () {
            // alert("Hi..2")
            // alert(findobj.readyState)
            // alert(findobj.status)
            if (findobj.readyState == 4 && findobj.status == 200) {
                //alert(findobj.responseText)
                var res = findobj.responseText.split("|");

                if (res[0] == "false") {
                    alert(Mode + "  Code is not Valid... Please Enter Valid " + Mode + " Code");
                    Code_ID.value = "";
                    Code_ID.focus();
                    return false;
                }

            }
        }
        findobj.send(null);
    }
    return false;
}

function OnSubmit_Submission() {

    if (document.getElementById(FRM_Name + 'txtTripsheetNo').value == "")
    {
        //if (document.getElementById(FRM_Name + 'Txt_Customer').value == "")
        //{
        //    alert("Plz Enter Customer Name~Code Format")
        //    document.getElementById(FRM_Name + 'Txt_Customer').focus();
        //    return false;
        //}
        var Search_Char = "~"
        //if (document.getElementById(FRM_Name + 'Txt_Customer').value.indexOf(Search_Char) == -1) 
        //{
        //    alert("Invalid Customer Name~Code Format");
        //    document.getElementById(FRM_Name + 'Txt_Customer').focus();
        //    return false
        //}
        if (document.getElementById(FRM_Name + 'DT_radDate_0').checked) {

            if (document.getElementById(FRM_Name + 'DT_txtDateFrom').value == "") {
                alert("Plz Enter From date")
                document.getElementById(FRM_Name + 'DT_txtDateFrom').focus();
                return false;
            }
            if (document.getElementById(FRM_Name + 'DT_txtDateTo').value == "") {
                alert("Plz Enter To date")
                document.getElementById(FRM_Name + 'DT_txtDateTo').focus();
                return false;
            }
        }
    }
    return true;
}


/*************************************************************************************************************
             FUNCTION FOr Check All
*************************************************************************************************************/
var FRM_NM = "ctl00_MyCPH1_"
function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind, CalC_YN) {

    Grid_Id = Grd_Name
    var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
    var rows = grid.rows.length;
    var Check_One = "N"
    var Total_amount = "0.00", NetAmt = "0.00", TotalNetAmt = "0.00"
    if (document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked) {
        for (var b = 2; b <= rows - 1; b++) {
            //alert(b)
            if (b < 10) {
                GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
            }
            else {
                GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
            }

            document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = true

        }
    }
    else {
        for (var b = 2; b <= rows - 1; b++) {
            //alert(b)
            if (b < 10) {
                GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
            }
            else {
                GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
            }

            document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = false

        }
    }
    if (CalC_YN == "Y") {
        Check_Calc('dockdata', 'ChkAll', 'chkOrderNo')
    }
}

function Check_Calc(gvExternalThcData, Obj_chk_All, Obj_Chk_Ind) {

    Grid_Id = Grd_Name
    var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
    var rows = grid.rows.length;
    var Check_One = "N"
    var Total_amount = "0.00", NetAmt = "0.00", TotalNetAmt = "0.00"
    var Total_adv_amt = "0.00", Total_PendAmt = "0.00"
    var Total_billAmount = "0"
    for (var b = 2; b <= rows - 1; b++) {
        if (b < 10) {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
        }
        else {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
        }
        if (document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked) {
            Total_billAmount = rounditn(parseFloat(document.getElementById(GV_FRM_NM + "Hnd_Dkttot").value) + parseFloat(Total_billAmount), 2)
            document.getElementById(FRM_NM + "Txt_BillAmt").value = rounditn(Total_billAmount, 2)
            if (document.getElementById(FRM_NM + "Hnd_ON_CR_Limit_Allow").value == "N") {
                if (parseFloat(Total_billAmount) > parseFloat(document.getElementById(FRM_NM + "Lbl_Credit_Limit").innerText)) {
                    alert("Bill Amount Should be Less then Or Equals to Credit Limit For The Same Customer.")
                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = false
                    document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked = false
                    Total_billAmount = rounditn(parseFloat(Total_billAmount) - parseFloat(document.getElementById(GV_FRM_NM + "Hnd_Dkttot").value), 2)
                }
            }
        }
        document.getElementById(FRM_NM + "Txt_BillAmt").value = rounditn(Total_billAmount, 2)
    }
}


/*****************************************************************************************************************
THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
return type XMLHttpObject
*****************************************************************************************************************/
function GetXMLHttpObject() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
    }
    catch (e) {
        // Internet Explorer    
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e) {
            try
            { xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }
    return xmlHttp;
}

/*************************************************************************************************************
FUNCTION VALIDATES DATESTR........ UT STR IS ONLY STRING TO DISPLAY CONTROL NAME
*************************************************************************************************************/

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


