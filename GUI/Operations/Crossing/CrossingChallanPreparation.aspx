<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingChallanPreparation.aspx.cs" Inherits="GUI_Operations_Crossing_CrossingChallanPreparation" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function btnsubmitClick() {
            var mTotalRecords = "<%=intTotalRecords %>"
            var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
            for (var i = 0; i < mTotalRecords; i++) {
                j = i + 2;

                if (j < 10) {
                    mDerivedControlName = "ctl00_MyCPH1_DocketDetail_ctl" + "0" + j + "_chkBill"
                    ratetype = "ctl00_MyCPH1_DocketDetail_ctl" + "0" + j + "_cboRateBase"
                    vendorrate = "ctl00_MyCPH1_DocketDetail_ctl" + "0" + j + "_lblVendorRate"
                }
                else {
                    mDerivedControlName = "ctl00_MyCPH1_DocketDetail_ctl" + j + "_chkBill"
                    ratetype = "ctl00_MyCPH1_DocketDetail_ctl" + j + "_cboRateBase"
                    vendorrate = "ctl00_MyCPH1_DocketDetail_ctl" + j + "_lblVendorRate"
                }

                if (document.getElementById(mDerivedControlName)) {
                    if (document.getElementById(mDerivedControlName).checked == true) {
                        if (mSelection == 0) {
                            mSelection = 1;
                        }
                        if (document.getElementById(ratetype).value == "0") {
                            alert("Please Select Vendor Rate Type.....")
                            document.getElementById(ratetype).focus();
                            return false;
                        }
                        if (document.getElementById(vendorrate).value == "0.00") {
                            alert("Vendor Rate Can not be Zero.....")
                            document.getElementById(ratetype).focus();
                            return false;
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                    }
                }
            }

            if (mSelection == 0) {
                alert("Select atleast one Document ....!");

                return false;
            }


            if (document.getElementById("ctl00_MyCPH1_txtVehicleEntry").value == "") {
                alert("Please Enter Vehicle No....!!!")
                return false;
            }
			document.getElementById('ctl00_MyCPH1_btnsubmit').style.display = "none";
            return true;

        }
        function DocketWise_Calc_OnContract(ObjId, flag) {
            var TotToPay = 0, TotCrossing = 0, TotDDChrg = 0, TotNetAmt = 0;
            var TotDocketTotal = 0, TotCrossingTotal = 0, TotDoorDeliveryTotal = 0, TotbulkyChargeTotal = 0;
            var docketAmount = 0, crossingAmt = 0, dooDeliveryChrg = 0, bulkyCharge = 0;

            var RateBase;

            var chkID = ObjId;

            var txtDocAmt = document.getElementById(chkID.replace("chkBill", "txtDocketAmt"));
            var txtCrossChrg = document.getElementById(chkID.replace("chkBill", "txtCrossCharge"));
            var txtDDChrg = document.getElementById(chkID.replace("chkBill", "txtDDCharge"));
            var txtBulkyChrg = document.getElementById(chkID.replace("chkBill", "txtBulkyCharge"));
            var txtRateBase = document.getElementById(chkID.replace("chkBill", "cboRateBase"));
            var txtVendorRate = document.getElementById(chkID.replace("chkBill", "lblVendorRate"));


            var txtTotalToPay = document.getElementById("ctl00_MyCPH1_txtTotalToPay");
            var txtTotalCrossing = document.getElementById("ctl00_MyCPH1_txtTotalCrossing");
            var txtTotDDCharge = document.getElementById("ctl00_MyCPH1_txtTotDDCharge");
            var txtTotBulkyCharge = document.getElementById("ctl00_MyCPH1_txtTotBulkyCharge");
            var txtNetPayable = document.getElementById("ctl00_MyCPH1_txtNetPayable");
            var grid = document.getElementById("ctl00_MyCPH1_DocketDetail");
            var rows = grid.rows.length;

            var ftrid = "";
            if (parseInt(rows) < 10)
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl0" + rows + "_";
            else
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl" + rows + "_";

            docketAmount = document.getElementById(chkID.replace("chkBill", "txtDocketAmt")).value;
            crossingAmt = document.getElementById(chkID.replace("chkBill", "txtCrossCharge")).value;
            dooDeliveryChrg = document.getElementById(chkID.replace("chkBill", "txtDDCharge")).value;
            bulkyCharge = document.getElementById(chkID.replace("chkBill", "txtBulkyCharge")).value;
            RateBase = document.getElementById(chkID.replace("chkBill", "cboRateBase")).value;
            VendorRate = document.getElementById(chkID.replace("chkBill", "lblVendorRate")).value;
            Paybas = document.getElementById(chkID.replace("chkBill", "hdnPaybas")).value;

            var IndTOTAmt = 0;
            if (document.getElementById(chkID).checked) {
                txtRateBase.disabled = false;
                if (Paybas == "P03") {
                    TotDocketTotal = parseFloat(docketAmount);
                }

                TotCrossingTotal = rounditn(parseFloat(TotCrossingTotal) + parseFloat(crossingAmt), 2)
                TotDoorDeliveryTotal = rounditn(parseFloat(TotDoorDeliveryTotal) + parseFloat(dooDeliveryChrg), 2)
                TotbulkyChargeTotal = rounditn(parseFloat(TotbulkyChargeTotal) + parseFloat(bulkyCharge), 2)

                var txtDocketTotal = document.getElementById(ftrid + "txtDocketTotal");
                var txtCrossTotal = document.getElementById(ftrid + "txtCrossTotal");
                var txtDDTotal = document.getElementById(ftrid + "txtDDTotal");
                //var txtBulkyChargeTotal = document.getElementById(ftrid+"txtBulkyChargeTotal");

                if (flag == 1) 
                {
                    txtCrossTotal.value = rounditn(parseFloat(txtCrossTotal.value) + parseFloat(TotCrossingTotal), 2);
                    txtDDTotal.value = rounditn(parseFloat(txtDDTotal.value) + parseFloat(TotDoorDeliveryTotal), 2);
                    //txtBulkyChargeTotal.value = rounditn(parseFloat(txtBulkyChargeTotal.value) + parseFloat(TotbulkyChargeTotal),2);

                    txtTotalCrossing.value = rounditn(parseFloat(txtTotalCrossing.value) + parseFloat(TotCrossingTotal), 2);
                    txtTotDDCharge.value = rounditn(parseFloat(txtTotDDCharge.value) + parseFloat(TotDoorDeliveryTotal), 2);
                    //txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) +  parseFloat(TotbulkyChargeTotal),2);
                }
                if (flag == 0) 
                {
                    txtCrossTotal.value = rounditn(parseFloat(txtCrossTotal.value) - parseFloat(TotCrossingTotal), 2);
                    txtDDTotal.value = rounditn(parseFloat(txtDDTotal.value) - parseFloat(TotDoorDeliveryTotal), 2);
                    //txtBulkyChargeTotal.value = rounditn(parseFloat(txtBulkyChargeTotal.value) - parseFloat(TotbulkyChargeTotal),2);

                    txtTotalCrossing.value = rounditn(parseFloat(txtTotalCrossing.value) - parseFloat(TotCrossingTotal), 2);
                    txtTotDDCharge.value = rounditn(parseFloat(txtTotDDCharge.value) - parseFloat(TotDoorDeliveryTotal), 2);
                    //txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) -  parseFloat(TotbulkyChargeTotal),2);

                    txtCrossChrg.value = "0.00";
                    txtDDChrg.value = "0.00";
                    //txtBulkyChrg.value = "0.00";
                    txtVendorRate.value = "0.00";
                }

                txtNetPayable.value = rounditn(parseFloat(txtTotalToPay.value) - parseFloat(txtTotalCrossing.value) - parseFloat(txtTotDDCharge.value) - parseFloat(txtTotBulkyCharge.value), 2)

                //txtNetPayable.value = rounditn(parseFloat(TotDocketTotal) - parseFloat(TotCrossingTotal) - parseFloat(TotDoorDeliveryTotal) - parseFloat(TotbulkyChargeTotal),2)
            }
        }

        function DocketWise_Calc(ObjId, flag) {
            var TotToPay = 0, TotCrossing = 0, TotDDChrg = 0, TotNetAmt = 0;
            var TotDocketTotal = 0, TotCrossingTotal = 0, TotDoorDeliveryTotal = 0, TotbulkyChargeTotal = 0;
            var docketAmount = 0, crossingAmt = 0, dooDeliveryChrg = 0, bulkyCharge = 0;

            var RateBase;

            var chkID = ObjId;

            var txtDocAmt = document.getElementById(chkID.replace("chkBill", "txtDocketAmt"));
            var txtCrossChrg = document.getElementById(chkID.replace("chkBill", "txtCrossCharge"));
            var txtDDChrg = document.getElementById(chkID.replace("chkBill", "txtDDCharge"));
            var txtBulkyChrg = document.getElementById(chkID.replace("chkBill", "txtBulkyCharge"));
            var txtRateBase = document.getElementById(chkID.replace("chkBill", "cboRateBase"));
            var txtVendorRate = document.getElementById(chkID.replace("chkBill", "lblVendorRate"));

            var txtTotalToPay = document.getElementById("ctl00_MyCPH1_txtTotalToPay");
            var txtTotalCrossing = document.getElementById("ctl00_MyCPH1_txtTotalCrossing");
            var txtTotDDCharge = document.getElementById("ctl00_MyCPH1_txtTotDDCharge");
            var txtTotBulkyCharge = document.getElementById("ctl00_MyCPH1_txtTotBulkyCharge");
            var txtNetPayable = document.getElementById("ctl00_MyCPH1_txtNetPayable");

            var grid = document.getElementById("ctl00_MyCPH1_DocketDetail");
            var rows = grid.rows.length;

            var ftrid = "";
            if (parseInt(rows) < 10)
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl0" + rows + "_";
            else
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl" + rows + "_";

            docketAmount = document.getElementById(chkID.replace("chkBill", "txtDocketAmt")).value;
            crossingAmt = document.getElementById(chkID.replace("chkBill", "txtCrossCharge")).value;
            dooDeliveryChrg = document.getElementById(chkID.replace("chkBill", "txtDDCharge")).value;
            bulkyCharge = document.getElementById(chkID.replace("chkBill", "txtBulkyCharge")).value;
            RateBase = document.getElementById(chkID.replace("chkBill", "cboRateBase")).value;
            VendorRate = document.getElementById(chkID.replace("chkBill", "lblVendorRate")).value;
            Paybas = document.getElementById(chkID.replace("chkBill", "hdnPaybas")).value;

            var IndTOTAmt = 0;
            if (document.getElementById(chkID).checked) {
                txtRateBase.disabled = false;
                if (Paybas == "P03") {
                    TotDocketTotal = parseFloat(docketAmount);
                }

                TotCrossingTotal = rounditn(parseFloat(TotCrossingTotal) + parseFloat(crossingAmt), 2)
                TotDoorDeliveryTotal = rounditn(parseFloat(TotDoorDeliveryTotal) + parseFloat(dooDeliveryChrg), 2)
                TotbulkyChargeTotal = rounditn(parseFloat(TotbulkyChargeTotal) + parseFloat(bulkyCharge), 2)


                var txtDocketTotal = document.getElementById(ftrid + "txtDocketTotal");
                var txtCrossTotal = document.getElementById(ftrid + "txtCrossTotal");
                var txtDDTotal = document.getElementById(ftrid + "txtDDTotal");
                var txtBulkyChargeTotal = document.getElementById(ftrid + "txtBulkyChargeTotal");

                if (flag == 0)
                    txtDocketTotal.value = rounditn(parseFloat(txtDocketTotal.value) + parseFloat(TotDocketTotal), 2);
                if (flag == 1) {
                    txtCrossTotal.value = rounditn(parseFloat(txtCrossTotal.value) + parseFloat(TotCrossingTotal), 2);
                    txtDDTotal.value = rounditn(parseFloat(txtDDTotal.value) + parseFloat(TotDoorDeliveryTotal), 2);
                    txtBulkyChargeTotal.value = rounditn(parseFloat(txtBulkyChargeTotal.value) + parseFloat(TotbulkyChargeTotal), 2);
                }

                if (flag == 0)
                    txtTotalToPay.value = rounditn(parseFloat(txtTotalToPay.value) + parseFloat(TotDocketTotal), 2);
                if (flag == 1) {
                    txtTotalCrossing.value = rounditn(parseFloat(txtTotalCrossing.value) + parseFloat(TotCrossingTotal), 2);
                    txtTotDDCharge.value = rounditn(parseFloat(txtTotDDCharge.value) + parseFloat(TotDoorDeliveryTotal), 2);
                    txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) + parseFloat(TotbulkyChargeTotal), 2);
                }

                txtNetPayable.value = rounditn(parseFloat(txtTotalToPay.value) - parseFloat(txtTotalCrossing.value) - parseFloat(txtTotDDCharge.value) - parseFloat(txtTotBulkyCharge.value), 2)

                //txtNetPayable.value = rounditn(parseFloat(TotDocketTotal) - parseFloat(TotCrossingTotal) - parseFloat(TotDoorDeliveryTotal) - parseFloat(TotbulkyChargeTotal),2)

            }
            else {
                var txtDocketTotal = document.getElementById(ftrid + "txtDocketTotal");
                var txtCrossTotal = document.getElementById(ftrid + "txtCrossTotal");
                var txtDDTotal = document.getElementById(ftrid + "txtDDTotal");
                var txtBulkyChargeTotal = document.getElementById(ftrid + "txtBulkyChargeTotal");

                if (Paybas == "P03") {
                    TotDocketTotal = parseFloat(docketAmount);
                }

                TotCrossingTotal = rounditn(parseFloat(txtCrossTotal.value) - parseFloat(crossingAmt), 2)
                TotDoorDeliveryTotal = rounditn(parseFloat(txtDDTotal.value) - parseFloat(dooDeliveryChrg), 2)
                TotbulkyChargeTotal = rounditn(parseFloat(txtBulkyChargeTotal.value) - parseFloat(bulkyCharge), 2)

                txtDocketTotal.value = rounditn(parseFloat(txtDocketTotal.value) - parseFloat(docketAmount), 2);

                txtCrossTotal.value = rounditn(parseFloat(TotCrossingTotal), 2);
                txtDDTotal.value = rounditn(parseFloat(TotDoorDeliveryTotal), 2);
                txtBulkyChargeTotal.value = rounditn(parseFloat(TotbulkyChargeTotal), 2);

                txtTotalToPay.value = rounditn(parseFloat(txtTotalToPay.value) - parseFloat(docketAmount), 2);
                txtTotalCrossing.value = rounditn(parseFloat(txtTotalCrossing.value) - parseFloat(crossingAmt), 2);
                txtTotDDCharge.value = rounditn(parseFloat(txtTotDDCharge.value) - parseFloat(dooDeliveryChrg), 2);
                txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) - parseFloat(bulkyCharge), 2);

                txtNetPayable.value = rounditn(parseFloat(txtTotalToPay.value) - parseFloat(txtTotalCrossing.value) - parseFloat(txtTotDDCharge.value) - parseFloat(txtTotBulkyCharge.value), 2)

                txtRateBase.disabled = true;
                txtRateBase.value = "0";
                txtCrossChrg.value = "0.00";
                txtDDChrg.value = "0.00";
                txtBulkyChrg.value = "0.00";
                txtVendorRate.value = "0.00";
            }
        }
        /*************************************************************************************************************
        FUNCTION FOR NO OF DECIMAL VALUE
        *************************************************************************************************************/

        function rounditn(Num, decplaces) {
            Places = 0
            if (Places > 0) {

                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {

                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    var Rounder = Math.pow(10, Places);
                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    //alert("Hi")
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();

                    }
                }
            }
            else return Math.round(Num);

        }
        function Other_Chg_Calc(ObjId) {
            var BulkyCharge = ObjId.getAttribute('id');
            var ChkID = BulkyCharge.replace("txtBulkyCharge", "chkBill");

            var TotToPay = 0, TotCrossing = 0, TotDDChrg = 0, TotNetAmt = 0;
            var TotDocketTotal = 0, TotCrossingTotal = 0, TotDoorDeliveryTotal = 0, TotbulkyChargeTotal = 0;
            var docketAmount = 0, crossingAmt = 0, dooDeliveryChrg = 0, bulkyCharge = 0;

            var RateBase;

            var chkID = ChkID;

            var txtDocAmt = document.getElementById(chkID.replace("chkBill", "txtDocketAmt"));
            var txtCrossChrg = document.getElementById(chkID.replace("chkBill", "txtCrossCharge"));
            var txtDDChrg = document.getElementById(chkID.replace("chkBill", "txtDDCharge"));
            var txtBulkyChrg = document.getElementById(chkID.replace("chkBill", "txtBulkyCharge"));
            var txtRateBase = document.getElementById(chkID.replace("chkBill", "cboRateBase"));
            var txtVendorRate = document.getElementById(chkID.replace("chkBill", "lblVendorRate"));

            var txtTotalToPay = document.getElementById("ctl00_MyCPH1_txtTotalToPay");
            var txtTotalCrossing = document.getElementById("ctl00_MyCPH1_txtTotalCrossing");
            var txtTotDDCharge = document.getElementById("ctl00_MyCPH1_txtTotDDCharge");
            var txtTotBulkyCharge = document.getElementById("ctl00_MyCPH1_txtTotBulkyCharge");
            var txtNetPayable = document.getElementById("ctl00_MyCPH1_txtNetPayable");

            var grid = document.getElementById("ctl00_MyCPH1_DocketDetail");
            var rows = grid.rows.length;

            var ftrid = "";
            if (parseInt(rows) < 10)
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl0" + rows + "_";
            else
                ftrid = "ctl00_MyCPH1_DocketDetail_ctl" + rows + "_";

            bulkyCharge = ObjId.value;
            var hidBulkyCharge = document.getElementById(chkID.replace("chkBill", "hidBulkyCharge"))
            var oldCharge = hidBulkyCharge.value;
            var IndTOTAmt = 0;
            if (document.getElementById(chkID).checked) {
                var txtBulkyChargeTotal = document.getElementById(ftrid + "txtBulkyChargeTotal");
                var txtDocketTotal = document.getElementById(ftrid + "txtDocketTotal");
                var txtCrossTotal = document.getElementById(ftrid + "txtCrossTotal");
                var txtDDTotal = document.getElementById(ftrid + "txtDDTotal");

                txtBulkyChargeTotal.value = rounditn(parseFloat(txtBulkyChargeTotal.value) - parseFloat(oldCharge), 2);
                txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) - parseFloat(oldCharge), 2);

                txtBulkyChargeTotal.value = rounditn(parseFloat(txtBulkyChargeTotal.value) + parseFloat(bulkyCharge), 2);
                txtTotBulkyCharge.value = rounditn(parseFloat(txtTotBulkyCharge.value) + parseFloat(bulkyCharge), 2);

                txtNetPayable.value = rounditn(parseFloat(txtTotalToPay.value) - parseFloat(txtTotalCrossing.value) - parseFloat(txtTotDDCharge.value) - parseFloat(txtTotBulkyCharge.value), 2)

                hidBulkyCharge.value = ObjId.value
            }
        }
        function CalcRate(cboRateBase) {

            var ret = CalculationRate(cboRateBase);
            //alert("Hi...")
        }

        function CalculationRate(cboRB) {

            var cboRateBase = cboRB.getAttribute('id');
            //alert(cboRateBase)
            var RateBase = cboRateBase;
            //alert(cboRateBase.value);
            var RateBaseValue = cboRB.value;
            //alert(RateBaseValue);
            var CrossCharge = cboRateBase.replace("cboRateBase", "txtCrossCharge");
            var ChkID = cboRateBase.replace("cboRateBase", "chkBill");
            var VendorRate = cboRateBase.replace("cboRateBase", "lblVendorRate");

            var DDCharge = cboRateBase.replace("cboRateBase", "txtDDCharge");

            var Origin = cboRateBase.replace("cboRateBase", "lblDestn");

            var Pkgs = cboRateBase.replace("cboRateBase", "lblPkgs");
            var ActualWt = cboRateBase.replace("cboRateBase", "lblActualWt");


            var hdnToCity = cboRateBase.replace("cboRateBase", "hdnToCity");

            var VendorCode = document.getElementById("ctl00_MyCPH1_hdnVendorCode").value
            if (RateBaseValue != "0" && RateBaseValue != "") {
                var findobj = false;
                findobj = GetXMLHttpObject();
                if (findobj) {
                    var strpg = "RateCalculation.aspx?Vendor=" + VendorCode + "&arrivedPkgs=" + document.getElementById(Pkgs).innerText + "&Weight=" + document.getElementById(ActualWt).innerText + "&Origin=" + document.getElementById(Origin).innerText + "&ToCity=" + document.getElementById(hdnToCity).value + "&RateBase=" + RateBaseValue + "&VendorRate=" + document.getElementById(VendorRate).value + "&DDCharge=" + document.getElementById(DDCharge).value;
                    strpg = strpg + "&sid1=" + Math.random() + "&sid2=" + Math.random();
                    findobj.open("GET", strpg, true);
                    findobj.onreadystatechange = function() {
                        if (findobj.readyState == 4 && findobj.status == 200) {
                            var res = findobj.responseText.split("|");
                            if (res[0] == "false") {
                                alert("There are No Contract Available");
                                DocketWise_Calc_OnContract(ChkID, 0);
                                document.getElementById(CrossCharge).value = "0.00";
                                document.getElementById(DDCharge).value = "0.00";
                                document.getElementById(VendorRate).value = "0.00";

                                return false;
                            }
                            if (res[0] == "true") {
                                document.getElementById(CrossCharge).value = res[1];
                                document.getElementById(DDCharge).value = res[2];
                                document.getElementById(VendorRate).value = res[3];
                                DocketWise_Calc_OnContract(ChkID, 1);
                                return true;
                            }
                        }
                    }

                    findobj.send(null);
                }
            }
            else {
                DocketWise_Calc_OnContract(ChkID, 0);
                document.getElementById(CrossCharge).value = "0.00";
                document.getElementById(DDCharge).value = "0.00";
                document.getElementById(VendorRate).value = "0.00";
            }
            return true;
        }
        function dalacalculation() {
            var tottopay = document.getElementById("ctl00_MyCPH1_txtTotalToPay").value
            var totcrossing = document.getElementById("ctl00_MyCPH1_txtTotalCrossing").value
            var totdoordelivery = document.getElementById("ctl00_MyCPH1_txtTotDDCharge").value
            var totbulkycharge = document.getElementById("ctl00_MyCPH1_txtTotBulkyCharge").value
            var tottruckfreight = document.getElementById("ctl00_MyCPH1_txtTruckFreight").value
            var totadvancetruckfreight = document.getElementById("ctl00_MyCPH1_txtAdvanceTruckFreight").value
            //var totbalancefreight = document.getElementById("ctl00_MyCPH1_txtBalanceFreight").value
            var totnetpayable = document.getElementById("ctl00_MyCPH1_txtNetPayable")

            if (parseInt(tottruckfreight) < parseInt(totadvancetruckfreight)) 
            {
                alert("Advance Amount Should Be Less Than Truck Freight")
                document.getElementById("ctl00_MyCPH1_txtTruckFreight").value = 0.00;
                document.getElementById("ctl00_MyCPH1_txtAdvanceTruckFreight").value = 0.00;
                document.getElementById("ctl00_MyCPH1_txtTruckFreight").focus();
                return false;
            }
            document.getElementById("ctl00_MyCPH1_txtBalanceFreight").value = parseInt(tottruckfreight) - parseInt(totadvancetruckfreight);
            totnetpayable.value = (parseInt(tottopay) + parseInt(totadvancetruckfreight)) - (parseInt(totcrossing) + parseInt(totdoordelivery) + parseInt(totbulkycharge) + parseInt(tottruckfreight))

        }   
    </script>

    <script language="javascript" type="text/javascript">
        // This Script is used to maintain Grid Scroll on Partial Postback
        var scrollTop;
        //Register Begin Request and End Request 
        //Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
        //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
        //Get The Div Scroll Position
        function BeginRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            scrollTop = m.scrollTop;
        }
        //Set The Div Scroll Position
        function EndRequestHandler(sender, args) {
            var m = document.getElementById('divGrid');
            m.scrollTop = scrollTop;
        } 
    </script>

    <asp:updatepanel id="updone" runat="server">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
                BorderWidth="0">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="4" Font-Bold="true">
            <center>
                Crossing Challan Preparation
                </center>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Crossing challan no
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:Label ID="lblCrossChallanNo" runat="server" Text="System Generated..." ForeColor="red"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
           Date
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:TextBox ID="txtVoucherDate" runat="server" BorderStyle="Groove" Width="60px"
                            Columns="8"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDate,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="a1">
                            <img alt="" src="../../images/calendar.jpg" border="0" />
                        </a><font class="blackfnt">dd/mm/yyyy </font>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Challan Location
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:Label ID="lblChallanLocation" runat="server" Text=""></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
           Vehicle No
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                        <asp:TextBox ID="txtVehicleEntry" runat="server" BorderStyle="Groove" Width="60px"
                            onblur="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Vendor
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true" ColumnSpan="3">
                        <asp:Label ID="lblVendor" runat="server" Text=""></asp:Label>
                        <asp:HiddenField ID="hdnVendorCode" runat="server" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Table ID="Table2" runat="server" CssClass="boxbg" Width="9.6in" CellSpacing="1"
                BorderWidth="1">
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
                        <div id="divGrid" style="overflow: auto; height: 300px; width:9.6in;" class="blackfnt">
                        <asp:GridView ID="DocketDetail" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                            CellSpacing="1" CssClass="boxbg" EmptyDataText="No Dockets Found...for Challan Preparation"
                            EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-BorderColor="AliceBlue"
                            EmptyDataRowStyle-BorderWidth="1" EmptyDataRowStyle-Font-Bold="true" EmptyDataRowStyle-HorizontalAlign="Center"
                            EmptyDataRowStyle-CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                            Style="width: 9.0in" ShowFooter="True">
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                            <Columns>
                                <asp:TemplateField FooterStyle-CssClass="bgbluegrey">
                                    <ItemTemplate>
                                        <center>
                                            <asp:CheckBox ID="chkBill" runat="server"  onclick="javascript:DocketWise_Calc(this.getAttribute('id'),0)"/>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket Number" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Wrap="True" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <font class="blackfnt">
                                                <asp:Label ID="lbldockno" Text='<%# DataBinder.Eval(Container.DataItem,"DOCKNO") %>'
                                                    runat="server"></asp:Label>
                                            </font>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket Date" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Wrap="True" HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <font class="blackfnt">
                                                <asp:Label ID="lbldockdt" Text='<%# DataBinder.Eval(Container.DataItem,"DOCKDT") %>'
                                                    runat="server"></asp:Label>
                                            </font>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Paybas" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <font class="blackfnt">
                                                <asp:Label ID="lblPaybas" Text='<%# DataBinder.Eval(Container.DataItem,"PAYBAS") %>'
                                                    runat="server"></asp:Label>
                                                <asp:HiddenField ID="hdnPaybas" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PAYBASCode") %>' />
                                            </font>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Origin" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblOrigin" Text='<%# DataBinder.Eval(Container.DataItem,"ORGNCD") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Destn" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDestn" Text='<%# DataBinder.Eval(Container.DataItem,"REASSIGN_DESTCD") %>'
                                            runat="server"></asp:Label>
                                        <asp:HiddenField ID="hdnToCity" Value='<%# DataBinder.Eval(Container.DataItem,"to_Loc") %>'
                                            runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Dest City" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDestCity" Text='<%# DataBinder.Eval(Container.DataItem,"to_Loc") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pkgs" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblPkgs" Text='<%# DataBinder.Eval(Container.DataItem,"PKGSNO") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actual Weight" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblActualWt" Text='<%# DataBinder.Eval(Container.DataItem,"ACTUWT") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Charged Weight" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblChargedWt" Text='<%# DataBinder.Eval(Container.DataItem,"CHRGWT") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket Total" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtDocketAmt" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"DKTTOT") %>' Width="60px"></asp:TextBox>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtDocketTotal" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate Basis" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="cboRateBase" runat="server" Enabled="false" onchange="javascript:return CalcRate(this);">
                                            <asp:ListItem Value="0" Text="Select"></asp:ListItem>
                                            <asp:ListItem Value="K" Text="Per Kg."></asp:ListItem>
                                            <asp:ListItem Value="F" Text="Flat RS"></asp:ListItem>
                                            <asp:ListItem Value="P" Text="Per Pkgs"></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Vendor Rate" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                    HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                    <asp:TextBox ID="lblVendorRate" runat="server" Text="0.00" Width="60px" Enabled="false"></asp:TextBox>
                                        <%--<asp:TextBox ID="lblVendorRate" runat="server" Text="0.00" Enabled="false" BorderStyle="Groove"
                                             Width="60px"></asp:TextBox>--%><%--'<%# DataBinder.Eval(Container.DataItem,"rate") %>'--%>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Crossing Charges" HeaderStyle-CssClass="blackfnt"
                                    FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtCrossCharge" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0.00" Width="60px"></asp:TextBox><%--'<%# DataBinder.Eval(Container.DataItem,"CrossingCharge") %>'--%>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtCrossTotal" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Door Delivery Charge" HeaderStyle-CssClass="blackfnt"
                                    FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtDDCharge" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0.00" Width="60px"></asp:TextBox><%--'<%# DataBinder.Eval(Container.DataItem,"doordeliveryCharge") %>'--%>
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtDDTotal" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bulky Charge" HeaderStyle-CssClass="blackfnt"
                                    FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <center>
                                            <asp:TextBox ID="txtBulkyCharge" runat="server" Enabled="true" BorderStyle="Groove" onchange="javascript:return Other_Chg_Calc(this)" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                Text="0.00" Width="60px"></asp:TextBox><%--'<%# DataBinder.Eval(Container.DataItem,"doordeliveryCharge") %>'--%>
                                            <asp:HiddenField ID="hidBulkyCharge" runat="server" Value="0.00" />
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                    <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <center>
                                            <asp:TextBox ID="txtBulkyChargeTotal" runat="server" Enabled="false" BorderStyle="Groove"
                                                Text="0" Width="60px"></asp:TextBox>
                                        </center>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                            <HeaderStyle CssClass="bgbluegrey" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
                        <asp:Table ID="Table3" runat="server" CssClass="boxbg" Width="5in" CellSpacing="1"
                            BorderWidth="0">
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell Font-Bold="true" ColumnSpan="2" HorizontalAlign="Center">
           SUMMARY
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Total To Pay (+)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtTotalToPay" BorderStyle="Groove" runat="server" Enabled="false"
                                        Text="0.00" Width="60px"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
          Total Crossing (-)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtTotalCrossing" BorderStyle="Groove" runat="server" Enabled="false"
                                      Text="0.00"  Width="60px" Columns="8"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Door delivery Charges (-)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtTotDDCharge" BorderStyle="Groove" runat="server" Enabled="false"
                                       Text="0.00" Width="60px" ></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                             <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Bulky Charges (-)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtTotBulkyCharge" BorderStyle="Groove" runat="server" Enabled="false"
                                       Text="0.00" Width="60px" ></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Truck Freight (-)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtTruckFreight" BorderStyle="Groove" runat="server" Enabled="true"
                                        Width="60px" Text="0.00" onblur="javascript:return dalacalculation()"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Advance Truck Freight (+)
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtAdvanceTruckFreight" BorderStyle="Groove" runat="server" Enabled="true"
                                        Width="60px" Text="0.00" onblur="javascript:return dalacalculation()"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
           Balance Freight
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtBalanceFreight" BorderStyle="Groove" runat="server" Enabled="false"
                                        Width="60px" Text="0.00" onblur="javascript:return dalacalculation()"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell Font-Bold="true">
           Net Payable
                                </asp:TableCell>
                                <asp:TableCell Font-Bold="true">
                                    <asp:TextBox ID="txtNetPayable" BorderStyle="Groove" runat="server" Enabled="false"
                                       Text="0.00" Width="60px"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell>
                        <center>
                        <asp:HiddenField ID="hidTotRecFound" runat="server" Value="0"/>
                            <asp:Button ID="btnsubmit" Text="Submit" BorderStyle="Groove" runat="server" CssClass="blackfnt"
                                OnClientClick="javascript:return btnsubmitClick()" OnClick="btnsubmit_Click" />
                        </center>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:updatepanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;">
    </div>
    <pgb:ProgressBar ID="ProgressBar1" runat="server" />
