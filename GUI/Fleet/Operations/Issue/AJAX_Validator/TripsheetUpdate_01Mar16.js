function IsDateGreater(DateValue1, DateValue2) {
    var a = DateValue1.split("/");
    var b = DateValue2.split("/");
    DateValue1 = a[1] + "/" + a[0] + "/" + a[2];
    DateValue2 = b[1] + "/" + b[0] + "/" + b[2];
    if (Date.parse(DateValue1) >= Date.parse(DateValue2))
        return true;
    else
        return false;
}

function valid(obj, tran, chqno, chqdate, VslipDt, VCloseDt, ServerDt) {

    var grid1 = document.getElementById("ctl00_MyCPH1_dgAdvancedet");
    var r1 = grid1.rows.length;

    for (i = 0; i < r1 - 1; i++) {
        //alert("1");
        j = i + 2
        var pref = "";

        if (j < 10) {
            pref = "ctl00_MyCPH1_dgAdvancedet_ctl0" + j + "_";

        }
        else {
            pref = "ctl00_MyCPH1_dgAdvancedet_ctl" + j + "_";

        }
        //alert("2");
        var mSelect = document.getElementById(pref + "chksel");
        //alert(mSelect.name) 
        //                    alert("1");
        //                    if(document.getElementById(pref + "chksel").checked==true)
        //                    {
        //                        alert(pref);   
        //                    }
        //                  alert("2");

        //if(document.getElementById(pref + "chksel").checked==true)
        {
            if (document.getElementById(pref + "txtAdvPlace").value != "" || document.getElementById(pref + "txtAdvDt").value != "" || document.getElementById(pref + "txtAdvAmt").value != "" || document.getElementById(pref + "txtBranchCode").value != "" || document.getElementById(pref + "txtSignature").value != "") {


                //alert(mSelect.name) 

                if (document.getElementById(pref + "txtAdvPlace").value == "") {
                    alert("Please Enter Advance Place !!")
                    document.getElementById(pref + "txtAdvPlace").focus();
                    return false;

                }


                if (document.getElementById(pref + "txtAdvDt").value == "") {
                    alert("Please Enter Advance Date !!")
                    document.getElementById(pref + "txtAdvDt").focus();
                    return false;

                }

                var AdvDt = document.getElementById(pref + "txtAdvDt").value;

                if (AdvDt.length < 10) {
                    alert("The date format should be : dd/mm/yyyy")
                    document.getElementById(pref + "txtAdvDt").focus();
                    return false
                }


                if (!Date.parse(AdvDt)) {
                    alert("Invalid advance date !!!")
                    document.getElementById(pref + "txtAdvDt").focus();
                    return false
                }



                //alert("AdvDt : " + Date.parse(AdvDt))
                // alert("VslipDt : " + Date.parse(VslipDt))
                //alert("ServerDt : " + Date.parse(ServerDt))
                //alert("VCloseDt : " + Date.parse(VCloseDt))


                if (!IsDateGreater(AdvDt, VslipDt))
                //if(Date.parse(AdvDt)< Date.parse(VslipDt))
                {
                    alert("Advance date can not be less than Issue Slip date " + VslipDt + "  !!!")
                    document.getElementById(pref + "txtAdvDt").focus();
                    return false
                }

                if (!IsDateGreater(ServerDt, AdvDt))
                //if(Date.parse(AdvDt)> Date.parse(ServerDt))
                {
                    alert("Advance date can not be greater than today's date !!!")
                    document.getElementById(pref + "txtAdvDt").focus();
                    return false
                }

                if (VCloseDt != "") {
                    if (!IsDateGreater(VCloseDt, AdvDt))
                    //if(Date.parse(AdvDt)> Date.parse(VCloseDt))
                    {
                        alert("Advance date can not be greater than Issue Slip close date " + VCloseDt + " !!!")
                        document.getElementById(pref + "txtAdvDt").focus();
                        return false
                    }
                }


                if (document.getElementById(pref + "txtAdvAmt").value == "") {
                    alert("Please Enter Advance Amount !!")
                    document.getElementById(pref + "txtAdvAmt").focus();
                    return false;

                }
                if (document.getElementById(pref + "txtBranchCode").value == "") {
                    alert("Please Enter Branchcode !!")
                    document.getElementById(pref + "txtBranchCode").focus();
                    return false;

                }

                if (document.getElementById(pref + "txtSignature").value == "") {
                    alert("Please Enter Advance Payee !!")
                    document.getElementById(pref + "txtSignature").focus();
                    return false;

                }

            } //if End
        }
    }
    //For End     
    //         
    if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value <= 0) {

        alert("Amount  should be greater  than Zero");
        return false;
    }

    if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value > 0) {

        if (tran.value == "") {
            alert("Select Mode Of Transaction");
            return false;
        }


        if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '') {
            alert("Please Select Cash/Bank Account !!")
            return false;
        }





        if (tran.value == "BANK") {
            if (chqno.value == "") {
                alert("Enter Cheque Number");
                return false;
            }
            else if (chqdate.value == "") {
                alert("Enter Cheque Date");
                return false;
            }
            else if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '') {
                alert("Please Select Bank Name !!")
                return false;
            }
            else if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00') {
                alert("Please Enter Amount !!")
                return false;
            }
        }
        else {

            if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00') {
                alert("Please Enter Amount !!")
                return false;
            }
        }
    }

}


function changeFocus(obj) {
    document.getElementById('ctl00$MyCPH1$cmdSubmit').focus()
}
function changePayment(obj) {
    alert("OK");
}



function Trip_Validation(Obj, mTripno, mTripLoc) {
    if (Obj.value == "") {
        return false;
    }
    //                                 if(ValidateDate(Obj)==false)
    //                                 {
    //                                    return false;
    //                                 }
    var Code_ID = Obj;
    var findobj = false;
    findobj = GetXMLHttpObject();

    if (findobj) {
        // alert(findobj)
        //var strpg="Tripsheet_Adv_Check_For_Stock.aspx"?DocCode="+DocCode+"&Value=" + Code_ID.value + "&sid=" + Math.random();
        var strpg = "Tripsheet_Adv_Check_For_Stock.aspx?TripNo=" + mTripno + "&TripLoc=" + mTripLoc + "&sid=" + Math.random();
        //alert(strpg)

        //alert(strpg);
        findobj.open("GET", strpg, true);
        findobj.onreadystatechange = function() {
            //alert(findobj.readyState)
            // alert(findobj.responseText)
            if (findobj.readyState == 4 && findobj.status == 200) {
                // alert(findobj.responseText)
                // var res=findobj.responseText.split("|");
                var res = findobj.responseText;
                if (res != "") {
                    alert(res);
                    Code_ID.value = "";
                    Code_ID.focus();
                    // document.getElementById(ABC).value="N"
                    return false;
                }
                else {
                    //document.getElementById(ABC).value="Y"
                }
            }
        }
        findobj.send(null);
    }

    return true

}
	    