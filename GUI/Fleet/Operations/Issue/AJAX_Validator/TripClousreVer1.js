// JScript File

function CheckLogEntryStardate(row_Index, txtStartDate, lblIssueDt, txtDateFrom) {
    var currentTime = new Date();
    var txtDateOpClose = document.getElementById("ctl00_MyCPH1_txtDateOpClose");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");

    var cDate = "";
    if (txtDateFrom.value == "") {
        if (txtDateOpClose.value == "") {
            txtStartDate.value = "";
            lblError.innerText = "Please Enter The Operational or Financial Close date!!!";
            txtDateOpClose.style.borderColor = "red";
            txtDateOpClose.style.borderColor = "red";
            txtDateOpClose.focus();
            return false;
        }
        else {
            lblError.innerText = "";
            txtDateOpClose.style.borderColor = "";
            txtDateOpClose.style.borderColor = "";
            cDate = txtDateOpClose.value;
        }
    }
    else {
        cDate = txtDateFrom.value;
        lbl_VehicleLog_Err.innerText = "";
        txtDateFrom.style.borderColor = "";
        txtStartDate.style.borderColor = "";
    }

    if (txtStartDate.value != "") {
        if (!isDate(txtStartDate.value)) {
            txtStartDate.style.borderColor = "red";
            lbl_VehicleLog_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtStartDate.focus();
            return false;
        }
        else {
            txtStartDate.style.borderColor = "";
            lbl_VehicleLog_Err.innerText = "";
        }
        if (lblIssueDt.innerText != txtStartDate.value) {
            if (IsDateGreater(lblIssueDt.innerText, txtStartDate.value)) {
                lbl_VehicleLog_Err.innerText = "Start Date should be greater than or equal to Issue Slip date!!!";
                txtStartDate.style.borderColor = "red";
                txtStartDate.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtStartDate.style.borderColor = "";
            }
        }
        if (txtStartDate.value != cDate) {
            if (IsDateGreater(txtStartDate.value, cDate)) {
                lbl_VehicleLog_Err.innerText = "Start Date should be Less than or Equal to Operational or Financial Close date!!!";
                txtStartDate.style.borderColor = "red";
                txtStartDate.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtStartDate.style.borderColor = "";
            }
        }
    }

    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

    var str_Index = "";
    var p_str_Index = "";
    str_Index = parseFloat(row_Index) + 2;
    p_str_Index = parseFloat(row_Index) + 1;
    if (parseFloat(str_Index) < 10) {
        str_Index = "0" + str_Index;
    }
    if (parseFloat(p_str_Index) < 10) {
        p_str_Index = "0" + p_str_Index;
    }
    if (parseFloat(str_Index) <= gvVehicleLogEntry.rows.length) {
        var txtEndKM = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry_ctl" + p_str_Index + "_txtEndKM");
        var txtStartKM = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry_ctl" + str_Index + "_txtStartKM");
        if (txtEndKM != null) {
            txtStartKM.value = txtEndKM.value;
        }
    }

}

function CheckLogEntryEndDate(txtEndDate, txtStartDate, txtDateFrom) {
    //alert("Hi1");
    var currentTime = new Date()
    var txtDateOpClose = document.getElementById("ctl00_MyCPH1_txtDateOpClose");
    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var lblError = document.getElementById("ctl00_MyCPH1_lblError");

    var cDate = "";
    if (txtDateFrom.value == "") {
        if (txtDateOpClose.value == "") {
            txtStartDate.value = "";
            lblError.innerText = "Please Enter The Operational or Financial Close date!!!";
            txtDateOpClose.style.borderColor = "red";
            txtDateOpClose.style.borderColor = "red";
            txtDateOpClose.focus();
            return false;
        }
        else {
            lblError.innerText = "";
            txtDateOpClose.style.borderColor = "";
            txtDateOpClose.style.borderColor = "";
            cDate = txtDateOpClose.value;
        }
    }
    else {
        cDate = txtDateFrom.value;
        lbl_VehicleLog_Err.innerText = "";
        txtDateFrom.style.borderColor = "";
        txtStartDate.style.borderColor = "";
    }

    if (txtEndDate.value != "") {
        if (!isDate(txtEndDate.value)) {
            txtEndDate.style.borderColor = "red";
            lbl_VehicleLog_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtEndDate.focus();
            return false;
        }
        else {
            txtEndDate.style.borderColor = "";
            lbl_VehicleLog_Err.innerText = "";
        }
        if (txtStartDate.value != txtEndDate.value) {
            if (IsDateGreater(txtStartDate.value, txtEndDate.value)) {
                lbl_VehicleLog_Err.innerText = "End Date should be greater than or equal to Start date!!!";
                txtEndDate.style.borderColor = "red";
                txtEndDate.value = "";
                txtEndDate.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtEndDate.style.borderColor = "";
            }
        }
        if (txtEndDate.value != cDate) {
            if (IsDateGreater(txtEndDate.value, cDate)) {
                lbl_VehicleLog_Err.innerText = "End Date should be Less than or Equal to Operational or Financial Close date!!!";
                txtEndDate.style.borderColor = "red";
                txtEndDate.value = "";
                txtEndDate.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtEndDate.style.borderColor = "";
            }
        }
    }
}
function CheckKMRun1(row_Index, txtStartKM, txtEndKM, txtKMRun, lblStartKm, txtCloseKM) {
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");

    if (txtStartKM.value != "" && txtStartKM.value != null) {
        if (txtEndKM.value != "" && txtEndKM.value != null) {
            txtKMRun.value = parseFloat(txtEndKM.value) - parseFloat(txtStartKM.value)
        }

        var str_Index = "";
        var n_str_Index = "", p_str_Index = "";

        p_str_Index = parseFloat(row_Index) + 1;
        str_Index = parseFloat(row_Index) + 2;
        n_str_Index = parseFloat(row_Index) + 3;

        if (parseFloat(str_Index) < 10) {
            str_Index = "0" + str_Index;
        }
        if (parseFloat(n_str_Index) < 10) {
            n_str_Index = "0" + n_str_Index;
        }
        if (parseFloat(p_str_Index) < 10) {
            p_str_Index = "0" + p_str_Index;
        }

        var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

        var n_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtStartKM");
        var n_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtEndKM");

        var p_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtStartKM");
        var p_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtEndKM");

        if (p_txtStartKM != null) {
            if (parseFloat(txtStartKM.value) < parseFloat(p_txtEndKM.value)) {
                lbl_VehicleLog_Err.innerText = "Start KM Should be Greater than or Equal to previous End KM";
                txtStartKM.style.borderColor = "red";
                txtStartKM.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtStartKM.style.borderColor = "";
            }
        }
    }
    //    var lbl_VehicleLog_Err=document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");

    //    if(txtStartKM.value!="" && txtStartKM.value!=null)
    //    {  
    //        if(txtStartKM.value==""){txtStartKM.value="0";}

    //        if(txtCloseKM.value=="")
    //        {
    //            txtStartKM.value="";
    //            lbl_VehicleLog_Err.innerText ="Please Enter The Closing KM. Reading";
    //            txtCloseKM.style.borderColor="";
    //            txtCloseKM.focus();
    //            return false;
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtCloseKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtStartKM.value)<parseFloat(lblStartKm.innerText))
    //        {
    //            lbl_VehicleLog_Err.innerText ="Start KM Should be Greater than or equal to Starting KM. Reading";
    //            txtStartKM.style.borderColor="red";
    //            txtStartKM.focus();
    //            return false; 
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtStartKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtStartKM.value)>parseFloat(txtCloseKM.value))
    //        {
    //            lbl_VehicleLog_Err.innerText ="Start KM Should be Less than or equal to Closing KM. Reading";
    //            txtStartKM.style.borderColor="red";
    //            txtStartKM.focus();
    //            return false; 
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtStartKM.style.borderColor="";
    //        }
    //        
    //        if(parseFloat(txtStartKM.value)==parseFloat(txtEndKM.value))
    //        {
    //            lbl_VehicleLog_Err.innerText ="Start KM Should not be equal to End KM";
    //            txtStartKM.style.borderColor="red";
    //            txtStartKM.focus();
    //            return false;
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtStartKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtStartKM.value)!=parseFloat(txtEndKM.value))
    //        {
    //            if(parseFloat(txtStartKM.value)>parseFloat(txtEndKM.value))
    //            {
    //                lbl_VehicleLog_Err.innerText ="Start KM Should be Less than End KM";
    //                txtStartKM.style.borderColor="red";
    //                txtStartKM.focus();
    //                return false;
    //            }
    //            else
    //            {
    //                lbl_VehicleLog_Err.innerText ="";
    //                txtStartKM.style.borderColor="";
    //            }
    //        }

    //        
    //        

    //        if(txtEndKM.value!="" && txtEndKM.value!=null )
    //        {
    //            txtKMRun.value=parseFloat(txtEndKM.value)-parseFloat(txtStartKM.value)
    //        }   

    //        var str_Index = "";
    //        var n_str_Index = "",p_str_Index ="";

    //        p_str_Index = parseFloat(row_Index) + 1;
    //        str_Index = parseFloat(row_Index) + 2;
    //        n_str_Index = parseFloat(row_Index) + 3; 

    //        if (parseFloat(str_Index) < 10)
    //        {
    //            str_Index = "0" + str_Index;
    //        }
    //        if (parseFloat(n_str_Index) < 10)
    //        {
    //            n_str_Index = "0" + n_str_Index;
    //        }
    //        if (parseFloat(p_str_Index) < 10)
    //        {
    //            p_str_Index = "0" + p_str_Index;
    //        }

    //        var gvVehicleLogEntry=document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

    //        var n_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtStartKM");
    //        var n_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtEndKM");

    //        var p_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtStartKM");
    //        var p_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtEndKM");
    //    
    //        if(p_txtStartKM!=null)
    //        {                           
    //            if(parseFloat(txtStartKM.value)<parseFloat(p_txtEndKM.value))
    //            {
    //                lbl_VehicleLog_Err.innerText ="Start KM Should be Greater than or Equal to  previous End KM";
    //                txtStartKM.style.borderColor="red";
    //                txtStartKM.focus();
    //                return false; 
    //            }
    //            else
    //            {
    //                lbl_VehicleLog_Err.innerText ="";
    //                txtStartKM.style.borderColor="";
    //            }
    //        }
    //    }
}
function CheckKMRun2(row_Index, txtStartKM, txtEndKM, txtKMRun, txtCloseKM) {

    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var lbl_Closing_KM_Err = document.getElementById("ctl00_MyCPH1_lbl_Closing_KM_Err");

    if (txtEndKM.value != "") {
        if (txtEndKM.value == "") { txtEndKM.value = "0"; }

        if (txtCloseKM.value == "") {
            txtEndKM.value = "";
            lbl_Closing_KM_Err.innerText = "Please Enter The Closing KM. Reading";
            //txtCloseKM.style.borderColor="red";
            txtCloseKM.focus();
            return false;
        }
        else {
            lbl_Closing_KM_Err.innerText = "";
            //txtCloseKM.style.borderColor="";
        }

        if (parseFloat(txtEndKM.value) > parseFloat(txtCloseKM.value)) {
            lbl_VehicleLog_Err.innerText = "End KM Should be Less than or equal to Closing KM. Reading";
            txtEndKM.style.borderColor = "red";
            txtEndKM.focus();
            return false;
        }
        else {
            lbl_VehicleLog_Err.innerText = "";
            txtEndKM.style.borderColor = "";
        }

        if (parseFloat(txtEndKM.value) == parseFloat(txtStartKM.value)) {
            lbl_VehicleLog_Err.innerText = "End KM Should not be equal to Start KM";
            txtEndKM.style.borderColor = "red";
            txtEndKM.focus();
            return false;
        }
        else {
            lbl_VehicleLog_Err.innerText = "";
            txtEndKM.style.borderColor = "";
        }

        if (parseFloat(txtEndKM.value) != parseFloat(txtStartKM.value)) {
            if (parseFloat(txtEndKM.value) < parseFloat(txtStartKM.value)) {
                lbl_VehicleLog_Err.innerText = "End KM Should be Greater than Start KM";
                txtEndKM.style.borderColor = "red";
                txtEndKM.focus();
                return false;
            }
            else {
                lbl_VehicleLog_Err.innerText = "";
                txtEndKM.style.borderColor = "";
            }
        }


        if (txtEndKM.value != "" && txtEndKM.value != null) {
            txtKMRun.value = parseFloat(txtEndKM.value) - parseFloat(txtStartKM.value);
        }

        var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

        str_Index = parseFloat(row_Index) + 3;
        if (parseFloat(str_Index) < 10) {
            str_Index = "0" + str_Index;
        }
        if (parseFloat(str_Index) <= gvVehicleLogEntry.rows.length) {
            var _txtStartKM = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry_ctl" + str_Index + "_txtStartKM");
            _txtStartKM.value = txtEndKM.value;
        }
    }
    //    var lbl_VehicleLog_Err=document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");

    //    if(txtEndKM.value!="" && txtEndKM.value!=null)
    //    {
    //        if(txtEndKM.value==""){txtEndKM.value="0";}
    //        
    //        if(txtCloseKM.value=="")
    //        {
    //            txtEndKM.value="";
    //            lbl_VehicleLog_Err.innerText ="Please Enter The Closing KM. Reading";
    //            txtCloseKM.style.borderColor="red";
    //            txtCloseKM.focus();
    //            return false;
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtCloseKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtEndKM.value)>parseFloat(txtCloseKM.value))
    //        {
    //            lbl_VehicleLog_Err.innerText ="End KM Should be Lessar than or equal to Closing KM. Reading";
    //            txtEndKM.style.borderColor="red";
    //            txtEndKM.focus();
    //            return false; 
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtEndKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtEndKM.value)==parseFloat(txtStartKM.value))
    //        {
    //            lbl_VehicleLog_Err.innerText ="End KM Should not be equal to Start KM";
    //            txtEndKM.style.borderColor="red";
    //            txtEndKM.focus();
    //            return false;
    //        }
    //        else
    //        {
    //            lbl_VehicleLog_Err.innerText ="";
    //            txtEndKM.style.borderColor="";
    //        }

    //        if(parseFloat(txtEndKM.value)!=parseFloat(txtStartKM.value))
    //        {
    //            if(parseFloat(txtEndKM.value)<parseFloat(txtStartKM.value))
    //            {
    //                lbl_VehicleLog_Err.innerText ="End KM Should be Greater than Start KM";
    //                txtEndKM.style.borderColor="red";
    //                txtEndKM.focus();
    //                return false;
    //            }
    //            else
    //            {
    //                lbl_VehicleLog_Err.innerText ="";
    //                txtEndKM.style.borderColor="";
    //            }
    //        }


    //        if(txtEndKM.value!="" && txtEndKM.value!=null )
    //        {
    //            txtKMRun.value=parseFloat(txtEndKM.value)-parseFloat(txtStartKM.value);
    //        } 
    //    
    //        var str_Index = "";
    //        var n_str_Index = "",p_str_Index ="";

    //        p_str_Index = parseFloat(row_Index) + 1;
    //        str_Index = parseFloat(row_Index) + 2;
    //        n_str_Index = parseFloat(row_Index) + 3; 
    //    
    //        if (parseFloat(str_Index) < 10)
    //        {
    //            str_Index = "0" + str_Index;
    //        }
    //        if (parseFloat(n_str_Index) < 10)
    //        {
    //            n_str_Index = "0" + n_str_Index;
    //        }
    //        if (parseFloat(p_str_Index) < 10)
    //        {
    //            p_str_Index = "0" + p_str_Index;
    //        }
    //        
    //        //alert(n_str_Index)
    //    
    //        var gvVehicleLogEntry=document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

    //        var n_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtStartKM");
    //        var n_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtEndKM");

    //        var p_txtStartKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtStartKM");
    //        var p_txtEndKM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtEndKM");

    //        if(p_txtStartKM!=null)
    //        {                           
    //            if(parseFloat(txtStartKM.value)<parseFloat(p_txtEndKM.value))
    //            {
    //                lbl_VehicleLog_Err.innerText ="Start KM Should be Greater than or Equal to  previous End KM";
    //                txtStartKM.style.borderColor="red";
    //                txtStartKM.focus();
    //                return false; 
    //            }
    //            else
    //            {
    //                lbl_VehicleLog_Err.innerText ="";
    //                txtStartKM.style.borderColor="";
    //            }
    //        }
    //    }
}
/*************************************************************************************************************
*   CHECK FOR VALID DECIMAL VALUE
/*************************************************************************************************************/
function checkDecimal(id, isID) {
    var txtID;

    if (isID == "TRUE") {
        txtID = document.getElementById(id);
    }
    else {
        txtID = id;
    }

    if (txtID.value != "") {
        if (isNaN(txtID.value)) {
            alert("Value should be Numeric.");
            txtID.value = "";
            return false;
        }
        if (parseFloat(txtID.value) < 0) {
            alert("Value should be greater than zero.");
            txtID.focus();
            return false;
        }
        if (parseFloat(txtID.value) > 23) {
            alert("Value should be lesser than 24.");
            txtID.value = "";
            txtID.focus();
            return false;
        }
    }
    return true;
}

