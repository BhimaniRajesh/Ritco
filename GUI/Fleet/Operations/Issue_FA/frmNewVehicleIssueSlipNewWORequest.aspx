<%@ page title="" language="C#" masterpagefile="~/GUI/MasterPage.master" autoeventwireup="true"
    codefile="frmNewVehicleIssueSlipNewWORequest.aspx.cs" inherits="GUI_Fleet_Operations_Issue_frmNewVehicleIssueSlipNewWORequest" %>

<%@ register assembly="TimePicker" namespace="MKB.TimePicker" tagprefix="MKB" %>
<%@ register tagprefix="UC2" tagname="UCPaymentControl" src="~/UserControls/PaymentControl.ascx" %>
<%@ register tagname="AutoComplete1" tagprefix="xac" src="~/GUI/Fleet/Operations/Issue/AutoComplete1/AMAC.ascx" %>
<%@ register tagname="AutoComplete1V" tagprefix="xac" src="~/GUI/Fleet/Operations/Issue/AutoComplete1/AMACValidation.ascx" %>
<%@ register tagname="AutoComplete" tagprefix="auc" src="~/GUI/Fleet/Operations/Issue/AutoComplete/MAC.ascx" %>
<%@ register tagname="AutoCompleteV" tagprefix="auc" src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACValidation.ascx" %>
<%@ register tagname="AutoComplete" tagprefix="aucD2" src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACD2.ascx" %>
<%@ register tagname="AutoComplete" tagprefix="aucCl" src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACCl.ascx" %>
<%@ register src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" tagname="WebxComplete" tagprefix="xac" %>
<asp:Content ID="Content2" ContentPlaceHolderID="CPHHeader" runat="Server">
    <style type="text/css">
        .ui-dialog-titlebar-close {
            visibility: hidden;
        }
    </style>
</asp:Content>

