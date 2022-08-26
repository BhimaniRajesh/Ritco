<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TripsheetFinClosureMain.aspx.cs" Inherits="Issue_New_TripSheet_Validation_TripSheetApprovalSubmission_TripsheetFinClosureMain" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function TripsheetView(ctrl) {
            window.open('./../TripsheetViewPrint.aspx?VSlipNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }

        var tollPopup, addBluePopupDisplay, addBluePopupDisplayTotal, fuelPopupDisplay, fuelPopupDisplaySlip, SummaryPopup, detentionPopup;
        var TotalFuelLtrPopup;
        $(document).ready(function () {
            //TripSubmissionRows('HIDE');

            detentionPopup = $("#detentionPopup").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            TotalFuelLtrPopup = $("#TotalFuelLtrPopup").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 500,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            addBluePopupDisplay = $("#addbluePopupDisplay").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });


            addBluePopupDisplayTotal = $("#addbluePopupDisplayTotal").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 500,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            fuelPopupDisplaySlip = $("#fuelPopupDisplaySlip").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            fuelPopupDisplay = $("#fuelPopupDisplay").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });


            tollPopup = $("#tollPopup").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 700,
                modal: true,
                buttons: {
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            SummaryPopup = $("#SummaryPopup").dialog({
                autoOpen: false,
                resizable: false,
                height: 400,
                width: "100%",
                modal: true,
                buttons: {
                    "TripFinancialClosure": function () {
                        debugger;
                        if (ValidateOnSubmit()) {
                            $(this).dialog("close");
                            $("#ctl00_MyCPH1_btnfinclose").click();
                        } else {
                            $(this).dialog("close");
                        }

                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });

            protsahanrashiPopup = $("#ProtsahanRashiPopup").dialog({
                autoOpen: false,
                resizable: false,
                height: 300,
                width: 800,
                modal: true,
                buttons: {
                    "Submit": function () {
                        if (Submit_ProtsahanRashi() == true) {
                            $(this).dialog("close");
                            $("#" + lblNExpenseID_ProtsahanRashi.replace("lblNExpense", "txtApprovalAmount")).focus();
                        }
                    },
                    Cancel: function () {
                        $(this).dialog("close");
                    }
                }
            });
        });


        function ViewSummaryPopup() {

            Load_TotalfuelDetails();

            //var txtTotal_CF = $('#ctl00_MyCPH1_txtTotal_CF');

            //if (parseFloat(txtTotal_CF.val() == "" ? "0" : txtTotal_CF.val()) < 0) {
            //    alert("Invalid Fuel C/F : " + txtTotal_CF.val());
            //    return false;
            //}

            //if ($('#ctl00_MyCPH1_txtApprovedProposedFuel').val() == "") {
            //    alert("Please enter ApprovedFuel !! ");
            //    $('#ctl00_MyCPH1_txtApprovedProposedFuel').focus();
            //    return false;
            //}

            //if (parseFloat($('#ctl00_MyCPH1_txtApprovedProposedFuel').val()) <= 0) {
            //    alert("Invalid ApprovedFuel !! ");
            //    $('#ctl00_MyCPH1_txtApprovedProposedFuel').focus();
            //    return false;
            //}

            SummaryPopup.dialog("open");
            return false;
        }

        function onTotalFuelLtrClick() {
            setTotalFuelDetails();
            TotalFuelLtrPopup.dialog("open");
        }

        function setTotalFuelDetails() {

            $("#lblSlipLtr").text($("#ctl00_MyCPH1_hdnFuelSlipLtr").val());
            $("#lblCardLtr").text($("#ctl00_MyCPH1_hdnFuelCardLtr").val());
            $("#lblFuelCashLtr").text($("#ctl00_MyCPH1_hdnFuelCashLtr").val());

            $("#lblAddBlueCashLtr").text($("#ctl00_MyCPH1_hdnAddBlueCashLtrs").val());

            $("#lblSlipAmt").text($("#ctl00_MyCPH1_hdnFuelSlipAmount").val());
            $("#lblCardAmt").text($("#ctl00_MyCPH1_hdnFuelCardAmout").val());
            $("#lblFuelCashAmt").text($("#ctl00_MyCPH1_hdnFuelCashAmount").val());

            $("#lblFuelPreviouseCF_Ltr").text(parseFloat($('#ctl00_MyCPH1_hdnPreviouseFuelCF_Ltr').val()));
            $("#lblFuelPreviouseCF_amount").text(parseFloat($('#ctl00_MyCPH1_hdnPreviouseFuelCF_amount').val()));

            $("#lblFuelLtrTotal").text(parseFloat($("#ctl00_MyCPH1_hdnFuelSlipLtr").val()) + parseFloat($("#ctl00_MyCPH1_hdnFuelCardLtr").val())
                 + parseFloat($("#ctl00_MyCPH1_hdnFuelCashLtr").val()) + parseFloat($('#ctl00_MyCPH1_hdnPreviouseFuelCF_Ltr').val()));

            $("#lblFuelCashAmtTotal").text(parseFloat($("#ctl00_MyCPH1_hdnFuelSlipAmount").val()) + parseFloat($("#ctl00_MyCPH1_hdnFuelCardAmout").val())
                 + parseFloat($("#ctl00_MyCPH1_hdnFuelCashAmount").val()) + parseFloat($('#ctl00_MyCPH1_hdnPreviouseFuelCF_amount').val()));


            $("#lblAddBlueSlipLtr_Blue").text($("#ctl00_MyCPH1_hdnAddBlueSlipLtrs").val());
            $("#lblAddBlueSlipAmt_Blue").text($("#ctl00_MyCPH1_hdnAddBlueSlipAmt").val());
            $("#lblAddBlueCardLtr_Blue").text($("#ctl00_MyCPH1_hdnAddBlueCardLtrs").val());
            $("#lblAddBlueCardAmt_Blue").text($("#ctl00_MyCPH1_hdnAddBlueCardAmt").val());
            $("#lblAddBlueCashLtr_Blue").text($("#ctl00_MyCPH1_hdnAddBlueCashLtrs").val());
            $("#lblAddBlueCashAmt_Blue").text($("#ctl00_MyCPH1_hdnAddBlueCashAmt").val());

            $("#lblAddBlueLtrTotal_Blue").text(parseFloat($("#ctl00_MyCPH1_hdnAddBlueSlipLtrs").val()) + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCardLtrs").val())
                 + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCashLtrs").val()));

            $("#lblAddBlueAmtTotal_Blue").text(parseFloat($("#ctl00_MyCPH1_hdnAddBlueSlipAmt").val()) + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCardAmt").val())
                + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCashAmt").val()));



        }

        function ViewAddBluePopup(addBlueId) {
            addBluePopupDisplay.dialog("open");
        }

        function ViewTotalAddBluePopup() {
            setTotalFuelDetails();
            addBluePopupDisplayTotal.dialog("open");
        }

        function ViewFuelPopup(fuelPopupId) {
            fuelPopupDisplay.dialog("open");
        }

        function ViewFuelSlipPopup() {
            fuelPopupDisplaySlip.dialog("open");
        }
        function ViewTollPopup(tollId) {
            tollPopup.dialog("open");
        }
        function ViewDetentionPopup() {
            detentionPopup.dialog("open");
        }


        function VehicleView(ctrl) {

            window.open('./../../../../../admin/VehicleMaster/VehicleViewPrint.aspx?VehicleNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
               , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

            //window.open('./../../../../Reports/VehicleTracking/VehicleTrackingView.aspx?VehicleNo=' + $(ctrl).text() + '&PrintMode=0', '_blank'
            //     , 'top=0, left=0, width=1000, height=750, scrollbars=no, menubar=no,toolbar=no,status=1,resizable=yes');

        }

        function ValidateOnSubmit() {
            //var rows = $("#ctl00_MyCPH1_gvEnroute tbody tr");

            //for (var i = 1; i < rows.length - 1; i++) {
            //    var txtApprovalAmount = $(rows[i]).find("input[type=text][id$=txtApprovalAmount]");
            //    var txtProposedAmount = $(rows[i]).find("input[type=text][id$=txtProposedAmount]");
            //    var txtApprovalRemark = $(rows[i]).find("input[type=text][id$=txtApprovalRemark]");
            //    if (parseFloat(txtApprovalAmount.val() == "" ? "0" : txtApprovalAmount.val()) != parseFloat(txtProposedAmount.val() == "" ? "0" : txtProposedAmount.val()) && txtApprovalRemark.val() == "") {
            //        alert("Please enter Approval Remark !!");
            //        txtApprovalRemark.focus();
            //        return false;
            //    }
            //}
            return true;
        }

        function ValidateOnReconsideration() {

            if ($("#ctl00_MyCPH1_txtReconsiderationRemark").val() == "") {
                alert("Please enter Reconsideration Remark !!");
                $("#ctl00_MyCPH1_txtReconsiderationRemark").focus();
                return false;
            }
            return true;
        }

        function calculateApprovedAmt(ctrl) {

            var txtApprovalAmount = $(ctrl);
            var txtProposedAmount = $(ctrl).closest("tr").find("input[type=text][id$=txtProposedAmount]");

            if (parseFloat(txtApprovalAmount.val() == "" ? "0" : txtApprovalAmount.val()) > parseFloat(txtProposedAmount.val() == "" ? "0" : txtProposedAmount.val())) {
                alert("Approval Amount Can not be greater then Proposed Amount !!");
                txtApprovalAmount.focus();
                return false;
            }
            else {
                var rows = $("#ctl00_MyCPH1_gvEnroute tbody tr");
                var totalApprovalAmt = 0;
                for (var i = 1; i < rows.length - 1; i++) {
                    var txtApprovalAmount = $(rows[i]).find("input[type=text][id$=txtApprovalAmount]");
                    totalApprovalAmt += parseFloat(txtApprovalAmount.val() == "" ? "0" : txtApprovalAmount.val());
                }
                $("[id$=txtApprovalTotal]").text(totalApprovalAmt);
            }

        }

        var ProposedExpense = 0.0, DriverAdvance = 0.0;
        function Load_TotalfuelDetails() {
            
            ProposedExpense = 0.0, DriverAdvance = 0.0;
            $("span[id*=txtApprovalAmount]").each(function () {
                var hfPolarity = $('#' + $(this).attr('id').replace('txtApprovalAmount', 'hfPolarity'));
                if ($(this).text() != "") {
                    if (hfPolarity.val() == "+") {
                        ProposedExpense = ProposedExpense + parseFloat($(this).text());
                    }
                    if (hfPolarity.val() == "-") {
                        ProposedExpense = ProposedExpense - parseFloat($(this).text());
                    }
                }
            });

            //Fuel Id
            var lblTotalFuel_A, ddlFixedPerKMTotal, txtAmtRateTotal, lblTotal_CF, lblStanderdFuel, txtProposedFuel, lblFuelEconomy;
            lblTotalFuel_A = $('#ctl00_MyCPH1_lblTotalFuel_A');
            txtTotalFuel_A = $('#ctl00_MyCPH1_txtTotalFuel_A');
            ddlFixedPerKMTotal = $('#ctl00_MyCPH1_ddlFixedPerKMTotal');
            txtAmtRateTotal = $('#ctl00_MyCPH1_txtAmtRateTotal');
            lblTotal_CF = $('#ctl00_MyCPH1_lblTotal_CF');
            txtTotal_CF = $('#ctl00_MyCPH1_txtTotal_CF');
            lblStanderdFuel = $('#ctl00_MyCPH1_lblStanderdFuel');
            txtProposedFuel = $('#ctl00_MyCPH1_txtProposedFuel');
            lblFuelEconomy = $('#ctl00_MyCPH1_lblFuelEconomy');

            var txtApprovedProposedFuel = $('#ctl00_MyCPH1_txtApprovedProposedFuel');

            var Dist = parseFloat($("#ctl00_MyCPH1_hdnDistance").val());

            if (ddlFixedPerKMTotal.val() == "P") {
                var totProposed = 0;
                totProposed = (parseFloat(txtAmtRateTotal.text()) == 0 ? 0 : Dist / parseFloat(txtAmtRateTotal.text()));
                //totProposed = (parseFloat(txtAmtRateTotal.val() == "" ? "0" : txtAmtRateTotal.val()) * Dist) / parseFloat(lblFuelEconomy.text() == "" ? "0" : lblFuelEconomy.text());
                txtApprovedProposedFuel.text(totProposed);
            }

            if (ddlFixedPerKMTotal.val() == "F") {
                txtApprovedProposedFuel.text(parseFloat(txtAmtRateTotal.text() == "" ? "0" : txtAmtRateTotal.text()));
            }

            if (parseFloat(txtApprovedProposedFuel.text()) > parseFloat(txtProposedFuel.text())) {
                alert("ApprovedFuel can not more then ProposedFuel");
                txtApprovedProposedFuel.text("");
                return false;
            }

            lblTotal_CF.text((parseFloat(lblTotalFuel_A.text()) - parseFloat(txtApprovedProposedFuel.text())).toFixed(2));
            txtTotal_CF.val((parseFloat(lblTotalFuel_A.text()) - parseFloat(txtApprovedProposedFuel.text())).toFixed(2));

            //Add Blue Id          
            var lblTotalAddBlue_A, ddlAddBlueFixedPerKMTotal, txtAddBlueAmtRateTotal, lblAddBlueTotal_CF, lblStanderdAddBlue, txtProposedAddBlue, lblAddBlueEconomy, lblPreviouseAddBlueCF_Ltr, lblPreviouseAddBlueCF_amount;
            lblTotalAddBlue_A = $('#ctl00_MyCPH1_lblTotalAddBlue_A');
            txtTotalAddBlue_A = $('#ctl00_MyCPH1_txtTotalAddBlue_A');
            ddlAddBlueFixedPerKMTotal = $('#ctl00_MyCPH1_ddlAddBlueFixedPerKMTotal');
            txtAddBlueAmtRateTotal = $('#ctl00_MyCPH1_txtAddBlueAmtRateTotal');
            lblAddBlueTotal_CF = $('#ctl00_MyCPH1_lblAddBlueTotal_CF');
            txtAddBlueTotal_CF = $('#ctl00_MyCPH1_txtAddBlueTotal_CF');
            lblStanderdAddBlue = $('#ctl00_MyCPH1_lblStanderdAddBlue');
            txtProposedAddBlue = $('#ctl00_MyCPH1_txtProposedAddBlue');
            lblAddBlueEconomy = $('#ctl00_MyCPH1_lblAddBlueEconomy');
            //  lblPreviouseAddBlueCF_Ltr = $('#ctl00_MyCPH1_lblPreviouseAddBlueCF_Ltr');
            //lblPreviouseAddBlueCF_amount = $('#ctl00_MyCPH1_lblPreviouseAddBlueCF_amount');


            var txtApprovedProposedAddBlue = $('#ctl00_MyCPH1_txtApprovedProposedAddBlue');            

            if (ddlAddBlueFixedPerKMTotal.val() == "P") {
                var totAddBlueProposed = 0;
                totAddBlueProposed = (parseFloat(txtAddBlueAmtRateTotal.val()) == 0 ? 0 : Dist / parseFloat(txtAddBlueAmtRateTotal.val()));
                //totProposed = (parseFloat(txtAmtRateTotal.val() == "" ? "0" : txtAmtRateTotal.val()) * Dist) / parseFloat(lblFuelEconomy.text() == "" ? "0" : lblFuelEconomy.text());
                txtApprovedProposedAddBlue.text(totAddBlueProposed);
            }

            if (ddlAddBlueFixedPerKMTotal.val() == "F") {
                txtApprovedProposedAddBlue.val(parseFloat(txtAddBlueAmtRateTotal.val() == "" ? "0" : txtAddBlueAmtRateTotal.val()));
            }

            if (parseFloat(txtApprovedProposedAddBlue.val()) > parseFloat(txtProposedAddBlue.text())) {
                alert("Approved Add Blue can not more then Proposed Add Blue");
                txtApprovedProposedAddBlue.text("");
                return false;
            }  

            lblAddBlueTotal_CF.text((parseFloat(lblTotalAddBlue_A.text()) - parseFloat(txtApprovedProposedAddBlue.val())).toFixed(2));
            txtAddBlueTotal_CF.val(parseFloat(lblTotalAddBlue_A.text()) - parseFloat(txtApprovedProposedAddBlue.val()));


            
            //summary amount 
            var TotalFuel = parseFloat(lblTotalFuel_A.text());
            $("#txtSummaryDistance").text(Dist);
            $("#txtSummaryTotalFuel1").text(TotalFuel);
            $("#txtSummaryTotalFuel").text(txtApprovedProposedFuel.text());
            $("#txtSummaryProposedFuel").text(txtApprovedProposedFuel.text());
            $("#txtSummaryTotalAddBlue").text(parseFloat(txtApprovedProposedAddBlue.text()).toFixed(2));

            //$("#txtSummaryFuelEconomy").text((Dist / FuelslipLtr));
            if (txtProposedFuel.val() == "0") {
                $("#txtSummaryFuelEconomy").text("0");
            } else {
                $("#txtSummaryFuelEconomy").text((Dist / parseFloat(txtApprovedProposedFuel.text())).toFixed(2));
            }

            $("#txtSummaryCFFuel").text(txtTotal_CF.val());

            $("#txtSummaryProposedExpense").text(ProposedExpense);

            DriverAdvance = parseFloat($("#ctl00_MyCPH1_hdnDriverAdvance").val());
            DriverAdvance = DriverAdvance + parseFloat($('#ctl00_MyCPH1_hdnPreviouseDriverAdvanceCF_amount').val());

            $("#txtSummaryDriverAdvance").text(DriverAdvance);
            $("#txtSummaryDriverBalance").text((ProposedExpense - DriverAdvance));


            //var addblueratio = ((parseFloat(AddBlueSlipLtrs) + parseFloat(AddBlueCardLtrs) + parseFloat(AddBlueCashLtrs)) / parseFloat(txtProposedFuel.val())) * 100;
            var addblueratio = ((parseFloat($("#ctl00_MyCPH1_hdnAddBlueSlipLtrs").val()) + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCardLtrs").val())
                + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCashLtrs").val())) / parseFloat(txtApprovedProposedFuel.text())) * 100;
            //$("#txtSummaryAddBlueRatio").text(((parseFloat(AddBlueSlipLtrs) + parseFloat(AddBlueCardLtrs) + parseFloat(AddBlueCashLtrs)) / (parseFloat(txtProposedFuel.val()) * 100)).toFixed(2));
            $("#txtSummaryAddBlueRatio").text(addblueratio.toFixed(2));

            var CumulativeValue = 0.0;
            //if ((SlipLtrs + CardLtrs + FuelCashLtrs) == 0) {
            //    CumulativeValue = 0.0;
            //} else {
            //    CumulativeValue = (FuelSlipAmount + FuelCardAmout + FuelCashAmount) / (SlipLtrs + CardLtrs + FuelCashLtrs);
            //}

            var TotalLtrsFuel = (parseFloat($("#ctl00_MyCPH1_hdnFuelSlipLtr").val()) + parseFloat($("#ctl00_MyCPH1_hdnFuelCardLtr").val())
                + parseFloat($("#ctl00_MyCPH1_hdnFuelCashLtr").val()) + parseFloat($("#ctl00_MyCPH1_hdnPreviouseFuelCF_Ltr").val()));

            if (TotalLtrsFuel == 0) {
                CumulativeValue = 0.0;
            } else {
                CumulativeValue = (parseFloat($("#ctl00_MyCPH1_hdnFuelSlipAmount").val()) + parseFloat($("#ctl00_MyCPH1_hdnFuelCardAmout").val()) + parseFloat($("#ctl00_MyCPH1_hdnFuelCashAmount").val()) + parseFloat($("#ctl00_MyCPH1_hdnPreviouseFuelCF_amount").val())) / TotalLtrsFuel;
            }


            var ProposedFuelAmount = 0.0;
            ProposedFuelAmount = (CumulativeValue * parseFloat(txtApprovedProposedFuel.text()));
            $("#txtSummaryProposedFuelAmount").text(ProposedFuelAmount.toFixed(2));

            var tollCardAmount = parseFloat($("#txtByCard_Toll").text() == "" ? "0" : $("#txtByCard_Toll").text());
            //$("#txtSummaryPerKMExpense").text((((ProposedExpense - FuelCashAmount) + AddBlueSlipAmt + AddBlueCardAmt + tollCardAmount) / Dist).toFixed(2));

            var perkmexpense = ((parseFloat(ProposedExpense) - parseFloat($("#ctl00_MyCPH1_hdnFuelCashAmount").val()))
                + parseFloat($("#ctl00_MyCPH1_hdnAddBlueSlipAmt").val()) + parseFloat($("#ctl00_MyCPH1_hdnAddBlueCardAmt").val())
                + parseFloat($("#ctl00_MyCPH1_hdnTollAmtByCard").val()) + parseFloat(ProposedFuelAmount) ) / Dist;

            $("#txtSummaryPerKMExpense").text((perkmexpense).toFixed(2));

        }

        var lblNExpenseID_ProtsahanRashi = "";
        function OpenProtsahanRashiPopup(ProtsahanRashiId) {
            lblNExpenseID_ProtsahanRashi = ProtsahanRashiId;
            protsahanrashiPopup.dialog("open");

            //ctl00_MyCPH1_grdProtsahanRashi txtApprovalAmount
        }
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet Financial Closure</asp:Label>
            </td>
            <td align="right"></td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <table cellspacing="1" width="800px">
        <tr align="left">
            <td>
                <table cellspacing="1" cellpadding="2" class="boxbg" width="800px">
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Financial Closure </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <b>Vehicle No</b>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblVehicleNo" CssClass="blackfnt" runat="server" Font-Bold="true" Font-Underline="true" onclick="VehicleView(this)" />
                        </td>
                        <td align="left">
                            <b>Tripsheet No</b>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblTripsheetNo" CssClass="blackfnt" runat="server" Font-Bold="true" Font-Underline="true" onclick="TripsheetView(this)" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <b>Route Type</b>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblRouteType" CssClass="blackfnt" runat="server" Font-Bold="true" />
                        </td>
                        <td align="left">
                            <b>Detention</b>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblDetention" CssClass="blackfnt" runat="server" Font-Bold="true" Font-Underline="true" Text="ViewDetails" onclick="ViewDetentionPopup()" />
                        </td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td colspan="6" align="center">
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
                                            <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Standard Amt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtEAmt" runat="server" Style="text-align: right"
                                                Width="75px" Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
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
                                            <asp:TextBox ID="txtProposedAmount" CssClass="input" Width="75px" Style="text-align: right"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedAmount") %>' ReadOnly="true"
                                                BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtProposedAmountTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Proposed Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtProposedRemark" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedRemark") %>' ReadOnly="true"
                                                runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="500"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtApprovalAmount" CssClass="input" Width="75px" Style="text-align: right"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>'
                                                onblur="calculateApprovedAmt(this);" ReadOnly="true"
                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtApprovalTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtApprovalRemark" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedRemarks") %>'
                                                runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="500" ReadOnly="true"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                    CssClass="bgbluegrey" />
                            </asp:GridView>
                        </td>
                    </tr>--%>

                    <tr style="background-color: white">
                        <td colspan="6" align="left">
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
                                            <asp:HiddenField ID="hidNExpense" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ExpenseId") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="" >
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate >
                                            <asp:Label ID="lblFixedPerKM" Text="" runat="server"></asp:Label>
                                            <asp:Label ID="txtAmtRate" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedFixedPerKM_Value") %>' runat="server"></asp:Label>
                                            <asp:Label ID="lblDistance" Text='Distance : ' runat="server"></asp:Label>
                                            <asp:HiddenField ID="hdnddlFixedPerKM" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"ApprovedFixedPerKM_TYPE") %>'></asp:HiddenField>
                                        </ItemTemplate>
                                        <ItemStyle  Width="500px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Standard Amt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtEAmt" runat="server" Style="text-align: right"
                                                Width="75px" Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
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
                                            <asp:Label ID="txtProposedAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedAmount") %>'
                                                Style="text-align: right"></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtProposedAmountTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Proposed Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtProposedRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedRemark") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtApprovalAmount" Style="text-align: right"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtApprovalTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="right" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtApprovalRemark" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedRemarks") %>'
                                                runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                    CssClass="bgbluegrey" />
                            </asp:GridView>
                        </td>
                    </tr>

                    <tr style="background-color: white; width: 500px;" align="left">
                        <td colspan="6">
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
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Grand Total"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Standard Amt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtEAmt" runat="server" Style="text-align: right"
                                                Width="75px" Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
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
                                            <asp:Label ID="txtProposedAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedAmount") %>' Style="text-align: right"></asp:Label>

                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtProposedAmountTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="Right" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Proposed Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtProposedRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ProposedRemark") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Amount">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtApprovalAmount" Style="text-align: right"
                                                runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovalAmount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="txtApprovalTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                BorderStyle="NONE"></asp:Label>
                                        </FooterTemplate>
                                        <ItemStyle Width="50px" HorizontalAlign="right" VerticalAlign="Top" Font-Bold="False" />
                                        <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Approval Remarks">
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="txtApprovalRemark" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedRemarks") %>'
                                                runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle ForeColor="Black" Font-Bold="true" Font-Italic="False" Font-Size="8pt"
                                    CssClass="bgbluegrey" />
                            </asp:GridView>
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
                                    <th>Approved Ltrs</th>
                                    <th>Approved Remarks</th>
                                </tr>
                                <tr style="background-color: white;">
                                    <td><b>TotalFuel</b></td>
                                    <td>
                                        <asp:Label ID="lblTotalFuel_A" onclick="onTotalFuelLtrClick()" runat="server" Width="75px" Font-Bold="true"
                                            Style="text-align: right;"
                                            Text="0" BorderStyle="NONE"></asp:Label>
                                        <asp:TextBox ID="txtTotalFuel_A" runat="server" Text="0" Style="display: none" />
                                    </td>
                                    <td><b>Vehicle Fuel Economy</b></td>
                                    <td>
                                        <asp:Label ID="lblFuelEconomy" runat="server" Width="75px" Font-Bold="true" Text="50" Style="text-align: right"
                                            BorderStyle="NONE"></asp:Label></td>
                                    <td>

                                        <asp:Label ID="lblFixedPerKMTotal_Type" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:Label ID="txtAmtRateTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:HiddenField ID="hdnDistance" runat="server" Value="0"></asp:HiddenField>
                                    </td>

                                    <td>
                                        <asp:Label ID="lblStanderdFuel" Text='0' runat="server" Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtProposedFuel" Text='0' runat="server" Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtTotalFuelRemark" Text=''
                                            runat="server" Width="200px" MaxLength="50"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtApprovedProposedFuel" Text='0' runat="server"
                                            Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtApprovedTotalFuelRemark" Text=""
                                            runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white;">
                                    <td><b>C/F</b></td>
                                    <td colspan="9">
                                        <asp:Label ID="lblTotal_CF" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:TextBox ID="txtTotal_CF" runat="server" Text="0" Style="display: none" />

                                    </td>
                                </tr>
                                <tr style="background-color: white;">
                                    <td><b>Total Add Blue</b></td>
                                    <td>
                                        <asp:Label ID="lblTotalAddBlue_A" onclick="onTotalFuelLtrClick()" runat="server" Width="75px" Font-Bold="true"
                                            Style="text-align: right;"
                                            Text="0" BorderStyle="NONE"></asp:Label>
                                        <asp:TextBox ID="txtTotalAddBlue_A" runat="server" Text="0" Style="display: none" />
                                    </td>
                                    <td><b>Vehicle Fuel Economy</b></td>
                                    <td>
                                        <asp:Label ID="lblAddBlueEconomy" runat="server" Width="75px" Font-Bold="true" Text="50" Style="text-align: right"
                                            BorderStyle="NONE"></asp:Label></td>
                                    <td>

                                        <asp:Label ID="lblAddBlueFixedPerKMTotal_Type" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:Label ID="txtAddBlueAmtRateTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:HiddenField ID="hdnAddBlueDistance" runat="server" Value="0"></asp:HiddenField>
                                    </td>

                                    <td>
                                        <asp:Label ID="lblStanderdAddBlue" Text='0' runat="server" Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtProposedAddBlue" Text='0' runat="server" Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtTotalAddBlueRemark" Text=''
                                            runat="server" Width="200px" MaxLength="50"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtApprovedProposedAddBlue" Text='0' runat="server"
                                            Style="font-weight: bold"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="txtApprovedTotalAddBlueRemark" Text=""
                                            runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white;">
                                    <td><b>Add Blue C/F</b></td>
                                    <td colspan="9">
                                        <asp:Label ID="lblAddBlueTotal_CF" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                            BorderStyle="NONE" />
                                        <asp:TextBox ID="txtAddBlueTotal_CF" runat="server" Text="0" Style="display: none" />

                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right">ReConsideration Remark :</td>
                        <td>
                            <asp:TextBox ID="txtReconsiderationRemark" Text='' runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="500"></asp:TextBox>
                        </td>
                        <td colspan="2" align="right">
                            <asp:Button ID="btnReconsideration" runat="server" Text="Reconsideration" OnClientClick="javacript:return ValidateOnReconsideration();"
                                OnClick="btnReconsideration_Click" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="right">
                            <asp:Button ID="btnSummary" runat="server" Text="View Summary" OnClientClick="return ViewSummaryPopup()" />
                            <asp:Button ID="btnfinclose" runat="server" Text="Financial Closure" Style="display: none;"
                                OnClick="btnfinclose_Click" />
                            <%--OnClientClick="javacript:return ValidateOnSubmit();"--%>

                            <asp:HiddenField ID="hdnDriverAdvance" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnAddBlueSlipLtrs" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnAddBlueCardLtrs" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnAddBlueCashLtrs" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnAddBlueSlipAmt" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnAddBlueCardAmt" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnAddBlueCashAmt" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnFuelSlipAmount" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnFuelCardAmout" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnFuelCashAmount" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnFuelSlipLtr" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnFuelCardLtr" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnFuelCashLtr" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnTollAmtByCard" Value='0' runat="server" />

                            <asp:HiddenField ID="hdnPreviouseFuelCF_Ltr" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnPreviouseFuelCF_amount" Value='0' runat="server" />
                            <asp:HiddenField ID="hdnPreviouseDriverAdvanceCF_amount" Value='0' runat="server" />

                        </td>
                    </tr>
            </td>
        </tr>
    </table>

    <div id="addbluePopupDisplay" title="Add Blue">
        <asp:GridView ID="grdAddBlue" runat="server" PageSize="1000" AutoGenerateColumns="False"
            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
            CssClass="dgRowStyle" Width="100%" AllowPaging="false"
            EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="Place" HeaderText="Place">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Fuel" HeaderText="Fuel (Ltr)">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Rate" HeaderText="Rate">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Amount" HeaderText="Amount">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

     <div id="fuelPopupDisplaySlip" title="Fuel Slip">
        <asp:GridView ID="grdFuelSlip" runat="server" PageSize="1000" AutoGenerateColumns="False"
            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
            CssClass="dgRowStyle" Width="100%" AllowPaging="false"
            EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="VendorCity" HeaderText="Place">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="FuelSlipDate" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Quantity" HeaderText="Fuel (Ltr)">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="RateAsPerFillingDate" HeaderText="Rate">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Amount" HeaderText="Amount">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

    <div id="fuelPopupDisplay" title="Fuel Data">
        <asp:GridView ID="grdFule" runat="server" PageSize="1000" AutoGenerateColumns="False"
            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
            CssClass="dgRowStyle" Width="100%" AllowPaging="false"
            EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="Place" HeaderText="Place">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Date" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Fuel" HeaderText="Fuel (Ltr)">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Rate" HeaderText="Rate">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Amount" HeaderText="Amount">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    </div>

    <div id="tollPopup" title="Toll">
        <table id="tblToll" class="boxbg" border="0" cellpadding="1" cellspacing="1">
            <thead>
                <tr class="bgbluegrey">
                    <th>Card No</th>
                    <th>
                        <asp:Label ID="txtCardNo_Toll" runat="server" />
                    </th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <tr class="bgwhite">
                    <td>Last Date</td>
                    <td>
                        <asp:Label ID="txtLastDate_Toll" runat="server" />
                    </td>
                    <td>Last Ref No.</td>
                    <td>
                        <asp:Label ID="txtLastRefNo_Toll" runat="server" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>This Date</td>
                    <td>
                        <asp:Label ID="txtThisDate_Toll" runat="server" />
                    </td>
                    <td>This Ref No.</td>
                    <td>
                        <asp:Label ID="txtThisRefNo_Toll" runat="server" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>By Card</td>
                    <td>
                        <asp:Label ID="txtByCard_Toll" runat="server" />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr class="bgwhite">
                    <td>By Cash</td>
                    <td>
                        <asp:Label ID="txtByCash_Toll" runat="server" />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
            <tfoot>
                <tr class="bgbluegrey">

                    <td>Total </td>
                    <td>
                        <asp:Label ID="txtTotal_Toll" runat="server" />
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </div>

    <div id="detentionPopup" title="Detention Data">
        <asp:GridView ID="grdDetention" runat="server" PageSize="1000" AutoGenerateColumns="False"
            CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
            CssClass="dgRowStyle" Width="100%" AllowPaging="false"
            EmptyDataText="No Records Found">
            <Columns>
                <asp:BoundField DataField="FromDate" HeaderText="FromDate">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="ToDate" HeaderText="ToDate">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>

            </Columns>
        </asp:GridView>
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
                    <td>Total Add Blue (Ltr)</td>
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
                    <td>Approved Fuel</td>
                    <td>
                        <label id="txtSummaryProposedFuel" />
                    </td>
                </tr>
                <tr class="bgwhite">
                    <td>Approved Fuel Amount</td>
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
                    <td>Approved Expense</td>
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
    <div id="addbluePopupDisplayTotal" title="Fuel Slip">
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
                        <asp:TextBox ID="txtTransitDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                            value='<%# DataBinder.Eval(Container.DataItem,"TransitDays") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Save Days">
                    <ItemTemplate>
                        <asp:TextBox ID="txtSaveDays" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"
                            value='<%# DataBinder.Eval(Container.DataItem,"SaveDays") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                        <asp:TextBox ID="txtAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove"
                            onkeypress="javascript:validFloat(event,this.id)" CssClass="input" value='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Approval Amount">
                    <ItemTemplate>
                        <asp:TextBox ID="txtApprovalAmount" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input" 
                            onkeypress="javascript:validFloat(event,this.id)" value='<%# DataBinder.Eval( Container.DataItem,"ApprovalAmount")%>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remarks">
                    <ItemTemplate>
                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="500" Width="65" BorderStyle="groove" CssClass="input"
                            value='<%# DataBinder.Eval(Container.DataItem,"Remark") %>' Enabled="false"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