function CheckValidMin(id, isID) {
    var txtID;
    if (isID == "TRUE") {
        txtID = document.getElementById(id);
    }
    else {
        txtID = id;
    }
    if (txtID.value != "") {
        if (isNaN(txtID.value)) {
            alert("Value should be Numeric.");
            txtID.value = "";
            return false;
        }
        if (parseFloat(txtID.value) < 0) {
            alert("Value should be greater than zero.");
            txtID.value = "";
            return false;
        }
        if (parseFloat(txtID.value) > 59) {
            alert("Invalid Minute");
            txtID.focus();
            return false;
        }
    }
    return true;
}

function CheckTransitTime(txtStartDate, tb_StartTime_HH, tb_StartTime_MM, txtEndDate, tb_EndTime_HH, tb_EndTime_MM, tb_Transit_HH, tb_Transit_MM) {
    var currentTime = new Date()
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var StartDateTime = "";
    var EndDateTime = "";

    if (txtEndDate != null) {
        if (txtStartDate != null) {
            if (txtStartDate.value == txtEndDate.value) {
                if (tb_StartTime_HH != null) {
                    if (parseInt(tb_EndTime_HH.value) < parseInt(tb_StartTime_HH.value)) {
                        lbl_VehicleLog_Err.innerText = "End Time Should be Greater than Start Time";
                        tb_EndTime_HH.style.borderColor = "red";
                        tb_EndTime_HH.focus();
                        return false;
                    }
                    else {
                        lbl_VehicleLog_Err.innerText = "";
                        tb_EndTime_HH.style.borderColor = "";
                    }

                }

                if (tb_StartTime_HH != null) {
                    if (tb_StartTime_HH.value == tb_EndTime_HH.value) {
                        if (parseFloat(tb_EndTime_MM.value) < parseFloat(tb_StartTime_MM.value)) {
                            lbl_VehicleLog_Err.innerText = "End Time Minute Should be Greater than Start Time Minute";
                            tb_EndTime_MM.style.borderColor = "red";
                            tb_EndTime_MM.focus();
                            return false;
                        }
                        else {
                            lbl_VehicleLog_Err.innerText = "";
                            tb_EndTime_MM.style.borderColor = "";
                        }
                    }
                }
            }

            if (txtStartDate.value != "" && txtEndDate.value != "") {
                var a = txtStartDate.value.split("/");
                var b = txtEndDate.value.split("/");

                StartDateTime = a[1] + "/" + a[0] + "/" + a[2];
                EndDateTime = b[1] + "/" + b[0] + "/" + b[2];

                StartDateTime = StartDateTime + " " + tb_StartTime_HH.value + ":" + tb_StartTime_MM.value + ":00";
                EndDateTime = EndDateTime + " " + tb_EndTime_HH.value + ":" + tb_EndTime_MM.value + ":00";

                createXMLHttpRequest();
                if (xmlHttpRequest) {
                    xmlHttpRequest.onreadystatechange = function() {
                        if (xmlHttpRequest.readyState == 4) {
                            var returnValue = xmlHttpRequest.responseText.split("~");
                            if (returnValue[0] == "Y") {
                                tb_Transit_HH.value = returnValue[1];
                                tb_Transit_MM.value = returnValue[2];
                            }
                        }
                    }
                    xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckTransitTime&datetime=" + currentTime + "&StartDateTime=" + StartDateTime + "&EndDateTime=" + EndDateTime, false);
                    xmlHttpRequest.send(null);
                }

            }
        }
    }
}

