<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmViewPrintVehicleIssueSlipV2.aspx.cs"
    Inherits="Issue_frmViewPrintVehicleIssueSlipV2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head runat="server">
    <title>Trip Sheet</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js"></script>

    <style type="text/css">
        td
        {
            font-family: Verdana;
            font-size: 7pt;
        }
        br.page
        {
            page-break-before: always;
        }
    </style>

    <script language="javascript">
        function printme() {
            var qs = new Querystring()
            var mPrintMode = qs.get("PrintMode");
            if (mPrintMode == "1") {
                window.print();
            }
        }
        function ViewPrint(mReqId) {
            //string    ReqId ="";
            //  var ReqId = Request.QueryString["VSlipId"];
            //  alert(mReqId);
            var strurl = "frmTripSheetDetails.aspx?id=" + mReqId    //+ "&PrintMode=" + tPrintMode  
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
        }
    </script>

</head>
<html>
<body onload="printme()">
    <form id="form1" runat="server">
    <table cellspacing="1" cellpadding="2" width="95%" align="center" class="boxbg" border="0"
        bgcolor="#8BA0E5">
        <tr style="background-color: white">
            <td colspan="4" align="left" style="vertical-align: top; text-align: left">
                <div>
                    <table runat="server" border="0" cellpadding="1" cellspacing="0" style="font-size: 7pt;
                        width: 100%; font-family: Verdana">
                        <tr>
                            <td align="left" style="width: 17%;" valign="top" rowspan="3">
                                <asp:Image ID="imgLogo" runat="server" />
                            </td>
                            <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                                text-transform: uppercase; font-family: Verdana; height: 48px; text-align: center"
                                valign="top">
                                <table id="d" runat="server" border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt;
                                    width: 100%; font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                                            text-transform: uppercase; font-family: Verdana; height: 48px; text-align: center"
                                            valign="top">
                                            TRIP SHEET&nbsp;&nbsp;<asp:Label ID="lblTripSheetStatus" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Manual Trip Sheet No:
                                        </td>
                                        <td align="left" style="width: 20%" valign="top" colspan="2">
                                            <asp:Label ID="lblManualTripsheet" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Controling Branch:
                                        </td>
                                        <td align="left" style="width: 50%" valign="top">
                                            <asp:Label ID="lblControllingBranch" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Route Operated:
                                        </td>
                                        <td align="left" style="width: 20%;" valign="top" colspan="2">
                                            <asp:Label ID="lblRoute" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Trip Sheet No:
                                        </td>
                                        <td align="left" style="width: 50%;" valign="top">
                                            <asp:Label ID="lblTripsheetNo" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                          <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip Start Date &amp; Time:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblStartDate" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 15%; font-weight: bold;" valign="top">
                                Vehicle No:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblVehno" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Vehicle Type:
                            </td>
                            <td align="left" style="width: 14%;" valign="top">
                                <asp:Label ID="lblVehType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip End Date &amp; Time:
                            </td>
                            <td align="left" style="width: 17%;" valign="top">
                                <asp:Label ID="lblEndDate" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Approved Route KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblRouteKM" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Vehicle Capacity:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblVehCapacity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 15%; font-weight: bold;" valign="top">
                                Driver1 Name:
                            </td>
                            <td align="left" style="width: 15%" valign="top">
                                <asp:Label ID="lblDriverNm" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver1 Licence No:
                            </td>
                            <td align="left" style="width: 17%;" valign="top">
                                <asp:Label ID="lblDriverLicNo" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver1 Licence Validity:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblDriverLicValidity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 15%; font-weight: bold;" valign="top">
                                Driver2 Name:
                            </td>
                            <td align="left" style="width: 15%" valign="top">
                                <asp:Label ID="lblDriverNm2" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver2 Licence No:
                            </td>
                            <td align="left" style="width: 17%;" valign="top">
                                <asp:Label ID="lblDriverLicNo2" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver2 Licence Validity:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblDriverLicValidity2" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip Start KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTripStartKM" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip End KM:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblTripEndKM" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Total Trip KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTotTripKM" runat="server"></asp:Label>
                            </td>
                        </tr>
			            <tr runat="server" id="Tr1666">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Category:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblCategory" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                External Usages Category :
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:Label ID="lblExternalUsageCategory" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="Tr1353545">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Cust Name :
                            </td>
                            <td align="left" style="width: 17%" valign="top" colspan="5">
                                <asp:Label ID="lblcustname" runat="server"></asp:Label>
                            </td>
                        </tr>
                        
                        <tr runat="server" id="Tr4">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Trip Start Location :
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTripStartLoc" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Trip End Location :
                            </td>
                            <td align="left" style="width: 17%" valign="top" colspan="3">
                                <asp:Label ID="lblTripEndLoc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="Tr5">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Trip From City :
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTripFromCity" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Trip To City :
                            </td>
                            <td align="left" style="width: 17%" valign="top" colspan="3">
                                <asp:Label ID="lblTripToCity" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="rEntryBy">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Entry By:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblEntryby" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Entry Date &amp; Time:
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:Label ID="lblEntryDt" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="Tr1">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Vehicle Mode:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblVehicleMode" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                <asp:Label ID="lblDocketLab" runat="server"></asp:Label>
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:Label ID="lblDockets" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="6" valign="top" style="height: 20px; font-weight: bold;
                                vertical-align: bottom; text-align: left;">
                                FUEL FILLED
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="4" style="width: 80%; height: 71px;" valign="top">
                                <asp:GridView ID="gvFuelExp" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                    Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="Place" HeaderText="Place">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillNo" HeaderText="Bill No.">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillDt" HeaderText="Bill Date">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="KM_Reading" HeaderText="Odometer Reading">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Diesel_Ltr" HeaderText="Diesel (Qty. in litres)">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Diesel_Rate" HeaderText="Diesel Rate/litre">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Amount" HeaderText="Amount Spent">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Exe_Amt" HeaderText="Amount Approved">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Font-Bold="True" />
                                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Card_Cash" HeaderText="By Card/Cash">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="True" />
                                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                                        </asp:BoundField>
                                    </Columns>
                                    <HeaderStyle Font-Bold="True" />
                                </asp:GridView>
                            </td>
                            <td align="left" style="width: 20%; height: 71px;" valign="top" colspan="2">
                                <table border="1" cellpadding="3" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td colspan="2" style="font-weight: bold; vertical-align: middle; text-align: center">
                                            KMPL Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; width: 70%">
                                            Approved KMPL
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblApprovedKMPL" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; width: 70%">
                                            Actual KMPL
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblActualKMPL" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-weight: bold; width: 70%">
                                            Variance KMPL
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblVarianceKMPL" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px;
                                vertical-align: bottom; text-align: left;">
                                ADVANCE PAID TO DRIVER
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6" valign="top">
                                <asp:GridView ID="gvAdvPaid" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                    Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="AdvLoc" HeaderText="Branch Name">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AdvDate" HeaderText="Date">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="VoucherRefNo" HeaderText="Voucher No.">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="AdvAmt" HeaderText="Amount">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Signature" HeaderText="Paid By Sign">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField HeaderText="Driver Sign" />
                                        <asp:BoundField HeaderText="Remark " />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px;
                                vertical-align: bottom; text-align: left;">
                                External THC Details
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6" valign="top">
                                <asp:GridView ID="gvETD" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                    Width="100%">
                                    <Columns>
                                        <asp:BoundField DataField="externalthcno" HeaderText="External Thc No">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fromcity" HeaderText="From City">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ToCity" HeaderText="To City">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ContractAmount" HeaderText="Contract Amount">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                       <asp:BoundField DataField="Advanceamount" HeaderText="Advance Amount">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BalanceAmount" HeaderText="Balance Amount">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="CustomerType" HeaderText="Customer Type">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="TransporterName" HeaderText="Transporter Name">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="TransporterChallanNo" HeaderText="Transporter Challan No">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="challandate" HeaderText="challandate">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="LoadingDate" HeaderText="LoadingDate">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>

                                         <asp:BoundField DataField="Weight" HeaderText="Weight">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="Nug" HeaderText="Nug">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="BrokerName" HeaderText="BrokerName">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px;
                                vertical-align: bottom; text-align: left;">
                                <asp:Label ID="LblJourney_Log" Text="JOURNEY DETAILS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6" valign="top">
                                <asp:GridView ID="gvJourneyDet" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                    Width="100%">
                                    <Columns>
                                        <asp:BoundField HeaderText="Route Operated" DataField="routename">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Location" HeaderText="Sources" />
                                        <asp:BoundField DataField="thcno" HeaderText="VHC.No">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Dept" HeaderText="Dept.Date | Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="arrival" HeaderText="Arrival Date | Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ld_actuwt" HeaderText="Weight(in Kg.)">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="OPENKM" HeaderText="OP. KM" />
                                        <asp:BoundField DataField="CLOSEKM" HeaderText="CL. KM" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="6" valign="top">
                                <asp:GridView ID="gvVehicleLogEntry" runat="server" Width="100%" AutoGenerateColumns="False"
                                    BorderWidth="1px" CellPadding="1" CellSpacing="1" EmptyDataText="No Records Found..."
                                    PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left" Visible="false">
                                    <Columns>
                                        <asp:BoundField DataField="From_Point" HeaderText="From">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="To_Point" HeaderText="To">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Start_Date_Tm" HeaderText="Start Date and Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="End_Date_Tm" HeaderText="End Date and Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Invoice_No" HeaderText="Invoice No">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Start_Km_Read" HeaderText="Start Km">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Category" HeaderText="Category">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Prod_Typ" HeaderText="Type of Product">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="No_Crates" HeaderText="No. of Crates">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="End_KM_Read" HeaderText="End Km">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="KM_Read" HeaderText="KM Run">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Transit_Time" HeaderText="Transit Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Idle_Time" HeaderText="Idle Time">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <%--<td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px; vertical-align: bottom; text-align: left;">
            <asp:Label ID="lblChecklist" Text="Checklist" runat="server"></asp:Label></td>--%>
                            <td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px;
                                vertical-align: bottom; text-align: left;">
                                CHECKLIST
                            </td>
                        </tr>
                        <tr style="background-color: White" align="center">
                            <td colspan="4" align="left" bgcolor="white">
                                <asp:GridView ID="gvChecklist" runat="server" Width="100%" Visible="false" AutoGenerateColumns="False"
                                    BorderWidth="1px" CellPadding="1" CellSpacing="1" EmptyDataText="No Records Found..."
                                    PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left" Font-Size="XX-Small">
                                    <Columns>
                                        <asp:BoundField DataField="Category" HeaderText="Category">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Chk_Desc" HeaderText="Checklist">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%" />
                                            <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Checked" HeaderText="Checking Done">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="25%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Chk_Comments" HeaderText="Comments">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="25%" />
                                            <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan="4" align="left">
                                <table id="table111" runat="server" visible="false" cellspacing="1" cellpadding="2"
                                    width="100%" align="left" border="1">
                                    <tr style="background-color: white">
                                        <td align="center">
                                            <font class="blackfnt">Checked By</font>
                                        </td>
                                        <td align="center">
                                            <font class="blackfnt">Checked Date and Time</font>
                                        </td>
                                        <td align="center">
                                            <font class="blackfnt">Approved By</font>
                                        </td>
                                        <td align="center">
                                            <font class="blackfnt">Approved Date and Time</font>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="center">
                                            <asp:Label ID="lblCheckedByChecklist" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="lblCheckedDate" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="lblApprovedByChecklist" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="lblApprovedDate" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="6" valign="top" style="font-weight: bold; height: 20px;
                                vertical-align: bottom; text-align: left;">
                                ATTACHED CNOTE WITH TRIPSHEET
                            </td>
                        </tr>
                        <tr style="background-color: White" align="center">
                            <td colspan="4" align="left" bgcolor="white">
                                <asp:GridView ID="gvCnote" runat="server" Width="1000px" Visible="true" AutoGenerateColumns="False"
                                    BorderWidth="1px" CellPadding="1" CellSpacing="1" EmptyDataText="No Records Found..."
                                    PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left" Font-Size="XX-Small">
                                    <Columns>
                                        <asp:BoundField DataField="Tripsheetno" HeaderText="Tripsheet No.">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DockNo" HeaderText="Docket No.">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DOCKDT" HeaderText="Booking Date">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ORGNCD" HeaderText="Origin">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DESTCD" HeaderText="Destination">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PKGSNO" HeaderText="No. of Packages">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ACTUWT" HeaderText="Actual Weight">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CHRGWT" HeaderText="Charged Weight">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SubTotal" HeaderText="Sub-Total">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DKTTOT" HeaderText="Cnote Total">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="True" Width="10%" />
                                            <ItemStyle Width="100px" HorizontalAlign="Right" VerticalAlign="Middle" CssClass="bgwhite" />
                                        </asp:BoundField>
                                    </Columns>
                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellspacing="0" cellpadding="0" width="100%" align="left" class="boxbg" border="0"
                        style="font-size: 8pt; font-family: Verdana">
                        <tr style="background-color: white">
                            <td style="font-weight: bold; width: 33%; height: 30px">
                                Sign of Driver:
                            </td>
                            <td style="font-weight: bold; width: 33%; height: 30px">
                                Sign of Fleet Supervisor:
                            </td>
                            <td style="font-weight: bold; width: 34%; height: 30px">
                                Sign of Fleet In-Charge:
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
                <br class="page">
                <div>
                    <br />
                    <table id="Table1" runat="server" border="0" cellpadding="1" cellspacing="0" style="font-size: 7pt;
                        width: 100%; font-family: Verdana">
                        <tr>
                            <td align="left" style="width: 17%;" valign="top" rowspan="3">
                                <asp:Image ID="imgLogo1" runat="server" />
                            </td>
                            <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                                text-transform: uppercase; font-family: Verdana; height: 48px; text-align: center"
                                valign="top">
                                <table border="1" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="5" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                                            text-transform: uppercase; font-family: Verdana; height: 30px; text-align: center"
                                            valign="top">
                                            trip sheet
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Manual Trip Sheet No:
                                        </td>
                                        <td align="left" style="width: 20%" valign="top" colspan="2">
                                            <asp:Label ID="lblManualTripsheet1" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Controling Branch:
                                        </td>
                                        <td align="left" style="width: 50%" valign="top">
                                            <asp:Label ID="lblControllingBranch1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Route Operated:
                                        </td>
                                        <td align="left" style="width: 20%" valign="top" colspan="2">
                                            <asp:Label ID="lblRoute1" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 25%; font-weight: bold;" valign="top">
                                            Trip Sheet No:
                                        </td>
                                        <td align="left" style="width: 50%" valign="top">
                                            <asp:Label ID="lblTripsheetNo1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip Start Date &amp; Time:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblStartDate1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Vehicle No:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblVehno1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver Name:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblDriverNm1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip End Date &amp; Time:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblEndDate1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Vehicle Type:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblVehType1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver Licence No:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblDriverLicNo1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Approved Route KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblRouteKM1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Vehicle Capacity:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblVehCapacity1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Driver Licence Validity:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblDriverLicValidity1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip Start KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTripStartKM1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Trip End KM:
                            </td>
                            <td align="left" style="width: 14%" valign="top">
                                <asp:Label ID="lblTripEndKM1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="width: 17%; font-weight: bold;" valign="top">
                                Total Trip KM:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblTotTripKM1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="Tr2">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Category:
                            </td>
                            <td align="left" style="width: 17%" valign="top">
                                <asp:Label ID="lblCategory1" runat="server"></asp:Label>
                            </td>
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                External Usages Category :
                            </td>
                            <td align="left" colspan="3" valign="top">
                                <asp:Label ID="lblExternalUsageCategory1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="server" id="Tr3">
                            <td align="left" style="font-weight: bold; width: 17%" valign="top">
                                Cust Name :
                            </td>
                            <td align="left" style="width: 17%" valign="top" colspan="5">
                                <asp:Label ID="lblcustname1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr runat="ser
                    </table>
                    <table border="0" cellpadding="3" cellspacing="0" style="font-size: 7pt; width: 100%;
                        font-family: Verdana">
                        <tr>
                            <td align="left" colspan="3" style="font-weight: bold; font-size: 7pt; width: 60%;
                                font-family: Verdana; height: 9px" valign="top">
                                EXPENSE DETAILS
                            </td>
                            <td align="left" colspan="3" style="font-weight: bold; font-size: 7pt; width: 60%;
                                font-family: Verdana; height: 9px" valign="top">
                                TRIP SUMMARY
                            </td>
                        </tr>
                        <tr>
                            <td align="left" colspan="3" valign="top" style="width: 60%;">
                                <asp:GridView ID="gvExpDetails" runat="server" CellPadding="1" AutoGenerateColumns="False"
                                    Width="100%" OnRowDataBound="gvExpDetails_RowDataBound" ShowFooter="True">
                                    <Columns>
                                        <asp:BoundField DataField="Trip_Exp_Header" HeaderText="Nature of Expense">
                                            <ItemStyle HorizontalAlign="Left" Width="50%" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Polarity" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Polarity" runat="server" Text='<%# Bind("Polarity") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <ItemStyle HorizontalAlign="Left" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BillNo" HeaderText="Bill No">
                                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillDate" HeaderText="Bill Date">
                                            <ItemStyle HorizontalAlign="Left" Width="15%" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Amount_spent" HeaderText="Amount Spent">
                                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <FooterStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Exe_Appr_Amt" HeaderText="Approved Amount">
                                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                            <FooterStyle HorizontalAlign="Right" Height="27px" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td align="left" style="width: 40%; height: 60px;" valign="top" colspan="3">
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: center">
                                            DRIVER SETTLEMENT
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 5%" valign="top">
                                            I.
                                        </td>
                                        <td align="left" style="width: 55%" valign="top">
                                            Total Advance:
                                        </td>
                                        <td align="left" style="width: 40%; text-align: right;" valign="top">
                                            <asp:Label ID="lblAdvPaid" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 5%" valign="top">
                                            II.
                                        </td>
                                        <td align="left" style="width: 55%" valign="top">
                                            Total Expenses (A+B):
                                        </td>
                                        <td align="left" style="width: 40%; text-align: right;" valign="top">
                                            <asp:Label ID="txtTotExp" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 5%" valign="top">
                                            A.
                                        </td>
                                        <td align="left" style="width: 55%" valign="top">
                                            Enroute Expense
                                        </td>
                                        <td align="left" style="width: 40%; text-align: right;" valign="top">
                                            <asp:Label ID="lblEnrouteExp" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 5%" valign="top">
                                            B.
                                        </td>
                                        <td align="left" style="width: 55%" valign="top">
                                            Fuel Expense By Cash:
                                        </td>
                                        <td align="left" style="width: 40%; text-align: right;" valign="top">
                                            <asp:Label ID="lblFuelExp" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="2" valign="top">
                                            Net
                                            <asp:Label ID="Label1" runat="server">Payable</asp:Label>/<asp:Label ID="Label2"
                                                runat="server">Receivable</asp:Label>
                                            (I-II):
                                        </td>
                                        <td align="left" style="width: 40%; text-align: right;" valign="top">
                                            <asp:Label ID="lblNetPayRec" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: center">
                                            KMPL Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="font-weight: bold; width: 33%" valign="top">
                                            Approved KMPL
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 33%" valign="top">
                                            Actual KMPL
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 33%" valign="top">
                                            Variance KMPL
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="lblKMPLApproved" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="lblKMPLActual" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="lblKMPLVariance" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: center">
                                            Diesel Expense Details
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="font-weight: bold; width: 40%" valign="top">
                                            Total Diesel Qty
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 36%" valign="top">
                                            Total Diesel Exp
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 25%" valign="top">
                                            Remark
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="lblDleselQty" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="lblDieselExp" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                            <asp:Label ID="Label5" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: center">
                                            Details of Total Route KM Run
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="font-weight: bold; width: 40%" valign="top">
                                            Route Approved KM
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 31%" valign="top">
                                            Actual KM
                                        </td>
                                        <td align="left" style="font-weight: bold; width: 31%" valign="top">
                                            Variance KM
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 33%" valign="top">
                                            &nbsp;<asp:Label ID="lblRouteApprovedKM" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%; text-align: right;" valign="top">
                                            &nbsp;<asp:Label ID="lblActualKM" runat="server"></asp:Label>
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                            &nbsp;<asp:Label ID="lblVarianceKM" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: left">
                                            Claim Details:
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="width: 33%" valign="top">
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                        </td>
                                        <td align="left" style="width: 33%" valign="top">
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <table border="1" cellpadding="1" cellspacing="0" style="font-size: 7pt; width: 100%;
                                    font-family: Verdana">
                                    <tr>
                                        <td align="left" colspan="3" valign="top" style="font-weight: bold; text-align: left">
                                            Remarks:
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div id="footer">
                        <table cellspacing="0" cellpadding="0" width="100%" align="left" class="boxbg" border="0"
                            style="font-size: 8pt; font-family: Verdana">
                            <tr style="background-color: white">
                                <td style="font-weight: bold; width: 33%; height: 18px">
                                    Sign of Driver:
                                </td>
                                <td style="font-weight: bold; width: 33%; height: 18px">
                                    Sign of Fleet Supervisor:
                                </td>
                                <td style="font-weight: bold; width: 34%; height: 18px">
                                    Sign of Fleet In-Charge:
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
