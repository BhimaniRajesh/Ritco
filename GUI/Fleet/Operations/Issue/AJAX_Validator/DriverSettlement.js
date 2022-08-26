
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
    if (Date.parse(DateValue1) >= Date.parse(DateValue2))
        return true;
    else
        return false;
}


var dtCh = "/";
var minYear = "1900";
var maxYear = "2100";
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this;
}

function CheckDsDateGreaterCloseDate() {
    var txtSettleDate = document.getElementById('ctl00$MyCPH1$txtSettleDate');
    var lblFinCloseDt = document.getElementById('ctl00$MyCPH1$lblFinCloseDt');
    if (txtSettleDate.value != lblFinCloseDt.innerText) {
        if (IsDateGreater(lblFinCloseDt.innerText, txtSettleDate.value)) {
            alert("Driver Settlement date is must be greater than Tripsheet Close Date.");
            txtSettleDate.value = "";
            txtSettleDate.focus();
            return false;
        }
    }
}

function CheckDsDateGreaterLastAdvDate() {
    var txtSettleDate = document.getElementById('ctl00$MyCPH1$txtSettleDate');
    var hfAdvDate = document.getElementById('ctl00$MyCPH1$hfAdvDate');
    if (txtSettleDate.value != hfAdvDate.value) {
        if (IsDateGreater(hfAdvDate.value, txtSettleDate.value)) {
            alert("Driver Settlement date is must be greater than Last Tripsheet Advanced Date.");
            txtSettleDate.value = "";
            txtSettleDate.focus();
            return false;
        }
    }
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
        alert("The date format should be : dd/mm/yyyy")
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
// function validrec(obj,tran,chqno,chqdate)
//        {
//            
//            if(document.getElementById('ctl00$MyCPH1$UCReceipt$txtAmount').value != '0.00')
//            {
//                        if(tran.value == "")
//                        {
//                                alert("Select Mode Of Transaction");
//                                return false;
//                        }
//                        
//                        
//                       
//                       
//                      
//                       if (tran.value == "BANK")
//                        {
//                        
//                        
//                        if (chqno.value == "")
//                            {
//                                alert("Enter Cheque Number");
//                                return false;
//                            }  
//                              if (chqno.value.length<6 )
//                            {
//                                alert("Cheque Number should be of six digit");
//                                return false;
//                            }
//                             
//                             if (chqdate.value == "")
//                            {
//                                alert("Enter Cheque Date");
//                                return false;
//                            }
//                             if (ValidateDate(chqdate)==false)
//                            {
//                                alert("Invalid Cheque Date");
//                                return false;
//                            }
//                          }  
//                            
//                            if (document.getElementById('ctl00$MyCPH1$UCReceipt$txtBanknm').value == '')
//                            {
//                                 alert("Please enter Bank Name !!")
//                                return false;
//                            }
//                             if (document.getElementById('ctl00$MyCPH1$UCReceipt$txtBranchnm').value == '')
//                            {
//                                 alert("Please enter Bank Branch Name !!")
//                                return false;
//                            }
//                            
//           }
//            
//        }
//        
function validcheck() {

    if (document.getElementById('ctl00$MyCPH1$txtSettleDate').value == "") {
        alert("Please Enter Driver Settlement Date");
        document.getElementById('ctl00$MyCPH1$txtSettleDate').focus();
        return false;
    }
    if (document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').readOnly == false) {
        if (document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value == "") {
            alert("Please enter amount paid to driver !!")
            document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').focus();
            return false;
        }
    }
    if (document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').readOnly == false) {
        if (document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value == "") {
            alert("Please enter amount received from driver !!")
            document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').focus();
            return false;
        }
    }
    if (document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').readOnly == false) {
        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            //if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value=="" )
            {
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
            }
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
        }

        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            //if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value=="" )
            {
                document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
            }
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
        }
        if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtPaidToDriver').value;
        }
        if (!CheckData()) {
            return false;
        }
    }


    if (document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').readOnly == false) {

        if (document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$ddlPayMode').value == "Cash")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            // if(document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtCashAmt').value=="" )
            {
                document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtCashAmt').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
            }
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
        }

        if (document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$ddlPayMode').value == "Bank")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            // if(document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtChqAmt').value=="" )
            {
                document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtChqAmt').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
            }
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
        }
        if (document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$ddlPayMode').value == "Both")//|| document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"
        {
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtNetPay').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
            document.getElementById('ctl00$MyCPH1$UCMyReceiptControl1$txtAmtApplA').value = document.getElementById('ctl00$MyCPH1$txtAmtRecvdFromDriver').value;
        }
        if (!CheckData_Receipt()) {
            return false;
        }
    }
    if (confirm("Do you want to submit") == false) {
        return false;
    }
}








//    function valid(obj,tran,chqno,chqdate)
//        {
//            
//            if(document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value != '0.00')
//            {
//                        if(tran.value == "")
//                        {
//                                alert("Select Mode Of Transaction");
//                                return false;
//                        }
//                        
//                        if (tran.value == "CASH")
//                        {
//                         if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
//                            {
//                                 alert("Please Select Cash account !!")
//                                return false;
//                            }
//                        }
//                       
//                       
//                      
//                        if (tran.value == "BANK")
//                        {
//                            
//                            if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
//                            {
//                                 alert("Please Select Bank Name !!")
//                                return false;
//                            }
//                            
//                            if (chqno.value == "")
//                            {
//                                alert("Enter Cheque Number");
//                                return false;
//                            }  
//                              if (chqno.value.length<6 )
//                            {
//                                alert("Cheque Number should be of six digit");
//                                return false;
//                            }
//                             
//                             if (chqdate.value == "")
//                            {
//                                alert("Enter Cheque Date");
//                                return false;
//                            }
//                             if (ValidateDate(chqdate)==false)
//                            {
//                                alert("Invalid Cheque Date");
//                                return false;
//                            }
//                            
//                            
//                            
//                        }
//                        
//           }
//            
//        }
        
        
       