function CheckIdleTime(row_Index, txtStartDate, tb_StartTime_HH, tb_EndTime_HH, tb_IdleTime_HH, txtEndDate, tb_StartTime_MM, tb_EndTime_MM, tb_IdleTime_MM) {
    var currentTime = new Date()
    var lbl_VehicleLog_Err = document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
    var StartDateTime = "";
    var EndDateTime = "";

    if (txtEndDate != null) {
        if (txtStartDate != null) {
            //            if (tb_StartTime_HH.value == "") { tb_StartTime_HH.value = "00"; }
            //            if (tb_EndTime_HH.value == "") { tb_EndTime_HH.value = "00"; }
            if (tb_IdleTime_HH.value == "") { tb_IdleTime_HH.value = "00"; }
            //            if (tb_StartTime_MM.value == "") { tb_StartTime_MM.value = "00"; }
            //            if (tb_EndTime_MM.value == "") { tb_EndTime_MM.value = "00"; }
            if (tb_IdleTime_MM.value == "") { tb_IdleTime_MM.value = "00"; }

            var str_Index = "";
            var n_str_Index = "", p_str_Index = "";

            p_str_Index = parseFloat(row_Index) + 1;
            str_Index = parseFloat(row_Index) + 2;
            n_str_Index = parseFloat(row_Index) + 3;

            if (parseFloat(str_Index) < 10) {
                str_Index = "0" + str_Index;
            }
            if (parseFloat(n_str_Index) < 10) {
                n_str_Index = "0" + n_str_Index;
            }
            if (parseFloat(p_str_Index) < 10) {
                p_str_Index = "0" + p_str_Index;
            }

            var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

            var n_tb_StartTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_StartTime_HH");
            var n_tb_EndTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_EndTime_HH");
            var n_tb_IdleTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_IdleTime_HH");
            var n_tb_StartTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_StartTime_MM");
            var n_tb_EndTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_EndTime_MM");
            var n_tb_IdleTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_IdleTime_MM");
            var n_txtStartDate = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtStartDate");
            var n_txtEndDate = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$txtEndDate");

            var p_tb_StartTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_StartTime_HH");
            var p_tb_EndTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_EndTime_HH");
            var p_tb_IdleTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_IdleTime_HH");
            var p_tb_StartTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_StartTime_MM");
            var p_tb_EndTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_EndTime_MM");
            var p_tb_IdleTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_IdleTime_MM");
            var p_txtStartDate = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtStartDate");
            var p_txtEndDate = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$txtEndDate");

            if (p_txtEndDate.value == txtStartDate.value) {
                if (p_tb_StartTime_HH != null) {
                    if (parseInt(tb_StartTime_HH.value) < parseInt(p_tb_EndTime_HH.value)) {
                        lbl_VehicleLog_Err.innerText = "Start Time Should be Greater than previous End Time";
                        tb_StartTime_HH.style.borderColor = "red";
                        tb_StartTime_HH.focus();
                        return false; ;
                    }
                    else {
                        lbl_VehicleLog_Err.innerText = "";
                        tb_StartTime_HH.style.borderColor = "";
                    }
                }

                if (p_tb_StartTime_HH != null) {
                    if (tb_StartTime_HH.value == p_tb_EndTime_HH.value) {
                        if (parseFloat(tb_StartTime_MM.value) < parseFloat(p_tb_EndTime_MM.value)) {
                            lbl_VehicleLog_Err.innerText = "start Time Minute Should be Greater than previous End Time Minute";
                            tb_StartTime_MM.style.borderColor = "red";
                            tb_StartTime_MM.focus();
                            return false;
                        }
                        else {
                            lbl_VehicleLog_Err.innerText = "";
                            tb_StartTime_MM.style.borderColor = "";
                        }
                    }
                }
            }

            if (p_tb_EndTime_HH != null && tb_StartTime_HH != null && p_tb_EndTime_MM != null && tb_StartTime_MM != null) {
                if (txtStartDate.value != "" && p_txtEndDate.value != "") {
                    var a = txtStartDate.value.split("/");
                    var b = p_txtEndDate.value.split("/");

                    StartDateTime = a[1] + "/" + a[0] + "/" + a[2];
                    EndDateTime = b[1] + "/" + b[0] + "/" + b[2];

                    StartDateTime = StartDateTime + " " + tb_StartTime_HH.value + ":" + tb_StartTime_MM.value + ":00";
                    EndDateTime = EndDateTime + " " + p_tb_EndTime_HH.value + ":" + p_tb_EndTime_MM.value + ":00";

                    createXMLHttpRequest();
                    if (xmlHttpRequest) {
                        xmlHttpRequest.onreadystatechange = function() {
                            if (xmlHttpRequest.readyState == 4) {
                                //alert("2 : " + xmlHttpRequest.responseText);
                                var returnValue = xmlHttpRequest.responseText.split("~");
                                if (returnValue[0] == "Y") {
                                    p_tb_IdleTime_HH.value = returnValue[1];
                                    p_tb_IdleTime_MM.value = returnValue[2];
                                }
                            }
                        }
                        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckIdleTime&datetime=" + currentTime + "&StartDateTime=" + StartDateTime + "&EndDateTime=" + EndDateTime, false);
                        xmlHttpRequest.send(null);
                    }
                }
            }
        }

    }
}

//function CheckTransitTimeHH(tb_StartTime_MM,tb_EndTime_MM,tb_Transit_MM,tb_StartTime_HH,tb_EndTime_HH,tb_Transit_HH)
//{
//    var lbl_VehicleLog_Err=document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");
//    if(tb_EndTime_HH!=null)
//    {
//        if(tb_EndTime_HH.value!="")
//        {
//            if(tb_StartTime_HH.value==""){tb_StartTime_HH.value="00";}
//            if(tb_EndTime_HH.value==""){tb_EndTime_HH.value="00";}
//            if(tb_Transit_HH.value==""){tb_Transit_HH.value="00";}
//            if(tb_StartTime_MM.value==""){tb_StartTime_MM.value="00";}
//            if(tb_EndTime_MM.value==""){tb_EndTime_MM.value="00";}
//            if(tb_Transit_MM.value==""){tb_Transit_MM.value="00";}

//            if(parseFloat(tb_StartTime_HH.value)>parseFloat(tb_EndTime_HH.value))
//            {
//                lbl_VehicleLog_Err.innerText ="End Time Should be Greater than Start Time";
//                tb_EndTime_HH.style.borderColor="red";
//                tb_EndTime_HH.focus();
//                return false; 
//            }
//            else
//            {
//                lbl_VehicleLog_Err.innerText ="";
//                tb_EndTime_HH.style.borderColor="";
//            }
//        
//            var time1 = (parseFloat(tb_StartTime_HH.value) * 60) + parseFloat(tb_StartTime_MM.value);
//            var time2 = (parseFloat(tb_EndTime_HH.value) * 60) + parseFloat(tb_EndTime_MM.value);
//            var a = "";
//        
//            a = parseFloat(time2)-parseFloat(time1);
//            
//            var minutes=parseInt(a/60);
//            var seconds=parseFloat(a%60);
//            if(tb_EndTime_HH!=null)
//            {
//                tb_Transit_HH.value=parseFloat(minutes);
//                tb_Transit_MM.value=parseFloat(seconds);   
//            }  
//        
//            if(tb_EndTime_MM!=null)
//            {
//                tb_Transit_HH.value=parseFloat(minutes);
//                tb_Transit_MM.value=parseFloat(seconds);        
//            } 
//        }
//    } 
//}

//function CheckTransitTimeMM(tb_StartTime_MM,tb_EndTime_MM,tb_Transit_MM,tb_StartTime_HH,tb_EndTime_HH,tb_Transit_HH)
//{  
//    var lbl_VehicleLog_Err=document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");

//    if(tb_EndTime_MM!=null)
//    {
//        if(tb_EndTime_MM.value!="")
//        {
//            if(tb_StartTime_HH.value==""){tb_StartTime_HH.value="00";}
//            if(tb_EndTime_HH.value==""){tb_EndTime_HH.value="00";}
//            if(tb_Transit_HH.value==""){tb_Transit_HH.value="00";}
//            if(tb_StartTime_MM.value==""){tb_StartTime_MM.value="00";}
//            if(tb_EndTime_MM.value==""){tb_EndTime_MM.value="00";}
//            if(tb_Transit_MM.value==""){tb_Transit_MM.value="00";}

//            if(tb_StartTime_HH.value==tb_EndTime_HH.value)
//            {
//                if(parseFloat(tb_StartTime_MM.value)>parseFloat(tb_EndTime_MM.value))
//                {
//                    lbl_VehicleLog_Err.innerText ="End Time Minute Should be Greater than Start Time Minute";
//                    tb_EndTime_MM.style.borderColor="red";
//                    tb_EndTime_MM.focus();
//                    return false;
//                }
//                else
//                {
//                    lbl_VehicleLog_Err.innerText ="";
//                    tb_EndTime_MM.style.borderColor="";
//                }
//            }

//            var time1 = (parseFloat(tb_StartTime_HH.value) * 60) + parseFloat(tb_StartTime_MM.value);
//            var time2 = (parseFloat(tb_EndTime_HH.value) * 60) + parseFloat(tb_EndTime_MM.value);
//            var a = "";

//            a = parseFloat(time2)-parseFloat(time1);

//            var minutes=parseInt(a/60);
//            var seconds=parseFloat(a%60);

//            if(tb_EndTime_HH!=null)
//            {  
//                tb_Transit_HH.value=parseFloat(minutes);
//                tb_Transit_MM.value=parseFloat(seconds); 
//            }

//            if(tb_EndTime_MM!=null)
//            {
//                tb_Transit_HH.value=parseFloat(minutes);
//                tb_Transit_MM.value=parseFloat(seconds); 
//            } 
//        }
//    }
//}

//function CheckIdleTimeHH(row_Index,tb_StartTime_HH,tb_EndTime_HH,tb_IdleTime_HH,tb_StartTime_MM,tb_EndTime_MM,tb_IdleTime_MM)
//{ 
//    var lbl_VehicleLog_Err=document.getElementById("ctl00_MyCPH1_lbl_VehicleLog_Err");

//    // alert(row_Index);
//    if(tb_EndTime_HH.value!="" && tb_EndTime_HH.value!=null && tb_EndTime_MM.value!="" && tb_EndTime_MM.value!=null)
//    {
//        if(tb_StartTime_HH.value==""){tb_StartTime_HH.value="00";}
//        if(tb_EndTime_HH.value==""){tb_EndTime_HH.value="00";}
//        if(tb_IdleTime_HH.value==""){tb_IdleTime_HH.value="00";}
//        if(tb_StartTime_MM.value==""){tb_StartTime_MM.value="00";}
//        if(tb_EndTime_MM.value==""){tb_EndTime_MM.value="00";}
//        if(tb_IdleTime_MM.value==""){tb_IdleTime_MM.value="00";}


//        var str_Index = "";
//        var n_str_Index = "",p_str_Index ="";

//        p_str_Index = parseFloat(row_Index) + 1;
//        str_Index = parseFloat(row_Index) + 2;
//        n_str_Index = parseFloat(row_Index) + 3; 

//        if (parseFloat(str_Index) < 10)
//        {
//            str_Index = "0" + str_Index;
//        }
//        if (parseFloat(n_str_Index) < 10)
//        {
//            n_str_Index = "0" + n_str_Index;
//        }
//        if (parseFloat(p_str_Index) < 10)
//        {
//            p_str_Index = "0" + p_str_Index;
//        }

//        var gvVehicleLogEntry=document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");

