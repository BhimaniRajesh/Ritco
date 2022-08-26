<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="vendorpayvoucher_Step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_vendorpayvoucher_Step2" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl_Fa.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <script language="javascript" type="text/javascript">
var submit = 0;
 function CheckDouble() {
	             
            //debugger;
            if (++submit > 1) {
                alert('This sometimes takes a few seconds - please be patient.');
                submit = 0;
                return false;
            }
	    return fsubmit();	
//            return true;
        }
        var Form_name = "ctl00$MyCPH1$"
        frm_name = "ctl00$MyCPH1$"
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var client_name = "<%=Session["Client"]%>"
    var Fromdate = "<%=Fromdt%>"
        //alert(Fromdate)
        var Todate = "<%=Todt%>"
        var FinYear = "<%=Session["FinYear"]%>"
        var FinYear_to = parseInt(FinYear) + 1
        Frmnae = "ctl00$MyCPH1$"
        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to
        }
        var FinYear_fromdate = "01/04/" + FinYear
        var FinYear_todate = "31/03/" + FinYear_to
        var Sle_finyear = FinYear + "-" + FinYear_to



        function calculation(a, b, c, d) {
            //alert("calculation");
            //alert("a: " + a);
            //alert("b: " + b);
            //alert("c: " + c);
            //alert("d: " + d);
            if (document.getElementById(d).checked == false) {
                document.getElementById(c).disabled = true

                var rows1 = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
                //alert("rows1 : " + rows1)
                if (rows1 <= 9) {
                    var id1 = "ctl00_MyCPH1_BillDetail_ctl0" + rows1 + "_txtTotal"
                }
                else {
                    var id1 = "ctl00_MyCPH1_BillDetail_ctl" + rows1 + "_txtTotal"
                }

                //alert("hi1");
                document.getElementById(id1).value = parseFloat(document.getElementById(id1).value) - document.getElementById(c).value
                //document.getElementById('ctl00_MyCPH1_colamt').value =document.getElementById(id1).value
                // document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById(id1).value;
                // document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById(id1).value;
                //// alert("Hi PAtanahi");
                // if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
                //     {
                //         document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = document.getElementById(id1).value;
                //     }
                // }

                // if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
                //     {
                //         document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = document.getElementById(id1).value;
                //     }
                // }
                //document.getElementById('ctl00_MyCPH1_netamt').value=0;
                //alert("a : " + a);
                //alert("b : " + b);
                //alert("c : " + c);
                //alert("d : " + d);
                document.getElementById('ctl00_MyCPH1_netamt').value = document.getElementById(id1).value;//parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value) - parseFloat(document.getElementById(a).innerText)
                //alert(document.getElementById(a).innerText);
                //alert(document.getElementById(b).innerText)
                //alert(document.getElementById(c).innerText)
                //sdocument.getElementById('ctl00_MyCPH1_netamt').value = parseFloat(document.getElementById(a).innerText) - parseFloat(document.getElementById(b).innerText)- parseFloat(document.getElementById(c).innerText)
                document.getElementById(c).value = 0

            }
            else {
                //alert("hi-1")
                document.getElementById(c).disabled = false
                var tot
                var varnetamt = document.getElementById(a).innerText
                var varpendamt = document.getElementById(b).innerText
                if (varpendamt == "") {
                    varpendamt = 0;
                    tot = parseFloat(varnetamt) - parseFloat(varpendamt)

                }
                tot = parseFloat(varnetamt) - parseFloat(varpendamt)

                document.getElementById(c).value = tot

                var rows = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
                //alert("rows : " + rows)

                if (rows <= 9) {
                    var id = "ctl00_MyCPH1_BillDetail_ctl0" + rows + "_txtTotal"
                }
                else {
                    var id = "ctl00_MyCPH1_BillDetail_ctl" + rows + "_txtTotal"
                }
                if (document.getElementById('ctl00_MyCPH1_netamt').value == "") {
                    document.getElementById('ctl00_MyCPH1_netamt').value = 0.00
                }
                document.getElementById(id).value = parseFloat(tot) + parseFloat(document.getElementById(id).value)
                //document.getElementById('ctl00_MyCPH1_colamt').value =document.getElementById(id).value

                // document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = document.getElementById(id).value;
                // document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = document.getElementById(id).value;
                //// alert("Hi PAtanahi1");
                // if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
                //     {
                //         document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = document.getElementById(id).value;
                //     }
                // }

                // if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
                //     {
                //         document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = document.getElementById(id).value;
                //     }
                // }



                //document.getElementById('ctl00_MyCPH1_netamt').value=0;
                document.getElementById('ctl00_MyCPH1_netamt').value = parseFloat(tot) + parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value)
            }
            fuleCalculation();
            //document.getElementById('ctl00_MyCPH1_netamt').value =document.getElementById(id).value;
        }

        function total_colam(netamt) {

            var collamount = 0
            var netpayamt = 0
            var currpayamt = 0

            if (reccount > 2) {
                for (i = 0; i < reccount - 1; i++) {

                    if (chkDoc[i + 1].checked == true) {
                        collamount = Number(collamount) + Number(OCTOTALDUE[i].value)
                        issueamt[i].value = issueamt_ori[i].value
                        netpayamt = Number(netpayamt) + Number(OCTOTALDUE[i].value)
                        currpayamt = Number(currpayamt) + Number(issueamt[i].value)
                    }
                    else {
                        issueamt[i].value = 0
                    }
                }
            }
            else {
                for (i = 0; i < reccount - 1; i++) {

                    if (chkDoc[i + 1].checked == true) {
                        collamount = netamt
                        issueamt.value = issueamt_ori.value
                        netpayamt = +Number(OCTOTALDUE.value)
                        currpayamt = Number(currpayamt) + Number(issueamt.value)
                    }
                    else {
                        issueamt.value = 0
                    }
                }
            }
            colamt.value = roundit(currpayamt)
            nettot.value = roundit(currpayamt)
            totissueamt.value = roundit(currpayamt)

        }
        function fvalidatePayAmt(a, maxVal, obj, d) {
            //alert("fvalidatePayAmt");
            maxVal = parseFloat(document.getElementById(a).innerText)
            CurrVal = parseFloat(document.getElementById(obj).value)

            if (CurrVal > maxVal) {
                alert("Maximum amount pending for payment is " + Math.round(maxVal))
                document.getElementById(obj).focus();
                return false;
            }
            var reccount = "<%=intTotalRecords%>"
        var currpayamt = 0
        for (i = 0; i < reccount; i++) {
            j = i + 2
            if (j < 10) {

                frm3 = Form_name + "BillDetail$ctl" + "0" + j + "$"
            }
            else {
                frm3 = Form_name + "BillDetail$ctl" + j + "$"

            }
            k = j + 1
            if (document.getElementById(d).checked == true) {
                currpayamt = Number(currpayamt) + Number(document.getElementById(frm3 + "txtCurrPayment").value)

            }
            else {
                document.getElementById(frm3 + "txtCurrPayment").value = 0;
            }
        }
        if (k < 10) {

            frm3 = Form_name + "BillDetail$ctl" + "0" + k + "$"
        }
        else {
            frm3 = Form_name + "BillDetail$ctl" + k + "$"

        }


        document.getElementById(frm3 + "txtTotal").value = currpayamt;
        //document.getElementById(Form_name+"colamt").value=currpayamt;
            //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = currpayamt;
            //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = currpayamt;
            //document.getElementById('ctl00_MyCPH1_netamt').value = currpayamt;
            //if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
            //    {
            //        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = currpayamt;
            //    }
            //}

            //if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
            //    {
            //        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = currpayamt;
            //    }
            //}

 fuleCalculation();



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


    function fsubmit() {


        var mTotalRecords = "<%=intTotalRecords%>"

    var server_dt = "<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"

    var mDerivedControlName = "";
    var mCurrPaymentControlName = "";
    var mBillDateControlName = "";

    var mnetamtControlName = "";
    var mAdvpaidControlName = "";
    var TotNetPayment = 0;
    var mSelection = 0;
    var j = 0;
    var mSelectedDockets = "";

    var mBillDate = "";


    var dt = document.getElementById(Frmnae + "txtVoucherDt").value
    var dt_dd = dt.substring(0, 2)
    var dt_mm = dt.substring(3, 5)
    var dt_yy = dt.substring(6, 10)
    dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))


    for (var i = 0; i < mTotalRecords; i++) {
        var CurrPayment = 0;
        j = i + 2;
        if (i < 10) {
            mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$chkBill"
            mCurrPaymentControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$txtCurrPayment"
              //  mBillDateControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$mVendorBill_DT"
            mnetamtControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$nettotamt"
            mAdvpaidControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$Advpaid"

        }
        else {
            mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$chkBill"
            mCurrPaymentControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$txtCurrPayment"
                //mBillDateControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$mVendorBill_DT"
            mnetamtControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$nettotamt"
            mAdvpaidControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$Advpaid"
            //ctl00_MyCPH1_BillDetail_ctl02_pendamt
        }


        //Populate Docket No.s for Preaparing Loading Sheet

        if (document.getElementById(mDerivedControlName)) {
            if (document.getElementById(mDerivedControlName).checked == true) {
                if (mSelection == 0) {
                    mSelection = 1;
                }
                else {
                    mSelection = mSelection + 1
                }
                CurrPayment = parseFloat(CurrPayment) + parseFloat(document.getElementById(mCurrPaymentControlName).value);
                TotNetPayment = parseFloat(TotNetPayment) + parseFloat(CurrPayment);
                mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);

                //alert(document.getElementById(mnetamtControlName).value);
                //alert(document.getElementById(mAdvpaidControlName).value);

                var balamt = "";
                balamt = parseFloat(document.getElementById(mnetamtControlName).value) - parseFloat(document.getElementById(mAdvpaidControlName).value);
                if (parseFloat(CurrPayment) > parseFloat(balamt)) {
                    alert("Current payment can not be greater than " + balamt);
                    document.getElementById(mCurrPaymentControlName).focus();
                    return false;
                }

		//if(document.getElementById('ctl00_MyCPH1_UCMyPaymentControl1_ddlPayMode').value == "-1")
//	{
	//	alert("Please Select Payment Mode!");
     //   return false;
	//}

                    //mBillDate = document.getElementById(mBillDateControlName).value;
                    //alert(mBillDate);
                    //var mBillDate_dd = mBillDate.substring(0, 2)
                    //var mBillDate_mm = mBillDate.substring(3, 5)
                    //var mBillDate_yy = mBillDate.substring(6, 10)
                    //mBillDate = new Date(months[parseFloat(mBillDate_mm)] + " " + parseFloat(mBillDate_dd) + ", " + parseFloat(mBillDate_yy))
                    ////alert(mBillDate)
                    //if (dt < mBillDate) {
                    //    alert("Voucher Date should not be less than vendor bill date !!!")
                    //    document.getElementById(Frmnae + "txtVoucherDt").focus();
                    //    return false;
                    //}


            }
        }
    }


    if (mSelection == 0) {
        alert("Select atleast one Bill to prepare payment voucher!");
        return false;
    }
        var txtInstrumentNo = document.getElementById(Form_name + "txtInstrumentNo");
        var txtInstrumentDate = document.getElementById(Form_name + "txtInstrumentDate");
        var ddlBankAccount = document.getElementById(Form_name + "ddlBankAccount");
        var txtOilCompanyName = document.getElementById(Form_name + "txtOilCompanyName");
        var txtRemark = document.getElementById(Form_name + "txtRemark");
        var ddlTranType = document.getElementById("ctl00_MyCPH1_ddlTranType");
        var ddlPayType = document.getElementById("ctl00_MyCPH1_ddlPayType");
        var trInstrument = document.getElementById("ctl00_MyCPH1_trInstrument");
        var lblRedeemFuelRewards = document.getElementById("ctl00_MyCPH1_lblRedeemFuelRewards");
        var txtRedeemFuelRewards = document.getElementById("ctl00_MyCPH1_txtRedeemFuelRewards");
        var txtInstrumentAmount = document.getElementById("ctl00_MyCPH1_txtInstrumentAmount");

        if (ddlTranType.value == "Instrument" || ddlTranType.value == "Both")
        {
            if (txtInstrumentAmount.value == "" || parseFloat(txtInstrumentAmount.value) <= 0) {
                alert("Instrument Amount can't be blank or zero");
                return false;
            }
            if(txtInstrumentNo.value=="")
            {
                alert("Instrument No can't be blank");
                return false;
            }
            if (txtInstrumentDate.value == "") {
                alert("Instrument Date can't be blank");
                return false;
            }
            if ( ddlBankAccount.value=="") {
                alert("Please select Bank Account Code");
                return false;
            }
        }
        if (ddlTranType.value == "Redeem" || ddlTranType.value == "Both") {
            if (txtRedeemFuelRewards.value == "" || parseFloat(txtRedeemFuelRewards.value)<=0) {
                alert("Redeem Fuel Rewards can't be blank or zero");
                return false;
            }
            
        }
        if (txtOilCompanyName.value == "")
        {
            alert("Oil company name can't be blank");
            return false;
        }
        if (txtRemark.value == "") {
            alert("Remark can't be blank");
            return false;
        }
        if (txtRemark.value.length > 500 ) {
            alert("Please enter Remark Maximum 500 characters");
            return false;
        }


        var txtTotalPaymentAmount = document.getElementById(Form_name + "txtTotalPaymentAmount");
       var  lblNetAmt = document.getElementById("ctl00_MyCPH1_lblNetAmt");
       if (txtTotalPaymentAmount.value == "" || parseFloat(txtTotalPaymentAmount.value) <= 0.00)
       {
           alert("Total Payment Amount can't be blank or zero");
           return false;
       }
       if (lblNetAmt.innerHTML == "" || parseFloat(lblNetAmt.innerHTML) <= 0.00)
       {
           alert("Net bill Amount can't be blank or zero");
           return false;
       }
      if (parseFloat(txtTotalPaymentAmount.value) != parseFloat(lblNetAmt.innerHTML)) {
          alert("Total Payment Amount & Net bill Amount Not Matched");
          return false;
        }


        //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value = TotNetPayment;//CurrPayment;
        //document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value = TotNetPayment;//CurrPayment;
    if (document.getElementById(Form_name + "txtVoucherDt").value == "") {
        alert("Please enter Voucher Date!!!")
        document.getElementById(Form_name + "txtVoucherDt").focus();
        return false;
    }



    // Validation of enter date with System Date
    var dockdt = document.getElementById(Form_name + "txtVoucherDt").value


    dockdt_dd = dockdt.substring(0, 2)
    dockdt_mm = dockdt.substring(3, 5)
    dockdt_yy = dockdt.substring(6, 10)



    var sdt = server_dt
    var sdt_dd = sdt.substring(0, 2)
    var sdt_mm = sdt.substring(3, 5)
    var sdt_yy = sdt.substring(6, 10)


    server_dt = new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))

    if (dt > server_dt) {
        alert("Financial Close Date should not be greater than today's date !!!")
        document.getElementById(Frmnae + "txtVoucherDt").focus();
        return false;
    }

    var FinYear_fromdate_dd = FinYear_fromdate.substring(0, 2)
    var FinYear_fromdate_mm = FinYear_fromdate.substring(3, 5)
    var FinYear_fromdate_yy = FinYear_fromdate.substring(6, 10)
    FinYear_fromdate1 = new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

    var FinYear_todate_dd = FinYear_todate.substring(0, 2)
    var FinYear_todate_mm = FinYear_todate.substring(3, 5)
    var FinYear_todate_yy = FinYear_todate.substring(6, 10)
    FinYear_todate1 = new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

    if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
        alert("You have Selected Finacial Year as " + Sle_finyear + " , SO Financial Close Date Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!")
        document.getElementById(Frmnae + "txtVoucherDt").focus();
        return false;
    }

    /*var Fromdate_dd=Fromdate.substring(0,2)
    var Fromdate_mm=Fromdate.substring(3,5)
    var Fromdate_yy=Fromdate.substring(6,10)
    Fromdate1=new Date(months[parseFloat(Fromdate_mm)] + " " + parseFloat(Fromdate_dd) + ", " + parseFloat(Fromdate_yy))
    
    var Todate_dd=Todate.substring(0,2)
    var Todate_mm=Todate.substring(3,5)
    var Todate_yy=Todate.substring(6,10)
    Todate1=new Date(months[parseFloat(Todate_mm)] + " " + parseFloat(Todate_dd) + ", " + parseFloat(Todate_yy))
    if (dt<Fromdate1)
                    {
                            alert( "Financial Close Date Should Be Greater than "+ Fromdate +"!!!")
                            document.getElementById(Frmnae+"txtVoucherDt").focus();
                            return false;
                    }
            
*/
    var dockdt_user = new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))

    var dockdt_sys = new Date()

    var d = new Date()
    d.setTime(dockdt_sys - dockdt_user)
    var tm = d.getTime()


    if (parseFloat(tm) < 0) {
        alert("Voucher Date cannot be greater than System date !!!")
        document.getElementById(Form_name + "txtVoucherDt").focus();
        return false;
    }
    //alert("Hi PAtanahi2");
        //if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash") {
        //    {
        //        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value = TotNetPayment;//CurrPayment;
        //    }
        //}

        //if (document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank") {
        //    {
        //        document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value = TotNetPayment;//CurrPayment;
        //    }
        //}


        //if (CheckData() == false) // Validation of Payment User Control
        //{
        //    return false;
        //}


    if (confirm("Do you want to submit") == false) {
        return false;
    }

    click_count = parseFloat(document.getElementById(Form_name + "click_count").value)
    if (click_count > 0) {
        alert("Sorry... You cannot click twice !!!")
        return false;
    }
    else {
        click_count = click_count + 1
        document.getElementById(Form_name + "click_count").value = click_count
        //return  true;
        //alert("submit");
        //return false;
    }

}