</asp:Content>
<%--
var TotToPay=0,TotCrossing=0,TotDDChrg=0,TotNetAmt=0
                 var TotDocketTotal=0,TotCrossingTotal=0,TotDoorDeliveryTotal=0,TotbulkyChargeTotal=0;
                 var docketAmount=0,crossingAmt=0,dooDeliveryChrg=0,bulkyCharge=0;

                var RateBase

                var chkID = ObjId
                
                var txtDocAmtID = chkID.replace( "chkBill", "txtDocketAmt")
                var txtCrossChrgID = chkID.replace( "chkBill", "txtCrossCharge")
                var txtDDChrgID = chkID.replace( "chkBill", "txtDDCharge")
                var txtBulkyChrgID = chkID.replace( "chkBill", "txtBulkyCharge")
                var txtRateBaseID = chkID.replace( "chkBill", "cboRateBase")
                var txtVendorRateID = chkID.replace( "chkBill", "lblVendorRate")
                
                var grid=document.getElementById("ctl00_MyCPH1_DocketDetail");
                "ctl00_MyCPH1_DocketDetail_ctl" + rows + "_" + txtid
            
                docketAmount = document.getElementById(chkID.replace( "chkBill", "txtDocketAmt")).value;
                crossingAmt = document.getElementById(chkID.replace( "chkBill", "txtCrossCharge")).value;
                dooDeliveryChrg = document.getElementById(chkID.replace( "chkBill", "txtDDCharge")).value;
                bulkyCharge = document.getElementById(chkID.replace( "chkBill", "txtBulkyCharge")).value;
                RateBase = document.getElementById(chkID.replace( "chkBill", "cboRateBase")).value;
                VendorRate = document.getElementById(chkID.replace( "chkBill", "lblVendorRate")).value;
                Paybas = document.getElementById(chkID.replace( "chkBill", "hdnPaybas")).value;
                
                var IndTOTAmt=0
                 
                                if(document.getElementById(chkID).checked)
                                  {
                                        document.getElementById(txtRateBaseID).disabled = false;
                                            if(Paybas=="P03")
                                            {
                                                TotDocketTotal=rounditn(parseFloat(TotDocketTotal)+parseFloat(docketAmount.value),2);
                                            }
                                            else if(Paybas=="P01" || Paybas=="P02")
                                            {
                                                TotDocketTotal=TotDocketTotal;
                                            }
                                        TotCrossingTotal=rounditn(parseFloat(TotCrossingTotal)+parseFloat(crossingAmt.value),2)
                                        TotDoorDeliveryTotal=rounditn(parseFloat(TotDoorDeliveryTotal)+parseFloat(dooDeliveryChrg.value),2)
                                        TotbulkyChargeTotal=rounditn(parseFloat(TotbulkyChargeTotal)+parseFloat(bulkyCharge.value),2)
                                        
                                        document.getElementById("ctl00_MyCPH1_txtTotalToPay").value=TotDocketTotal;
                                        document.getElementById("ctl00_MyCPH1_txtTotalCrossing").value=TotCrossingTotal;
                                        document.getElementById("ctl00_MyCPH1_txtTotDDCharge").value=TotDoorDeliveryTotal;
                                        document.getElementById("ctl00_MyCPH1_txtTotBulkyCharge").value=TotbulkyChargeTotal;
                                        document.getElementById("ctl00_MyCPH1_txtNetPayable").value=rounditn(parseFloat(TotDocketTotal)-parseFloat(TotCrossingTotal)-parseFloat(TotDoorDeliveryTotal)-parseFloat(TotbulkyChargeTotal),2)
                    

                                   }
                                  else
                                   {
                                        document.getElementById(txtRateBaseID).disabled = true;
                                        document.getElementById(txtRateBaseID).value = "0";
                                        document.getElementById(txtCrossChrgID).value = "0.00";
                                        document.getElementById(txtDDChrgID).value = "0.00";
                                        document.getElementById(txtBulkyChrgID).value = "0.00";
                                        document.getElementById(txtVendorRateID).value = "0.00";
                                   }
                       
                      }
                        
                        
            --%>