//        var n_tb_StartTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_StartTime_HH");
//        var n_tb_EndTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_EndTime_HH");
//        var n_tb_IdleTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_IdleTime_HH");
//        var n_tb_StartTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_StartTime_MM");
//        var n_tb_EndTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_EndTime_MM");
//        var n_tb_IdleTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + n_str_Index + "$tb_IdleTime_MM");
//            
//        var p_tb_StartTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_StartTime_HH");
//        var p_tb_EndTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_EndTime_HH");
//        var p_tb_IdleTime_HH = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_IdleTime_HH");
//        var p_tb_StartTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_StartTime_MM");
//        var p_tb_EndTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_EndTime_MM");
//        var p_tb_IdleTime_MM = document.getElementById("ctl00$MyCPH1$gvVehicleLogEntry$ctl" + p_str_Index + "$tb_IdleTime_MM");
//    
//        if(p_tb_StartTime_HH!=null)
//        {
//            if(parseInt(tb_StartTime_HH.value) < parseInt(p_tb_EndTime_HH.value))
//            {
//                lbl_VehicleLog_Err.innerText ="Start Time Should be Greater than previous End Time";
//                tb_StartTime_HH.style.borderColor="red";
//                tb_StartTime_HH.focus();
//                return false; ;
//            }
//            else
//            {
//                lbl_VehicleLog_Err.innerText ="";
//                tb_StartTime_HH.style.borderColor="";
//            }
//        }

//        if(p_tb_StartTime_HH!=null)
//        {
//            if(tb_StartTime_HH.value==p_tb_EndTime_HH.value)
//            {
//                if(parseFloat(tb_StartTime_MM.value)< parseFloat(p_tb_EndTime_MM.value))
//                {
//                    lbl_VehicleLog_Err.innerText ="start Time Minute Should be Greater than previous End Time Minute";
//                    tb_StartTime_MM.style.borderColor="red";
//                    tb_StartTime_MM.focus();
//                    return false;
//                }
//                else
//                {
//                    lbl_VehicleLog_Err.innerText ="";
//                    tb_StartTime_MM.style.borderColor="";
//                }
//            }
//        }
//   
//        if(tb_StartTime_HH!=null || tb_StartTime_MM!=null)
//        {
//            var time1 = (parseFloat(tb_StartTime_HH.value) * 60) + parseFloat(tb_StartTime_MM.value);
//        }
//        if(p_tb_EndTime_HH!=null && p_tb_EndTime_MM!=null)
//        {
//            var time2 = (parseFloat(p_tb_EndTime_HH.value) * 60) + parseFloat(p_tb_EndTime_MM.value);     
//        }
//        var a = "";

//        a = parseFloat(time1)-parseFloat(time2);

//        var minutes=parseInt(a/60);
//        var seconds=parseFloat(a%60);     

//        if(p_tb_EndTime_HH!=null && tb_StartTime_HH!=null)
//        {  
//            p_tb_IdleTime_HH.value=parseFloat(minutes);
//            p_tb_IdleTime_MM.value=parseFloat(seconds); 
//        }
//    }
//}  

//////////////////////////////////////////////////////////////
function CalculateTHCAmt(txtFreightAmt, txtLabourChrg, txtOtherChrg, txtTHCTotalAmt) {
    if (txtFreightAmt.value == "") { txtFreightAmt.value = "0"; }
    if (txtLabourChrg.value == "") { txtLabourChrg.value = "0"; }
    if (txtOtherChrg.value == "") { txtOtherChrg.value = "0"; }
    txtTHCTotalAmt.value = parseFloat(txtFreightAmt.value) + parseFloat(txtLabourChrg.value) + parseFloat(txtOtherChrg.value)
    txtTHCTotalAmt.disabled = true;
}
function FillLastKmRead(row_Index, ddlFuelType) {
    var str_Index = "";
    var p_str_Index = "";
    str_Index = parseFloat(row_Index) + 2;
    p_str_Index = parseFloat(row_Index) + 1;
    if (parseFloat(str_Index) < 10) {
        str_Index = "0" + str_Index;
    }
    if (parseFloat(p_str_Index) < 10) {
        p_str_Index = "0" + p_str_Index;
    }
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    //if(parseFloat(str_Index) <= dgHSD_OIL_EXP.rows.length)
    {
        var txtKM_Reading = document.getElementById("ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + p_str_Index + "$txtKM_Reading");
        var txtLKmRead = document.getElementById("ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + str_Index + "$txtLKmRead");
        if (txtKM_Reading != null) {
            txtLKmRead.value = txtKM_Reading.value;
        }
    }
}

function CallulateTHCFooter() {
    var gvTHC = document.getElementById("ctl00_MyCPH1_gvTHC");
    var l = 0;
    l = gvTHC.rows.length;

    var FooterTotFreightAmt = "";
    var FooterTotLabourChrg = "";
    var FooterTotOtherChrg = "";
    var FooterTotTHCTotalAmt = "";

    if (l < 10) {
        FooterTotFreightAmt = document.getElementById("ctl00_MyCPH1_gvTHC_ctl0" + l + "_FooterTotFreightAmt");
        FooterTotLabourChrg = document.getElementById("ctl00_MyCPH1_gvTHC_ctl0" + l + "_FooterTotLabourChrg");
        FooterTotOtherChrg = document.getElementById("ctl00_MyCPH1_gvTHC_ctl0" + l + "_FooterTotOtherChrg");
        FooterTotTHCTotalAmt = document.getElementById("ctl00_MyCPH1_gvTHC_ctl0" + l + "_FooterTotTHCTotalAmt");
    }
    else {
        FooterTotFreightAmt = document.getElementById("ctl00_MyCPH1_gvTHC_ctl" + l + "_FooterTotFreightAmt");
        FooterTotLabourChrg = document.getElementById("ctl00_MyCPH1_gvTHC_ctl" + l + "_FooterTotLabourChrg");
        FooterTotOtherChrg = document.getElementById("ctl00_MyCPH1_gvTHC_ctl" + l + "_FooterTotOtherChrg");
        FooterTotTHCTotalAmt = document.getElementById("ctl00_MyCPH1_gvTHC_ctl" + l + "_FooterTotTHCTotalAmt");
    }

    FooterTotFreightAmt.value = "0.00";
    FooterTotLabourChrg.value = "0.00";
    FooterTotOtherChrg.value = "0.00";
    FooterTotTHCTotalAmt.value = "0.00";

    for (i = 0; i < l - 2; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvTHC_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvTHC_ctl" + j + "_";
        }

        var txtFreightAmt = document.getElementById(pref + "txtFreightAmt");
        var txtLabourChrg = document.getElementById(pref + "txtLabourChrg");
        var txtOtherChrg = document.getElementById(pref + "txtOtherChrg");
        var txtTHCTotalAmt = document.getElementById(pref + "txtTHCTotalAmt");

        FooterTotFreightAmt.value = parseFloat(FooterTotFreightAmt.value) + parseFloat(txtFreightAmt.value);
        FooterTotLabourChrg.value = parseFloat(FooterTotLabourChrg.value) + parseFloat(txtLabourChrg.value);
        FooterTotOtherChrg.value = parseFloat(FooterTotOtherChrg.value) + parseFloat(txtOtherChrg.value);
        FooterTotTHCTotalAmt.value = parseFloat(FooterTotTHCTotalAmt.value) + parseFloat(txtTHCTotalAmt.value);
    }
    FooterTotFreightAmt.disabled = true;
    FooterTotLabourChrg.disabled = true;
    FooterTotOtherChrg.disabled = true;
    FooterTotTHCTotalAmt.disabled = true;
}
function diableTextBox(txtboxId) {
    var txtBox = document.getElementById(txtboxId);
    txtBox.disabled = true;
    return true;
}
function CheckKM(row_Index, txtKM_Reading, txtLKmRead) {
    var str_Index = "";
    var lbl_OilExp_Expense = document.getElementById("ctl00_MyCPH1_lbl_OilExp_Expense");
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");

    if (parseFloat(txtKM_Reading.value) < parseFloat(txtLKmRead.value)) {
        lbl_OilExp_Expense.innerText = "Current km reading cannot be less than last km reading!";
        txtKM_Reading.style.borderColor = "red";
        txtKM_Reading.focus();
        return false;
    }
    else {
        lbl_OilExp_Expense.innerText = "";
        txtKM_Reading.style.borderColor = "";
    }
    str_Index = parseFloat(row_Index) + 3;
    if (parseFloat(str_Index) < 10) {
        str_Index = "0" + str_Index;
    }
    if (parseFloat(str_Index) <= dgHSD_OIL_EXP.rows.length) {
        var _txtLKmRead = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + str_Index + "_txtLKmRead");
        _txtLKmRead.value = txtKM_Reading.value;
    }
}

function CalculateDiesel() {
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var txtFuelFilledEnroute = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtFuelFilledEnroute");
    var totamt = "0.00";

    for (i = 0; i < dgHSD_OIL_EXP.rows.length - 1; i++) {
        j = i + 2;
        var pref = "";
        if (j < 10) {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
        }
        else {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
        }
        var txtDiesel_Ltr = document.getElementById(pref + "txtDiesel_Ltr");
        var txtDieselRate_Ltr = document.getElementById(pref + "txtDieselRate_Ltr");
        var txtAmt = document.getElementById(pref + "txtAmt");
        txtAmt.value = parseFloat(txtDiesel_Ltr.value) * parseFloat(txtDieselRate_Ltr.value);
        if (txtDiesel_Ltr.value != "") {
            totamt = parseFloat(totamt) + parseFloat(txtDiesel_Ltr.value);
        }

    }
    //txtFuelFilledEnroute.value = totamt;
    CheckClosingKM();
}
function CalculateDieselLiters(txtDiesel_Ltr, txtDieselRate_Ltr, txtAmt) {
    txtAmt.value = (parseFloat(txtDiesel_Ltr.value) * parseFloat(txtDieselRate_Ltr.value)).toFixed(2);
    CheckClosingKM();
}


function CheckApprovedAmt(row_Index, txtExeAmt1) {
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    ///var hfApprovedAmt=document.getElementById("ctl00_MyCPH1_hfApprovedAmt");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");

    var totamt = "0.00";

    for (i = 0; i < dgHSD_OIL_EXP.rows.length - 1; i++) {
        j = i + 2;
        var pref = "";
        if (j < 10) {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
        }
        else {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
        }
        var txtExeAmt = document.getElementById(pref + "txtExeAmt");
        if (txtExeAmt.value != "") {
            totamt = parseFloat(totamt) + parseFloat(txtExeAmt.value);
        }
    }
    //hfApprovedAmt.value = totamt;
}