function ValidateForm(obj) {

    if (obj.value != "") {

        if (isDate(obj.value) == false) {

            obj.focus()
            return false
        }
        return true
    }
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
    function fuleCalculation() {
       
        var rows1 = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
        //alert("rows1 : " + rows1)
        if (rows1 <= 9) {
            var id1 = "ctl00_MyCPH1_BillDetail_ctl0" + rows1 + "_txtTotal"
        }
        else {
            var id1 = "ctl00_MyCPH1_BillDetail_ctl" + rows1 + "_txtTotal"
        }
        var txtTotUnit = document.getElementById("ctl00_MyCPH1_txtTotUnit");
            //alert("hi1");
        var total = document.getElementById(id1);
        var rate = document.getElementById("ctl00_MyCPH1_lblRate");
       
        var strfule = parseFloat(txtTotUnit.value) * parseFloat(rate.innerHTML);
        document.getElementById("ctl00_MyCPH1_lblFuleDiscount").innerHTML = roundNumber(strfule, 2);
        document.getElementById("ctl00_MyCPH1_hdnFuleDiscount").value = roundNumber(strfule, 2);
        document.getElementById("ctl00_MyCPH1_lblNetAmt").innerHTML = roundNumber(parseFloat(total.value) - parseFloat(strfule), 2);
        document.getElementById("ctl00_MyCPH1_hdnNetAmt").value = roundNumber(parseFloat(total.value) - parseFloat(strfule), 2);
    }

    function chargeCalculation() {


        var txtInstrumentAmount = document.getElementById("ctl00_MyCPH1_txtInstrumentAmount");
        //alert(txtInstrumentAmount.value);
        //alert("hi1");
        var txtRedeemFuelRewards = document.getElementById("ctl00_MyCPH1_txtRedeemFuelRewards");

        var strCharge = parseFloat(txtInstrumentAmount.value) + parseFloat(txtRedeemFuelRewards.value);
        document.getElementById("ctl00_MyCPH1_txtTotalPaymentAmount").value = roundNumber(strCharge, 2);
        document.getElementById("ctl00_MyCPH1_hdnTotalPaymentAmount").value = roundNumber(strCharge, 2);
     
    }
    function showTR() {


        var ddlTranType = document.getElementById("ctl00_MyCPH1_ddlTranType");
        var ddlPayType = document.getElementById("ctl00_MyCPH1_ddlPayType");
        var trInstrument = document.getElementById("ctl00_MyCPH1_trInstrument");
        var lblRedeemFuelRewards = document.getElementById("ctl00_MyCPH1_lblRedeemFuelRewards");
        var txtRedeemFuelRewards = document.getElementById("ctl00_MyCPH1_txtRedeemFuelRewards");
        var txtInstrumentAmount = document.getElementById("ctl00_MyCPH1_txtInstrumentAmount");
        if (ddlTranType.value == "Instrument")
        {
            ddlPayType.style.display = "block";
            trInstrument.style.display = "block";
            lblRedeemFuelRewards.style.display = "none";
            txtRedeemFuelRewards.style.display = "none";
            txtRedeemFuelRewards.value = "0.00";
        }
        else if(ddlTranType.value=="Redeem")
        {
            ddlPayType.style.display = "none";
            trInstrument.style.display = "none";
            lblRedeemFuelRewards.style.display = "block";
            txtRedeemFuelRewards.style.display = "block";
            txtInstrumentAmount.value="0.00";
        }
        else if (ddlTranType.value == "Both") {
            ddlPayType.style.display = "block";
            trInstrument.style.display = "block";
            lblRedeemFuelRewards.style.display = "block";
            txtRedeemFuelRewards.style.display = "block";
        }
        chargeCalculation();
    }
    </script>



    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank"
                style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <p align="left"><font class="blackfnt"><b>You Selected</b></font></p>
        <table>
            <tr>
                <td>
                    <asp:HiddenField ID="click_count" Value="0" runat="server" />
                    <table border="0" cellpadding="3" cols="1" style="width: 9.5in" bgcolor="#808080" cellspacing="1" align="left" class="boxbg">

                        <tr bgcolor="#FFFFFF" id="BillDtRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Agent Bill Date </font></td>
                            <td width="343" align="center">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblAgentBillDate" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="VendorRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Vendor</font>
                            </td>
                            <td>
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendor1" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>

                        <tr bgcolor="#FFFFFF" id="BENoRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Bill Entry Number</font>
                            </td>
                            <td>
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblBENo" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>

                        <tr bgcolor="#FFFFFF" id="VBENoRow" runat="server" visible="false">
                            <td width="205"><font class="blackfnt">Vendor Bill Number</font>
                            </td>
                            <td>
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="LblVBENo" runat="server"></asp:Label>
                                    </font>
                                </div>
                            </td>
                        </tr>


                    </table>
                </td>
            </tr>
            <tr>
                <td>

                    <br />
                    <br />
                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Payment Voucher Summary</b></font></b></td>
                        </tr>
                    </table>

                    <br />
                </td>
            </tr>
            <tr>
                <td>

                    <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width: 9.5in" align="left" class="boxbg">
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Payment Voucher No.</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="center" width="20%">
                                <div align="left"><font class="blackfnt" color="red">System generated... </font></div>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">Voucher Date</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">

                                <asp:TextBox ID="txtVoucherDt" runat="server" Width="60px" onblur="javascript:ValidateForm(this)"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDt,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="a1">
                                    <img src="../../../../images/calendar.jpg" border="0" />
                                </a>
                            </font></td>
                        </tr>
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Vendor</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%" colspan="3">
                                <div align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendor" runat="server"></asp:Label>
                                    </font>
                                </div>

                            </td>
                        </tr>
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Vendor Service Tax no.</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">
                                <asp:Label ID="lblServiceTaxNo" runat="server"></font></asp:Label> 
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">Vendor 
                                  PAN number</font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">
                                <asp:Label ID="lblPANNo" runat="server"></asp:Label>
                            </font></td>
                        </tr>
                        <tr>
                            <td valign="top" bgcolor="#FFFFFF" width="25%"><font class="blackfnt">&nbsp; 
                            </font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="center" width="20%">
                                <div align="left"><font class="blackfnt"></font></div>
                            </td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt"><b>Net 
                                  Payable</b></font></td>
                            <td valign="top" bgcolor="#FFFFFF" align="left" width="20%">
                                <asp:TextBox ID="netamt" runat="server" Width="70px" Text="0.00" ReadOnly="true"></asp:TextBox>
                            </td>

                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center"><font class="blackfnt"><b>Vendor Bill Details</b> </font></td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>

                    <!-- DataGrid -->

                    <asp:GridView ID="BillDetail" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                        AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"
                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"
                        EmptyDataText="No Records Found..." Style="width: 9.5in" OnRowCreated="BillDetail_RowCreated">
                        <Columns>
                            <asp:TemplateField FooterStyle-CssClass="bgbluegrey">


                                <%-- <HeaderTemplate>
                <center>
                <asp:CheckBox runat="server" ID="HeaderLevelCheckBox" OnCheckedChanged="HeaderChecked" />
                </center>
            </HeaderTemplate>--%>
                                <ItemTemplate>
                                    <center>
                                        <asp:CheckBox ID="chkBill" runat="server" AutoPostBack="true" />
                                        <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' onclick="javascript:total_colam('<%# DataBinder.Eval(Container.DataItem,"netamt") %>')" />--%>
                                    </center>
                                </ItemTemplate>

                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Bill Entry Number" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>

                                    <font class="blackfnt">
                                        <asp:Label ID="BILLNO" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="vendorcode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorcode") %>' />
                                        <asp:HiddenField ID="vendorname" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"vendorname") %>' />
                                        <asp:HiddenField ID="Acccode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Acccode") %>' />

                                    </font>

                                </ItemTemplate>

                            </asp:TemplateField>

                            <%--<asp:BoundField DataField="BILLNO" HeaderText="Bill entry number" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>

                            <%--<asp:BoundField DataField="vendorBILLNO" HeaderText="Vendor Bill Number " FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                            </asp:BoundField>--%>




                           <%-- <asp:TemplateField HeaderText="Vendor Bill date" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <font class="blackfnt">
                                        <asp:Label ID="VendorBill_DT" Text='<%# DataBinder.Eval(Container.DataItem,"VendorBill_DT") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="mVendorBill_DT" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorBill_DT1") %>' />
                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:BoundField DataField="Due_DT" HeaderText="Due Date" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>--%>
                            <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ThcNo" HeaderText="Thc No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ThcDate" HeaderText="Thc Date" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vehno" HeaderText="Vehicle No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OthAdvReferenceNo" HeaderText="Reference No" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="OthAdvUnit" HeaderText="Unit" FooterStyle-CssClass="bgbluegrey">
                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <font class="blackfnt">
                                        <asp:Label ID="netamt" Text='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="nettotamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"netamt") %>' />
                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Amount Paid" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <font class="blackfnt">
                                        <asp:Label ID="pendamt" Text='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>' runat="server"></asp:Label>
                                        <asp:HiddenField ID="Advpaid" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>' />

                                        <asp:HiddenField ID="pendingamt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>' />
                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:BoundField DataField="pendamt" HeaderText="Amount Paid" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>

                            <asp:TemplateField HeaderText="Current Payment" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtCurrPayment" runat="server" Text="" Width="50px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtTotal" runat="server" Text="0" Width="50px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" HorizontalAlign="Right" />
                    </asp:GridView>

                    <br />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left" class="boxbg">
                        <tr class="bgwhite">
                            <td></td>
                            <td></td>
                            <td>Rate</td>

                            <td> <asp:Label ID="lblRate" runat="server" Text="5"></asp:Label></td>
                            <td>Total Unit</td>
                            <td><asp:TextBox ID="txtTotUnit" runat="server" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="javascript:return fuleCalculation();"></asp:TextBox></td>
                            <td>Fuel Discount</td>
                            <td>
                                 <asp:Label ID="lblFuleDiscount" runat="server" ></asp:Label>
                                <asp:HiddenField ID="hdnFuleDiscount" runat="server" />
                            </td>
                        </tr>
                         <tr class="bgwhite">
                            <td colspan="7" align="right">Net Bill Amount</td>
                            <td>
                                <asp:Label ID="lblNetAmt" runat="server" ></asp:Label>
                                 <asp:HiddenField ID="hdnNetAmt" runat="server" />
                                
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                <asp:DropDownList ID="ddlTranType" runat="server" onchange="javascript:return showTR(this)" >
                                    <%--<asp:ListItem  Value="">--SELECT--</asp:ListItem>--%>
                                     <asp:ListItem  Value="Both">Both </asp:ListItem>
                                    <asp:ListItem  Value="Instrument">Instrument</asp:ListItem>
                                    <asp:ListItem  Value="Redeem">Redeem </asp:ListItem>
                                   
                                </asp:DropDownList></td>
                            <td></td>
                            <td> <asp:DropDownList ID="ddlPayType" runat="server" style="display:none">
                                    <%--<asp:ListItem  Value="">--SELECT--</asp:ListItem>--%>
                                    <asp:ListItem  Value="CH">Cheque</asp:ListItem>
                                    <asp:ListItem  Value="NE">NEFT </asp:ListItem>
                                    <asp:ListItem  Value="RT">RTGS </asp:ListItem>
                                </asp:DropDownList></td>
                            </td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                               
                            </td>
                        </tr>
                          <tr class="bgwhite" id="trInstrument" runat="server"  style="display:none">
                            <td>
                                <asp:Label ID="lblInstrumentAmount" runat="server" Text="Instrument Amount" ></asp:Label>
                            </td>
                            <td><asp:TextBox ID="txtInstrumentAmount" runat="server" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="javascript:return chargeCalculation();"></asp:TextBox></td>
                             <td>
                                <asp:Label ID="lblInstrumentNo" runat="server" Text="Instrument No"></asp:Label>
                            </td>
                            <td><asp:TextBox ID="txtInstrumentNo" runat="server" ></asp:TextBox></td>
                             <td>
                                <asp:Label ID="lblInstrumentDate" runat="server" Text="Instrument Date"></asp:Label>
                            </td>
                            <td><font class="blackfnt">

                                <asp:TextBox ID="txtInstrumentDate" runat="server" Width="60px" onblur="javascript:ValidateForm(this)"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtInstrumentDate,'anchor2','dd/MM/yyyy'); return false;" name="anchor2" id="a2">
                                    <img src="../../../../images/calendar.jpg" border="0" />
                                </a>
                            </font>

                            </td>
                             <td>
                                <asp:Label ID="lblBankAccount" runat="server" Text="Bank Account"></asp:Label>
                            </td>
                            <td><asp:DropDownList ID="ddlBankAccount" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr class="bgwhite" >
                            <td>
                                <asp:Label ID="lblRedeemFuelRewards" runat="server" Text="Redeem Fuel Rewards" style="display:none"></asp:Label>
                            </td>
                            <td><asp:TextBox ID="txtRedeemFuelRewards" runat="server" Text="0.00" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onblur="javascript:return chargeCalculation();" style="display:none"></asp:TextBox></td>
                             <td>
                                <asp:Label ID="lblOilCompanyName" runat="server" Text="Oil Company Name"></asp:Label>
                            </td>
                            <td><asp:TextBox ID="txtOilCompanyName" runat="server" ></asp:TextBox></td>
                             <td>
                                <asp:Label ID="lblRemark" runat="server" Text="Remark"></asp:Label>
                            </td>
                            <td colspan="3"><asp:TextBox ID="txtRemark" runat="server" Height="43px" TextMode="MultiLine"
                                Width="222px" MaxLength="600"></asp:TextBox></td>
                            
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                <asp:Label ID="lblTotalPaymentAmount" runat="server" Text="Total Payment Amount"></asp:Label>
                            </td>
                            <td><asp:TextBox ID="txtTotalPaymentAmount" runat="server" ReadOnly="true"></asp:TextBox>
                                  <asp:HiddenField ID="hdnTotalPaymentAmount" runat="server" />
                            </td>
                             <td colspan="6">
                                </td>
                            
                        </tr>
                    </table>

                    <%--  <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible="true">
                        <ContentTemplate>
                            <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server"></UC5:UCMyPaymentControl>
                        </ContentTemplate>
                    </asp:UpdatePanel>--%>
                    <br />

                    <%--<table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td colspan="4" align="center"><font class="blackfnt"> 
                                  <b>Payment Summary</b> </font></td>
                              </tr>
                            </table>
                            <br /><br />
                            <table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
                              <tr bgcolor="#FFFFFF"> 
                                <td> <font class="blackfnt">Mode Of Transaction 
                                  </font></td>
                                <td> <font class="blackfnt">
                                  <asp:UpdatePanel ID="u1" runat="server">
				        <ContentTemplate>
                               <asp:DropDownList ID="transtype" runat="server" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"  AutoPostBack="true">
                               <asp:ListItem Text="Select" Value=""></asp:ListItem>
                               <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                               <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                               <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                               </asp:DropDownList>
                                  </ContentTemplate>
						</asp:UpdatePanel>
                                  </font> </td>
                                <td  > <font class="blackfnt">Issued From Account</font> 
                                </td>
                                <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
				        <ContentTemplate>
                                <asp:DropDownList  AutoPostBack="true" ID="acccode" runat="server">
                               </asp:DropDownList>
                               </ContentTemplate>
                               <Triggers>
						<asp:AsyncPostBackTrigger ControlID="transtype" EventName="SelectedIndexChanged" />
						</Triggers>
						</asp:UpdatePanel>
                               </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td> <font class="blackfnt">Cheque No </font> </td>
                                <td> <font class="blackfnt">
                                <asp:TextBox ID="chqno" runat="server" Text="" Width="50px" MaxLength="6"></asp:TextBox></font>
                                </td>
                                <td><font class="blackfnt">Cheque Date </font></td>
                                <td> <font class="blackfnt">
                                <asp:TextBox ID="chqdate" runat="server" Text="" Width="60px"  onblur="javascript:ValidateForm(this)"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$chqdate,'anchor2','dd/MM/yyyy'); return false;"  name="anchor2" id="a2" ><img src="../../../../images/calendar.jpg" border="0" /> 
                                        </a>
                                  dd/mm/yyyy </font> </td>
                              </tr>
                              
                              <tr bgcolor="#ffffff"> 
                                <td ><font class="blackfnt">Payment Amount</font></td>
                                <td> <font class="blackfnt">
                                  <asp:TextBox ID="colamt" runat="server" Width="50px" Text="0.00"></asp:TextBox>
                                  </font> </td>
                                <td><font class="blackfnt">&nbsp;</font></td>
                                <td> </td>
                              </tr>
                            </table>--%>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="left">
                    </div>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
    </div>
</asp:Content>