<asp:content id="Content1" contentplaceholderid="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        var currentuser = '<%=SessionUtilities.CurrentEmployeeID%>';
    </script>
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripGenerate_New.js?vs=<%=System.DateTime.Now.Ticks %>"></script>
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script type="text/javascript">
        var foo = false;
        var styleToSelect;
        function onOk() { }

        function PopUpVehicleView() {
            //<a href="../../../admin/VehicleMaster/VehicleViewPrint.aspx">../../../admin/VehicleMaster/VehicleViewPrint.aspx</a>
            var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
            window.open('../../../admin/VehicleMaster/VehicleViewPrint.aspx?VehicleNo=' + txtVehno.value + '&PrintMode=0', '_blank'
                    , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }

        function PopUpDriverView() {
            //<a href="../../Webadmin/Driver/DriverViewPrint.aspx">../../Webadmin/Driver/DriverViewPrint.aspx</a>
            var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
            window.open('../../Webadmin/Driver/DriverViewPrint.aspx?id=' + txtDriver1.value + '&PrintMode=0', '_blank'
                    , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }


        function popupMeDriver1Lic(strFile) {
            //ctl00_MyCPH1_LblEBill
            //alert(strFile);
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }

        function popupMeDriver1Photo(strFile) {
            //ctl00_MyCPH1_LblEBill
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }

        function popupMeDriver2Lic(strFile) {
            //ctl00_MyCPH1_LblEBill
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }

        function popupMeDriver2Photo(strFile) {
            //ctl00_MyCPH1_LblEBill
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }

        function popupMeCleanerLic(strFile) {
            //ctl00_MyCPH1_LblEBill
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
        }

        function popupMeCleanerPhoto(strFile) {
            //ctl00_MyCPH1_LblEBill
            var mstrFile = document.getElementById("ctl00_MyCPH1_" + strFile).innerText
            //alert("mstrFile:" + mstrFile);
            var mFilePath = "http://182.18.135.201/Webx8.2/UploadedImages/" + mstrFile;
            //var mFilePath="http://124.153.77.48/Nitco35/UploadedImages/" + mstrFile;
            window.open(mFilePath, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=550,status=no,left=220,top=70")
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
        $(document).ready(function () {
            // GetVehicleDetailToValidate();
            $("#divPopUp").dialog({
                title: "Trip sheet on hold",
                autoOpen: false, height: 'auto', width: '600',
                modal: true,
                show: { effect: "blind" },
                hide: { effect: "explode" },
                buttons: {

                    "Request for validate": function () {

                        if (SendVehicleDetailToValidate()) {
                            $('#divPopUp').dialog('close');
                            //$("#ctl00_MyCPH1_tblStep1").attr("disabled", "disabled");
                            //$("#divStep2").attr("style", "display:block");

                        }


                    },
                    "Cancel": function () {
                        $('#divPopUp').dialog('close');
                        CancelVehicle();

                    }
                }
            });

            //if (GetVehicleDetailToValidate()) {
            //    $('#divPopUp').dialog('open');
            //}
            $("#ctl00_MyCPH1_btnStep1").click(function () {

                var tran = document.getElementById('ctl00_MyCPH1_UCPayment_dlsttranstype');
                var chqno = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqNo');
                var chqdate = document.getElementById('ctl00_MyCPH1_UCPayment_txtChqDate');

                var hf_Vehicle_Filter = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Filter");
                var hfAutoManualTsStatus = document.getElementById("ctl00_MyCPH1_hfAutoManualTsStatus");

                var txtManualTripSheetNo = document.getElementById("ctl00_MyCPH1_txtManualTripSheetNo");
                var txtEndLoc = document.getElementById("ctl00_MyCPH1_txtEndLoc");
                var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");

                var CollapsiblePanelExtender2 = document.getElementById("ctl00$MyCPH1$CollapsiblePanelExtender2_ClientState");
                var pnlTripSummaryDet = document.getElementById("ctl00_MyCPH1_pnlTripSummaryDet");
                var lblTripHdrError = document.getElementById("ctl00_MyCPH1_lblTripHdrError");
                var pnlTripSummaryHdr = document.getElementById("ctl00_MyCPH1_pnlTripSummaryHdr");

                var gvFuelSlip = document.getElementById("ctl00_MyCPH1_gvFuelSlip");


                if (txtManualTripSheetNo.value == "") {
                    alert("Please enter Manual Trip Sheet No.");
                    if (pnlTripSummaryHdr.value == "Hide") {
                        txtManualTripSheetNo.focus();
                    }
                    return false;
                }

                if (txtEndLoc != null && txtEndLoc.value == "") {
                    alert("Please enter End Location");
                    //txtEndLoc.focus();
                    return false;
                }




                var txtVehno = document.getElementById("ctl00_MyCPH1_txtVehno");
                if (txtVehno.value.trim() == "") {
                    alert("Please enter vehice number.!");
                    txtVehno.focus();
                    return false;
                }

                var txtDieselCarryForward = document.getElementById("ctl00_MyCPH1_txtDieselCarryForward");
                var txtDieselCarryForwardAmt = document.getElementById("ctl00_MyCPH1_txtDieselCarryForwardAmt");

                if (txtDieselCarryForward != null) {
                    if (txtDieselCarryForward.value == "") {
                        alert("Please enter Diesel Balance Quantity");
                        //txtDieselCarryForward.focus();
                        return false;
                    }
                }

                if (txtDieselCarryForwardAmt != null) {
                    if (txtDieselCarryForwardAmt.value == "") {
                        alert("Please enter Diesel Balance Amount");
                        //txtDieselCarryForwardAmt.focus();
                        return false;
                    }
                }

                var ddlDriver1 = document.getElementById("ctl00_MyCPH1_ddlDriver1");
                var ddlDriver2 = document.getElementById("ctl00_MyCPH1_ddlDriver2");
                var ddlCleaner = document.getElementById("ctl00_MyCPH1_ddlCleaner");

                var txtDriver1 = document.getElementById("ctl00_MyCPH1_txtDriver1");
                var txtDriver1NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver1NotFromRoster");
                var lblDriver1Licno = document.getElementById("ctl00_MyCPH1_lblDriver1Licno");
                var lblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");

                var txtDriver2 = document.getElementById("ctl00_MyCPH1_txtDriver2");
                var txtDriver2NotFromRoster = document.getElementById("ctl00_MyCPH1_txtDriver2NotFromRoster");
                var lblDriver2Licno = document.getElementById("ctl00_MyCPH1_lblDriver2Licno");
                var lblDriver2ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver2ValidDt");

                var txtCleaner = document.getElementById("ctl00_MyCPH1_txtCleaner");
                var txtCleanerNotFromRoster = document.getElementById("ctl00_MyCPH1_txtCleanerNotFromRoster");
                var lblCleanerLicno = document.getElementById("ctl00_MyCPH1_lblCleanerLicno");
                var lblCleanerValidDt = document.getElementById("ctl00_MyCPH1_lblCleanerValidDt");


                if (ddlDriver1.value != "0") {
                    if (ddlDriver1.value == "Y") {
                        if (txtDriver1.value == "") {
                            alert("Please Enter Driver1!!!");
                            //txtDriver1.focus();
                            return false;
                        }
                    }
                    if (ddlDriver1.value == "N") {
                        if (txtDriver1NotFromRoster.value == "") {
                            alert("Please Enter Driver1!!!");
                            //txtDriver1NotFromRoster.focus();
                            return false;
                        }
                        if (lblDriver1Licno.value == "") {
                            //alert("Please Enter License No. of Driver1!!!");
                            //lblDriver1Licno.focus();
                            //return false;
                        }
                        if (lblDriver1ValidDt.value == "") {
                            //alert("Please Enter Valid Upto Date of Driver1!!!");
                            //lblDriver1ValidDt.focus();
                            //return false;
                        }
                        else {
                            var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                            if (isDate(lblDriver1ValidDt.value)) {
                                if (!IsDateGreater(hfTodayDate.value, lblDriver1ValidDt.value)) {
                                    alert("License date must be grater than or equal today's date of Driver1!");
                                    //lblDriver1ValidDt.focus();
                                    return false;
                                }
                            }
                            else {
                                alert("Invalid Date of Driver1");
                                //lblDriver1ValidDt.focus();
                                return false;
                            }
                        }
                    }
                }
                else {
                    alert("Select Driver1 From Roster Y/N!!!")
                    //ddlDriver1.focus();
                    return false;
                }
                //alert(ddlDriver2.value);

                //if (ddlDriver2.value != "0") {

                if (ddlDriver2.value != "0") {
                    if (ddlDriver2.value == "Y") {
                        if (txtDriver2.value == "") {
                            alert("Please Enter Driver2!!!");
                            //txtDriver2.focus();
                            return false;
                        }
                    }
                    if (ddlDriver2.value == "N") {
                        if (txtDriver2NotFromRoster.value == "") {
                            alert("Please Enter Driver2!!!");
                            //txtDriver2NotFromRoster.focus();
                            return false;
                        }
                        if (lblDriver2Licno.value == "") {
                            //alert("Please Enter License No. of Driver2!!!");
                            //lblDriver2Licno.focus();
                            //return false;
                        }
                        if (lblDriver2ValidDt.value == "") {
                            //alert("Please Enter Valid Upto Date of Driver2!!!");
                            //lblDriver2ValidDt.focus();
                            //return false;
                        }
                        else {
                            var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                            if (isDate(lblDriver2ValidDt.value)) {
                                if (!IsDateGreater(hfTodayDate.value, lblDriver2ValidDt.value)) {
                                    alert("License date must be grater than or equal  today's date of Driver2!");
                                    //lblDriver2ValidDt.focus();
                                    return false;
                                }
                            }
                            else {
                                alert("Invalid Date of Driver2!!");
                                //lblDriver2ValidDt.focus();
                                return false;
                            }
                        }
                    }
                }
                else {
                    alert("Select Driver2 From Roster Y/N!!!")
                    //ddlDriver2.focus();
                    return false;
                }

                if (ddlCleaner.value != "0") {
                    if (ddlCleaner.value == "Y") {
                        if (txtCleaner.value == "") {
                            alert("Please Enter Cleaner!!!");
                            //txtCleaner.focus();
                            return false;
                        }
                    }
                    if (ddlCleaner.value == "N") {
                        if (txtCleanerNotFromRoster.value == "") {
                            alert("Please Enter Cleaner!!!");
                            //txtDriver2NotFromRoster.focus();
                            return false;
                        }
                    }
                }
                else {
                    alert("Select Cleaner From Roster Y/N!!!")
                    //ddlCleaner.focus();
                    return false;
                }

                var varlblDriver1ValidDt = document.getElementById("ctl00_MyCPH1_lblDriver1ValidDt");
                if (varlblDriver1ValidDt.value != "") {
                    var hfTodayDate = document.getElementById("ctl00_MyCPH1_hfTodayDate");
                    if (!IsDateGreater(varlblDriver1ValidDt.value, hfTodayDate.value)) {
                        alert("Licence Validity document expired  !!");
                        txtDriver1.focus();
                        return false;
                    }
                }

                if (GetVehicleDetailToValidate()) {

                    $('#divPopUp').dialog('open');
                    return false;
                }

                var ddlTripBIllingSelection = document.getElementById("ctl00_MyCPH1_ddlTripBIllingSelection");
                var txtCustomer = document.getElementById("ctl00_MyCPH1_txtCustomer");

                if (ddlTripBIllingSelection != null || ddlTripBIllingSelection != null) {
                    if (ddlTripBIllingSelection.value == "0" || ddlTripBIllingSelection.value == "") {
                        alert("Select Trip Billing Type!!!");
                        //ddlRouteType.focus();
                        return false;
                    }
                }

                if (txtCustomer != null) {
                    if (txtCustomer.value == "") {
                        alert("Enter Customer!!!");
                        //ddlRouteType.focus();
                        return false;
                    }
                }


                $("#ctl00_MyCPH1_tblStep1").attr("disabled", "disabled");
                $("#divStep2").attr("style", "display:block");
                return false;
            });


        });


    </script>

    <script language="javascript" type="text/javascript">

        var TableFuelSlipShown = "";
        var tblAdvanceEntryShown = "";
        var showRouteOpenShown = "";

        (function pageLoad() {
            //alert("In Doc.Ready");
            $("#ctl00_MyCPH1_C1").hide();
            $("#ctl00_MyCPH1_C2").hide();
            $("#ctl00_MyCPH1_C2_1").hide();
            $("#ctl00_MyCPH1_C3").hide();
            $("#ctl00_MyCPH1_TableRow16").hide();
            $("#ctl00_MyCPH1_TableRowFuelSlip").hide();
            $("#ctl00_MyCPH1_TableRow11").hide();
            //$("#ctl00_MyCPH1_TableRow12").hide();
            $("#ctl00_MyCPH1_TableRow13").hide();

            if (showRouteOpenShown != "true" && showRouteOpenShown == "") {
                $('#ctl00_MyCPH1_txtRouteType1').hide();
                $('#ctl00_MyCPH1_txtRouteType2').hide();
                $('#ctl00_MyCPH1_txtRouteType3').hide();
                $('#ctl00_MyCPH1_txtRouteType4').hide();
            }



            if (tblAdvanceEntryShown != "true" && tblAdvanceEntryShown == "") {
                //alert('In Page Load tblAdvanceEntryShown:'+tblAdvanceEntryShown);
                $('#ctl00_MyCPH1_tblAdvanceEntry').hide();
            }

            if (TableFuelSlipShown != "true" && TableFuelSlipShown == "") {
                //alert('In Page Load TableFuelSlipShown:' + TableFuelSlipShown);
                $('#ctl00_MyCPH1_TableFuelSlip').hide();
            }
        })();
    </script>

    <script language="javascript" type="text/javascript">

        function showtblAdvanceEntry() {
            var checkbox = $("#ctl00_MyCPH1_chkbxAdvacneDetails");
            checkbox.change(function (event) {
                var checkbox = event.target;
                if (checkbox.checked) {
                    tblAdvanceEntryShown = "true";
                    $('#ctl00_MyCPH1_tblAdvanceEntry').show();
                    // alert('In Func tblAdvanceEntryShown:' + tblAdvanceEntryShown);

                } else {
                    $('#ctl00_MyCPH1_tblAdvanceEntry').hide();
                }
            });
        }



        function showTableFuelSlip() {
            var checkbox = $("#ctl00_MyCPH1_chkbxFuelSlipEntry");
            checkbox.change(function (event) {
                var checkbox = event.target;
                if (checkbox.checked) {
                    TableFuelSlipShown = "true";
                    $('#ctl00_MyCPH1_TableFuelSlip').show();
                    //alert('In Func TableFuelSlipShown:' + TableFuelSlipShown);

                } else {
                    $('#ctl00_MyCPH1_TableFuelSlip').hide();
                }
            });
        }

        function showRouteOpen() {
            $('#ctl00_MyCPH1_ddlRouteType').change(function () {
                if ($(this).val() == '02') {
                    $('#ctl00_MyCPH1_txtRouteType1').show();
                    $('#ctl00_MyCPH1_txtRouteType2').show();
                    $('#ctl00_MyCPH1_txtRouteType3').show();
                    $('#ctl00_MyCPH1_txtRouteType4').show();
                    $('#ctl00_MyCPH1_ddlRouteName').hide();
                    showRouteOpenShown = "true";
                }

                if ($(this).val() == '01') {
                    $('#ctl00_MyCPH1_txtRouteType1').hide();
                    $('#ctl00_MyCPH1_txtRouteType2').hide();
                    $('#ctl00_MyCPH1_txtRouteType3').hide();
                    $('#ctl00_MyCPH1_txtRouteType4').hide();
                    $('#ctl00_MyCPH1_ddlRouteName').show();
                }
            });
        }

    </script>


    <%--VALIDATION: DATA NOT FROM MASTERS--%>
    <script type="text/javascript">
        function Location_Blur(Obj, Mode) {
            if (Obj.value == "") {
                return false;
            }
            var Search_Char = "~"
            if (Obj.value.indexOf(Search_Char) == -1) {
                alert("Invalid " + Mode + " Name ~ Code Format");
                Obj.focus();
                return false
            }
        }

        function City_Blur(Obj, Mode) {
            if (Obj.value == "") {
                return false;
            }
            var Search_Char = ":"
            if (Obj.value.indexOf(Search_Char) == -1) {
                alert("Invalid " + Mode + " Name : Code Format");
                Obj.focus();
                return false
            }
        }
        function ValidateSubmit() {
            $("#ctl00_MyCPH1_tblStep1").prop("disabled", false);            
            $('input[type=text][name$=txtamounttotal]').prop("disabled", false);                                  
        }
    </script>

    <%--VALIDATION: AMOUNT--%>
    <script type="text/javascript">
        function Amount_Alert(ctrl) {

            //var amt = $('#ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt').val();
            var amt = $(ctrl).val();

            if (amt != "") {
                if (confirm('Do you want to give Rs ' + amt)) {
                    return true;
                }
                else {
                    //$('#ctl00_MyCPH1_dgAdvanceDet_ctl02_txtAdvAmt').val("");
                    $(ctrl).val("");
                    return false;
                }
            }
        }


         <%--VALIDATION: AMOUNT ONLY NUMBERS--%>
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
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
    <%-- <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel9">
        <ContentTemplate>--%>
    <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="1000px">
        <asp:TableRow Style="background-color: white">
            <asp:TableCell HorizontalAlign="left" Width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="TRIP SHEET >> ISSUE NEW WITHOUT REQUEST" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <br />
    <asp:Table ID="tblStep1" CellSpacing="1" CellPadding="3" runat="server" class="boxbg" Width="1000px" BorderWidth="0">
        <asp:TableRow Style="background-color: white">
            <asp:TableCell>
                <table cellspacing="1" class="boxbg" border="0" width="1000px">
                    <tr class="bgbluegrey">
                        <td width="80%">
                            <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">TRIPSHEET SUMMARY</asp:Label>
                        </td>
                        <%-- <td width="5%">
                                    <asp:Panel ID="pnlTripSummaryHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblTripHdrError" runat="server" Font-Bold="True" Visible="false">Show...</asp:Label>
                                    </asp:Panel>
                                </td>--%>
                    </tr>
                </table>
                <table cellspacing="1" align="center">
                    <tr align="center">
                        <td align="left">
                            <asp:Panel ID="pnlTripSummaryDet" runat="server">
                                <asp:Table ID="Table3" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                    class="boxbg" Width="1000px" BorderWidth="0">
                                    <asp:TableRow ID="tblTripSummaryHdr" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Trip Sheet No.</font> </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class=blackfnt color="red">< System generated ></font> </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <font class="blackfnt" color="red">*</font> <font class="bluefnt">Trip Sheet Date &
                                                        Time</font>
                                            <asp:HiddenField ID="hfFinancialYr" runat="server" />
                                            <asp:HiddenField ID="hfAutoManualTsStatus" runat="server" />
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:UpdatePanel
                                                            ID="UpdatePanel23" runat="server" RenderMode="Inline" UpdateMode="Always">
                                                            <ContentTemplate>
                                                                <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10"
                                                                    Width="60px"></asp:TextBox><ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt"
                                                                        Format="dd/MM/yyyy" TargetControlID="txtDate" runat="server" />
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                    <td>
                                                        <MKB:TimeSelector ID="TimeSelector1" runat="server" DisplaySeconds="false" CssClass="input">
                                                        </MKB:TimeSelector>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblError" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow1" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left"> 
                                                <font class="bluefnt">Manual Trip Sheet No.</font> </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtManualTripSheetNo" runat="server" BorderStyle="Groove" Width="100"
                                                    MaxLength="50" CssClass="input" /><%--OnTextChanged="Check_ManualTripSheetNo"  AutoPostBack=true--%>
                                                <asp:RequiredFieldValidator ID="ReqManualTripSheetNo" ControlToValidate="txtManualTripSheetNo"
                                                    runat="server" Display="Dynamic" Text="!" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                <asp:Label ID="lbl_Manual_TS_Err" runat="server" CssClass="balckfnt" ForeColor="Red"></asp:Label>
                                                <asp:UpdatePanel
                                                    ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:Label ID="lblMTS" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="txtManualTripSheetNo" EventName="TextChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </font>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <%--******************** COMMENTED C1 ***********************--%>

                                    <asp:TableRow ID="C1" Style="background-color: white">
                                        <asp:TableCell HorizontalAlign="left">
                                                <font class="bluefnt">Start Location</font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left">
                                            <font class="bluefnt">
                                                <asp:TextBox ID="txtStartLoc1" runat="server" BorderStyle="None" Width="50" MaxLength="5"
                                                    ReadOnly="true"></asp:TextBox>
                                                <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                                                <asp:HiddenField ID="hfAttached" runat="server" Value="" />
                                                <asp:HiddenField ID="hdndieselCF" runat="server" />
                                            </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left">
                                                
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left">
                                            <font class="bluefnt">
                                                
                                            </font>
                                        </asp:TableCell>
                                    </asp:TableRow>

                                    <%--******************* ADDED  1 ***********************--%>
                                    <asp:TableRow Style="background-color: white">
                                        <asp:TableCell HorizontalAlign="left">
                                                <font class="bluefnt">Fleet Centre</font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" ColumnSpan="1">
                                            <font class="bluefnt">
                                                <asp:Label ID="txtStartLoc" runat="server" BorderStyle="None" Width="50" MaxLength="5"
                                                    ReadOnly="true"></asp:Label>
                                                <asp:HiddenField ID="HiddenField1" Value="" runat="server" />
                                                <asp:HiddenField ID="HiddenField2" runat="server" Value="" />
                                                <asp:HiddenField ID="HiddenField3" runat="server" />
                                            </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left">
                                                 <font class="blackfnt" color="red">*</font> <font class="bluefnt">End Location</font>  
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left">
                                            <div runat="server" id="dvEndLoc">
                                                <font class="bluefnt">
                                                    <asp:TextBox ID="txtEndLoc" runat="server" BorderStyle="Groove" Width="50" MaxLength="5"
                                                        CssClass="input" OnTextChanged="CheckLocation" AutoPostBack="true"></asp:TextBox>
                                                    <input id="btnPopupLoc" type="button" value="..." name="custpup12" runat="server" />
                                                    <asp:UpdatePanel ID="UpdatePanelEndLoc" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <asp:Label ID="LblLocError" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="txtEndLoc" EventName="TextChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                    <%--  <asp:RequiredFieldValidator ID="ReqEndLoc" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtEndLoc" ValidationGroup="main"></asp:RequiredFieldValidator>--%>
                                                </font>
                                            </div>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <%--**************************************************--%>
                                </asp:Table>
                            </asp:Panel>
                            <%--  <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server"
                                        TargetControlID="pnlTripSummaryDet" Collapsed="false" ExpandControlID="pnlTripSummaryHdr"
                                        CollapseControlID="pnlTripSummaryHdr" AutoCollapse="False" TextLabelID="lblTripHdrError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />--%>
                        </td>
                    </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow Style="background-color: white">
            <asp:TableCell>
                <table cellspacing="1" class="boxbg" border="0" width="1000px">
                    <tr class="bgbluegrey">
                        <td width="80%">
                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Vehicle Details</asp:Label>
                        </td>
                        <td width="5%">
                            <asp:Label ID="lblVehiclePopup" runat="server" Font-Bold="True" onclick="PopUpVehicleView();" >View</asp:Label>
                        </td>
                        <%-- <td width="5%">
                                    <asp:Panel ID="pnlVehicleHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblVehicleError" runat="server" Font-Bold="True" Visible="false">Show...</asp:Label>
                                    </asp:Panel>
                                </td>--%>
                    </tr>
                </table>
                <table cellspacing="1" align="center">
                    <tr align="center">
                        <td align="left">
                            <asp:Panel ID="pnlVehicleDet" runat="server">
                                <asp:Table ID="tblVehicleHdr" CellSpacing="1" CellPadding="3" runat="server"
                                    class="boxbg" Width="1000px" BorderWidth="0">
                                    <asp:TableRow ID="TableRow2" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Select Vehicle No.</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtVehno" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10"
                                                        Width="75px"></asp:TextBox>
                                                    <asp:TextBox ID="txtVehno_Name" Style="display: none" runat="server" CssClass="input" onfocus="this.blur()"
                                                        Width="100px" BorderStyle="Groove" ReadOnly="true"></asp:TextBox><br />
                                                    <xac:AutoComplete1V ID="xacVehicle" runat="server" WebxEntity="VehicleValidation"
                                                        CodeTarget="txtVehno" MinPrefixLength="2" NameTarget="txtVehno_Name" />
                                                    <asp:HiddenField ID="hfVehicleLocation" runat="server" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <%--<font class="blackfnt" color="red">*</font>--%> <font class="bluefnt">Model </font>
    
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehModel" runat="server" BorderStyle="None" MaxLength="10" onfocus="this.blur()"
                                                Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                         <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="bluefnt"> </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow3" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Category</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehCategory" runat="server" BorderStyle="None" MaxLength="10"
                                                onfocus="this.blur()" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <%--<font class="blackfnt" color="red">*</font>--%> <font class="bluefnt">Capacity </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehCapacity" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                MaxLength="10" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="bluefnt"> </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow4" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Opening KM</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehOpnKM" BorderStyle="Groove" CssClass="input" runat="server" MaxLength="10"
                                                Width="100px" onkeypress="return isNumber(event)" onblur="Javascript:return SetVehicleOpeningKM();"></asp:TextBox>
                                            <asp:HiddenField ID="hfVehOpnKM" runat="server" />
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <%--<font class="blackfnt" color="red">*</font> --%><font class="bluefnt">Opening Fuel (LTRS) </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehOpnFuel" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                MaxLength="10" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="bluefnt"> </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <%-- ************** C2 *****************--%>
                                    <asp:TableRow ID="TableRow5" Style="background-color: white" runat="server">
                                        <asp:TableCell ID="C2" HorizontalAlign="left" Width="200px"> <font class="bluefnt">Vendor Name</font> 
                                        </asp:TableCell>
                                        <asp:TableCell ID="C2_1" HorizontalAlign="left">
                                            <asp:TextBox ID="txtVendorName" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        <%-- ************** C2 *****************--%>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                <%--<font class="blackfnt" color="red">*</font>--%> <font class="bluefnt">Opening Fuel Amount </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehOpnFuelAmt" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                MaxLength="10" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                         <%-- ************** C2 *****************--%>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                <%--<font class="blackfnt" color="red">*</font>--%> <font class="bluefnt">Opening Add Blue(LTRS) </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehOpnAddBlue" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                MaxLength="10" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow18" Style="background-color: white" runat="server">                                      
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                <%--<font class="blackfnt" color="red">*</font>--%> <font class="bluefnt">Opening Add Blue Amount </font>
                                        </asp:TableCell>
                                        <asp:TableCell ColumnSpan="3" HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtVehOpnAddBlueAmt" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                MaxLength="10" Width="200px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="bluefnt"> </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="ROW_DIESEL_BALANCE" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Diesel Balance Qty. (in Ltr)</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtDieselCarryForward" MaxLength="25" runat="server" Style="text-align: right"
                                                BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </asp:TableCell>
                                        <%-- ************** C3 *****************--%>
                                        <asp:TableCell ID="C3" HorizontalAlign="left" Width="200px">
                                            <font class="blackfnt" color="red">*</font> <font class="bluefnt">Diesel Balance Amount </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtDieselCarryForwardAmt" MaxLength="25" runat="server" Style="text-align: right"
                                                BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow16" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Vehicle Checklist</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                            <div class="demoarea">
                                                <asp:LinkButton ID="lnkCheckList" runat="server" Text="Click Here For CheckList" />
                                                <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender" runat="server" TargetControlID="lnkCheckList"
                                                    PopupControlID="Panel6" BackgroundCssClass="modalBackground" OkControlID="OkButton"
                                                    OnOkScript="onOk()" DropShadow="true" PopupDragHandleControlID="Panel3" />
                                            </div>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="bluefnt"> </font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow runat="server" ID="TableRowFuelSlip" Style="background-color: white">
                                        <asp:TableCell HorizontalAlign="left"> <%--<font class="blackfnt" color="red">*</font>--%>
                                                     <font class="bluefnt">Fuel slip provided</font>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                            <asp:UpdatePanel ID="UpdatePanel12" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:CheckBox ID="chkFuelSlipFlag" runat="server" AutoPostBack="true" OnCheckedChanged="chkFuelSlipFlag_CheckedChanged" />
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="chkFuelSlipFlag" EventName="CheckedChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:Panel>
                            <%-- <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                        TargetControlID="pnlVehicleDet" Collapsed="false" ExpandControlID="pnlVehicleHdr"
                                        CollapseControlID="pnlVehicleHdr" AutoCollapse="False" TextLabelID="lblVehicleError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />--%>
                        </td>
                    </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow ID="TableRow16436" Style="background-color: white" runat="server">
            <asp:TableCell>
                <table cellspacing="1" class="boxbg" border="0" width="1000px">
                    <tr class="bgbluegrey">
                        <td width="80%">
                            <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Driver Details</asp:Label>
                        </td>
                         <td width="5%">
                            <asp:Label ID="lblDriverView" runat="server" Font-Bold="True" onclick="PopUpDriverView();" >View</asp:Label>
                        </td>
                        <%-- <td width="5%">
                                    <asp:Panel ID="pnlDriverHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblDriverError" runat="server" Font-Bold="True" Visible="false">Show...</asp:Label>
                                    </asp:Panel>
                                </td>--%>
                    </tr>
                </table>
                <table cellspacing="1" align="center">
                    <tr align="center">
                        <td align="left">
                            <asp:Panel ID="pnlDriverDet" runat="server">
                                <asp:Table ID="Table4" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                    class="boxbg" Width="1000px" BorderWidth="0">
                                    <asp:TableRow ID="TableRow7" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">From Roster</font> 
                                        
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlDriver1" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlDriver1_SelectedIndexChanged">
                                                        <asp:ListItem Text="--Select--" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                                        <asp:ListItem Text="N" Value="N"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlDriver2" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlDriver2_SelectedIndexChanged">
                                                        <asp:ListItem Text="--Select--" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                                        <asp:ListItem Text="N" Value="N"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlCleaner" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlDriver3_SelectedIndexChanged">
                                                        <asp:ListItem Text="--Select--" Value="0" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Y" Value="Y"></asp:ListItem>
                                                        <asp:ListItem Text="N" Value="N"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow15" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Driver Type</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="TextBox1" runat="server" Style="text-align: left" BorderStyle="None"
                                                Width="150px" onfocus="this.blur()" Text="Driver1" Font-Bold="true"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="TextBox2" runat="server" Style="text-align: left" BorderStyle="None"
                                                Width="150px" onfocus="this.blur()" Text="Driver2" Font-Bold="true"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="TextBox3" runat="server" Style="text-align: left" BorderStyle="None"
                                                Width="150px" onfocus="this.blur()" Text="Cleaner" Font-Bold="true"></asp:TextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>

                                    <asp:TableRow ID="TableRow8" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Select Driver</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel16" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtDriver1" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                                        Width="75px"></asp:TextBox>
                                                    <asp:TextBox ID="txtDriver1Name" runat="server" CssClass="bgwhite"
                                                        Width="100px" BorderStyle="Groove"></asp:TextBox>
                                                    <%--<asp:TextBox ID="TextBox4" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                        Width="100px" BorderStyle="Groove"></asp:TextBox>--%>
                                                    <br />
                                                    <asp:TextBox ID="txtDriver1NotFromRoster" runat="server" BorderStyle="Groove" Enabled="false"
                                                        CssClass="input" Width="150px" Visible="false"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDriver1ID" runat="Server" Value="" />
                                                    <%--<xac:WebxComplete ID="xacDriver" MinPrefixLength="2" WebxEntity="Driver" runat="server"
                                                        CodeTarget="txtDriver1" NameTarget="txtDriver1Name" />--%>
                                                    <auc:AutoCompleteV ID="aucDriver" MinPrefixLength="1" runat="server" WebxEntity="DriverValidation"
                                                        CodeTarget="txtDriver1" NameTarget="txtDriver1Name" />
                                                    <asp:HiddenField ID="hf_Manual_Driver1_Code" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_Photo" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_photo_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriverLic_Validity" runat="server" />
                                                    <asp:HiddenField ID="hfDriverLic_Validity_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_TripCount" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_TripCount_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfTot_No_Trip" runat="server" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel9" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtDriver2" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                                        Width="75px"></asp:TextBox>
                                                    <asp:TextBox ID="txtDriver2Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                        Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                                    <asp:TextBox ID="txtDriver2NotFromRoster" runat="server" BorderStyle="Groove" Enabled="false"
                                                        CssClass="input" Width="150px" Visible="false"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDriver2ID" runat="Server" Value="" />
                                                    <aucD2:AutoComplete ID="AutoComplete1" MinPrefixLength="1" runat="server" WebxEntity="Driver"
                                                        CodeTarget="txtDriver2" NameTarget="txtDriver2Name" />
                                                    <asp:HiddenField ID="hfDriver2_photo_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriver2Lic_Validity_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriver2_Mandetory_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriver2_With_LocationFilter_Rule" runat="server" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="txtCleaner" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                                Width="60px"></asp:TextBox>
                                            <asp:TextBox ID="txtCleanerName" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                BorderStyle="Groove"></asp:TextBox><br />
                                            <asp:TextBox ID="txtCleanerNotFromRoster" runat="server" BorderStyle="Groove" Enabled="false"
                                                MaxLength="10" CssClass="input" Width="150px" Visible="false"></asp:TextBox>
                                            <aucCl:AutoComplete ID="AutoComplete2" MinPrefixLength="1" runat="server" WebxEntity="Driver"
                                                CodeTarget="txtCleaner" NameTarget="txtCleanerName" />
                                            <asp:HiddenField ID="hfCleaner_Mandetory_Rule" runat="server" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow9" Style="background-color: white; display: none;" runat="server">

                                        <asp:TableCell HorizontalAlign="left" Width="200px" Style="display: none;"> <font class="bluefnt">License no.</font> 
                                        </asp:TableCell>
                                        <%--<asp:TableCell HorizontalAlign="left" Width="200px">
                                                </asp:TableCell>--%>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel17" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblDriver1Licno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        Width="150px"></asp:TextBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel18" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblDriver2Licno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        Width="150px"></asp:TextBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel19" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblCleanerLicno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        onfocus="this.blur()" Width="150px"></asp:TextBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>


                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow10" Style="background-color: white;" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Valid upto date</font> 
                                        </asp:TableCell>
                                        <%--<asp:TableCell HorizontalAlign="left" Width="200px">
                                                </asp:TableCell>--%>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel20" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblDriver1ValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        Width="150px"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" TargetControlID="lblDriver1ValidDt"
                                                        runat="server" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel21" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblDriver2ValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        Width="150px"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender4" Format="dd/MM/yyyy" TargetControlID="lblDriver2ValidDt"
                                                        runat="server" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:UpdatePanel ID="UpdatePanel22" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="lblCleanerValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        onfocus="this.blur()" Width="150px" Style="display: none;"></asp:TextBox>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                    </asp:TableRow>

                                    <%--******************** Commented **********************--%>

                                    <asp:TableRow ID="TableRow11" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">View</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <a href="javascript:popupMeDriver1Lic('lblDriver1LicView')">
                                                <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="always">
                                                    <ContentTemplate>
                                                        <asp:Label ID="lblDriver1LicView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                            Text="" Font-Underline="true"></asp:Label>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </a>| <a href="javascript:popupMeDriver1Photo('lblDriver1PhotoView')">
                                                <asp:UpdatePanel ID="UpdatePanel11" runat="server" RenderMode="Inline" UpdateMode="always">
                                                    <ContentTemplate>
                                                        <asp:Label ID="lblDriver1PhotoView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                            Text="" Font-Underline="true"></asp:Label>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </a>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <a href="javascript:popupMeDriver2Lic('LblDLiscense')">
                                                <asp:Label ID="lblDriver2LicView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                    Text="" Font-Underline="true"></asp:Label></a> | <a href="javascript:popupMeDriver2Photo('LblDLiscense')">
                                                        <asp:Label ID="lblDriver2PhotoView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                            Text="" Font-Underline="true"></asp:Label></a>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <a href="javascript:popupMeCleanerLic('LblDLiscense')">
                                                <asp:Label ID="lblCleanerLicView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                    Text="" Font-Underline="true"></asp:Label></a> | <a href="javascript:popupMeCleanerPhoto('LblDLiscense')">
                                                        <asp:Label ID="lblCleanerPhotoView" runat="server" CssClass="blackfnt" Font-Bold="true"
                                                            Text="" Font-Underline="true"></asp:Label></a>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow12" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Driver Balance Amount</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="LblDriverBalance" runat="server" BorderStyle="None" MaxLength="10"
                                                onfocus="this.blur()" Width="150px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="TextBox20" Style="display: none" runat="server" BorderStyle="None" Text="NA" MaxLength="10"
                                                onfocus="this.blur()" Width="150px"></asp:TextBox>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <asp:TextBox ID="TextBox22" Style="display: none" runat="server" BorderStyle="None" Text="NA" MaxLength="10"
                                                onfocus="this.blur()" Width="150px"></asp:TextBox>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="TableRow13" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Advance to be paid</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px" ColumnSpan="3">
                                            <asp:UpdatePanel ID="UpdatePane7" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:CheckBox ID="chkAdvanceFlag" runat="server" AutoPostBack="true" OnCheckedChanged="chkAdvanceFlag_CheckedChanged" />
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="chkAdvanceFlag" EventName="CheckedChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <%--*************************************************************--%>
                                </asp:Table>
                            </asp:Panel>
                            <%--  <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                                        TargetControlID="pnlDriverDet" Collapsed="false" ExpandControlID="pnlDriverHdr"
                                        CollapseControlID="pnlDriverHdr" AutoCollapse="False" TextLabelID="lblDriverError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />--%>
                        </td>
                    </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow Style="background-color: white" ID="tblTripBilling" runat="server">
            <asp:TableCell>
                <table cellspacing="1" class="boxbg" border="0" width="1000px">
                    <tr class="bgbluegrey">
                        <td width="80%">
                            <asp:Label ID="lbllablel444" CssClass="blackfnt" Font-Bold="true" runat="server"
                                Width="500px">Trip Billing Selection</asp:Label>
                        </td>
                        <%--  <td width="5%">
                                    <asp:Panel ID="pnlTripSelectionHdr" runat="server" Width="25px">
                                        <asp:Label ID="pnlTripSelectionError" runat="server" Font-Bold="True" Visible="false">Show...</asp:Label>
                                    </asp:Panel>
                                </td>--%>
                    </tr>
                </table>
                <table cellspacing="1" align="center">
                    <tr align="center">
                        <td align="left">
                            <asp:Panel ID="pnlTripSelectionDet" runat="server">
                                <asp:Table ID="Table8" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                    class="boxbg" Width="1000px" BorderWidth="0">
                                    <asp:TableRow ID="TableRow17" Style="background-color: white" runat="server">
                                        <asp:TableCell HorizontalAlign="left" Width="120px"> <font class="bluefnt">Billing Type Available</font> 
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="60px">
                                            <asp:UpdatePanel ID="UpdatePanel14" runat="server" RenderMode="Inline" UpdateMode="always">
                                                <ContentTemplate>
                                                    <asp:DropDownList ID="ddlTripBIllingSelection" AutoPostBack="true" runat="server"
                                                        OnSelectedIndexChanged="ddlTripBIllingSelection_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell1" runat="server"
                                            Visible="true">
                                            <font class="blackfnt" color="red">*</font>
                                            <asp:Label ID="Label12" class="bluefnt" runat="server" Text="Enter Customer Details :"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell HorizontalAlign="left" ID="TableCell2" runat="server">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtCustomer" runat="server" TabIndex="1" MaxLength="10" onblur="javascript:return partyTest('csgn',this.getAttribute('id'))"
                                                            Width="100px" CssClass="ltxtm" autocomplete="off"></asp:TextBox>-<asp:TextBox ID="txtCustomerName"
                                                                Width="150px" CssClass="ltxtm" runat="server" Enabled="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <xac:WebxComplete ID="xaccsgn" NameTarget="txtCustomerName" MinPrefixLength="2" WebxEntity="Customer"
                                                            runat="server" CodeTarget="txtCustomer" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:Panel>
                            <%-- <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender622" runat="Server"
                                        TargetControlID="pnlTripSelectionDet" Collapsed="false" ExpandControlID="pnlTripSelectionHdr"
                                        CollapseControlID="pnlTripSelectionHdr" AutoCollapse="False" TextLabelID="pnlTripSelectionError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />--%>
                        </td>
                    </tr>
                </table>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow class="bgbluegrey">
            <asp:TableCell HorizontalAlign="Center">
                <asp:Button ID="btnStep1" runat="server" Text="Step 1 >>" ValidationGroup="main" />
            </asp:TableCell>
        </asp:TableRow>


    </asp:Table>
    <div style="display: none" id="divStep2">
        <asp:Table ID="tblStep2" runat="server">
            <asp:TableRow Style="background-color: white">
                <asp:TableCell>
                    <table cellspacing="1" class="boxbg" border="0" width="1000px">
                        <tr class="bgbluegrey">
                            <td width="80%">
                                <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Route Selection</asp:Label>
                            </td>
                            <%-- <td width="5%">
                                    <asp:Panel ID="pnlRouteSelectionHdr" runat="server" Width="25px">
                                        <asp:Label ID="pnlRouteSelectionError" runat="server" Font-Bold="True" Visible="false">Show...</asp:Label>
                                    </asp:Panel>
                                </td>--%>
                        </tr>
                    </table>
                    <table cellspacing="1" align="center">
                        <tr align="center">
                            <td align="left">
                                <asp:Panel ID="pnlRouteSelectionDet" runat="server">
                                    <asp:Table ID="Table5" CellSpacing="1" CellPadding="3" runat="server"
                                        class="boxbg" Width="1000px" BorderWidth="0">
                                        <asp:TableRow ID="TableRow14" Style="background-color: white" runat="server">
                                            <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Route Type</font> 
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="200px">
                                                <asp:UpdatePanel ID="UpdatePanel6" runat="server" RenderMode="Inline" UpdateMode="always">
                                                    <ContentTemplate>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlRouteType" runat="server" onchange="showRouteOpen()">
                                                                        <asp:ListItem Value="01" Text="Fixed"></asp:ListItem>
                                                                        <asp:ListItem Value="02" Text="Open"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:Label ID="lblRouteError" runat="server" Text=""></asp:Label>
                                                                </td>
                                                                <td visible="false">
                                                                    <asp:DropDownList ID="ddlRouteName" runat="server" Width="200px" CssClass="input">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>

                                                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtRouteType1" BorderStyle="Groove" CssClass="input" />
                                                                        <ajaxToolkit:AutoCompleteExtender ID="Extender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType1">
                                                                        </ajaxToolkit:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtRouteType2" BorderStyle="Groove" CssClass="input" />
                                                                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType2">
                                                                        </ajaxToolkit:AutoCompleteExtender>
                                                                    </td>

                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtRouteType3" BorderStyle="Groove" CssClass="input" />
                                                                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType3">
                                                                        </ajaxToolkit:AutoCompleteExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox runat="server" ID="txtRouteType4" BorderStyle="Groove" CssClass="input" />
                                                                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType4">
                                                                        </ajaxToolkit:AutoCompleteExtender>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </asp:TableCell>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="200px" ID="tblTripRouteHdr" runat="server"
                                                Visible="false">
                                                <font class="blackfnt" color="red">*</font>
                                                <asp:Label ID="Label11" class="bluefnt" runat="server" Text="Select Trip Route :"></asp:Label>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" ID="tblTripRouteDet" runat="server" Visible="false">
                                                <asp:UpdatePanel ID="UpdatePanel8" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlRoute" runat="server" Width="200px">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlRouteType" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:Panel>
                                <%-- <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender5" runat="Server"
                                        TargetControlID="pnlRouteSelectionDet" Collapsed="false" ExpandControlID="pnlRouteSelectionHdr"
                                        CollapseControlID="pnlRouteSelectionHdr" AutoCollapse="False" TextLabelID="pnlRouteSelectionError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />--%>
                            </td>
                        </tr>
                    </table>
                    
                    <table cellspacing="1" class="boxbg" border="0" width="1000px">
                        <tr style="background-color: white">
                            <td width="30%" >
                                <asp:Label ID="Label7" CssClass="blackfnt" Font-Bold="true" runat="server" >CheckList</asp:Label>
                            </td>
                            <td >
                            <asp:FileUpload runat="server" id="fileUploadCheckList"></asp:FileUpload>
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="tblrwAdvanceDetail" Style="background-color: white" runat="server">
                <asp:TableCell>
                    <table cellspacing="1" class="boxbg" border="0" width="1000px">
                        <tr class="bgbluegrey">
                            <td width="75%">
                                <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Advance to be Paid</asp:Label>
                            </td>
                            <td width="5%">
                                <asp:CheckBox ID="chkbxAdvacneDetails" onclick="showtblAdvanceEntry()" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="tblAdvanceEntry" Style="background-color: white" runat="server">
                <asp:TableCell>
                    <%-- <table cellspacing="1" class="boxbg" border="0" width="1000px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label9" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Advance Details</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlAdvanceHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblAdvanceError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>--%>
                    <table cellspacing="1" align="center">
                        <tr align="center">
                            <td align="left">
                                <asp:Panel ID="pnlAdvanceDet" runat="server">
                                    <asp:Table ID="tbl_Driver_Adv" runat="server" CellSpacing="1" CellPadding="3" Style="width: 1000px" class="boxbg" border="0">
                                        <asp:TableRow CssClass="bgbluegrey" Style="background-color: white">
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                                <font class="blackfnt"><b>Details of Advance Taken</b></font>

                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow CssClass="bgbluegrey" Style="background-color: white">

                                            <asp:TableCell HorizontalAlign="left" Width="20%">
                                                                            <font class="blackfnt">Enter no. of rows</font>
                                            </asp:TableCell>
                                            <asp:TableCell ColumnSpan="3" HorizontalAlign="left">
                                                <asp:UpdatePanel ID="UpdatePanel15" runat="server" UpdateMode="Always" RenderMode="Inline">
                                                    <ContentTemplate>
                                                        <asp:TextBox ID="txtAddAdvanceRow" runat="server" Text="1" MaxLength="3" Width="30"
                                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))" BorderStyle="Groove"
                                                            OnTextChanged="Add_RowAdvance" AutoPostBack="true"></asp:TextBox>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:UpdatePanel ID="UpdatePanelpayment" runat="server" UpdateMode="Always">
                                                            <ContentTemplate>
                                                                <asp:Label ID="lbl_dgAdvanceDet_Err" CssClass="redfnt" runat="server" Text=""></asp:Label>
                                                                <asp:GridView ID="dgAdvanceDet" OnRowDataBound="dgAdvanceDet_RowDataBound" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                                    CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                                    BorderWidth="3px" Width="1000px">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Sr.No.">
                                                                            <ItemTemplate>
                                                                                <center>
                                                                                    <%#Container.DataItemIndex + 1%>
                                                                                </center>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="System Date">
                                                                            <ItemTemplate>
                                                                                <center>
                                                                                    <%= DateTime.Now.ToString("dd MMM yyyy")%>
                                                                                </center>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Place">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtAdvPlace" CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"AdvPlace") %>' runat="server" Width="150px" BorderStyle="Groove"
                                                                                    MaxLength="50"></asp:TextBox>

                                                                                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                                    ServiceMethod="Get_CityNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtAdvPlace">
                                                                                </ajaxToolkit:AutoCompleteExtender>

                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Advance Date (dd/mm/yyyy)">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtAdvDt" CssClass="input" onblur="CheckAdvDt()" Text='<%# DataBinder.Eval(Container.DataItem,"AdvDt") %>' runat="server"
                                                                                    MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtAdvDt"
                                                                                    runat="server" />
                                                                                <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtAdvDt"
                                                                                    ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                                                    Width="1px"></asp:RegularExpressionValidator>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Mode">
                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlMode" OnSelectedIndexChanged="ddlMode_SelectedIndexChanged" AutoPostBack="true" runat="server" Width="200px" Style="text-align: left"
                                                                                    BorderStyle="Groove">
                                                                                    <asp:ListItem Text="-Select-" Value="0"></asp:ListItem>
                                                                                    <%--<asp:ListItem Value="1" Text="Cash"></asp:ListItem>--%>
                                                                                    <asp:ListItem Value="2" Text="Happay"></asp:ListItem>
                                                                                    <asp:ListItem Value="3" Text="Bank"></asp:ListItem>
                                                                                </asp:DropDownList>
                                                                                <asp:HiddenField runat="server" ID="hdnMode" Value='<%# DataBinder.Eval(Container.DataItem,"Mode") %>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Account Name">
                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                            <ItemTemplate>
                                                                                <asp:DropDownList ID="ddlAcount" OnSelectedIndexChanged="ddlAcount_SelectedIndexChanged" AutoPostBack="true" runat="server" Width="200px" Style="text-align: left"
                                                                                    BorderStyle="Groove">
                                                                                </asp:DropDownList>
                                                                                <asp:HiddenField runat="server" ID="hdnBankAccount" Value='<%# DataBinder.Eval(Container.DataItem,"Account") %>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Amount">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtAdvAmt" CssClass="input" onkeypress="return isNumber(event)" Text='<%# DataBinder.Eval(Container.DataItem,"AdvAmt") %>' onblur="FillPaymentAmt(this); Amount_Alert(this);" runat="server"
                                                                                    Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                                <%--OnTextChanged="PopulateAdvamt"  AutoPostBack="true"--%>
                                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                                    SetFocusOnError="true" ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Reference No">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtRefNo" CssClass="input" onkeypress="return isNumber(event)" Text='<%# DataBinder.Eval(Container.DataItem,"RefNo") %>' runat="server"
                                                                                    Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                                <%--OnTextChanged="PopulateAdvamt"  AutoPostBack="true"--%>
                                                                                <asp:RegularExpressionValidator ID="RegAdvAmt1" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                                    SetFocusOnError="true" ControlToValidate="txtRefNo" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Branch Code">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtBranchCode" CssClass="input" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BranchCode") %>'
                                                                                    Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                                <%--onBlur="CheckValidBranchCode(this)"--%>

                                                                                <ajaxToolkit:AutoCompleteExtender ID="Extender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                                    ServiceMethod="GetLocationCodeNew" CompletionListItemCssClass="autocomplete_listItem"
                                                                                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                                    ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtBranchCode">
                                                                                </ajaxToolkit:AutoCompleteExtender>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Advance Paid By">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtSignature" CssClass="input" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Signature") %>' Width="100px" BorderStyle="Groove"
                                                                                    MaxLength="50"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                                Font-Underline="False" Wrap="False" />
                                                                        </asp:TemplateField>
                                                                    </Columns>

                                                                    <%--<PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                                    ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                <selecteditemstyle backcolor="#669999" font-bold="True" forecolor="White" />
                                                                <itemstyle forecolor="#000066" />
                                                                <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />--%>
                                                                </asp:GridView>
                                                                <asp:HiddenField ID="hfPaymentAmount" runat="server" />
                                                                <%--  <asp:UpdatePanel ID="UpdatePanelpayment" runat="server" UpdateMode="Always">
                                                               <ContentTemplate>
                                                                    <UC2:UCPaymentControl ID="UCPayment" runat="server"></UC2:UCPaymentControl>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>--%>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:Panel>

                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableRow6" Style="background-color: white" runat="server">
                <asp:TableCell>
                    <table cellspacing="1" class="boxbg" border="0" width="1000px">
                        <tr class="bgbluegrey">
                            <td width="75%">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Fuel Slip Enter</asp:Label>
                            </td>
                            <td width="5%">
                                <asp:CheckBox ID="chkbxFuelSlipEntry" onclick="showTableFuelSlip()" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="TableFuelSlip" Style="background-color: white" runat="server">
                <asp:TableCell>


                    <table cellspacing="1" align="center" width="1000px">
                        <tr align="center">
                            <td align="left">
                                <asp:Panel ID="pnlFuelSlipDet" runat="server" Width="1000px">
                                    <asp:Table ID="Table7" runat="server" border="0" Width="1000px">

                                        <asp:TableRow Style="background-color: white" runat="server">
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                                <asp:TableRow runat="server">
                                                    <asp:TableCell>
                                                        <asp:Table ID="TableFuelSlip123" runat="server" border="0" Width="1000px">
                                                            <asp:TableRow class="bgbluegrey">
                                                                <asp:TableCell HorizontalAlign="left" Width="20%">
                                                                            <font class="blackfnt">Enter no. of rows</font>
                                                                </asp:TableCell>
                                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="left">
                                                                    <asp:UpdatePanel ID="UpdatePanel13" runat="server" UpdateMode="Always" RenderMode="Inline">
                                                                        <ContentTemplate>
                                                                            <asp:TextBox ID="txtAddFuelSlipRow" runat="server" Text="0" MaxLength="3" Width="30"
                                                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))" BorderStyle="Groove"
                                                                                OnTextChanged="Add_RowFuelSlip" AutoPostBack="true"></asp:TextBox>
                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                            <asp:TableRow Style="background-color: white">
                                                                <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                                                    <asp:TableRow>
                                                                        <asp:TableCell>
                                                                            <asp:UpdatePanel ID="UpdatePanel40" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                <ContentTemplate>
                                                                                    <asp:Label ID="Label4" CssClass="redfnt" runat="server" Text=""></asp:Label>
                                                                                    <asp:GridView ID="gvFuelSlip" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                                                                        SelectedIndex="1" ShowFooter="true" OnRowDataBound="gvFuelSlip_RowDataBound"
                                                                                        Width="1000px" BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt">
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Sr. No." HeaderStyle-Width="75">
                                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderStyle-Wrap="true" HeaderStyle-Width="100" HeaderText="Slip Type">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                                <ContentTemplate>--%>
                                                                                                    <asp:DropDownList ID="ddlFuelType" runat="server" Width="85px" Style="text-align: left"
                                                                                                        BorderStyle="Groove" OnSelectedIndexChanged="ddlFuelType_SelectedIndexChanged"
                                                                                                        AutoPostBack="true">
                                                                                                        <asp:ListItem Text="Fuel Slip" Value="1" />
                                                                                                        <%--<asp:ListItem Text="Fuel Card" Value="2" />--%>
                                                                                                    </asp:DropDownList>
                                                                                                    <%--  </ContentTemplate>
                                                                                            </asp:UpdatePanel>--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="System Date" HeaderStyle-Width="100px">
                                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblSystemDate" runat="server"></asp:Label>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Fuel Slip No.">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtFuelSlipNo" CssClass="input" Width="120px" Style="text-align: left"
                                                                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelSlipNo") %>'
                                                                                                        BorderStyle="Groove"></asp:TextBox>
                                                                                                    <%--  **************************************************--%>
                                                                                                    <%--<asp:Label ID="lbl_FuelSlipNo_Err" runat="server" CssClass="balckfnt" ForeColor="Red"></asp:Label><asp:UpdatePanel
                                                                                                    ID="UP3" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                                                                    <ContentTemplate>
                                                                                                        <asp:Label ID="lblFSN" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                                                                                    </ContentTemplate>
                                                                                                    <Triggers>
                                                                                                        <asp:AsyncPostBackTrigger ControlID="txtFuelSlipNo" EventName="TextChanged" />
                                                                                                    </Triggers>
                                                                                                </asp:UpdatePanel>--%>
                                                                                                    <%-- *************************************************--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                                <FooterTemplate>
                                                                                                    <asp:Label ID="lblHdr6764" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Fuel Vendor">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <%--<asp:UpdatePanel ID="UpdatePanel30" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                                <ContentTemplate>--%>
                                                                                                    <asp:DropDownList ID="ddlFuelVendor" OnSelectedIndexChanged="ddlFuelVendor_SelectedIndexChanged" AutoPostBack="true" runat="server" Width="200px" Style="text-align: left"
                                                                                                        BorderStyle="Groove">
                                                                                                    </asp:DropDownList>
                                                                                                    <%--  </ContentTemplate>
                                                                                            </asp:UpdatePanel>--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>

                                                                                            <%--Added By Anupam --%>
                                                                                            <asp:TemplateField HeaderText="Fuel Type">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <%--      <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                                <ContentTemplate>--%>
                                                                                                    <asp:DropDownList ID="ddlFuelTypePD" OnSelectedIndexChanged="ddlFuelTypePD_SelectedIndexChanged" runat="server" Width="100px" Style="text-align: left"
                                                                                                        BorderStyle="Groove"
                                                                                                        AutoPostBack="true">
                                                                                                        <asp:ListItem Text="Diesel" Value="Diesel" />
                                                                                                        <asp:ListItem Text="AddBlue" Value="AddBlue" />
                                                                                                        <asp:ListItem Text="CNG" Value="CNG" />
                                                                                                    </asp:DropDownList>
                                                                                                    <%--  </ContentTemplate>
                                                                                            </asp:UpdatePanel>--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>

                                                                                            <asp:TemplateField HeaderText="From City">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtFromCity" runat="server"
                                                                                                        Width="100px" CssClass="input" MaxLength="20" Enabled="false" BorderStyle="Groove"></asp:TextBox>

                                                                                                    <%--Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'--%>

                                                                                                    <%--<div class="blackfnt">
                                                                                                    <ajaxToolkit:AutoCompleteExtender ID="Extender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                                                        ServiceMethod="GetFUelCity" CompletionListItemCssClass="autocomplete_listItem"
                                                                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                                                        ServicePath="../../../services/WebService.asmx" TargetControlID="txtFromCity">
                                                                                                    </ajaxToolkit:AutoCompleteExtender>
                                                                                                </div>--%>

                                                                                                    <asp:HiddenField ID="hdFromCityCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"FromCityCode") %>' />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                                <FooterTemplate>
                                                                                                    <asp:TextBox ID="txtFromCityFoo" Width="100px" Style="text-align: right" runat="server"
                                                                                                        Font-Bold="true" BorderStyle="None" onfocus="this.blur()"></asp:TextBox>


                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <%--Added By Anupam --%>

                                                                                            <asp:TemplateField HeaderText="Quantity in Litre">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtQtyLiter" runat="server"
                                                                                                        Width="100px" Style="text-align: right" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                                        MaxLength="10" BorderStyle="Groove"></asp:TextBox>
                                                                                                    <%--Text='<%# DataBinder.Eval(Container.DataItem,"QtyLiter") %>' <asp:RegularExpressionValidator ID="RegtxtQtyLiter" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                                                     SetFocusOnError="true" ControlToValidate="txtQtyLiter" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                                <FooterTemplate>
                                                                                                    <asp:TextBox ID="txtTotalDieselFilled" Width="100px" Style="text-align: right" runat="server"
                                                                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <%--style="text-align:right" --%>
                                                                                            <asp:TemplateField HeaderText="Rate">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtRate" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Rate") %>'
                                                                                                        Width="100px" MaxLength="10" onfocus="this.blur()" CssClass="input" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                                                                    <%-- <asp:RegularExpressionValidator ID="RegRate" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                                                 SetFocusOnError="true" ControlToValidate="txtRate" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Amount">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />

                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtAmount" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'
                                                                                                        Width="100px" MaxLength="10"></asp:TextBox>
                                                                                                    <asp:HiddenField ID="hdSrNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>' />
                                                                                                </ItemTemplate>

                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                                <FooterTemplate>
                                                                                                    <asp:TextBox ID="txtTotalAmount" Width="100px" Style="text-align: right" runat="server"
                                                                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                                                                </FooterTemplate>
                                                                                            </asp:TemplateField>
                                                                                              <asp:TemplateField HeaderText="IGST">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtIGST" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IGST") %>'
                                                                                                        Width="100px" MaxLength="10"></asp:TextBox>                                                                                                    
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />                                                                                             
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="SGST">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtSGST" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SGST") %>'
                                                                                                        Width="100px" MaxLength="10"></asp:TextBox>                                                                                                   
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />                                                                                               
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="CGST">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtCGST" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CGST") %>'
                                                                                                        Width="100px" MaxLength="10"></asp:TextBox>                                                                                                   
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />                                                                                                
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Total Amount">
                                                                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txtamounttotal" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TotalAmount") %>'
                                                                                                        Width="100px" MaxLength="10"></asp:TextBox>                                                                                                   
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />                                                                                               
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                        <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                                                                            CssClass="bgbluegrey" />
                                                                                    </asp:GridView>

                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                            <asp:HiddenField ID="hdnTotalDieselFilled" runat="server" />
                                                                            <asp:HiddenField ID="hdnTotalAmount" runat="server" />
                                                                        </asp:TableCell>
                                                                    </asp:TableRow>
                                                                </asp:TableCell>
                                                            </asp:TableRow>
                                                        </asp:Table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" ValidationGroup="main"
                        OnClick="SubmitData" OnClientClick="javascript:ValidateSubmit();" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <%--    
        </ContentTemplate>
    </asp:UpdatePanel>--%>
    <asp:Panel ID="Panel6" runat="server" Style="display: none" CssClass="modalPopup"
        Height="280px" Width="600px">
        <table>
            <tr>
                <td>
                    <asp:Panel ID="Panel4" runat="server" Style="cursor: move; text-align: center; background-color: #DDDDDD; border: solid 1px Gray; color: Black"
                        Height="20px" Width="600">
                        <div>
                            <p>
                                CheckList
                            </p>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
            <tr style="background-color: white">
                <td class="blackfnt" colspan="3" style="text-align: Center">
                    <asp:Label ID="lblCheckListError" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label><asp:HiddenField
                        ID="hfChecklist_Mandatory" runat="server" />
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" style="text-align: right">
                    <asp:Panel ID="Panel5" runat="server" Height="230px" Width="600px" HorizontalAlign="Left"
                        ScrollBars="Vertical">
                        <asp:GridView ID="gvChecklist" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                            SelectedIndex="1" ShowFooter="false" Width="550px" BorderStyle="None" EmptyDataText="No Records Found..."
                            BorderWidth="3px" CssClass="blackfnt" HeaderStyle-CssClass="GridHeader" Visible="false">
                            <Columns>
                                <asp:BoundField DataField="Category" HeaderText="Category">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CheckList" HeaderText="Checklist">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="250px" />
                                    <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Checking Done">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="false" />
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comments">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtComments" CssClass="input" Width="100px" Style="text-align: left"
                                            runat="server" BorderStyle="Groove"></asp:TextBox><asp:HiddenField ID="Category_ID"
                                                runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Chk_Cat") %>' />
                                        <asp:HiddenField ID="CheckList_ID" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Chk_ID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <%-- <asp:BoundField DataField="Chk_Cat" HeaderText="Category ID" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chk_ID" HeaderText="CheckList ID" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                            </asp:BoundField>--%>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                CssClass="bgbluegrey" />
                        </asp:GridView>
                        <asp:Table ID="Table6" runat="server" Visible="false" CellSpacing="1" CellPadding="3"
                            Width="550px" class="boxbg" border="0">
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Checked By</font>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtCheckedBy" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Checked Date</font>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtCheckedDate" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtCheckedDate"
                                        runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Approved By</font>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtApprovedBy" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Approved Date</font>
                                </asp:TableCell><asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtApprovedDate" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtApprovedDate"
                                        runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="OkButton" runat="server" Width="100px" Text="OK" />
                    <asp:TextBox ID="txtHoldFlag" runat="server" Style="display: none"></asp:TextBox><asp:HiddenField ID="hidFitnessValidation" runat="server" />
                    <asp:HiddenField ID="hidFitnessExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidFitnessGraceDays" runat="server" />
                    <asp:HiddenField ID="hidNationalPermitValidation" runat="server" />
                    <asp:HiddenField ID="hidNationalPermitExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidNationalPermitGraceDays" runat="server" />
                    <asp:HiddenField ID="hid5YrPermitValidation" runat="server" />
                    <asp:HiddenField ID="hid5YrPermitExpiryDate" runat="server" />
                    <asp:HiddenField ID="hid5YrPermitGraceDays" runat="server" />
                    <asp:HiddenField ID="hidInsuranceValidation" runat="server" />
                    <asp:HiddenField ID="hidInsuranceExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidInsuranceGraceDays" runat="server" />
                    <asp:HiddenField ID="hidRoadTaxValidation" runat="server" />
                    <asp:HiddenField ID="hidRoadTaxExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidRoadTaxGraceDays" runat="server" />
                    <asp:HiddenField ID="hidDriverLicValidation" runat="server" />
                    <asp:HiddenField ID="hidDriverLicExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidDriverLicGraceDays" runat="server" />
                    <asp:HiddenField ID="hidDriverLicVerifValidation" runat="server" />
                    <asp:HiddenField ID="hidDriverLicVerifExpiryDate" runat="server" />
                    <asp:HiddenField ID="hidDriverLicVerifGraceDays" runat="server" />
                    <asp:HiddenField ID="hidDieselLiterValidation" runat="server" />
                    <asp:HiddenField ID="hidDieselLiter" runat="server" />
                    <asp:HiddenField ID="hidDieselLiterGrace" runat="server" />
                    <asp:HiddenField ID="hidCashValidation" runat="server" />
                    <asp:HiddenField ID="hidCash" runat="server" />
                    <asp:HiddenField ID="hidCashGrace" runat="server" />
                    <asp:HiddenField ID="hdnSecondTripApproved" Value="N" runat="server" />
                    <asp:HiddenField ID="hdnEndLocEnable" Value="N" runat="server" />
                    <asp:HiddenField ID="hidRequestID" runat="server" />
                </td>
            </tr>
        </table>

    </asp:Panel>
    <div id="divPopUp">
        <table class="boxbg" id="tblVehicleDetails">
            <thead>
                <tr>
                    <th>Message
                    </th>
                    <th>Perticulars
                    </th>
                    <th>Validity/Actual
                    </th>
                    <th>Grace
                    </th>
                    <th>Remarks
                    </th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
</asp:content>