function CheckOpClose() {
    var hfApprovedAmt = document.getElementById("ctl00_MyCPH1_hfApprovedAmt");

    var txtDateOpClose = document.getElementById("ctl00_MyCPH1_txtDateOpClose");
    var txtDateFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom");

    var txtCloseKM = document.getElementById("ctl00_MyCPH1_txtCloseKM");
    var txtExeAmt = document.getElementById("ctl00_MyCPH1_txtExeAmt");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    var gvTHC = document.getElementById("ctl00_MyCPH1_gvTHC");
    ///////vehicle log entry//////////////////////////////////////////////////////
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    var txtDateFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom");
    var txtCloseKM = document.getElementById("ctl00_MyCPH1_txtCloseKM");


    CheckApprovedAmt();

    if (txtDateOpClose.value == "") {
        alert("Enter Operational Close Date !!!");
        txtDateOpClose.focus();
        return false;
    }
    if (txtCloseKM.value == "") {
        alert("Enter Closing KM!!!");
        txtCloseKM.focus();
        return false;
    }

    if (gvTHC != null) {
        if (gvTHC.rows.length != 0) {
            for (i = 0; i < gvTHC.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvTHC$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvTHC$ctl" + j + "$";
                }
                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var txtTHCNo = document.getElementById(pref + "txtTHCNo");
                var txtTHCDt = document.getElementById(pref + "txtTHCDt");
                var txtFreightAmt = document.getElementById(pref + "txtFreightAmt");
                var txtTHCTotalAmt = document.getElementById(pref + "txtTHCTotalAmt");

                if (txtFrom.value == "") {
                    alert("Enter From City!!!");
                    txtFrom.focus();
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To City!!!");
                    txtTo.focus();
                    return false;
                }
                if (txtTHCNo.value == "") {
                    alert("Enter THC Number !!!");
                    txtTHCNo.focus();
                    return false;
                }
                if (txtTHCDt.value == "") {
                    alert("Enter THC Date!!!");
                    txtTHCDt.focus();
                    return false;
                }
                if (txtFreightAmt.value == "0") {
                    alert("Enter Freight Amount!!!");
                    txtFreightAmt.focus();
                    return false;
                }
            }
        }
    }
    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvVehicleLogEntry$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvVehicleLogEntry$ctl" + j + "$";
                }

                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var txtStartDate = document.getElementById(pref + "txtStartDate");
                var tb_StartTime_HH = document.getElementById(pref + "tb_StartTime_HH");
                var tb_StartTime_MM = document.getElementById(pref + "tb_StartTime_MM");
                var txtInvoiceNo = document.getElementById(pref + "txtInvoiceNo");
                var txtStartKm = document.getElementById(pref + "txtStartKm");
                var txtNoOfCrates = document.getElementById(pref + "txtNoOfCrates");
                var txtEndDate = document.getElementById(pref + "txtEndDate");
                var tb_EndTime_HH = document.getElementById(pref + "tb_EndTime_HH");
                var tb_EndTime_MM = document.getElementById(pref + "tb_EndTime_MM");
                var txtEndKm = document.getElementById(pref + "txtEndKm");

                var ddlCategory = document.getElementById(pref + "ddlCategory");
                var ddlTypeofProduct = document.getElementById(pref + "ddlTypeofProduct");

                if (txtFrom.value == "") {
                    alert("Enter From")
                    txtFrom.focus();
                    //document.getElementById(pref + "txtFrom").focus();
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To");
                    txtTo.focus();
                    //document.getElementById(pref + "txtTo").focus();
                    return false;
                }
                if (txtStartDate.value == "") {
                    alert("Select Start Date");
                    txtStartDate.focus();
                    //document.getElementById(pref + "txtStartDate").focus();
                    return false;
                }

                if (tb_StartTime_HH.value == "") {
                    alert("Enter Start Time Hour");
                    tb_StartTime_HH.focus();
                    //document.getElementById(pref + "tb_StartTime_HH").focus();
                    return false;
                }

                if (tb_StartTime_MM.value == "") {
                    alert("Enter Start Time Minute");
                    tb_StartTime_MM.focus();
                    //document.getElementById(pref + "tb_StartTime_MM").focus();
                    return false;
                }

                if (txtInvoiceNo.value == "") {
                    alert("Enter Invoice No");
                    txtInvoiceNo.focus();
                    //document.getElementById(pref + "txtInvoiceNo").focus();
                    return false;
                }

                if (txtStartKm.value == "") {
                    alert("Enter Start KM");
                    txtStartKm.focus();
                    //document.getElementById(pref + "txtStartKm").focus();
                    return false;
                }



                if (ddlCategory.value == "0") {
                    alert("Select Category!!!");
                    ddlCategory.focus();
                    return false;
                }
                if (ddlTypeofProduct.value == "0") {
                    alert("Select Product Type!!!");
                    ddlTypeofProduct.focus();
                    return false;
                }

                if (txtNoOfCrates.value == "") {
                    alert("Enter No of Crates!!!");
                    txtNoOfCrates.focus();
                    //document.getElementById(pref + "txtNoOfCrates").focus();
                    return false;
                }

                if (txtEndDate.value == "") {
                    alert("Select End Date");
                    txtEndDate.focus();
                    //document.getElementById(pref + "txtEndDate").focus();
                    return false;
                }

                if (tb_EndTime_HH.value == "") {
                    alert("Enter End Time Hour");
                    tb_EndTime_HH.focus();
                    //document.getElementById(pref + "tb_EndTime_HH").focus();
                    return false;
                }

                if (tb_EndTime_MM.value == "") {
                    alert("Enter End Time Minute");
                    tb_EndTime_MM.focus();
                    //document.getElementById(pref + "tb_EndTime_MM").focus();
                    return false;
                }

                if (txtEndKm.value == "") {
                    alert("Enter End KM");
                    txtEndKm.focus();
                    //document.getElementById(pref + "txtEndKm").focus();
                    return false;
                }

            }
        }
    }
    if (dgHSD_OIL_EXP != null) {
        if (dgHSD_OIL_EXP.rows.length > 1) {
            for (i = 0; i < dgHSD_OIL_EXP.rows.length - 1; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
                }
                var txtOilPlace = document.getElementById(pref + "txtOilPlace");
                var ddlPPName = document.getElementById(pref + "ddlPPName");
                var ddlBrand = document.getElementById(pref + "ddlBrand");
                var ddlFuelType = document.getElementById(pref + "ddlFuelType");
                var txtLKmRead = document.getElementById(pref + "txtLKmRead");
                var txtKM_Reading = document.getElementById(pref + "txtKM_Reading");
                var txtDiesel_Ltr = document.getElementById(pref + "txtDiesel_Ltr");
                var txtDieselRate_Ltr = document.getElementById(pref + "txtDieselRate_Ltr");
                var txtAmt = document.getElementById(pref + "txtAmt");
                var txtExeAmt = document.getElementById(pref + "txtExeAmt");
                var ddlPayment = document.getElementById(pref + "ddlPayment");
                if (txtOilPlace.value == "") {
                    alert("Enter Place !!!");
                    txtOilPlace.focus();
                    return false;
                }
                if (ddlPPName.value == "") {
                    alert("Select Petrol Pump Name !!!");
                    ddlPPName.focus();
                    return false;
                }
                if (ddlBrand.value == "") {
                    alert("Select Brand !!!");
                    ddlBrand.focus();
                    return false;
                }
                if (ddlFuelType.value == "") {
                    alert("Select Fuel Type !!!");
                    ddlFuelType.focus();
                    return false;
                }
                if (txtKM_Reading.value == "") {
                    alert("Enter KM Reading !!!");
                    txtKM_Reading.focus();
                    return false;
                }
                if (txtDiesel_Ltr.value == "0") {
                    alert("Enter Diesel !!!");
                    txtDiesel_Ltr.focus();
                    return false;
                }
                if (txtDieselRate_Ltr.value == "0") {
                    alert("Enter Diesel Rate/litres !!!");
                    txtDieselRate_Ltr.focus();
                    return false;
                }

                if (txtExeAmt.value == "") {
                    alert("Enter Amount Approved By Fleet Executive !!!");
                    txtExeAmt.focus();
                    return false;
                }
                if (ddlPayment.value == "select") {
                    alert("Select Diesel Card or Cash!!!");
                    ddlPayment.focus();
                    return false;
                }
            }
        }
    }
    if (gvEnroute != null) {
        if (gvEnroute.rows.length > 2) {
            for (i = 0; i < gvEnroute.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvEnroute$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvEnroute$ctl" + j + "$";
                }
                var ddlNExpense = document.getElementById(pref + "ddlNExpense");
                var txtAmount = document.getElementById(pref + "txtAmount");
                var hfEAmt = document.getElementById(pref + "hfEAmt");
                var txtEAmt = document.getElementById(pref + "txtEAmt");

                if (txtAmount.value != "" || hfEAmt.value != "" || txtEAmt.value != "") {
                    //alert(ddlNExpense.value)
                    if (ddlNExpense.value == "0") {
                        alert("Select Nature of Expense!!!");
                        ddlNExpense.focus();
                        return false;
                    }
                    if (txtAmount.value == "") {
                        alert("Enter Amount!!!");
                        txtAmount.focus();
                        return false;
                    }
                    if (hfEAmt.value == "") {
                        if (txtEAmt.value == "") {
                            alert("Standard Amount is Required. \n Kindly check the FTL Type mappaing with Vehicle Master or Trip Route Expense Master Entry!!!");
                            txtEAmt.focus();
                            return false;
                        }
                    }
                }
            }
        }
    }
    if (hfApprovedAmt.value != "") {
        if (parseFloat(txtApprovedFuelAmt.value) < parseFloat(hfApprovedAmt.value)) {
            var ConFirmBox = confirm("Approved fuel amount is greater than amount approved by fleet executive.\n\n Are you sure?");
            if (ConFirmBox == false) {
                txtExeAmt.focus();
                return false;
            }
        }
    }
    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) {
        return false;
    }
}

