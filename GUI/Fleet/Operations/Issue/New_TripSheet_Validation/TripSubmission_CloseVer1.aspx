<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripSubmission_CloseVer1.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSubmission_CloseVer1" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/LED/DateSelector.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../AJAX_Validator/TripClousreVer1.js?<%=System.DateTime.Now.Ticks.ToString() %>"></script>
    <script type="text/javascript" language="javascript" src="TripSubmission_CloseVer1PopUp.js?<%=System.DateTime.Now.Ticks.ToString() %>"></script>

    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function ValidateDate(obj) {
            if (obj.value != "") {
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
        function checkUnloadingDate(id) {
            var txtTripEndDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndDate");
            var txtUnloadingDate = document.getElementById(id);
            if (txtUnloadingDate.value != '' && txtUnloadingDate.value != null) {
                var lblTripSheetDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTripSheetDate");
                var lblLoadingDate = document.getElementById(id.replace("txtUnloadingDate", "lblLoadingDate"));
                var startArray = lblTripSheetDate.innerHTML.split("/");
                var EndArray = txtUnloadingDate.value.split("/");
                var LoadingDateArray = lblLoadingDate.innerHTML.split("/");
                var startDt = new Date(startArray[2], startArray[1] - 1, startArray[0]);
                var endDt = new Date(EndArray[2], EndArray[1] - 1, EndArray[0]);
                var LoadingDt = new Date(LoadingDateArray[2], LoadingDateArray[1] - 1, LoadingDateArray[0]);

                if (startDt > endDt) {
                    alert('Unloading date must be greater or equal to Trip Start Date');
                    txtTripEndDate.focus();
                    txtTripEndDate.value = "";
                    return false;
                }

                if (LoadingDt > endDt) {
                    alert('Unloading date must be greater or equal to Loaded Date');
                    txtUnloadingDate.focus();
                    txtUnloadingDate.value = "";
                    return false;
                }
            }
        }
        function OperationallyCloseValid(type) {
            try {
                //if (type == "F") {
                //    SummaryPopup.dialog("close");
                //}

                var txtTripEndKm = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndKm");
                var lblTripStartKm = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTripStartKm");

                var txtTripEndDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndDate");
                var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
                if (txtTripEndDate.value == '' || txtTripEndDate.value == null) {
                    alert('Please Enter Trip End Date');
                    txtTripEndDate.focus();
                    return false;
                }

                if (txtTripEndDate.value != '' && txtTripEndDate.value != null) {
                    var lblTripSheetDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTripSheetDate");
                    var startArray = lblTripSheetDate.innerHTML.split("/");
                    var EndArray = txtTripEndDate.value.split("/");
                    var startDt = new Date(startArray[2], startArray[1] - 1, startArray[0]);
                    var endDt = new Date(EndArray[2], EndArray[1] - 1, EndArray[0]);
                    if (startDt > endDt) {
                        alert('Please Enter Trip End date must be greater or equal to Trip Start Date');
                        txtTripEndDate.focus();
                        return false;
                    }

                }



                if (txtTripEndKm.value == '' || txtTripEndKm.value == null) {
                    alert('Please Enter Trip End Km');
                    txtTripEndKm.focus();
                    return false;
                }

                if (parseFloat(txtTripEndKm.value) <= parseFloat(lblTripStartKm.innerHTML)) {
                    alert('Trip End Km must be greater then Trip Start KM !!');
                    txtTripEndKm.focus();
                    return false;
                }


                var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
                var GridView1 = document.getElementById("ctl00_MyCPH1_gvEnroute");
                var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");

                //if (dgHSD_OIL_EXP != null) {
                //    if (dgHSD_OIL_EXP.rows.length > 1) {
                //        for (i = 0; i < dgHSD_OIL_EXP.rows.length - 1; i++) {
                //            j = i + 2;
                //            var pref = "";
                //            if (j < 10) {
                //                pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl0" + j + "_";
                //            }
                //            else {
                //                pref = "ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + j + "_";
                //            }
                //            var txtOilPlace = document.getElementById(pref + "txtOilPlace");
                //            var ddlPPName = document.getElementById(pref + "ddlPPName");
                //            var ddlBrand = document.getElementById(pref + "ddlBrand");
                //            var ddlFuelType = document.getElementById(pref + "ddlFuelType");
                //            var txtLKmRead = document.getElementById(pref + "txtLKmRead");
                //            var txtKM_Reading = document.getElementById(pref + "txtKM_Reading");
                //            var txtDiesel_Ltr = document.getElementById(pref + "txtDiesel_Ltr");
                //            var txtDieselRate_Ltr = document.getElementById(pref + "txtDieselRate_Ltr");
                //            var txtAmt = document.getElementById(pref + "txtAmt");
                //            var txtExeAmt = document.getElementById(pref + "txtExeAmt");
                //            var ddlPayment = document.getElementById(pref + "ddlPayment");
                //            if (txtOilPlace.value == "") {
                //                alert("Enter Place !!!");
                //                txtOilPlace.focus();
                //                return false;
                //            }
                //            if (ddlPPName.value == "Select") {
                //                alert("Select Petrol Pump Name !!!");
                //                ddlPPName.focus();
                //                return false;
                //            }
                //            if (ddlBrand.value == "Select") {
                //                alert("Select Brand !!!");
                //                ddlBrand.focus();
                //                return false;
                //            }
                //            if (ddlFuelType.value == "Select") {
                //                alert("Select Fuel Type !!!");
                //                ddlFuelType.focus();
                //                return false;
                //            }
                //            if (txtKM_Reading.value == "") {
                //                alert("Enter KM Reading !!!");
                //                txtKM_Reading.focus();
                //                return false;
                //            }
                //            if (txtDiesel_Ltr.value == "0") {
                //                alert("Enter Diesel !!!");
                //                txtDiesel_Ltr.focus();
                //                return false;
                //            }
                //            if (txtDieselRate_Ltr.value == "0") {
                //                alert("Enter Diesel Rate/litres !!!");
                //                txtDieselRate_Ltr.focus();
                //                return false;
                //            }
                //            if (txtExeAmt.value == "") {
                //                alert("Enter Amount Approved By Fleet Executive !!!");
                //                txtExeAmt.focus();
                //                return false;
                //            }
                //            if (ddlPayment.value == "select") {
                //                alert("Select Diesel Card or Cash!!!");
                //                ddlPayment.focus();
                //                return false;
                //            }
                //        }
                //    }
                //}
                if (dgGeneral != null) {
                    if (dgGeneral.rows.length > 2) {
                        for (i = 0; i < dgGeneral.rows.length - 2; i++) {
                            j = i + 2;
                            var pref = "";
                            if (j < 10) {
                                pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
                            }
                            else {
                                pref = "ctl00_MyCPH1_dgGeneral_ctl" + j + "_";
                            }
                            var txtFillingDate = document.getElementById(pref + "txtFillingDate");
                            var hdnIsCancel = document.getElementById(pref + "hdnIsCancel");
                            if (txtFillingDate.value == "" && hdnIsCancel.value != "Y") {
                                alert("Enter Filling Date!!!");
                                txtFillingDate.focus();
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
                                pref = "ctl00_MyCPH1_gvEnroute_ctl0" + j + "_";
                            }
                            else {
                                pref = "ctl00_MyCPH1_gvEnroute_ctl" + j + "_";
                            }
                            var txtAmount = document.getElementById(pref + "txtAmount");
                            var hfEAmt = document.getElementById(pref + "hfEAmt");
                            var txtEAmt = document.getElementById(pref + "txtEAmt");

                            if (txtAmount.value != "" || hfEAmt.value != "" || txtEAmt.innerText != "") {
                                if (txtAmount.value == "") {
                                    alert("Enter Amount!!!");
                                    txtAmount.focus();
                                    return false;
                                }
                                if (hfEAmt.value == "") {
                                    if (txtEAmt.innerText == "") {
                                        alert("Standard Amount is Required. \n Kindly check the FTL Type mappaing with Vehicle Master or Trip Route Expense Master Entry!!!");
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                }

                if (type == "F") {

                    if ($("#ctl00_MyCPH1_txtAmtRateTotal").val() == "") {
                        alert("Please enter FixedPerKm Rate");
                        return false;
                    }

                    if (parseFloat($("#ctl00_MyCPH1_txtAmtRateTotal").val()) == 0) {
                        alert("Please enter FixedPerKm Rate");
                        return false;
                    }

                    if ($("#ctl00_MyCPH1_txtProposedFuel").val() == "") {
                        alert("Please enter Proposed fuel")
                        return false;
                    }
                    if (parseFloat($("#ctl00_MyCPH1_txtProposedFuel").val()) == 0) {
                        alert("Please enter Proposed fuel")
                        return false;
                    }

                }

                //var ConFirmBox = confirm("Are you sure to submit data?");
                //if (ConFirmBox == false) {
                //    return false;
                //}
                if (confirm("Are you sure to submit data?")) {
                    return true;
                } else {
                    return false;
                }
            } catch (e) {
                alert(e.message);
                return false;
            }
            return true;
        }

        function ValidateOnNext() {
            var txtTripEndKm = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndKm");
            var txtTripEndDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_txtTripEndDate");
            var dgHSD_OIL_EXP = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
            if (txtTripEndDate.value == '' || txtTripEndDate.value == null) {
                alert('Please Enter Trip End Date');
                txtTripEndDate.focus();
                return false;
            }

            if (txtTripEndDate.value != '' && txtTripEndDate.value != null) {
                var lblTripSheetDate = document.getElementById("ctl00_MyCPH1_Repeater1_ctl00_lblTripSheetDate");
                var startArray = lblTripSheetDate.innerHTML.split("/");
                var EndArray = txtTripEndDate.value.split("/");
                var startDt = new Date(startArray[2], startArray[1] - 1, startArray[0]);
                var endDt = new Date(EndArray[2], EndArray[1] - 1, EndArray[0]);
                if (startDt > endDt) {
                    alert('Please Enter Trip End date must be greater or equal to Trip Start Date');
                    txtTripEndDate.focus();
                    return false;
                }

            }

            if (txtTripEndKm.value == '' || txtTripEndKm.value == null) {
                alert('Please Enter Trip End Km');
                txtTripEndKm.focus();
                return false;
            }
            var gvEnroute = document.getElementById("ctl00_MyCPH1_gvEnroute");
            var GridView1 = document.getElementById("ctl00_MyCPH1_gvEnroute");
            var dgGeneral = document.getElementById("ctl00_MyCPH1_dgGeneral");


            if (dgGeneral != null) {
                if (dgGeneral.rows.length > 2) {
                    for (i = 0; i < dgGeneral.rows.length - 2; i++) {
                        j = i + 2;
                        var pref = "";
                        if (j < 10) {
                            pref = "ctl00_MyCPH1_dgGeneral_ctl0" + j + "_";
                        }
                        else {
                            pref = "ctl00_MyCPH1_dgGeneral_ctl" + j + "_";
                        }
                        var txtFillingDate = document.getElementById(pref + "txtFillingDate");
                        var hdnIsCancel = document.getElementById(pref + "hdnIsCancel");
                        if (txtFillingDate.value == "" && hdnIsCancel.value != "Y") {
                            alert("Enter Filling Date!!!");
                            txtFillingDate.focus();
                            return false;
                        }
                    }
                }
            }


            $("#ctl00_MyCPH1_btnNextStep").hide();
            $("#ctl00_MyCPH1_btnOperationClose").hide();
            TripSubmissionRows('SHOW');
            SetRecoverableAmount("SET");
            return false;
        }

        function rounditn(Num, decplaces) {
            Places = decplaces
            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    var Rounder = Math.pow(10, Places);
                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
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
            } else return Math.round(Num);
        }
        function CashFuelCalculation() {
            var txtCashRate = document.getElementById("ctl00_MyCPH1_txtCashRate");
            var txtCashLiter = document.getElementById("ctl00_MyCPH1_txtCashLiter");
            var lblCashTotal = document.getElementById("ctl00_MyCPH1_lblCashTotal");
            var hidCashTotal = document.getElementById("ctl00_MyCPH1_hidCashTotal");
            if (txtCashRate != "" && txtCashLiter != "") {
                lblCashTotal.innerText = rounditn(parseFloat(txtCashRate.value) * parseFloat(txtCashLiter.value), 2);
                hidCashTotal.value = parseFloat(txtCashRate.value) * parseFloat(txtCashLiter.value);
            }
        }

        function SetTotalKM(ctrl) {
            var txtTripEndKm = $(ctrl);
            var lblTripStartKm = $('#' + txtTripEndKm.attr('id').replace('txtTripEndKm', 'lblTripStartKm'));
            var lblTotalTripKm = $('#' + txtTripEndKm.attr('id').replace('txtTripEndKm', 'lblTotalTripKm'));

            var StartKm = parseFloat((lblTripStartKm.text() == "" ? "0" : lblTripStartKm.text()));
            var EndKm = parseFloat((txtTripEndKm.val() == "" ? "0" : txtTripEndKm.val()));

            if (EndKm < StartKm && txtTripEndKm.val() != "") {
                alert("Trip End Km can not be less then Trip Start KM !!")
                txtTripEndKm.val("");
                txtTripEndKm.focus();
                return false;
            }

            var Dist = Math.abs(EndKm - StartKm);
	    if (parseFloat(Dist) > 15000) {
                alert("Trip End KM can not be more then 15000 KM, Please enter valid Trip End KM!!")
                txtTripEndKm.val("");
                txtTripEndKm.focus();
            }
            lblTotalTripKm.text(Dist.toString());

        }

        function FixedCalculation(ctrl, type) {

            var ddlFixedPerKM, txtAmtRate, txtEAmt, txtAmount, lblDistance;
            if (type == "D") {
                ddlFixedPerKM = $(ctrl);
                txtAmtRate = $('#' + ddlFixedPerKM.attr('id').replace('ddlFixedPerKM', 'txtAmtRate'));
                txtEAmt = $('#' + ddlFixedPerKM.attr('id').replace('ddlFixedPerKM', 'txtEAmt'));
                txtAmount = $('#' + ddlFixedPerKM.attr('id').replace('ddlFixedPerKM', 'txtAmount'));
                lblDistance = $('#' + ddlFixedPerKM.attr('id').replace('ddlFixedPerKM', 'lblDistance'));
            }
            if (type == "T") {
                txtAmtRate = $(ctrl);
                ddlFixedPerKM = $('#' + txtAmtRate.attr('id').replace('txtAmtRate', 'ddlFixedPerKM'));
                txtEAmt = $('#' + txtAmtRate.attr('id').replace('txtAmtRate', 'txtEAmt'));
                txtAmount = $('#' + txtAmtRate.attr('id').replace('txtAmtRate', 'txtAmount'));
                lblDistance = $('#' + txtAmtRate.attr('id').replace('txtAmtRate', 'lblDistance'));
            }

            var txtTripEndKm = $('input[id*=txtTripEndKm]');
            var lblTripStartKm = $('span[id*=lblTripStartKm]');

            var StartKm = parseFloat((lblTripStartKm.text() == "" ? "0" : lblTripStartKm.text()));
            var EndKm = parseFloat((txtTripEndKm.val() == "" ? "0" : txtTripEndKm.val()));
            var Dist = Math.abs(EndKm - StartKm);
            lblDistance.text("Distance : " + Dist.toString());

            if (ddlFixedPerKM.val() == "P") {
                txtEAmt.val(Dist * parseFloat(txtAmtRate.val() == "" ? "0" : txtAmtRate.val()));
                txtAmount.val(Dist * parseFloat(txtAmtRate.val() == "" ? "0" : txtAmtRate.val()));
            }
            if (ddlFixedPerKM.val() == "F") {
                txtEAmt.val((txtAmtRate.val() == "" ? "0" : txtAmtRate.val()));
                txtAmount.val((txtAmtRate.val() == "" ? "0" : txtAmtRate.val()));
            }
            GVcalculateBalanceNewVer1();
        }
    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <UserControl:UserMessage runat="server" ID="umsg" />
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <table cellspacing="1" cellpadding="3" style="width: 950px" align="left" class="boxbg"
        border="0" id="mainTable">
        <%-- <tr class="bgbluegrey">
            <td align="center" rowspan="2">LOGO</td>
            <td colspan="4" align="center">
                <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Trip Submission"></asp:Label>
            </td>
        </tr>--%>
        <tr style="background-color: white">
            <td colspan="6" align="left" style="background-color: white">
                <asp:Repeater runat="server" ID="Repeater1">
                    <ItemTemplate>
                        <table border="1" cellpadding="1" cellspacing="0" class="boxbg" width="1000px">
                            <tr class="bgbluegrey">
                                <td align="center" rowspan="3" style="background-color: white">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="../../../../images/WebXpress_logo.gif" /></td>
                                <td colspan="5" align="center">
                                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Trip Submission"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td>
                                    <font class="bluefnt">Trip Sheet No</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTripSheetNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "vslipNo")%>'></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Controlling Branch</font>
                                </td>
                                <td colspan="3">
                                    <asp:Label ID="lblControlBranch" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "tripsheet_startLoc")%>'></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Route Type</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblRouteTp" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "Trip_Route_Type_Desc")%>'></asp:Label>
                                    :
                                    <asp:Label ID="lblRouteTypeDetail" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "route")%>'></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Manual Trip Sheet No</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblManualTripSheetNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "manual_tripsheetno")%>'></asp:Label>
                                </td>

                            </tr>

                            <tr style="background-color: white" height="20">
                                <td colspan="6" align="center"></td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Trip Start Date & Time</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTripSheetDate" Text='<%# DataBinder.Eval(Container.DataItem, "start_Dt_tm")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Vehicle No.</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblVehicleNo" Text='<%# DataBinder.Eval(Container.DataItem, "vehicleno")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Driver Name</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblDriverName1" Text='<%# DataBinder.Eval(Container.DataItem, "Driver_Name")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Trip End Date & Time</font>
                                </td>
                                <td>
                                    <asp:HiddenField ID="hfOperationalyCloseDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Oper_Close_Dt")%>' />
                                    <asp:TextBox ID="txtTripEndDate" BorderStyle="Groove" CssClass="input" Width="75px"
                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Oper_Close_Dt")%>'></asp:TextBox>
                                    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtTripEndDate"
                                        runat="server" />--%>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Vehicle Type</font></td>
                                <td>
                                    <asp:Label ID="lblVehicleType" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem, "Type_name")%>'></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Trip End KM</font></td>
                                <td>
                                    <asp:TextBox ID="txtTripEndKm" runat="server" onkeypress="javascript:validFloat(event,this.id)" CssClass="blackfnt"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "f_closure_closekm")%>' onblur="SetTotalKM(this);">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr runat="server" id="row_FTCity" style="background-color: white">
                                <td>
                                    <font class="bluefnt">Trip Start KM</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTripStartKm" Text='<%# DataBinder.Eval(Container.DataItem, "f_issue_startkm")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Vehicle Capacity</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblVehicleCategory" Text='<%# DataBinder.Eval(Container.DataItem, "Capacity")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="bluefnt">Total Trip KM</font>
                                </td>
                                <td>
                                    <asp:Label ID="lblTotalTripKm" Text='<%# DataBinder.Eval(Container.DataItem, "TotalKM")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="bluefnt">Entry By</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblEntryBy" Text='<%# DataBinder.Eval(Container.DataItem, "Entryby")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Entry Date & Time</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblEntryDateTime" Text='<%# DataBinder.Eval(Container.DataItem, "Entrydt")%>' runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr style="background-color: white; display: none;">
                                <td align="left">
                                    <font class="bluefnt">Average Diesel Rate</font>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblAverageDieselRate" Style="text-align: right" runat="server" CssClass="blackfnt"
                                        Text=""></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Approved Fuel Amount</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtApprovedFuelAmt" Style="text-align: right" CssClass="blackfnt"
                                        runat="server" BorderStyle="None"></asp:TextBox>
                                    <asp:HiddenField ID="hfApprovedAmt" runat="server" />
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Fuel Filled Enroute</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFuelFilledEnroute" Style="text-align: right" CssClass="blackfnt"
                                        runat="server" BorderStyle="None"></asp:TextBox>
                                    <asp:HiddenField ID="hftxtFuelFilledEnroute" runat="server" />

                                </td>
                            </tr>
                            <tr style="background-color: white; display: none;">
                                <td align="left">
                                    <font class="bluefnt">Actual KMPL</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtKMPL" Style="text-align: right" runat="server" CssClass="blackfnt"
                                        Text="" BorderStyle="None" onfocus="this.blur()" />
                                    <asp:HiddenField ID="hdnDiesel_CF" runat="server" Value="N" />
                                </td>
                                <td align="left">
                                    <font class="bluefnt">Approved Diesel (liters)</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtApprovedDiesel" Style="text-align: right" runat="server" CssClass="blackfnt"
                                        Text="" BorderStyle="None" />
                                    <asp:HiddenField ID="hfKMPL" runat="server" />
                                    <asp:Label ID="lbl_Closing_KM_Err" runat="server" Text="" CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="hf_CloseKMGreater10K" runat="server" Value="N" />
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
                <br />
            </td>
        </tr>

        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>CarryForward Details</b></font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="6">
                <table class="boxbg" cellspacing="0" cellpadding="1" width="1000" border="1">
                    <tr style="background-color: white">
                        <td>Fuel C/F Ltrs</td>
                        <td colspan="2">
                            <asp:Label ID="lblPreviouseFuelCF_Ltr" runat="server" Text="0" Font-Bold="true"></asp:Label></td>
                        <td>Add Blue C/F Ltrs</td>
                        <td colspan="2">
                            <asp:Label ID="lblPreviouseAddBlueCF_Ltr" runat="server" Text="0" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr style="background-color: white">
                        <td>Fuel C/F Amount </td>
                        <td colspan="2">
                            <asp:Label ID="lblPreviouseFuelCF_amount" runat="server" Text="0" Font-Bold="true"></asp:Label></td>
                        <td>Add Blue C/F Amount</td>
                        <td colspan="2">
                            <asp:Label ID="lblPreviouseAddBlueCF_amount" runat="server" Text="0" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr style="background-color: white">
                        <td>Driver Advance Amount C/F </td>
                        <td colspan="2">
                            <asp:Label ID="lblPreviouseDriverAdvanceCF_amount" runat="server" Text="0" Font-Bold="true"></asp:Label></td>
                        <td></td>
                        <td colspan="2"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <%--<font class="blackfnt"><b>Fuel Filled</b></font>--%>
                <font class="blackfnt"><b>Credit Fuel</b></font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="6">

                <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                    CssClass="dgRowStyle" Width="70%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                    PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr No.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="VENDORNAME" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FuelMode" ItemStyle-HorizontalAlign="Left" HeaderText="FuelMode" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:TemplateField HeaderText="FuelType">
                            <ItemTemplate>
                                <asp:Label ID="lblFuelType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelType") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="City">
                            <ItemTemplate>
                                <asp:Label ID="lblVendorCity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VendorCity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reference No">
                            <ItemTemplate>
                                <asp:Label ID="lblUserSlipNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"UserSlipNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reference Date">
                            <ItemTemplate>
                                <asp:Label ID="lblFuelSlipDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelSlipDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Odometer Reading">
                            <ItemTemplate>
                                <asp:Label ID="lblOdometerReading" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Quantity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Diesel(Qty In Ltr)">
                            <ItemTemplate>
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Quantity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Diesel as per Slip date Rate/Ltr">
                            <ItemTemplate>
                                <asp:Label ID="lblRate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Rate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Filling Date">
                            <ItemTemplate>
                                <asp:TextBox ID="txtFillingDate" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                    CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"FillingDate") %>' onblur="GetRateFillingDateWise(this)"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtFillingDate"
                                    runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate As per Filling Date">
                            <ItemTemplate>
                                <asp:Label ID="lblRateAsPerFillingDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RateAsPerFillingDate") %>'></asp:Label>
                                <asp:HiddenField ID="hdnRateAsPerFillingDate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"RateAsPerFillingDate") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Final Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblFinalAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AmountAsPerFillingDate") %>'></asp:Label>
                                <asp:HiddenField ID="hdnFinalAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"AmountAsPerFillingDate") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Fuel Slip Cancel">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkCancelFuelSlip" runat="server" OnClientClick="return CancelFuelSlip(this);" OnClick="lnkCancelFuelSlip_Click">Cancel</asp:LinkButton>
                                <asp:Label ID="lblCancelFuelSlip" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="hdnSrNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"srno") %>' />
                                <asp:HiddenField ID="hdnModule" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Module") %>' />
                                <asp:HiddenField ID="hdnIsCancel" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"IsCancel") %>' />
                                <asp:HiddenField ID="hdnIsBilled" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"IsBilled") %>' />
                                <asp:HiddenField ID="hdnVendorCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"VendorCode") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>

        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>Fuel Card</b></font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="6">
                <asp:GridView ID="grdFuelCardDetails" runat="server" AutoGenerateColumns="False"
                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                    CssClass="dgRowStyle" Width="70%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                    PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr No.">
                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Supplier" ItemStyle-HorizontalAlign="Left" HeaderText="Supplier" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FuelType" ItemStyle-HorizontalAlign="Left" HeaderText="FuelType" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="FuelCardNo" ItemStyle-HorizontalAlign="Left" HeaderText="CardNo" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="City" ItemStyle-HorizontalAlign="Left" HeaderText="City" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TransactionID" ItemStyle-HorizontalAlign="Left" HeaderText="TransactionID" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="TransactionDate" ItemStyle-HorizontalAlign="Left" HeaderText="TransactionDate" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="DieselQty" ItemStyle-HorizontalAlign="Left" HeaderText="Diesel ( Qty in Litre )" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="AddFuelQty" ItemStyle-HorizontalAlign="Left" HeaderText="Add Blue ( Qty in Litre )" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="SwappingDate" ItemStyle-HorizontalAlign="Left" HeaderText="SwappingDate" ReadOnly="True"
                            HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Rate" ItemStyle-HorizontalAlign="Left" HeaderText="Rate" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                        <asp:BoundField DataField="Amount" ItemStyle-HorizontalAlign="Left" HeaderText="Amount" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>

        <%-- Not in Use --%>
        <tr class="bgbluegrey" style="width: 1000px; display: none;">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>Fuel Details</b></font>
            </td>
        </tr>
        <tr style="background-color: white; width: 1000px; display: none;">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="5" align="left">
                <asp:TextBox ID="txtAddRowOilExp" runat="server" MaxLength="2" Width="30" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                    BorderStyle="Groove" OnTextChanged="add_rowOil" AutoPostBack="true"></asp:TextBox>
            </td>
        </tr>
        <tr style="background-color: white; width: 1000px; display: none;">
            <td colspan="6" align="left">
                <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <table border="0" width="1000px">
                            <tr align="left">
                                <td>
                                    <font class="redfnt">
                                        <asp:Label ID="lbl_OilExp_Expense" runat="server" Text=""></asp:Label></font>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False" CellSpacing="1" CellPadding="3"
                                        HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager"
                                        OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound">
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="Sr.No.">
                                                <ItemTemplate>
                                                    <center>
                                                        <%# Container.ItemIndex+1 %>.
                                                        <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </center>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Place">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        MaxLength="50" Enabled="false"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Petrol Pump Name">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlPPName" runat="server" CssClass="input" Width="100px" BorderStyle="Groove"
                                                        MaxLength="50" Enabled="false">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="reqPPName" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="ddlPPName"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Brand">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlBrand" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"
                                                        MaxLength="50" Enabled="false">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="reqBrand" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="ddlBrand"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Fuel Type">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="input" Width="70px" BorderStyle="Groove"
                                                        Enabled="false">
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="reqFuelType" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="ddlFuelType"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Last Km Reading">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtLKmRead" Width="50px" onfocus="this.blur()" BorderStyle="None"
                                                        runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="KM Reading">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove" MaxLength="6" Enabled="false"></asp:TextBox>
                                                    <%--AutoPostBack="True" OnTextChanged="txtKM_Reading_TextChanged" --%>
                                                    <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server" ErrorMessage="!"
                                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtKM_Reading"
                                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Bill No.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBillno" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"
                                                        MaxLength="25" Enabled="false"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqBillno" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtBillno"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Bill Date">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBilldt" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                        CssClass="input" Enabled="false"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtBilldt"
                                                        runat="server" />
                                                    <%--<asp:RequiredFieldValidator ID="reqBilldt" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"  ControlToValidate="txtBilldt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REVBilldt" runat="server" ControlToValidate="txtBilldt"
                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            Width="1px"></asp:RegularExpressionValidator>--%>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Diesel<br>(Qtn. in<br>litres)">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDiesel_Ltr" runat="server" CssClass="input" Width="60px" Style="text-align: right"
                                                        onkeypress="javascript:validFloat(event,this.getAttribute('id'))" BorderStyle="Groove"
                                                        MaxLength="6" Enabled="false" /><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack="true" --%>
                                                    <%--<asp:RequiredFieldValidator ID="reqDiesel_Ltr" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"   ControlToValidate="txtDiesel_Ltr"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegDiesel_Ltr" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtDiesel_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Diesel<br>Rate/litres">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDieselRate_Ltr" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="60px" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="6" Enabled="false"></asp:TextBox><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack=true --%>
                                                    <asp:RequiredFieldValidator ID="reqDieselRate_Ltr" runat="server" Display="Dynamic"
                                                        Text="!" ValidationGroup="VGDtFromTo" ControlToValidate="txtDieselRate_Ltr"></asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegDieselRate_Ltr" runat="server" ErrorMessage="!"
                                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtDieselRate_Ltr"
                                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Amount">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmt" runat="server" Width="60px" Style="text-align: right" BorderStyle="None"
                                                        MaxLength="6" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Enabled="false"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Amount Approved<br> By Fleet<br>Executive">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtExeAmt" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="60px" BorderStyle="Groove" MaxLength="6" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        ReadOnly="false" Enabled="false"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqExeAmt" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtExeAmt"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="By Card/Cash">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlPayment" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        Enabled="false" OnSelectedIndexChanged="CardNo_Dispaly" AutoPostBack="true">
                                                        <asp:ListItem Value="select" Text="Select" />
                                                        <asp:ListItem Value="Cash" Text="Cash" />
                                                        <asp:ListItem Value="Diesel Card" Text="Diesel Card" />
                                                    </asp:DropDownList>
                                                    <br>
                                                    <asp:Label ID="FCCard" runat="server"></asp:Label>
                                                    <asp:RequiredFieldValidator ID="reqPayment" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="ddlPayment"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Remarks">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        ReadOnly="false" Enabled="false"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="true" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                            ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        <ItemStyle ForeColor="#000066" />
                                        <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowOilExp" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td align="left" colspan="6">
                <b id="B1" runat="server">Total</b>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td style="width: 100px">
                <font class="bluefnt">Odometer</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalOdometerReading" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
            <td style="width: 100px">
                <font class="bluefnt">Diesel(Ltr)</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalDieselQty" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
            <td style="width: 100px">
                <font class="bluefnt">Diesel(Rate/Ltr)</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalDieselRate" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td style="width: 100px">
                <font class="bluefnt">Amount</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalAmount" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
            <td style="width: 100px">
                <font class="bluefnt">Rate(Filling Date)</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalRateFillingDate" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
            <td style="width: 100px">
                <font class="bluefnt">Final Amount</font>
            </td>
            <td style="width: 100px">
                <asp:Label ID="lblTotalFinalAmount" runat="server" CssClass="blackfnt" Text="0"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td align="left" colspan="6">
                <b id="Total" runat="server">Total</b>
                <asp:Label ID="lbl1" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td>
                <font class="bluefnt">Total Cash</font>
            </td>
            <td>
                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="3567"></asp:Label>
            </td>
            <td>
                <font class="bluefnt">Total Diesel</font>
            </td>
            <td>
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="6575765"></asp:Label>
            </td>
            <td colspan="2"></td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td align="left">
                <font class="bluefnt">Total Advance</font>
            </td>
            <td align="left">
                <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="kjgfkgh"></asp:Label>
            </td>
            <td align="left">
                <font class="bluefnt">Ltr</font>
            </td>
            <td align="left">
                <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="3645456456"></asp:Label>
            </td>
            <td colspan="2"></td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td>
                <font class="bluefnt">Route Type Edit</font>
            </td>
            <td>
                <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text="6575765"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txt" runat="server" Text="65564"></asp:TextBox>
            </td>
            <td colspan="3"></td>
        </tr>
        <tr style="background-color: white; display: none;" align="left">
            <td align="left" width="20%">
                <font class="blackfnt">Enter no. of rows</font>&nbsp;&nbsp;
            </td>
            <td align="left" colspan="5">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30"
                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                            BorderStyle="Groove" AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>

                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td colspan="2">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:GridView ID="dgWorkgroup" runat="server" PageSize="1000"
                            AutoGenerateColumns="False" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left"
                            OnRowDataBound="dgWorkgroup_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Sr.No">
                                    <ItemTemplate>
                                        <center>
                                            <%#Container.DataItemIndex + 1%>
                                            <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.DataItemIndex + 1%>'></asp:Label>
                                            <asp:HiddenField ID="hfTaskId" runat="server" Value="" />
                                        </center>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="From City">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtToll" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtRow1" runat="server"
                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                            ControlToValidate="txtToll" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="To City">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBorder" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtRow2" runat="server"
                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                            ControlToValidate="txtBorder" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Distance (KM)">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtCheckPost" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtRow3" runat="server"
                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                            ControlToValidate="txtCheckPost" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td colspan="4"></td>
        </tr>
        <%--  <tr style="background-color: white">
                    <td colspan="6" align="center">
                        <asp:Button ID="btnFinalSubmit" runat="server" Text="Continue" OnClick="btnFinalSubmit_Click" Visible="false" />
                    </td>
                </tr>
        <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
            </Triggers>--%>

        <tr class="bgbluegrey" style="display: none;">
            <td colspan="6">
                <font class="blackfnt"><b>Cash Fuel</b></font>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td colspan="2">
                <font class="blackfnt">Cash Rate:-</font><asp:TextBox ID="txtCashRate" CssClass="input" Width="75px" Style="text-align: right"
                    runat="server" Text='0.00' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                    BorderStyle="Groove" onblur="javascript:return CashFuelCalculation()"></asp:TextBox>
            </td>
            <td colspan="2">
                <font class="blackfnt">Cash Liter:-</font><asp:TextBox ID="txtCashLiter" CssClass="input" Width="75px" Style="text-align: right"
                    runat="server" Text='0.00' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                    BorderStyle="Groove" onblur="javascript:return CashFuelCalculation()"></asp:TextBox>
            </td>
            <td colspan="2">
                <font class="blackfnt">Total:-</font><asp:Label ID="lblCashTotal" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label>
                <asp:HiddenField ID="hidCashTotal" runat="server" Value="0.00"></asp:HiddenField>
            </td>
        </tr>
        <tr class="bgbluegrey" style="display: none;">
            <td colspan="6">
                <font class="blackfnt"><b>Credit Fuel</b></font>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td colspan="2">
                <font class="blackfnt">Total Credit Fuel:-</font><asp:TextBox ID="txtCreditFuel" CssClass="input" Width="75px" Style="text-align: right"
                    runat="server" Text='0.00' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                    BorderStyle="Groove"></asp:TextBox>
            </td>
            <td colspan="4"></td>
        </tr>

        <%-- Not in Use --%>


        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font cssclass="blackfnt"><b>Advance Paid To Driver</b></font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="6">
                <table border="1" cellpadding="1" cellspacing="0" width="1000px" class="boxbg">
                    <tr style="background-color: white">
                        <td>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="BranchCode" ItemStyle-HorizontalAlign="Left" HeaderText="Branch Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="AdvDate" ItemStyle-HorizontalAlign="Left" HeaderText="Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="VoucherRefNo" ItemStyle-HorizontalAlign="Left" HeaderText="Voucher No" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                                    <asp:TemplateField HeaderText="Amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDriverAdv" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>'></asp:Label>
                                            <asp:HiddenField ID="hdnDriverAdv" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Remark" ItemStyle-HorizontalAlign="Left" HeaderText="Remark" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                                    <asp:TemplateField HeaderText="Options" Visible="false">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="hyp" runat="server" Text="POD"></asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white; display: none;">
            <td colspan="6">
                <b>Total:</b><asp:Label ID="lblTotal" runat="server" Text="15666"></asp:Label></td>
        </tr>
        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font cssclass="blackfnt"><b>Journey Details</b></font>
            </td>
        </tr>
        <tr style="background-color: white" id="trJourneyDetails">
            <td colspan="6">
                <asp:HiddenField ID="hdnTotalRecoverableAmount" runat="server" />
                <table border="1" cellpadding="1" cellspacing="0" width="700px" class="boxbg">
                    <tr style="background-color: white">
                        <td>
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="thcno" ItemStyle-HorizontalAlign="Left" HeaderText="THC NO" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="thcdt" ItemStyle-HorizontalAlign="Left" HeaderText="THC Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="fromcity" ItemStyle-HorizontalAlign="Left" HeaderText="From City" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                                    <asp:BoundField DataField="tocity" ItemStyle-HorizontalAlign="Left" HeaderText="To City" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <%--<asp:BoundField DataField="loadingDate" ItemStyle-HorizontalAlign="Left" HeaderText="Loaded Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />--%>
                                    <asp:TemplateField HeaderText="Loaded Date">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblLoadingDate" runat="server" Width="65"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"loadingDate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="UnloadingDate">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtUnloadingDate" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                                CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>' onblur="return checkUnloadingDate(this.id);"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtUnloadingDate"
                                                runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="weight" ItemStyle-HorizontalAlign="Left" HeaderText="Weight" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="Commodity" ItemStyle-HorizontalAlign="Left" HeaderText="Product" HeaderStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="vslipdt" />
                                    <asp:BoundField DataField="nug" ItemStyle-HorizontalAlign="Left" HeaderText="Nug" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="freightamt" ItemStyle-HorizontalAlign="Left" HeaderText="Freight" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="advanceamount" ItemStyle-HorizontalAlign="Left" HeaderText="Advance" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="custcode" ItemStyle-HorizontalAlign="Left" HeaderText="Customer" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:TemplateField HeaderText="Detention Amount">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDetentionAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TripDetentionAmount") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Detention Remark">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDetentionRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TripDetentionRemark") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Recoverable Amount">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRecoverableAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TripRecoverableAmount") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Recoverable Remark">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRecoverableRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TripRecoverableRemark") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="POD Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPODRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"remarks") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>

                                    <%--<asp:BoundField DataField="remarks" ItemStyle-HorizontalAlign="Left" HeaderText="POD Remarks" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />--%>
                                    <asp:TemplateField HeaderText="Upload Document" Visible="true">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:FileUpload ID="fuPod" runat="server" />
                                            <asp:HyperLink ID="lblUloadLink" runat="server" Font-Underline="true" Text='View'
                                                Target="_blank" CssClass="bluefnt" NavigateUrl='<%# string.Format("../ViewETScammedDocument.aspx?DocName={0}", Server.UrlEncode(DataBinder.Eval(Container.DataItem,"lblUloadLink").ToString()))  %>'></asp:HyperLink>
                                            <asp:HiddenField ID="hdnEthcNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"thcno") %>'></asp:HiddenField>
                                            <asp:HiddenField ID="hdnTripType" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TripType") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>Empty KM</b></font>
            </td>
        </tr>

        <tr style="background-color: white;" align="left" id="trEmptyKM">
            <td align="left" width="20%">
                <font class="blackfnt">Enter no. of rows</font>&nbsp;&nbsp;
            </td>
            <td align="left" colspan="5">
                <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:TextBox ID="txtEmtyKMRows" runat="server" MaxLength="2" Width="30" Text="0"
                            BorderStyle="Groove" AutoPostBack="true" OnTextChanged="txtEmtyKMRows_TextChanged"></asp:TextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white;" id="trEmptyKM1">
            <td colspan="2">
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="grdEmtyKM" runat="server" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                            EmptyDataText="No Records Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="From">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFromKM" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                            CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"FromKm") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtToKM" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"ToKm") %>'
                                            CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Distance">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDistance" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"Distance") %>'
                                            CssClass="input" onkeypress="javascript:validFloat(event,this.id)"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtEmtyKMRows" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td colspan="4"></td>
        </tr>

        <tr class="bgbluegrey" style="width: 1000px">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>Detention</b></font>
            </td>
        </tr>

        <tr style="background-color: white;" align="left" id="trDetention1">
            <td align="left" width="20%">
                <font class="blackfnt">Enter no. of rows</font>&nbsp;&nbsp;
            </td>
            <td align="left" colspan="5">
                <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:TextBox ID="txtDetentionRows" runat="server" MaxLength="2" Width="30" Text="0"
                            BorderStyle="Groove" AutoPostBack="true" OnTextChanged="txtDetentionRows_TextChanged"></asp:TextBox>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>

        <tr style="background-color: white;" id="trDetention2">
            <td colspan="2">
                <asp:UpdatePanel ID="UpdatePanel8" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="grdDetantion" runat="server" AutoGenerateColumns="False"
                            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                            CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                            EmptyDataText="No Records Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr No.">
                                    <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="From">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"FromDate") %>' CssClass="input"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calFromDt" Format="dd/MM/yyyy" TargetControlID="txtFrom"
                                            runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"ToDate") %>' CssClass="input"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderToDt" Format="dd/MM/yyyy" TargetControlID="txtTo" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" Width="65" BorderStyle="groove"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>' CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtDetentionRows" EventName="TextChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td colspan="4"></td>
        </tr>

        <tr style="background-color: white" align="center" id="trOperationalBtn">
            <td colspan="6">
                <asp:Button ID="btnOperationClose" runat="server" Text="Operational Close" OnClientClick="javascript:return OperationallyCloseValid('O')"
                    OnClick="btnOperationClose_Click" />
                <asp:Button ID="btnNextStep" runat="server" Text="Next Step" OnClientClick="javascript:return ValidateOnNext()" />
                <%--OnClick="btnNextStep_Click"--%>
                <asp:Label ID="Label2" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
            </td>
        </tr>

        <tr class="bgbluegrey" style="width: 1000px" id="trRoute3">
            <td colspan="6" align="left">
                <font class="blackfnt"><b>Route Details</b></font>
            </td>
        </tr>
        <tr style="background-color: white;" id="trRoute2">
            <td colspan="6"><b>Select Route : </b>
                <asp:DropDownList ID="ddlRouteType" runat="server" onchange="showRouteOpen()">
                    <asp:ListItem Value="01" Text="Fixed" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="02" Text="Open"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="lblRouteError" runat="server" Text=""></asp:Label>

                <asp:UpdatePanel ID="UpdatePanel9" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlRouteName" runat="server" AutoPostBack="true" Width="200px" CssClass="input" OnSelectedIndexChanged="ddlRouteName_SelectedIndexChanged">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <%--  <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlRouteName" EventName=SelectedIndexChanged" />
                    </Triggers>--%>
                </asp:UpdatePanel>
            </td>

        </tr>
        <tr style="background-color: white; display: none;" id="trRoute1">
            <td colspan="6">
                <asp:TextBox runat="server" ID="txtRouteType1" BorderStyle="Groove" CssClass="input" />
                <ajaxToolkit:AutoCompleteExtender ID="Extender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType1">
                </ajaxToolkit:AutoCompleteExtender>

                <asp:TextBox runat="server" ID="txtRouteType2" BorderStyle="Groove" CssClass="input" />
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType2">
                </ajaxToolkit:AutoCompleteExtender>

                <asp:TextBox runat="server" ID="txtRouteType3" BorderStyle="Groove" CssClass="input" />
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType3">
                </ajaxToolkit:AutoCompleteExtender>

                <asp:TextBox runat="server" ID="txtRouteType4" BorderStyle="Groove" CssClass="input" />
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType4">
                </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>


        <tr class="bgbluegrey" style="width: 1000px;" id="trTripsubmission">
            <td colspan="6" align="left">
                <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="En-Route Expenses"></asp:Label>
                - 
                <asp:Label ID="lblFlag" runat="server" CssClass="blackfnt" Font-Bold="true" Text=""></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white; width: 1000px; display: none;">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="5" align="left">
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" Width="20px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                            AutoPostBack="true" BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged" Enabled="false"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tb_Row_No"
                            ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white; width: 500px;" align="left" id="trTripsubmission1">
            <td colspan="6">
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <font class="redfnt">
                            <asp:Label ID="lbl_Enroute_Err" runat="server" Text=""></asp:Label></font>
                        <asp:GridView ID="gvEnroute" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                            SelectedIndex="1" OnRowDataBound="gvEnroute_RowDataBound"
                            HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" Width="70%" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nature of Expense">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblNExpense" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Expense") %>'></asp:Label>
                                        <asp:Label ID="lblDisplay" runat="server" Text="View Data" Visible="false"></asp:Label>
                                        <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                        <asp:HiddenField ID="hdnPopUpData" runat="server" Value=""></asp:HiddenField>

                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Sub Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlFixedPerKM" runat="server" onchange="javascript:return FixedCalculation(this,'D')">
                                            <asp:ListItem Value="F">Fixed</asp:ListItem>
                                            <asp:ListItem Value="P">Per KM</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtAmtRate" Text='0' runat="server" CssClass="input" Width="75px" BorderStyle="Groove"
                                            onblur="javascript:return FixedCalculation(this,'T')" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        <asp:Label ID="lblDistance" Text='Distance : ' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Bill No." Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBillNo" Text='<%# DataBinder.Eval(Container.DataItem,"BillNo") %>'
                                            runat="server" CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill date" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Date") %>'
                                            CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                            runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Standard Amt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="txtEAmt" runat="server" Style="text-align: right"
                                            Width="75px" onblur="javascript:return calculateBalanceNew()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            MaxLength="50"></asp:Label>
                                        <asp:HiddenField ID="hfEAmt" Value='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            runat="server" />
                                        <asp:HiddenField ID="hfPolarity" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Polarity") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="false" />
                                    <FooterStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="false" />
                                    <FooterTemplate>
                                        <asp:Label ID="txtETotalAmt" Width="75px" Style="text-align: right" runat="server"
                                            Font-Bold="true" BorderStyle="None"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Proposed Amount">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAmount" CssClass="input" Width="75px" Style="text-align: right"
                                            runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="txtEnAmtTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemark" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>'
                                            runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                        <asp:HiddenField ID="hdnFlag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Flag") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                CssClass="bgbluegrey" />
                        </asp:GridView>
                        <asp:HiddenField ID="hdnJsonExistingfuelSlipData" runat="server" />
                        <asp:HiddenField ID="hdnJsonFuelCardData" runat="server" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlRouteName" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:HiddenField ID="hfEnAmtTotal" runat="server" />
                <asp:HiddenField ID="hfETotalAmt" runat="server" />

                <asp:HiddenField ID="hdnJsonVehicleTollCardNo" runat="server" />
                <asp:HiddenField ID="hdnJsonVehicleTollCardRefDate" runat="server" />
                <asp:HiddenField ID="hdnJsonVehicleTollCardRefNo" runat="server" />
            </td>
        </tr>
        <tr style="background-color: white; width: 500px;" align="left" id="trTripsubmission3">
            <td colspan="6">
                <asp:UpdatePanel ID="UpdatePanel10" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:GridView ID="gvEnrouteExtra" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                            SelectedIndex="1" OnRowDataBound="gvEnrouteExtra_RowDataBound"
                            HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" Width="70%" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nature of Expense">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblNExpense" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Expense") %>'></asp:Label>
                                        <asp:Label ID="lblDisplay" runat="server" Text="View Data" Visible="false"></asp:Label>
                                        <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                        <asp:HiddenField ID="hdnPopUpData" runat="server" Value=""></asp:HiddenField>
                                        <asp:FileUpload ID="fldTollUpload" runat="server" Visible="false" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Grand Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill No." Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtBillNo" Text='<%# DataBinder.Eval(Container.DataItem,"BillNo") %>'
                                            runat="server" CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill date" Visible="false">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Date") %>'
                                            CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                            runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Standard Amt">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="txtEAmt" runat="server" Style="text-align: right"
                                            Width="75px" onblur="javascript:return calculateBalanceNew()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            MaxLength="50"></asp:Label>
                                        <asp:HiddenField ID="hfEAmt" Value='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            runat="server" />
                                        <asp:HiddenField ID="hfPolarity" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Polarity") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="false" />
                                    <FooterStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="false" />
                                    <FooterTemplate>
                                        <asp:Label ID="txtETotalAmt" Width="75px" Style="text-align: right" runat="server"
                                            Font-Bold="true" BorderStyle="None"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Proposed Amount">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAmount" CssClass="input" Width="75px" Style="text-align: right"
                                            runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="txtEnAmtTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE"></asp:Label>
                                    </FooterTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemark" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>'
                                            runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                        <asp:HiddenField ID="hdnFlag" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Flag") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                CssClass="bgbluegrey" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlRouteName" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white; width: 80%;" align="left" id="trTripsubmission4">
            <td colspan="6">

                <table id="tblTotalFuel" class="boxbg" border="0" cellpadding="1" cellspacing="1" width='70%'>
                    <tr class="bgbluegrey">
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th>Standard Ltrs</th>
                        <th>Proposed Ltrs</th>
                        <th>Remarks</th>
                    </tr>
                    <tr style="background-color: white;">
                        <td><b>TotalFuel</b></td>
                        <td>
                            <asp:Label ID="lblTotalFuel_A" onclick="onTotalFuelLtrClick()" runat="server" Width="75px" Font-Bold="true"
                                Style="text-align: right; text-decoration: underline"
                                Text="0" BorderStyle="NONE"></asp:Label>
                            <asp:TextBox ID="txtTotalFuel_A" runat="server" Text="0" Style="display: none" />
                        </td>
                        <td><b>Vehicle Fuel Economy</b></td>
                        <td>
                            <asp:Label ID="lblFuelEconomy" runat="server" Width="75px" Font-Bold="true" Text="50" Style="text-align: right"
                                BorderStyle="NONE"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddlFixedPerKMTotal" runat="server" onchange="javascript:return Load_TotalfuelDetails()">
                                <asp:ListItem Value="F">Fixed</asp:ListItem>
                                <asp:ListItem Value="P">Per KM</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtAmtRateTotal" Text='0' runat="server" CssClass="input" Width="75px" BorderStyle="Groove"
                                onblur="javascript:return Load_TotalfuelDetails()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                        </td>

                        <td>
                            <asp:UpdatePanel ID="UpdatePanel11" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblStanderdFuel" Text='0' runat="server"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </td>
                        <td>
                            <asp:TextBox ID="txtProposedFuel" Text='0' runat="server" CssClass="input" Width="75px" BorderStyle="Groove"
                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTotalFuelRemark" Text=''
                                runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white;">
                        <td><b>C/F</b></td>
                        <td colspan="8">
                            <asp:Label ID="lblTotal_CF" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                BorderStyle="NONE" />
                            <asp:TextBox ID="txtTotal_CF" runat="server" Text="0" Style="display: none" />

                        </td>
                    </tr>
                    <tr style="background-color: white;">
                        <td><b>Total Add Blue</b></td>
                        <td>
                            <asp:Label ID="lblTotalAddBlue_A" onclick="javascript:ViewAddBluePopup('');" runat="server" Width="75px" Font-Bold="true"
                                Style="text-align: right; text-decoration: underline"
                                Text="0" BorderStyle="NONE"></asp:Label>
                            <asp:TextBox ID="txtTotalAddBlue_A" runat="server" Text="0" Style="display: none" />
                        </td>
                        <td><b>Vehicle Add Blue Economy</b></td>
                        <td>
                            <asp:Label ID="lblAddBlueEconomy" runat="server" Width="75px" Font-Bold="true" Text="50" Style="text-align: right"
                                BorderStyle="NONE"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddlAddBlueFixedPerKMTotal" runat="server" onchange="javascript:return Load_TotalfuelDetails()">
                                <asp:ListItem Value="F">Fixed</asp:ListItem>
                                <asp:ListItem Value="P">Per KM</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtAddBlueAmtRateTotal" Text='0' runat="server" CssClass="input" Width="75px" BorderStyle="Groove"
                                onblur="javascript:return Load_TotalfuelDetails()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                        </td>

                        <td>
                            <asp:UpdatePanel ID="UpdatePanel12" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblStanderdAddBlue" Text='0' runat="server"></asp:Label>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </td>
                        <td>
                            <asp:TextBox ID="txtProposedAddBlue" Text='0' runat="server" CssClass="input" Width="75px" BorderStyle="Groove"
                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTotalAddBlueRemark" Text=''
                                runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                        <tr style="background-color: white;">
                        <td><b>Add Blue C/F</b></td>
                        <td colspan="8">
                            <asp:Label ID="lblTotal_AddBlue_CF" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                BorderStyle="NONE" />
                            <asp:TextBox ID="txtTotal_AddBlue_CF" runat="server" Text="0" Style="display: none" />

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white" align="center" id="trTripsubmission2">
            <td colspan="6">
                <asp:Button ID="btnSummary" runat="server" Text="View Summary" OnClientClick="return ViewSummaryPopup()" />
                <asp:Label ID="lblError" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                <asp:Button ID="btnTripSubbmission" runat="server" Text="Trip Submission" Style="display: none;"
                    OnClick="btnTripSubbmission_Click" />
                <%--OnClientClick="return OperationallyCloseValid('F');"--%>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnIsOperationalClose" runat="server" Value="0" />
    <asp:HiddenField ID="hdnIsFinancialClose" runat="server" />
    <asp:HiddenField ID="hdnTotalProposedAmt" runat="server" />
    <div id="addbluePopupDisplay" title="Total AddBlue">
        <table id="tblAddBlueDisplay" class="boxbg" border="0" cellpadding="1" cellspacing="1" style="display: none;">
            <thead>
                <tr class="bgbluegrey">
                    <th>Place</th>
                    <th>Date</th>
                    <th>Fuel (Ltr)</th>
                    <th>Rate</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">
                    <td></td>
                    <td>Total (Ltr)</td>
                    <td>
                        <input type="text" id="txtTotalLtr_AddBlueDisplay" value="" readonly /></td>
                    <td>Total</td>
                    <td>
                        <input type="text" id="txtTotal_AddBlueDisplay" value="" readonly /></td>

                </tr>
            </tfoot>
        </table>


        <table id="tblTotalAddBlueFuelLtr" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="50%">
            <thead>
                <tr class="bgbluegrey">
                    <th>Mode </th>
                    <th>Liter</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>

                <tr class="bgwhite">
                    <td>Slip </td>
                    <td>
                        <label id="lblAddBlueSlipLtr_Blue" />
                    </td>
                    <td>
                        <label id="lblAddBlueSlipAmt_Blue" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Card</td>
                    <td>
                        <label id="lblAddBlueCardLtr_Blue" />
                    </td>
                    <td>
                        <label id="lblAddBlueCardAmt_Blue" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Cash</td>
                    <td>
                        <label id="lblAddBlueCashLtr_Blue" />
                    </td>
                    <td>
                        <label id="lblAddBlueCashAmt_Blue" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td><b>Total</b></td>
                    <td>

                        <label id="lblAddBlueLtrTotal_Blue" />

                    </td>
                    <td>

                        <label id="lblAddBlueAmtTotal_Blue" />

                    </td>
                </tr>
            </tbody>

        </table>

    </div>

    <div id="addbluePopup" title="Cash AddBlue">
        <table id="tblAddBlue" class="boxbg" border="0" cellpadding="1" cellspacing="1">
            <thead>
                <tr class="bgbluegrey">
                    <th>Place</th>
                    <th>Date</th>
                    <th>Fuel (Ltr)</th>
                    <th>Rate</th>
                    <th>Amount</th>
                    <th>IGST</th>
                    <th>SGST</th>
                    <th>CGST</th>
                    <th>TotalAmount</th>                  
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">
                    <td></td>
                    <td>Total (Ltr)</td>
                    <td>
                        <input type="text" id="txtTotalLtr_AddBlue" value="" readonly /></td>
                    <td>Total</td>
                    <td>
                        <input type="text" id="txtTotal_AddBlue" value="" readonly /></td>
                    <td></td>
                    <td></td>
                    <td>Total Amount</td>
                    <td><input type="text" id="txtTotalAmount_AddBlue" value="" readonly /></td>                   
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="fuelPopupDisplay" title="Fuel Slip">
        <table id="tblfuelDisplay" class="boxbg" border="0" cellpadding="1" cellspacing="1">
            <thead>
                <tr class="bgbluegrey">
                    <th>Place</th>
                    <th>Date</th>
                    <th>Fuel (Ltr)</th>
                    <th>Rate</th>
                    <th>Amount</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">
                    <td></td>
                    <td>Total (Ltr)</td>
                    <td>
                        <input type="text" id="txtTotalLtr_fuelDisplay" value="" readonly /></td>
                    <td>Total</td>
                    <td>
                        <input type="text" id="txtTotal_fuelDisplay" value="" readonly /></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="fuelPopup" title="Cash Fuel">
        <table id="tblfuel" class="boxbg" border="0" cellpadding="1" cellspacing="1">
            <thead>
                <tr class="bgbluegrey">
                    <th>Place</th>
                    <th>Date</th>
                    <th>Fuel (Ltr)</th>
                    <th>Rate</th>
                    <th>Amount</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">
                    <td></td>
                    <td>Total (Ltr)</td>
                    <td>
                        <input type="text" id="txtTotalLtr_fuel" value="" readonly /></td>
                    <td>Total</td>
                    <td>
                        <input type="text" id="txtTotal_fuel" value="" readonly /></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="tollPopup" title="Toll">
        <table id="tblToll" class="boxbg" border="0" cellpadding="1" cellspacing="1">
            <thead>
                <tr class="bgbluegrey">
                    <th>Card No</th>
                    <th>
                        <label id="txtCardNo_Toll" />
                    </th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr class="bgwhite">
                    <td>Last Ref No.</td>
                    <td>
                        <label id="txtLastRefNo_Toll" />
                    </td>
                    <td>Last Date</td>
                    <td>
                        <label id="txtLastDate_Toll" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>This Ref No.</td>
                    <td>
                        <input type="text" id="txtThisRefNo_Toll" value="" /></td>
                    <td>This Date</td>
                    <td>
                        <input type="text" id="txtThisDate_Toll" value="" /></td>
                </tr>
                <tr class="bgwhite">
                    <td>By Card</td>
                    <td>
                        <input type="text" id="txtByCard_Toll" value="0" onkeypress="javascript:validFloat(event,this.id)" onblur="calculateTollDetails()" /></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr class="bgwhite">
                    <td>By Cash</td>
                    <td>
                        <input type="text" id="txtByCash_Toll" value="0" onkeypress="javascript:validFloat(event,this.id)" onblur="calculateTollDetails()" /></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">

                    <td>Total </td>
                    <td>
                        <input type="text" id="txtTotal_Toll" value="" readonly /></td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="SummaryPopup" title="Summary" style="text-align: center;">
        <table id="tblSummary" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="50%">
            <thead>
                <tr class="bgbluegrey">
                    <th colspan="4">Fuel Economy</th>
                </tr>
            </thead>
            <tbody>
                <tr class="bgwhite">
                    <td>Distance(kms)</td>
                    <td>
                        <label id="txtSummaryDistance" />
                    </td>

                </tr>
                <tr class="bgwhite">
                    <td>Total Fuel (Ltr)</td>
                    <td>
                        <label id="txtSummaryTotalFuel" />
                    </td>

                </tr>
                <tr class="bgwhite">
                    <td>Fuel Economy(kmpl) </td>
                    <td>
                        <label id="txtSummaryFuelEconomy" />
                    </td>

                </tr>
                <tr class="bgwhite">
                    <td>Total Add Blue(Ltr) </td>
                    <td>
                        <label id="txtSummaryTotalAddBlue" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Add Blue Ratio</td>
                    <td>
                        <label id="txtSummaryAddBlueRatio" />
                    </td>

                </tr>
                <tr class="bgwhite">
                    <td>Per Km Expense</td>
                    <td>
                        <label id="txtSummaryPerKMExpense" />
                    </td>

                </tr>

                <tr class="bgbluegrey">
                    <th colspan="2">Fuel Details</th>
                </tr>
                <tr class="bgwhite">
                    <td>Total Fuel</td>
                    <td>
                        <label id="txtSummaryTotalFuel1" />
                    </td>
                </tr>

                <tr class="bgwhite">
                    <td>Proposed Fuel</td>
                    <td>
                        <label id="txtSummaryProposedFuel" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Proposed Fuel Amount</td>
                    <td>
                        <label id="txtSummaryProposedFuelAmount" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>C/F Fuel</td>
                    <td>
                        <label id="txtSummaryCFFuel" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Proposed Expense</td>
                    <td>
                        <label id="txtSummaryProposedExpense" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Driver Advance </td>
                    <td>
                        <label id="txtSummaryDriverAdvance" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Driver Balance</td>
                    <td>
                        <label id="txtSummaryDriverBalance" />
                    </td>
                </tr>
            </tbody>
        </table>
        <br />
        <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClientClick="return SummaryCancel();" />--%>
    </div>

    <div id="TotalFuelLtrPopup" title="Total Fuel Ltr">
        <table id="tblTotalFuelLtr" class="boxbg" border="0" cellpadding="1" cellspacing="1" width="50%">
            <thead>
                <tr class="bgbluegrey">
                    <th>Mode </th>
                    <th>Liter</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody>
                <tr class="bgwhite">
                    <td>Slip </td>
                    <td>
                        <label id="lblSlipLtr" />
                    </td>
                    <td>
                        <label id="lblSlipAmt" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Card </td>
                    <td>
                        <label id="lblCardLtr" />
                    </td>
                    <td>
                        <label id="lblCardAmt" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Cash </td>
                    <td>
                        <label id="lblFuelCashLtr" />
                    </td>
                    <td>
                        <label id="lblFuelCashAmt" />
                    </td>
                </tr>

                <tr class="bgwhite">
                    <td>C/F Fuel </td>
                    <td>
                        <label id="lblFuelPreviouseCF_Ltr" />
                    </td>
                    <td>
                        <label id="lblFuelPreviouseCF_amount" />
                    </td>
                </tr>


                <tr class="bgwhite">
                    <td><b>Total</b> </td>
                    <td>
                        <label id="lblFuelLtrTotal" />
                    </td>
                    <td>
                        <label id="lblFuelCashAmtTotal" />
                    </td>
                </tr>


                <tr class="bgwhite" style="display: none;">
                    <td>AddBlue Cash (Ltr)</td>
                    <td>AddBlue Cash (Ltr)</td>
                    <td>
                        <label id="lblAddBlueCashLtr" />
                    </td>
                </tr>
            </tbody>

        </table>
    </div>

    <div id="ProtsahanRashiPopup" title="Protsahan Rashi">
                <asp:GridView ID="grdProtsahanRashi" runat="server" AutoGenerateColumns="false"
                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                    CssClass="dgRowStyle" Width="100%" AllowPaging="false"
                    EmptyDataText="No Records Found">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr No.">
                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ETHC No">
                            <ItemTemplate>
                                <asp:Label ID="txtETHCNo" runat="server" MaxLength="10" Width="65"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"ExternalTHCNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="From">
                            <ItemTemplate>
                                <asp:Label ID="txtFrom" runat="server" MaxLength="10" Width="65"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="To">
                            <ItemTemplate>
                                <asp:Label ID="txtTo" runat="server" MaxLength="10" Width="65"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Loading Date">
                            <ItemTemplate>
                                <asp:Label ID="txtLoadingDate" runat="server" MaxLength="10" Width="65"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"LoadingDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Unloading Date">
                            <ItemTemplate>
                                <asp:Label ID="txtUnloadingDate" runat="server" MaxLength="10" Width="65"
                                    Text='<%# DataBinder.Eval(Container.DataItem,"UnloadingDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Transit Days">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTransitDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Save Days">
                            <ItemTemplate>
                                <asp:TextBox ID="txtSaveDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove" onkeypress="javascript:validFloat(event,this.id)" CssClass="input"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remarks">
                            <ItemTemplate>
                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" Width="65" BorderStyle="groove" CssClass="input"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
    </div>
</asp:Content>