function CheckEnRouteExpDetails() {
    var hfApprovedAmt = document.getElementById("ctl00_MyCPH1_hfApprovedAmt");

    var txtDateOpClose = document.getElementById("ctl00_MyCPH1_txtDateOpClose");
    var txtDateFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom");

    var txtCloseKM = document.getElementById("ctl00_MyCPH1_txtCloseKM");
    var txtExeAmt = document.getElementById("ctl00_MyCPH1_txtExeAmt");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
    var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    var gvTHC = document.getElementById("ctl00_MyCPH1_gvTHC");
    ///////vehicle log entry//////////////////////////////////////////////////////
    var gvVehicleLogEntry = document.getElementById("ctl00_MyCPH1_gvVehicleLogEntry");
    var txtDateFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom");
    var txtCloseKM = document.getElementById("ctl00_MyCPH1_txtCloseKM");


    CheckApprovedAmt();

    if (txtDateOpClose.value == "") {
        alert("Enter Operational Close Date !!!");
        txtDateOpClose.focus();
        return false;
    }
    if (txtDateFrom.value == "") {
        alert("Enter Operational/Financial Close Date !!!");
        txtDateFrom.focus();
        return false;
    }

    if (txtCloseKM.value == "") {
        alert("Enter Closing KM!!!");
        txtCloseKM.focus();
        return false;
    }

    if (gvTHC != null) {
        if (gvTHC.rows.length != 0) {
            for (i = 0; i < gvTHC.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvTHC$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvTHC$ctl" + j + "$";
                }
                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var txtTHCNo = document.getElementById(pref + "txtTHCNo");
                var txtTHCDt = document.getElementById(pref + "txtTHCDt");
                var txtFreightAmt = document.getElementById(pref + "txtFreightAmt");
                var txtTHCTotalAmt = document.getElementById(pref + "txtTHCTotalAmt");

                if (txtFrom.value == "") {
                    alert("Enter From City!!!");
                    txtFrom.focus();
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To City!!!");
                    txtTo.focus();
                    return false;
                }
                if (txtTHCNo.value == "") {
                    alert("Enter THC Number !!!");
                    txtTHCNo.focus();
                    return false;
                }
                if (txtTHCDt.value == "") {
                    alert("Enter THC Date!!!");
                    txtTHCDt.focus();
                    return false;
                }
                if (txtFreightAmt.value == "0") {
                    alert("Enter Freight Amount!!!");
                    txtFreightAmt.focus();
                    return false;
                }
            }
        }
    }
    if (gvVehicleLogEntry != null) {
        //alert("1");
        if (gvVehicleLogEntry.rows.length != 0) {
            for (i = 0; i < gvVehicleLogEntry.rows.length - 1; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvVehicleLogEntry$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvVehicleLogEntry$ctl" + j + "$";
                }

                var txtFrom = document.getElementById(pref + "txtFrom");
                var txtTo = document.getElementById(pref + "txtTo");
                var txtStartDate = document.getElementById(pref + "txtStartDate");
                var tb_StartTime_HH = document.getElementById(pref + "tb_StartTime_HH");
                var tb_StartTime_MM = document.getElementById(pref + "tb_StartTime_MM");
                var txtInvoiceNo = document.getElementById(pref + "txtInvoiceNo");
                var txtStartKm = document.getElementById(pref + "txtStartKm");
                var txtNoOfCrates = document.getElementById(pref + "txtNoOfCrates");
                var txtEndDate = document.getElementById(pref + "txtEndDate");
                var tb_EndTime_HH = document.getElementById(pref + "tb_EndTime_HH");
                var tb_EndTime_MM = document.getElementById(pref + "tb_EndTime_MM");
                var txtEndKm = document.getElementById(pref + "txtEndKm");
                var ddlCategory = document.getElementById(pref + "ddlCategory");
                var ddlTypeofProduct = document.getElementById(pref + "ddlTypeofProduct");

                if (txtFrom.value == "") {
                    alert("Enter From")
                    txtFrom.focus();
                    //document.getElementById(pref + "txtFrom").focus();
                    return false;
                }
                if (txtTo.value == "") {
                    alert("Enter To");
                    txtTo.focus();
                    //document.getElementById(pref + "txtTo").focus();
                    return false;
                }
                if (txtStartDate.value == "") {
                    alert("Select Start Date");
                    txtStartDate.focus();
                    //document.getElementById(pref + "txtStartDate").focus();
                    return false;
                }

                if (tb_StartTime_HH.value == "") {
                    alert("Enter Start Time Hour");
                    tb_StartTime_HH.focus();
                    //document.getElementById(pref + "tb_StartTime_HH").focus();
                    return false;
                }

                if (tb_StartTime_MM.value == "") {
                    alert("Enter Start Time Minute");
                    tb_StartTime_MM.focus();
                    //document.getElementById(pref + "tb_StartTime_MM").focus();
                    return false;
                }

                if (txtInvoiceNo.value == "") {
                    alert("Enter Invoice No");
                    txtInvoiceNo.focus();
                    //document.getElementById(pref + "txtInvoiceNo").focus();
                    return false;
                }

                if (txtStartKm.value == "") {
                    alert("Enter Start KM");
                    txtStartKm.focus();
                    //document.getElementById(pref + "txtStartKm").focus();
                    return false;
                }
                if (ddlCategory.value == "0") {
                    alert("Select Category!!!");
                    ddlCategory.focus();
                    return false;
                }
                if (ddlTypeofProduct.value == "0") {
                    alert("Select Product Type!!!");
                    ddlTypeofProduct.focus();
                    return false;
                }

                if (txtNoOfCrates.value == "") {
                    alert("Enter No of Crates");
                    txtNoOfCrates.focus();
                    //document.getElementById(pref + "txtNoOfCrates").focus();
                    return false;
                }

                if (txtEndDate.value == "") {
                    alert("Select End Date");
                    txtEndDate.focus();
                    //document.getElementById(pref + "txtEndDate").focus();
                    return false;
                }

                if (tb_EndTime_HH.value == "") {
                    alert("Enter End Time Hour");
                    tb_EndTime_HH.focus();
                    //document.getElementById(pref + "tb_EndTime_HH").focus();
                    return false;
                }

                if (tb_EndTime_MM.value == "") {
                    alert("Enter End Time Minute");
                    tb_EndTime_MM.focus();
                    //document.getElementById(pref + "tb_EndTime_MM").focus();
                    return false;
                }

                if (txtEndKm.value == "") {
                    alert("Enter End Time Minute");
                    txtEndKm.focus();
                    //document.getElementById(pref + "txtEndKm").focus();
                    return false;
                }

            }
        }
    }
    if (dgHSD_OIL_EXP.rows.length > 1) {
        for (i = 0; i < dgHSD_OIL_EXP.rows.length - 1; i++) {
            j = i + 2;
            var pref = "";
            if (j < 10) {
                pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
            }
            else {
                pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
            }
            var txtOilPlace = document.getElementById(pref + "txtOilPlace");
            var ddlPPName = document.getElementById(pref + "ddlPPName");
            var ddlBrand = document.getElementById(pref + "ddlBrand");
            var ddlFuelType = document.getElementById(pref + "ddlFuelType");
            var txtLKmRead = document.getElementById(pref + "txtLKmRead");
            var txtKM_Reading = document.getElementById(pref + "txtKM_Reading");
            var txtDiesel_Ltr = document.getElementById(pref + "txtDiesel_Ltr");
            var txtDieselRate_Ltr = document.getElementById(pref + "txtDieselRate_Ltr");
            var txtAmt = document.getElementById(pref + "txtAmt");
            var txtExeAmt = document.getElementById(pref + "txtExeAmt");
            var ddlPayment = document.getElementById(pref + "ddlPayment");
            if (txtOilPlace.value == "") {
                alert("Enter Place !!!");
                txtOilPlace.focus();
                return false;
            }
            if (ddlPPName.value == "") {
                alert("Select Petrol Pump Name !!!");
                ddlPPName.focus();
                return false;
            }
            if (ddlBrand.value == "") {
                alert("Select Brand !!!");
                ddlBrand.focus();
                return false;
            }
            if (ddlFuelType.value == "") {
                alert("Select Fuel Type !!!");
                ddlFuelType.focus();
                return false;
            }
            if (txtKM_Reading.value == "") {
                alert("Enter KM Reading !!!");
                txtKM_Reading.focus();
                return false;
            }
            if (txtDiesel_Ltr.value == "0") {
                alert("Enter Diesel !!!");
                txtDiesel_Ltr.focus();
                return false;
            }
            if (txtDieselRate_Ltr.value == "0") {
                alert("Enter Diesel Rate/litres !!!");
                txtDieselRate_Ltr.focus();
                return false;
            }

            if (txtExeAmt.value == "") {
                alert("Enter Amount Approved By Fleet Executive !!!");
                txtExeAmt.focus();
                return false;
            }

            //            if(ddlPayment.disabled != true)
            //            {
            //                var curOption = ddlPayment.options[ddlPayment.selectedIndex];
            //                if(curOption.innerText == "")
            //                {
            //                    alert("Select Diesel Card or Cash!!!");
            //                    ddlPayment.focus();
            //                    return false;
            //                }
            //            }
            if (ddlPayment.disabled == false) {
                if (ddlPayment.value == "select") {
                    alert("Select Diesel Card or Cash!!!");
                    ddlPayment.focus();
                    return false;
                }
            }
        }
    }
    if (gvEnroute != null) {
        if (gvEnroute.rows.length > 2) {
            for (i = 0; i < gvEnroute.rows.length - 2; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00$MyCPH1$gvEnroute$ctl0" + j + "$";
                }
                else {
                    pref = "ctl00$MyCPH1$gvEnroute$ctl" + j + "$";
                }
                var ddlNExpense = document.getElementById(pref + "ddlNExpense");
                var txtAmount = document.getElementById(pref + "txtAmount");
                var hfEAmt = document.getElementById(pref + "hfEAmt");
                var txtEAmt = document.getElementById(pref + "txtEAmt");

                if (txtAmount.value != "" || hfEAmt.value != "" || txtEAmt.value != "") {
                    //alert(ddlNExpense.value)
                    if (ddlNExpense.value == "0") {
                        alert("Select Nature of Expense!!!");
                        ddlNExpense.focus();
                        return false;
                    }
                    if (txtAmount.value == "") {
                        alert("Enter Amount!!!");
                        txtAmount.focus();
                        return false;
                    }
                    if (hfEAmt.value == "") {
                        if (txtEAmt.value == "") {
                            alert("Standard Amount is Required. \n Kindly check the FTL Type mappaing with Vehicle Master or Trip Route Expense Master Entry!!!");
                            txtEAmt.focus();
                            return false;
                        }
                    }
                }
            }
        }
    }
    if (hfApprovedAmt.value != "") {
        if (parseFloat(txtApprovedFuelAmt.value) < parseFloat(hfApprovedAmt.value)) {
            var ConFirmBox = confirm("Approved fuel amount is greater than amount approved by fleet executive.\n\n Are you sure?");
            if (ConFirmBox == false) {
                txtExeAmt.focus();
                return false;
            }
        }
    }
    var ConFirmBox = confirm("Are you sure to submit data?");
    if (ConFirmBox == false) {
        return false;
    }
}
function createXMLHttpRequest() {
    // Mozilla, Safari,...
    if (window.XMLHttpRequest) { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
    // IE
    else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
}
function CheckValidExp(row_Index, ddlNExpense, txtEAmt, hfEAmt, hfPolarity) {
    var currentTime = new Date();
    var str_Index = "";
    var lblVehno = document.getElementById("ctl00_MyCPH1_lblVehno");
    var hfRouteCode = document.getElementById("ctl00_MyCPH1_hfRouteCode");

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvEnroute").rows.length - 2; intIndex++) {
        if (intIndex < 10) {
            str_Index = "0" + intIndex;
        }
        else {
            str_Index = intIndex;
        }
        if (row_Index == intIndex - 2) {
            continue;
        }

        var D_ddlNExpense;

        D_ddlNExpense = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlNExpense");
        //D_ddlRouteSegment=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlRouteSegment");
        if (D_ddlNExpense.value == ddlNExpense.value) {
            alert("This Part already exist at row " + (intIndex - 1));
            ddlNExpense.selectedIndex = 0;
            ddlNExpense.focus();
            return false;
        }
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                FillPolarity(ddlNExpense, hfPolarity);
                //alert(hfPolarity.value);
                if (returnValue[0] == "N") {
                    txtEAmt.disabled = true;
                    txtEAmt.value = "0";
                    hfEAmt.value = "0";
                }
                else {
                    //txtEAmt.disabled = true;
                    txtEAmt.disabled = true;
                    txtEAmt.value = returnValue[1];
                    hfEAmt.value = returnValue[1];

                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillStandardAmt&datetime=" + currentTime + "&RouteCode=" + hfRouteCode.value + "&ExpCode=" + ddlNExpense.value + "&Vehno=" + lblVehno.innerText, false);
        xmlHttpRequest.send(null);
    }
}
function FillPolarity(ddlNExpense, hfPolarity) {
    var currentTime = new Date();

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    hfPolarity.value = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=FillPolarity&datetime=" + currentTime + "&ExpCode=" + ddlNExpense.value, false);
        xmlHttpRequest.send(null);
    }
}
function CheckClosingKM() {
    var prefix = "ctl00_MyCPH1_";
    var lblStartKm = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTripStartKm");
    var txtCloseKM = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndKm");
    var txtTotalKms = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTotalTripKm");
    var hfKMPL = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_hfKMPL");
    var txtApprovedDiesel = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtApprovedDiesel");
    var lblAverageDieselRate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblAverageDieselRate");
    var txtApprovedFuelAmt = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtApprovedFuelAmt");
    var txtFuelFilledEnroute = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtFuelFilledEnroute");
    //var txtFuelFilled=document.getElementById(prefix+"txtFuelFilled");
    var txtTotalKms = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTotalTripKm")
    var txtKMPL = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtKMPL");
    var hf_CloseKMGreater10K = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_hf_CloseKMGreater10K");
    var lbl_Closing_KM_Err = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lbl_Closing_KM_Err");

    if (lblAverageDieselRate.innerText == "") {
        lblAverageDieselRate.innerText = "0.0";
    }
    if (hfKMPL.value == "") {
        hfKMPL.value = "0.0";
    }
    if (txtCloseKM.value != "" && lblStartKm.innerText != "") {
        if (parseFloat(txtCloseKM.value) < parseFloat(lblStartKm.innerText)) {
            lbl_Closing_KM_Err.innerText = "Close Km Cannot  be less than  Start Km!";
            txtTotalKms.value = "";
            txtCloseKM.focus();
            return false;
        }
        else {
            lbl_Closing_KM_Err.innerText = "";
            txtTotalKms.value = (parseFloat(txtCloseKM.value) - parseFloat(lblStartKm.innerText)).toString();
            if (hf_CloseKMGreater10K.value == "Y") {
                if ((parseFloat(txtTotalKms.value)) > 10000) {
                    txtTotalKms.style.borderColor = "red";
                    lbl_Closing_KM_Err.innerText = "Trip sheet total km should not be greater than 10,000 Km!";
                    txtCloseKM.focus();
                    return false;
                }
                else {
                    txtTotalKms.style.borderColor = "";
                    lbl_Closing_KM_Err.innerText = "";
                    if ((parseFloat(txtTotalKms.value)) > 5000) {
                        var ConFirmBox = confirm("Trip sheet total km is greater than 5,000 Km. \n\n Are you sure?");
                        if (ConFirmBox == false) {
                            txtCloseKM.focus();
                            return false;
                        }
                    }
                    if (parseFloat(hfKMPL.value) != 0) {
                        txtApprovedDiesel.value = ((parseFloat(txtTotalKms.value) / parseFloat(hfKMPL.value)).toFixed(2)).toString();
                    }
                    else {
                        txtApprovedDiesel.value = "0.0";
                    }
                    if (parseFloat(txtApprovedDiesel.value) != 0) {
                        txtApprovedFuelAmt.value = ((parseFloat(txtApprovedDiesel.value) * parseFloat(lblAverageDieselRate.innerText)).toFixed(2)).toString();
                    }
                    else {
                        txtApprovedFuelAmt.value = "0.0";
                    }
                }
            }
        }
    }
    //if(txtFuelFilledEnroute.value != "" && txtFuelFilled.value != "" && txtTotalKms.value != "")
    if (txtFuelFilledEnroute.value != "" && txtTotalKms.value != "") {
        if (parseFloat(txtFuelFilledEnroute.value) != 0) {
            txtKMPL.value = (parseFloat(txtTotalKms.value) / parseFloat(txtFuelFilledEnroute.value)).toFixed(2);
        }
        else {
            txtKMPL.value = "0.0";
        }
    }
}


//function CheckValidRS(row_Index,ddlNExpense,ddlRouteSegment)
//{
//    var str_Index = "";
//    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvEnroute").rows.length-2; intIndex++)
//    {
//        if (intIndex < 10)
//        {
//            str_Index = "0" + intIndex;
//        }
//        else
//        {
//            str_Index = intIndex;
//        }
//        if (row_Index == intIndex - 2)
//        {
//            continue;
//        }
//        
//        var D_ddlNExpense,D_ddlRouteSegment;
//        
//        D_ddlNExpense=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlNExpense");
//        D_ddlRouteSegment=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlRouteSegment");
//        
//        if (D_ddlNExpense.value == ddlNExpense.value && D_ddlRouteSegment.value == ddlRouteSegment.value)
//        {
//            alert("This Part already exist at row " + (intIndex - 1));
//            ddlRouteSegment.selectedIndex = 0;
//            ddlRouteSegment.focus();
//            return false;
//        }
//    }
//}
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this;
}
var dtCh = "/";
var minYear = "1900";
var maxYear = "2100";

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}
function isDate(dtStr) {
    var daysInMonth = DaysArray(12)
    var pos1 = dtStr.indexOf(dtCh)
    var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
    var strDay = dtStr.substring(0, pos1)
    var strMonth = dtStr.substring(pos1 + 1, pos2)
    var strYear = dtStr.substring(pos2 + 1)
    strYr = strYear
    if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
    if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
    for (var i = 1; i <= 3; i++) {
        if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
    }

    month = parseInt(strMonth)
    day = parseInt(strDay)
    year = parseInt(strYr)
    if (pos1 == -1 || pos2 == -1) {
        //alert("The date format should be : dd/mm/yyyy")
        return false
    }
    if (strMonth.length < 1 || month < 1 || month > 12) {
        alert("Please enter a valid month")
        return false
    }
    if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
        alert("Please enter a valid day")
        return false
    }
    if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
        alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
        return false
    }

    if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        alert("Please enter a valid date")
        return false
    }
    return true
}
function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}
function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function ValidateDate(obj) {
    if (obj.value != "") {
        if (isDate(obj.value) == false) {
            obj.focus();
            return false;
        }
        return true;
    }
}
function IsDateGreater(DateValue1, DateValue2) {
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];
    if (Date.parse(DateValue1) == Date.parse(DateValue2))
        return true;
    else
        if (Date.parse(DateValue1) > Date.parse(DateValue2))
        return true;
    else
        return false;
}

function ValidDateHSD(txtDate, lblIssueDt) {
    var date = new Date()
    var lbl_OilExp_Expense = document.getElementById("ctl00_MyCPH1_lbl_OilExp_Expense");
    var d = "", m = "";

    d = date.getDate().toString();
    m = (date.getMonth() + 1).toString();

    if (d.length == 1) { d = "0" + d; }
    if (m.length == 1) { m = "0" + m; }

    date = d + "/" + m + "/" + date.getFullYear();

    if (txtDate.value == "") {
        lbl_OilExp_Expense.innerText = "";
        txtDate.style.borderColor = "";
        return true;
    }
    else {
        if (!isDate(txtDate.value)) {
            txtDate.style.borderColor = "red";
            lbl_OilExp_Expense.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value = "";
            txtDate.focus();
            return false;
        }
        else {
            if (!IsDateGreater(date, txtDate.value)) {
                txtDate.style.borderColor = "red";
                lbl_OilExp_Expense.innerText = "Bill Date should not be greater than today's date for HSD/OIL Expenses!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_OilExp_Expense.innerText = "";
            }
            if (!IsDateGreater(txtDate.value, lblIssueDt.innerText)) {
                txtDate.style.borderColor = "red";
                lbl_OilExp_Expense.innerText = "Bill Date should not be less than Issue Slip Date for HSD/OIL Expenses!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_OilExp_Expense.innerText = "";
            }

        }
    }
}

function ValidCloseDate(txtDate, lblIssueDt) {
    var date = new Date()
    var lbl_Enroute_Err = document.getElementById("ctl00_MyCPH1_lblError");
    var d = "", m = "";

    d = date.getDate().toString();
    m = (date.getMonth() + 1).toString();

    if (d.length == 1) { d = "0" + d; }
    if (m.length == 1) { m = "0" + m; }

    date = d + "/" + m + "/" + date.getFullYear();

    if (txtDate.value == "") {
        lbl_Enroute_Err.innerText = "";
        txtDate.style.borderColor = "";
        return true;
    }
    else {
        if (!isDate(txtDate.value)) {
            txtDate.style.borderColor = "red";
            lbl_Enroute_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value = "";
            txtDate.focus();
            return false;
        }
        else {
            if (!IsDateGreater(date, txtDate.value)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Trisheet close date should not be greater than today's date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
            if (!IsDateGreater(txtDate.value, lblIssueDt.innerText)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Tripsheet close date should not be less than Issue Slip Date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
        }
    }
}
function ValidCloseDateFinance(lblIssueNo, txtDate, lblIssueDt) {
    var date = new Date()
    var currentTime = new Date();

    var lbl_Enroute_Err = document.getElementById("ctl00_MyCPH1_lblError");
    var AdvancedEntryDate = "";
    var d = "", m = "";

    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function() {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    AdvancedEntryDate = returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetAdvTripDate&datetime=" + currentTime + "&TripsheetNo=" + lblIssueNo.innerText, false);
        xmlHttpRequest.send(null);
    }

    //alert(AdvancedEntryDate)

    d = date.getDate().toString();
    m = (date.getMonth() + 1).toString();

    if (d.length == 1) { d = "0" + d; }
    if (m.length == 1) { m = "0" + m; }

    date = d + "/" + m + "/" + date.getFullYear();

    if (txtDate.value == "") {
        lbl_Enroute_Err.innerText = "";
        txtDate.style.borderColor = "";
        return true;
    }
    else {
        if (!isDate(txtDate.value)) {
            txtDate.style.borderColor = "red";
            lbl_Enroute_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value = "";
            txtDate.focus();
            return false;
        }
        else {
            if (!IsDateGreater(date, txtDate.value)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Trisheet close date should not be greater than today's date!!!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
            if (!IsDateGreater(txtDate.value, lblIssueDt.innerText)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Tripsheet close date should not be less than Issue Slip Date!!!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
            if (AdvancedEntryDate != txtDate.value) {
                if (IsDateGreater(AdvancedEntryDate, txtDate.value)) {
                    txtDate.style.borderColor = "red";
                    lbl_Enroute_Err.innerText = "Tripsheet close date should be greater than Advanced Entry Date!!!";
                    txtDate.focus();
                    return false;
                }
                else {
                    txtDate.style.borderColor = "";
                    lbl_Enroute_Err.innerText = "";
                }
            }
        }
    }

}
function ValidCloseDateOperational(txtDate, lblIssueDt) {
    var date = new Date()
    var lbl_Enroute_Err = document.getElementById("ctl00_MyCPH1_lblError");
    var d = "", m = "";

    d = date.getDate().toString();
    m = (date.getMonth() + 1).toString();

    if (d.length == 1) { d = "0" + d; }
    if (m.length == 1) { m = "0" + m; }

    date = d + "/" + m + "/" + date.getFullYear();

    if (txtDate.value == "") {
        lbl_Enroute_Err.innerText = "";
        txtDate.style.borderColor = "";
        return true;
    }
    else {
        if (!isDate(txtDate.value)) {
            txtDate.style.borderColor = "red";
            lbl_Enroute_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value = "";
            txtDate.focus();
            return false;
        }
        else {
            if (!IsDateGreater(date, txtDate.value)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Trisheet close date should not be greater than today's date!!!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
            if (!IsDateGreater(txtDate.value, lblIssueDt.innerText)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Tripsheet close date should not be less than Issue Slip Date!!!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }

        }
    }
}
function ValidDate(txtDate, lblIssueDt) {
    var date = new Date()
    var lbl_Enroute_Err = document.getElementById("ctl00_MyCPH1_lbl_Enroute_Err");
    var d = "", m = "";

    d = date.getDate().toString();
    m = (date.getMonth() + 1).toString();

    if (d.length == 1) { d = "0" + d; }
    if (m.length == 1) { m = "0" + m; }

    date = d + "/" + m + "/" + date.getFullYear();

    if (txtDate.value == "") {
        lbl_Enroute_Err.innerText = "";
        txtDate.style.borderColor = "";
        return true;
    }
    else {
        if (!isDate(txtDate.value)) {
            txtDate.style.borderColor = "red";
            lbl_Enroute_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value = "";
            txtDate.focus();
            return false;
        }
        else {
            if (!IsDateGreater(date, txtDate.value)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Bill Date should not be greater than today's date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }
            if (!IsDateGreater(txtDate.value, lblIssueDt.innerText)) {
                txtDate.style.borderColor = "red";
                lbl_Enroute_Err.innerText = "Bill Date should not be less than Issue Slip Date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else {
                txtDate.style.borderColor = "";
                lbl_Enroute_Err.innerText = "";
            }

        }
    }
}

function calculateBalance() {
    //    var hfEnAmtTotal=document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    //    var hfETotalAmt=document.getElementById("ctl00_MyCPH1_hfETotalAmt");

    var totadv = "0.00", totamt = "0.00";
    for (i = 0; i < 20; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00$MyCPH1$dgEnroute$ctl0" + j + "$";
        }
        else {
            pref = "ctl00$MyCPH1$dgEnroute$ctl" + j + "$";
        }
        var amt = document.getElementById(pref + "txtAmt");
        var EAmt = document.getElementById(pref + "txtEAmt");
        if (amt.value != "") {
            totadv = parseFloat(totadv) + parseFloat(amt.value);
        }
        if (EAmt.value != "") {
            totamt = parseFloat(totamt) + parseFloat(EAmt.value);
        }
    }
    document.getElementById("ctl00$MyCPH1$dgEnroute$ctl22$txtEnAmtTotal").value = totadv;
    document.getElementById("ctl00$MyCPH1$dgEnroute$ctl22$txtETotalAmt").value = totamt;
    //    hfEnAmtTotal.value=totadv;
    //    hfETotalAmt.value=totamt
}

function GVcalculateBalance() {
    var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
    var l = 0;

    l = gvEnroute.rows.length;

    var txtETotalAmt = "";
    var txtEnAmtTotal = "";

    if (l < 10) {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtEnAmtTotal");
    }
    else {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtEnAmtTotal");
    }

    var hfEnAmtTotal = document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    var hfETotalAmt = document.getElementById("ctl00_MyCPH1_hfETotalAmt");

    var totadv = "0.00", totamt = "0.00";

    for (i = 0; i < l - 2; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvEnroute_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvEnroute_ctl" + j + "_";
        }

        var amt = document.getElementById(pref + "txtAmount");
        var EAmt = document.getElementById(pref + "txtEAmt");
        var hfPolarity = document.getElementById(pref + "hfPolarity");
        if (hfPolarity.value == "+") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) + parseFloat(amt.value);
            }
            if (EAmt.value != "") {
                totamt = parseFloat(totamt) + parseFloat(EAmt.value);
            }
        }
        else if (hfPolarity.value == "-") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) - parseFloat(amt.value);
            }
            if (EAmt.value != "") {
                totamt = parseFloat(totamt) - parseFloat(EAmt.value);
            }
        }
    }

    hfEnAmtTotal.value = totadv;
    hfETotalAmt.value = totamt;
    txtEnAmtTotal.value = totadv;
    txtETotalAmt.value = totamt;

    txtEnAmtTotal.value = hfEnAmtTotal.value;
    txtETotalAmt.value = hfETotalAmt.value;

}
function GVcalculateBalanceNew() {
    var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
    var l = 0;

    l = gvEnroute.rows.length;

    var txtETotalAmt = "";
    var txtEnAmtTotal = "";

    if (l < 10) {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtEnAmtTotal");
    }
    else {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtEnAmtTotal");
    }

    var hfEnAmtTotal = document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    var hfETotalAmt = document.getElementById("ctl00_MyCPH1_hfETotalAmt");

    var totadv = "0.00", totamt = "0.00";

    for (i = 0; i < l - 2; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvEnroute_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvEnroute_ctl" + j + "_";
        }

        var amt = document.getElementById(pref + "txtAmount");
        var EAmt = document.getElementById(pref + "txtEAmt");
        var hfPolarity = document.getElementById(pref + "hfPolarity");
        if (hfPolarity.value == "+") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) + parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) + parseFloat(EAmt.innerText);
            }
        }
        else if (hfPolarity.value == "-") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) - parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) - parseFloat(EAmt.innerText);
            }
        }
    }

    hfEnAmtTotal.value = totadv;
    hfETotalAmt.value = totamt;
    txtEnAmtTotal.innerText = totadv;
    txtETotalAmt.innerText = totamt;

    txtEnAmtTotal.innerText = hfEnAmtTotal.value;
    txtETotalAmt.innerText = hfETotalAmt.value;

}


function GVcalculateBalanceNewVer1() {
    var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
    var l = 0;

    l = gvEnroute.rows.length;

    var txtETotalAmt = "";
    var txtEnAmtTotal = "";

    if (l < 10) {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtEnAmtTotal");
    }
    else {
        txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtETotalAmt");
        txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + l + "_txtEnAmtTotal");
    }

    var hfEnAmtTotal = document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    var hfETotalAmt = document.getElementById("ctl00_MyCPH1_hfETotalAmt");

    var totadv = "0.00", totamt = "0.00";

    for (i = 0; i < l - 2; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvEnroute_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvEnroute_ctl" + j + "_";
        }

        var amt = document.getElementById(pref + "txtAmount");
        var EAmt = document.getElementById(pref + "txtEAmt");
        var hfPolarity = document.getElementById(pref + "hfPolarity");
        if (hfPolarity.value == "+") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) + parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) + parseFloat(EAmt.innerText);
            }
        }
        else if (hfPolarity.value == "-") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) - parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) - parseFloat(EAmt.innerText);
            }
        }
    }

    hfEnAmtTotal.value = totadv;
    hfETotalAmt.value = totamt;
    txtEnAmtTotal.innerText = totadv;
    txtETotalAmt.innerText = totamt;

    txtEnAmtTotal.innerText = hfEnAmtTotal.value;
    txtETotalAmt.innerText = hfETotalAmt.value;


    //Exrtra Expense calculation

    var gvEnrouteExtra = document.getElementById("ctl00_MyCPH1_gvEnrouteExtra");
    var lE = 0;

    lE = gvEnrouteExtra.rows.length;

    var txtETotalAmtExtra = "";
    var txtEnAmtTotalExtra = "";

    if (lE < 10) {
        txtETotalAmtExtra = document.getElementById("ctl00_MyCPH1_gvEnrouteExtra_ctl0" + lE + "_txtETotalAmt");
        txtEnAmtTotalExtra = document.getElementById("ctl00_MyCPH1_gvEnrouteExtra_ctl0" + lE + "_txtEnAmtTotal");
    }
    else {
        txtETotalAmtExtra = document.getElementById("ctl00_MyCPH1_gvEnrouteExtra_ctl" + lE + "_txtETotalAmt");
        txtEnAmtTotalExtra = document.getElementById("ctl00_MyCPH1_gvEnrouteExtra_ctl" + lE + "_txtEnAmtTotal");
    }

    var hfEnAmtTotal = document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    var hfETotalAmt = document.getElementById("ctl00_MyCPH1_hfETotalAmt");

    //var totadv = "0.00", totamt = "0.00";

    for (i = 0; i < lE - 2; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_gvEnrouteExtra_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_gvEnrouteExtra_ctl" + j + "_";
        }

        var amt = document.getElementById(pref + "txtAmount");
        var EAmt = document.getElementById(pref + "txtEAmt");
        var hfPolarity = document.getElementById(pref + "hfPolarity");
        if (hfPolarity.value == "+") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) + parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) + parseFloat(EAmt.innerText);
            }
        }
        else if (hfPolarity.value == "-") {
            if (amt.value != "") {
                totadv = parseFloat(totadv) - parseFloat(amt.value);
            }
            if (EAmt.innerText != "") {
                totamt = parseFloat(totamt) - parseFloat(EAmt.innerText);
            }
        }
    }

    hfEnAmtTotal.value = totadv;
    hfETotalAmt.value = totamt;

    txtEnAmtTotalExtra.innerText = totadv;
    txtETotalAmtExtra.innerText = totamt;
    
    //ProposedExpense = totamt;
    //txtEnAmtTotalExtra.innerText = hfEnAmtTotal.value;
    //txtETotalAmtExtra.innerText = hfETotalAmt.value;


}

function calculateBalanceNew() {
    var totadv = "0.00", totamt = "0.00";
    for (i = 0; i < 20; i++) {
        j = i + 2
        var pref = "";
        if (j < 10) {
            pref = "ctl00_MyCPH1_dgEnroute_ctl0" + j + "_";
        }
        else {
            pref = "ctl00_MyCPH1_dgEnroute_ctl" + j + "_";
        }
        var amt = document.getElementById(pref + "txtAmount");
        var EAmt = document.getElementById(pref + "txtEAmt");
        if (amt.value != "") {
            totadv = parseFloat(totadv) + parseFloat(amt.value);
        }
        if (innerText.value != "") {
            totamt = parseFloat(totamt) + parseFloat(EAmt.innerText);
        }
    }
    document.getElementById("ctl00_MyCPH1_dgEnroute_ctl22_txtEnAmtTotal").innerText = totadv;
    document.getElementById("ctl00_MyCPH1_dgEnroute_ctl22_txtETotalAmt").innerText = totamt;
}

function validFloat(event, txtid) {
    var tb = document.getElementById(txtid);
    var txt = tb.value;
    if (event.keyCode == 13)
        return true;

    if (event.keyCode == 46)
        if (txt.indexOf('.') != -1)
        event.keyCode = 0;

    if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
    { event.keyCode = 0; return false; }
} 
