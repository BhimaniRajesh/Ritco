<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCGeneration.aspx.cs" Inherits="GUI_Operations_THCGeneration_THCGeneration" %>

<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<asp:SqlDataSource ID="MySQLDataSource_TS" runat="server" SelectCommand="usp_TripSheetListForTHC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="dllVehicle" DefaultValue="" Name="VehicleNo" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>--%>

    <asp:SqlDataSource ID="MySQLDataSource_TDSAccCode" runat="server"
        SelectCommand="SELECT accdesc+':'+Company_acccode as dispval,accdesc,acccode FROM webx_acctinfo WHERE acccode='CLA0015'"
        SelectCommandType="Text"></asp:SqlDataSource>

    <asp:Panel ID="Panel1" HorizontalAlign="Left" runat="server">
        <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>
        <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
        <script src="./THCGeneration.js?<%=System.DateTime.Now.Ticks.ToString() %>" language="javascript" type="text/javascript"></script>
        <script language="JavaScript" type="text/javascript">
            var cal = new CalendarPopup("testdiv1");
            cal.setCssPrefix("TEST");
            cal.showNavigationDropdowns();

            function VehUpperCase(txtVeh) {
                var txtVehno = document.getElementById(txtVeh);
                txtVehno.value = txtVehno.value.toUpperCase();
            }
			function InitAutoComplete() {
			var txtBalamtbr = $("#<%= balamtbr.ClientID%>");
            var mhdnBalamtbr = "<%= hdnBalamtbr.ClientID%>";
            AutoCompleteByAjax(txtBalamtbr, "../../../RestService/MasterService.svc/GetLocationList", "POST", "application/json; charset=utf-8", "json", "prefixText", 'v', 'v', 'l', 'v', mhdnBalamtbr, 'Invalid Location');
			 }
			 
			 //Date Compare
            function MyDateCompareV1(startDt, endDt) {
                var startDtArr;
                var endDtArr;

                startDtArr = startDt.split('/');
                endDtArr = endDt.split('/');

                var myStartDt = new Date(startDtArr[2], startDtArr[1] - 1, startDtArr[0]);
                var myEndDt = new Date(endDtArr[2], endDtArr[1] - 1, endDtArr[0]);
                var dtDiff = myEndDt.getTime() - myStartDt.getTime();

                dtDiff = dtDiff / 86400000;


                if (Trim(startDt) == Trim(endDt)) {
                    dtDiff = 0;
                }
                //alert(dtDiff);
                return dtDiff
            } 
			 
			function OnTHCDateChange() {
				
                var joo = true;
                if (MyDateCompareV1($("#<%= hdnSystemDate.ClientID%>").val(), $("#<%= txtTHCDate.ClientID%>").val()) > 0) joo = false;

                if (!joo) {
                    alert("THC Date cannot be greater than Sys. Date:" + $("#<%= hdnSystemDate.ClientID%>").val());
                    $("#<%= txtTHCDate.ClientID%>").val( $("#<%= hdnSystemDate.ClientID%>").val());
                    $("#<%= txtTHCDate.ClientID%>").focus();
                    return false;
                }


                if (MyDateCompareV1($("#<%= txtTHCDate.ClientID%>").val(), $("#<%= hdnSystemDate.ClientID%>").val()) > 3) {
                    alert("Only 3 Back Days allowed in THC Date !!");
                    $("#<%= txtTHCDate.ClientID%>").val($("#<%= hdnSystemDate.ClientID%>").val());
                    $("#<%= txtTHCDate.ClientID%>").focus();
                    return false;
                }
            }



            function OnTransitLocationChange() {
                var TransitLocation = $("#<%= txtTransitLocation.ClientID%>").val();
                var THCLocation = "<%=SessionUtilities.CurrentBranchCode%>";
                var THCDestination = $("#<%= txtTHCDestination.ClientID%>").val();

                if (TransitLocation != "" && (TransitLocation == THCLocation || TransitLocation == THCDestination) ) {
                    alert("TransitLocation can not be same as THC Location OR THC Destination Location !!");
                    $("#<%= txtTransitLocation.ClientID%>").val("");
                    $("#<%= txtTransitLocation.ClientID%>").focus();
                    return false;
                }
            }

            function OnChkIsTransshipmentChange() {

                if ($("#<%= chkIsTransshipment.ClientID%>").prop("checked")) {
                    $("#<%= txtTransitTentativeFreight.ClientID%>").prop("disabled", false);
                    $("#<%= txtTransitLocation.ClientID%>").prop("disabled", false);
                    $("#<%= txtTransitRemark.ClientID%>").prop("disabled", false);
                } else {
                    $("#<%= txtTransitTentativeFreight.ClientID%>").prop("disabled", true);
                    $("#<%= txtTransitLocation.ClientID%>").prop("disabled", true);
                    $("#<%= txtTransitRemark.ClientID%>").prop("disabled", true);
                }
                
            }
			
			$( document ).ready(function() {
				OnChkIsTransshipmentChange();
			});
        </script>
        <asp:UpdatePanel ID="upTHCCreate" UpdateMode="Conditional" runat="server">
            <Triggers>
                <asp:PostBackTrigger ControlID="btnMarketVehicleAttch" />
                <asp:PostBackTrigger ControlID="btnDriverAttch" />
                <asp:PostBackTrigger ControlID="btnBrockrMemoAttch" />
                <asp:PostBackTrigger ControlID="btnStep2" />
            </Triggers>
            <ContentTemplate>
                <asp:Label ID="lblCount" CssClass="blackfnt" Text="" Font-Bold="true" runat="server"></asp:Label>
                <asp:Table ID="Table1" runat="server" CssClass="stbl" CellSpacing="1" Width="950">
                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell ColumnSpan="6" HorizontalAlign="Center" Font-Bold="true">
                            <asp:Label runat="server" ID="lblMainHdr" Text=""></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell ColumnSpan="6">
                            <asp:Table ID="tblBsicDetails" runat="server" CssClass="stbl" CellSpacing="1" Width="950">
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableHeaderCell ColumnSpan="6">
                                        <PRBAR:PRB ID="PB" runat="server" />
                                        <asp:HiddenField ID="hdnTHCType" runat="server" />
                                        <asp:HiddenField ID="hdnDKTCalleAs" runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnSystemDate" />
                                        <asp:HiddenField runat="server" ID="hdnTHCCalledAs" />
                                        <asp:HiddenField ID="hdnChargeCodeAll" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnContTyp" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnMFNo" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnTHCTotCnote" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnTHCTotPkg" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnTHCTotWt" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnNoConnectionVendorvehicle" runat="server" Value="N" />

                                    </asp:TableHeaderCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblManualTHCNo" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="false">
                                        <asp:TextBox ID="txtManualTHCNo" runat="server" Text="NA" CssClass="ltxt" MaxLength="25"
                                            Width="90"></asp:TextBox>
                                        <font class="bluefnt">("NA" if Not Applicable)</font>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblTHCDate" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="false">
                                        <asp:HiddenField runat="server" ID="hSysDate" />
                                        <asp:HiddenField ID="hdnTHCDate" runat="server" />
                                        <asp:TextBox ID="txtTHCDate" CssClass="ltxtm" runat="server" MaxLength="10" Width="70" onblur="javascript:OnTHCDateChange(this);"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTHCDate,'a1','dd/MM/yyyy'); return false;"
                                            id="a1">
                                            <img src="../../images/calendar.jpg" id="clikCal" runat="server" border="0" />
                                        </a><font class="blackfnt">[dd/mm/yyyy]</font>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblTHCTime" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="false">
                                        <asp:TextBox ID="txtTHCTime" runat="server" MaxLength="5" Width="33" CssClass="ltxtm"
                                            OnChange="javascript:CHECKTime(this);"></asp:TextBox>
                                        <font class="blackfnt">[HH:MM]</font>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow" ID="trRouteDetails" runat="server">
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblRouteMode" CssClass="nfnt" Text="Route Mode"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="dllRouteMode" AutoPostBack="True" DataTextField="CodeDesc"
                                            DataValueField="CodeID" OnSelectedIndexChanged="OnRouteModeChange">
                                        </asp:DropDownList>
                                        <asp:CheckBox ID="chkIsEmptyVehicle" runat="server" OnCheckedChanged="chkIsEmptyVehicleCheckedChanged"
                                            CssClass="nfnt" Text="Is Empty Vehicle" AutoPostBack="True" />
                                        <asp:HiddenField ID="hidEmptyRoot" runat="server" Value="N" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblRouteName" CssClass="nfnt" Text="Route Name"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="dllRouteName" EnableViewState="true" AutoPostBack="true"
                                            DataTextField="MyRouteName" DataValueField="MyRouteName" OnSelectedIndexChanged="OnRouteNameChange">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtTHCDestination" runat="server" Width="60" CssClass="ltxt"></asp:TextBox>
                                        <asp:Label runat="server" ID="err1" CssClass="redfnt"></asp:Label><br />
                                        <xac:WebxComplete ID="xacfrom" MinPrefixLength="1" FilterString="2345" WebxEntity="BranchCode"
                                            runat="server" CodeTarget="txtTHCDestination" />
                                        <asp:HiddenField ID="hdnTHCDestination" runat="server"></asp:HiddenField>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="false">
                                    </asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblActDeptTime" CssClass="nfnt" Text="Actual Dept. Time"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtActDeptTime" runat="server" MaxLength="5" Width="33" CssClass="ltxt"
                                            AutoPostBack="true" OnTextChanged="ActDeptTimeTextChanged" OnChange="javascript:CHECKTime(this);"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblSchDeptTimeCP" CssClass="nfnt" Text="Sch. Dept. Date/Time"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblSchdDeptDay" runat="server" Text="" CssClass="bluefnt"></asp:Label>
                                        <asp:Label ID="lblSchdDeptDate" runat="server" Text="" CssClass="bluefnt"></asp:Label>
                                        <asp:Label ID="lblSchdDeptTime" runat="server" Text="" CssClass="bluefnt"></asp:Label>
                                        <%--  <font class="blackfnt">[HH:MM]</font>--%>
                                        <asp:HiddenField ID="hdnSchdDeptTime" runat="server" />
                                        <asp:HiddenField ID="hdnGetdate" runat="server" />
                                        <asp:HiddenField ID="hdnSchFullDateTime" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblLateEarlyCP" CssClass="nfnt" Text="Late/Early "></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="Label1" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trSchedule" CssClass="nrow" runat="server" Visible="false">
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblSchType" CssClass="nfnt" Text="Schedule Type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblSchedule" CssClass="nfnt" Text="Schedule"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblNoSchRoute" runat="server" Text="" CssClass="redfnt"></asp:Label>
                                        <asp:RadioButtonList ID="rdbSchRoute" AutoPostBack="true" OnSelectedIndexChanged="onRadioScheduleChange"
                                            CssClass="bluefnt" CellSpacing="1" CellPadding="2" RepeatColumns="3" RepeatDirection="Horizontal"
                                            runat="server">
                                        </asp:RadioButtonList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="Label6" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblVendorType" CssClass="nfnt" Text="Vendor Type"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList runat="server" ID="dllVendorType" AutoPostBack="true" DataTextField="Vendor_Type"
                                            DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblVendorName" CssClass="nfnt" Text="Vendor Name"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSplNameCP" runat="server" CssClass="blackfnt" Text="Supplier Name & Mob No."
                                            Visible="false"></asp:Label>
                                        <asp:HiddenField ID="hdnContTypSystem" runat="server" Value="0" />
                                        <asp:HiddenField ID="hdnContIDSystem" runat="server" Value="" />
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:DropDownList runat="server" ID="dllVendors" AutoPostBack="true" DataTextField="Vendor_Name"
                                            DataValueField="Vendor_Code" OnSelectedIndexChanged="OnVendorChange">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" CssClass="ltxt"
                                            Visible="false"></asp:TextBox><br />
                                        <asp:TextBox ID="txtSupplierNM" runat="server" MaxLength="50" Width="200" CssClass="ltxt"
                                            Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtSupplierMOB" MaxLength="10" Width="100" runat="server" CssClass="ltxt"
                                            Visible="false"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkCity" style="display:none;" CssClass="blackfnt" AutoPostBack="true" runat="server"
                                            Text="Select City" OnCheckedChanged="chkCityCheckedChanged"  />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trCity" CssClass="nrow" Visible="true" runat="server">
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblFromCity" CssClass="nfnt" Text="From City"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtFromCity" runat="server" MaxLength="35" Width="80px" CssClass="ltxt"></asp:TextBox>
										<xac:WebxComplete ID="WebxComplete3" MinPrefixLength="1" FilterString="345" WebxEntity="City"
                                            runat="server" CodeTarget="txtFromCity" />
										<asp:HiddenField ID="hdnFromCity" runat="server" ></asp:HiddenField>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lblToCity" CssClass="nfnt" Text="TO City"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtToCity" runat="server" MaxLength="35" Width="80px" CssClass="ltxt"></asp:TextBox>
										<xac:WebxComplete ID="WebxComplete2" MinPrefixLength="1" FilterString="345" WebxEntity="City"
                                            runat="server" CodeTarget="txtToCity" />
										<asp:HiddenField ID="hdnToCity" runat="server" ></asp:HiddenField>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="Label8" CssClass="nfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trContractDetails" CssClass="nrow" runat="server">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:CheckBox ID="chkAdHocContract" runat="server" Text="Use Ad-hoc Amount" onclick="javascript:return onAdhocChange(this);" Enabled="false" />
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="4">
                                        <font class="bluefnt">Active Contract : </font>
                                        <asp:Label ID="lblActiveContract" runat="server" Text="None" CssClass="bluefnt"></asp:Label>
                                        <asp:HiddenField ID="hdnActiveContractDesc" runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <%--Add for changes of project P005871--%>
                                <asp:TableRow ID="TableCEWBNo" CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblCEWBNo" CssClass="nfnt" Text="CEWB No"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtCEWBNo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                    </asp:TableCell>
                                     <asp:TableCell ColumnSpan="4">
                                        <asp:CheckBox ID="chkIsTransshipment" runat="server" Text="Transshipment" onclick="javascript:return OnChkIsTransshipmentChange(this);" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <%--ENd--%>
                                 <asp:TableRow ID="tblRowTransshipment" CssClass="nrow">
                                    
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblTransitLocation" CssClass="nfnt" Text="Transit Location"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell >
                                        <asp:TextBox ID="txtTransitLocation" CssClass="ltxtm" runat="server" Width="100" onblur="return OnTransitLocationChange();"></asp:TextBox>
										<xac:WebxComplete ID="WebxComplete1" MinPrefixLength="1" FilterString="345" WebxEntity="BranchCode"
                                            runat="server" CodeTarget="txtTransitLocation" />
                                        <asp:HiddenField ID="hdnTransitLocation" runat="server"></asp:HiddenField>
                                    </asp:TableCell>
                                     <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblTransitRemark" CssClass="nfnt" Text="Transit Remark"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell >
                                        <asp:TextBox ID="txtTransitRemark" CssClass="ltxtm" TextMode="MultiLine" row="2" runat="server" MaxLength="250" Width="100"></asp:TextBox>
                                    </asp:TableCell>
                                     <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblTransitTentativeFreight" CssClass="nfnt" Text="Tentative Freight"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell >
                                         <asp:TextBox ID="txtTransitTentativeFreight" CssClass="ltxtm" runat="server" Text="0.0" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Width="100"></asp:TextBox> 
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trRouteModeAir1" CssClass="hrow" Visible="false">
                                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                                        <asp:Table ID="tblRouteModeAir" runat="server" CssClass="stbl" CellSpacing="1" Width="900">
                                            <asp:TableRow CssClass="hrow">
                                                <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                                    <asp:Label runat="server" ID="lblAirModeDetails" Font-Bold="true" CssClass="hfnt"
                                                        Text="Flight Information"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblAirport" CssClass="nfnt" Text="Airport"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList runat="server" ID="dllAirport" AutoPostBack="true" DataTextField="Airportname"
                                                        DataValueField="Airportcode">
                                                    </asp:DropDownList>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblAiline" CssClass="nfnt" Text="Airline Name"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList runat="server" ID="dllAirline" AutoPostBack="true" DataTextField="Codedesc"
                                                        DataValueField="Codeid" OnSelectedIndexChanged="OnAirLineChange">
                                                    </asp:DropDownList>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblFilghtNo" CssClass="nfnt" Text="Flight No"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList runat="server" ID="dllFilghtNo" AutoPostBack="true" DataTextField="Flightnumber"
                                                        DataValueField="Flightcode">
                                                        <%--OnSelectedIndexChanged="OnFlightChange"--%>
                                                    </asp:DropDownList>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblFlgSchDeptTimeCP" CssClass="nfnt" Text="Flight Sch. Dept. Time">
                                                    </asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label ID="lblFlgSchDeptTime" runat="server" CssClass="blackfnt"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblAWBNo" CssClass="nfnt" Text="AWB No"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtAWBNo" runat="server" Width="75" MaxLength="50">
                                                    </asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="Label12" CssClass="nfnt" Text=""></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trRouteModeTrain1" CssClass="hrow" Visible="false">
                                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                                        <asp:Table ID="tblRouteModeTrain" runat="server" CssClass="stbl" CellSpacing="1"
                                            Width="900">
                                            <asp:TableRow CssClass="hrow">
                                                <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                                    <asp:Label runat="server" ID="Label2" Font-Bold="true" CssClass="hfnt" Text="Train Information"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblTrainName" CssClass="nfnt" Text="Train Name"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtTrainName" runat="server" Width="200" MaxLength="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblTrainNo" CssClass="nfnt" Text="Train No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtTrainNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblRRNo" CssClass="nfnt" Text="RR No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtRRNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trRouteModeRoad" CssClass="hrow" Visible="false">
                                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                                        <asp:Table ID="tblRouteModeRoad" runat="server" CssClass="stbl" CellSpacing="1" Width="900">
                                            <asp:TableRow ID="trVehicleDetails" CssClass="hrow">
                                                <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                                    <asp:Label runat="server" ID="Label3" Font-Bold="true" CssClass="hfnt" Text="Vehicle Information"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblVehicle" CssClass="nfnt" Text="Vehicle "></asp:Label>
                                                    <br />
                                                    <asp:Label runat="server" ID="lblmktVehicle" Visible="false" CssClass="nfnt" Text="Upload Vehicle Image"></asp:Label>
                                                    <asp:Label runat="server" ID="lblTripsheet" CssClass="nfnt" Text="Select Tripsheet No"
                                                        Visible="false"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="true">
                                                    <asp:DropDownList runat="server" ID="dllVehicle" DataTextField="DispVehicle" DataValueField="VEHNO"
                                                        AutoPostBack="true" OnSelectedIndexChanged="OnVehicleChange">
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtMarketVehicle" Visible="false" runat="server" Width="200" MaxLength="10"
                                                        OnBlur="Javascript:return VehUpperCase(this.getAttribute('id'))"></asp:TextBox>
                                                    <br />
                                                     <%--<asp:DropDownList runat="server" ID="cboTripSheet" AutoPostBack="true" DataSourceID="MySQLDataSource_TS"
                                                        DataTextField="VSlipNo" DataValueField="CodeSlipNo" OnSelectedIndexChanged="OnTSChange"
                                                        Visible="false">
                                                    </asp:DropDownList>--%>
                                                    <asp:DropDownList runat="server" ID="cboTripSheet" AutoPostBack="true" 
                                                        DataTextField="VSlipNo" DataValueField="CodeSlipNo" OnSelectedIndexChanged="OnTSChange"
                                                        Visible="false">
                                                    </asp:DropDownList>
                                                    <asp:FileUpload ID="uplfMarketVehicle" Width="200" runat="server" CssClass="blackfnt"
                                                        EnableViewState="true" Visible="false" />
                                                    <asp:ImageButton ID="btnMarketVehicleAttch" runat="server" CausesValidation="false"
                                                        OnClick="btnAddAttachments_Click" ImageUrl="~/GUI/images/add.gif" CommandName="VEHICLEPHOTO"
                                                        Visible="false" />
                                                    <asp:Label runat="server" ID="lblMarketVehicleFileStatus" CssClass="nfnt" Text=""></asp:Label>
                                                    <asp:HiddenField ID="hdnMarketVehicleFileNM" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblVehicleType" CssClass="nfnt" Text="Vehicle Type"></asp:Label>
                                                    <br />
                                                    <asp:Label runat="server" ID="lblFTLType" CssClass="nfnt" Text="FTL Type"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList runat="server" ID="dllVehicleTypes" AutoPostBack="true" DataTextField="Type_Name"
                                                        DataValueField="TypeCode" OnSelectedIndexChanged="OnVehicleTypesChanged">
                                                    </asp:DropDownList>
                                                    <br />
                                                    <asp:DropDownList ID="dllFTLType" runat="server" DataTextField="CodeDesc" DataValueField="CodeID">
                                                    </asp:DropDownList>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblVehicleRegdate" CssClass="nfnt" Text="Vehicle Regn Date"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtVehicleRegdate" CssClass="ltxtm" runat="server" MaxLength="10"
                                                        Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtVehicleRegdate,'a2','dd/MM/yyyy'); return false;"
                                                        id="a2">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblEngineNo" CssClass="nfnt" Text="Engine No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtEngineNo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblChasisNo" CssClass="nfnt" Text="Chasis No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtChasisNo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="RCBookNo" CssClass="nfnt" Text="RC Book No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtRCBookNo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblCertificateNo" CssClass="nfnt" Text="Certificate No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtCertificateNo" CssClass="ltxtm" runat="server" MaxLength="15"
                                                        Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblInsuranceNo" CssClass="nfnt" Text="Insurance No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtInsuranceNo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblvehRTONo" CssClass="nfnt" Text="RTO No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtRTONo" CssClass="ltxtm" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow2" CssClass="nrow">
                                                <asp:TableCell Wrap="false">
                                                    <asp:Label runat="server" ID="lblVehPermitDT" CssClass="nfnt" Text="Vehicle Permit Validity Date"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtVehPermitDT" CssClass="ltxtm" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtVehPermitDT,'a7','dd/MM/yyyy'); return false;"
                                                        id="a7">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="false">
                                                    <asp:Label runat="server" ID="lblInsDT" CssClass="nfnt" Text="Insurance Validity Date"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtInsDT" CssClass="ltxtm" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtInsDT,'a3','dd/MM/yyyy'); return false;"
                                                        id="a3">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="false">
                                                    <asp:Label runat="server" ID="lblFitnessDT" CssClass="nfnt" Text="Fitness Validity Date"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txFitnessDT" CssClass="ltxtm" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txFitnessDT,'a4','dd/MM/yyyy'); return false;"
                                                        id="a4">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>

                                            <asp:TableRow CssClass="hrow">
                                                <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                                    <asp:Label runat="server" ID="Label9" Font-Bold="true" CssClass="hfnt" Text="Driver Information"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblDriverName" CssClass="nfnt" Text="Driver Name "></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblDriveMobNo" CssClass="nfnt" Text="Driver Mob No. "></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblLicenceNo" CssClass="nfnt" Text="Licence No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblRTONo" CssClass="nfnt" Text="Issue By RTO"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblLicDate" CssClass="nfnt" Text="Licence Validity Date "></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="Label14" CssClass="nfnt" Text="Driver 1"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtDriver1" CssClass="ltxt" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtDriver1MOB" CssClass="rtxt" runat="server" MaxLength="10" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtLicence1" CssClass="ltxt" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtIssuedBy1" CssClass="ltxt" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtLicVDate1" CssClass="ltxt" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtLicVDate1,'a5','dd/MM/yyyy'); return false;"
                                                        id="a5">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="Label10" CssClass="nfnt" Text="Driver 2"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtDriver2" CssClass="ltxt" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtDriver2MOB" CssClass="rtxt" runat="server" MaxLength="10" Width="100"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtLicence2" CssClass="ltxt" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtIssuedBy2" CssClass="ltxt" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtLicVDate2" CssClass="ltxt" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtLicVDate2,'a5','dd/MM/yyyy'); return false;"
                                                        id="a6">
                                                        <img src="./../../images/calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="nrow" Visible="false">
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblDriverPhoto" CssClass="nfnt" Text="Driver Photo Upload"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:FileUpload ID="uplfDriverPhoto" Width="200" runat="server" CssClass="blackfnt" />
                                                    <asp:ImageButton ID="btnDriverAttch" runat="server" CausesValidation="false" OnClick="btnAddAttachments_Click"
                                                        ImageUrl="~/GUI/images/add.gif" CommandName="DRIVERPHOTO" />
                                                    <asp:Label runat="server" ID="lblDriverAttchStatus" CssClass="nfnt" Text=""></asp:Label>
                                                    <asp:HiddenField ID="hdnDriverFileNM" runat="server" />
                                                </asp:TableCell><asp:TableCell>
                                                    <asp:CheckBox ID="chkBrockrMemo" onclick="javascript:BrockrMemoYN();" runat="server"
                                                        Text="Brocker Memo" CssClass="blackfnt" />
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="true">
                                                    <asp:TextBox ID="txtBrockrMemo" runat="server" Enabled="false" CssClass="ltxt" Text="NO"
                                                        Width="30" MaxLength="3"></asp:TextBox>
                                                    <asp:FileUpload ID="uplfBrockrMemo" Width="200" runat="server" CssClass="blackfnt"
                                                        Enabled="false" />
                                                    <asp:ImageButton ID="btnBrockrMemoAttch" runat="server" CausesValidation="false"
                                                        OnClick="btnAddAttachments_Click" ImageUrl="~/GUI/images/add.gif" CommandName="BrockrMemo" />
                                                    <asp:Label runat="server" ID="lblBrockrMemoStatus" CssClass="nfnt" Text=""></asp:Label>
                                                    <asp:HiddenField ID="hdnBrockrMemoFileNM" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="true" ColumnSpan="2">
                                                    <asp:Label runat="server" ID="lbl_Error" CssClass="redfnt"></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow1" CssClass="nrow">
                                                <asp:TableCell Wrap="false">
                                                    <asp:Label runat="server" ID="lblLateDeptReason" CssClass="nfnt" Text="Late Dept. Reason [if any]"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList ID="dllLateDeptReason" runat="server" DataTextField="CodeDesc"
                                                        DataValueField="CodeID">
                                                    </asp:DropDownList>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblVehFreeSpace" CssClass="nfnt" Text="Out Veh. Free Space"></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtOVFS" runat="server" Text="0" CssClass="input" Width="30" MaxLength="3">
                                                    </asp:TextBox>
                                                    <font class="nfnt">%</font>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Label runat="server" ID="lblSealNo" CssClass="nfnt" Text="Seal No."></asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell Wrap="true">
                                                    <asp:TextBox ID="txtSealNo" runat="server" Text="Open Body" CssClass="ltxt" Width="100"
                                                        MaxLength="10" onchange="Javascript:return CheckSealNo(this);">
                                                    </asp:TextBox><asp:Image ID="imgSealNo" runat="server" Style="display: none" ImageUrl="~/GUI/images/tick.png" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">
                                        <asp:Button ID="btnStep1" Text="Step - 1" runat="server" CssClass="nbtn" OnClientClick="Javascript:return DATACHECK_Step1();"
                                            OnClick="btnStep1_Click" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trDocketdetails" CssClass="nrow" Visible="false" runat="server">
                        <asp:TableCell HorizontalAlign="Left" ID="tblDocketdetails" runat="server" ColumnSpan="6">
                            <asp:Table ID="Table2" runat="server" CssClass="stbl" CellSpacing="1" Width="100%">
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label runat="server" ID="lblLoadSupCode" CssClass="nfnt" Text="Loading Supervisor/Emp Code:"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtLoadSupCode" OnBlur="Javascript:return locTest(this.getAttribute('id'),'emptest');"
                                            CssClass="ltxtm" runat="server" Width="100" MaxLength="50"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label runat="server" ID="lbltxtStartKM" CssClass="nfnt" Text="Starting KMs."></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtStartKM" runat="server" CssClass="ltxtm" Width="50" MaxLength="6"
                                            onkeypress="javascript:return validInt(event);">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="true">
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label ID="lblvehcap" runat="server" Text="Vehicle Capacity :" CssClass="balckfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtVehicleCAP" Text="0.00" runat="server" CssClass="rtxt" Width="60"
                                            MaxLength="10" Enabled="false">
                                        </asp:TextBox><font class="blackfnt">kg</font>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblMand" runat="server" Text="*" CssClass="redfnt" Font-Bold="true"></asp:Label>
                                        <asp:Label ID="lblOutRemarks" runat="server" Text="Remarks :" CssClass="nfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtOutRemarks" CssClass="ltxt" TextMode="MultiLine" runat="server"
                                            Rows="2" Width="150"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkOVLoadYN" onclick="javascript:CHECKOvld();" runat="server" Text="Overload "
                                            CssClass="blackfnt" />
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="true">
                                        <asp:TextBox ID="txtOVLoadYN" runat="server" Enabled="false" CssClass="ltxt" Text="NO"
                                            Width="30" MaxLength="3"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell Wrap="false">
                                        <asp:Label ID="lblWeightLoaded" runat="server" Text="Weight loaded" CssClass="nfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtWtLoaded" Text="0.00" runat="server" Width="60" CssClass="rtxt"
                                            MaxLength="10" onchange="javascript:OnWtLoadChange();"> </asp:TextBox><font class="blackfnt">kg</font>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblVehicleCapUti" runat="server" Text="Capacity utilization" CssClass="nfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtVehicleCapUti" Text="0.00" runat="server" CssClass="ltxt" Width="60"
                                            MaxLength="10" Style="text-align: right;" Enabled="false">
                                        </asp:TextBox><font class="blackfnt">%</font>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblOverloadReason" runat="server" Text="Overload Reason" CssClass="nfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Wrap="true">
                                        <asp:DropDownList ID="dllOverloadreasn" Enabled="false" CssClass="nfnt" runat="server"
                                            DataTextField="CodeDesc" DataValueField="CodeID">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                        <asp:Label runat="server" ID="lblForMFDockets" Font-Bold="true" CssClass="hfnt" Text=""></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableCell ColumnSpan="6">
                                        <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle"
                                            AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                            OnRowDataBound="dgDocket_RowDataBound" Width="100%">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox runat="server" ID="SelectAllCheckBox" Text="" Onclick="Javascript:return SelectAll(this);" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkDocket" Text="" Onclick="Javascript:return ENABLED_ALLFIELDS(this);" />
                                                        <asp:HiddenField ID="hidWtLoad" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                                        <asp:HiddenField ID="hndgrdockdt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Dockdt_ddmmyyyy")%>' />
                                                        <asp:HiddenField ID="hdnDeclVal" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DECLVAL")%>' />
                                                        <asp:HiddenField ID="hdnEWBNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "EWBNo")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="CN #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <HeaderTemplate>
                                                        <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lblColname" runat="server"> </asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdnDktNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DOCKNO")%>' />
                                                        <asp:HiddenField ID="hdnDktSF" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DOCKSF")%>' />
                                                        <asp:HiddenField ID="hdnDktPkg" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                                        <asp:HiddenField ID="hdnDktWt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Dockdt_ddmmyyyy")%>'
                                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Trans. Mode" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnkTransMode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TransMode")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Bkg. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OrgCode")%>'
                                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
															<asp:HiddenField ID="hdnDktOrigin" Value='<%#DataBinder.Eval(Container.DataItem, "OrgCode") %>' runat="server" />	
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Dely. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnk" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReDestCode")%>'
                                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
															<asp:HiddenField ID="hdnDktDestination" Value='<%#DataBinder.Eval(Container.DataItem, "ReDestCode") %>' runat="server" />	
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="City From-To" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnkFromTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTo")%>'
                                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                                                    ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_DelyDate")%>'
                                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Pkgs.[L/P/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdpkgsno" Value='<%#DataBinder.Eval(Container.DataItem, "PackagesLB").ToString().Trim()%>'
                                                            runat="server" />
                                                        <asp:TextBox runat="server" Enabled="False" OnChange="Javascript:return ENABLED_WT(this);"
                                                            ID="txtPkgs" CssClass="rtxtm" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                                        <span class="bluefnt">/ </span>
                                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                        <span class="bluefnt">/ </span>
                                                        <asp:Label ID="lblBookedPkgs" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PKGSNO")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Wt.[L/P/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hdwt" Value='<%#DataBinder.Eval(Container.DataItem, "WeightLB").ToString().Trim()%>'
                                                            runat="server" />
                                                        <asp:TextBox runat="server" OnChange="Javascript:return CHK_WT(this);" Enabled="False"
                                                            ID="txtWt" Width="30" CssClass="rtxtm" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                                        <span class="bluefnt">/ </span>
                                                        <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                        <span class="bluefnt">/ </span>
                                                        <asp:Label ID="lblBookedWt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ACTUWT")%>'
                                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">
                                        <div id="tr_div_setp2" runat="server">
                                            <asp:Button ID="btnSumbitMF" Text="Sumbit" runat="server" CssClass="nbtn" Enabled="false"
                                                OnClick="btnSubmitDir_Click" OnClientClick="Javascript:return DATACHECK_Step2();" />
                                            <asp:Button ID="btnStep2" Text="Click For Payment Details" runat="server" CssClass="nbtn"
                                                OnClick="btnStep2_Click" OnClientClick="Javascript:return DATACHECK_Step2();" />
                                        </div>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <%--   <asp:TableRow CssClass="hrow" ID="trPaymentdetails" runat="server" Visible="false">
                        <asp:TableCell HorizontalAlign="Left" ColumnSpan="6">
                            <asp:Table ID="tblPaymentDetails" runat="server" CssClass="stbl" CellSpacing="1"
                                Width="100%">
                                <asp:TableRow ID="TableRow4" CssClass="hrow">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                        <asp:Label runat="server" ID="Label4" Font-Bold="true" CssClass="hfnt" Text="Payment Details"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:CheckBox ID="chkWtAdjCP" onclick="javascript:CHECKWTADJ();" runat="server" Font-Bold="true"
                                            Text="Weight Adjustment " CssClass="nfnt" />
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblContamt" runat="server" Text="Contract Amt." Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblStdContAmtCP" runat="server" Text="Standard Cont. Amt." Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblAdvamt" runat="server" Text="Advance Amount" Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblAdvPaidAt" runat="server" Text="Advance Amount Paid At" Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblBalPaidAt" runat="server" Text="Balance Amount Paid At" Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="nrow">
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblTotWt" runat="server" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField runat="server" ID="hdnTotWt" Value="0" />
                                        <asp:DropDownList ID="dllWtAdj" Enabled="false" CssClass="nfnt" runat="server">
                                            <asp:ListItem Text="+" Value="+"></asp:ListItem>
                                            <asp:ListItem Text="-" Value="-"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtWtAdj" Enabled="false" Style="text-align: right;" runat="server"
                                            CssClass="ltxt" Width="60" Text="0.00" OnTextChanged="WTADJ_Contamt" AutoPostBack="true"
                                            MaxLength="10">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:TextBox ID="txtContamt" runat="server" Width="80" CssClass="rtxt">
                                        </asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:Label ID="lblStdContAmt" runat="server" Text="" Font-Bold="true"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:TextBox ID="txtAdvamt" runat="server" Width="80" CssClass="rtxt"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:TextBox ID="txtAdvPaidAt" OnBlur="Javascript:return locTest(this.getAttribute('id'),'loctest');"
                                            runat="server" Width="80" CssClass="ltxt"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Center">
                                        <asp:TextBox ID="txtBalPaidAt" OnBlur="Javascript:return locTest(this.getAttribute('id'),'loctest');"
                                            runat="server" Width="80" CssClass="ltxt"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="TableRow3" CssClass="hrow">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                                        <asp:Label runat="server" ID="Label5" Font-Bold="true" CssClass="hfnt" Text="Other Charges Details"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="hrow">
                                    <asp:TableCell ColumnSpan="6">
                                        <asp:Table ID="Table3" runat="server" CssClass="stbl" CellSpacing="1" Width="100%">
                                            <asp:TableRow CssClass="hrow">
                                                <asp:TableCell HorizontalAlign="Left">
                                                    <asp:Repeater ID="reptHeader" runat="server" OnItemDataBound="reptHeader_OnItemDataBound">
                                                        <ItemTemplate>
                                                            <td align="center">
                                                                <asp:Label ID="lblTitle" runat="server"></asp:Label>
                                                                <asp:HiddenField ID="hidChargeCode" runat="server" />
                                                            </td>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="hrow">
                                                <asp:TableCell>
                                                    <asp:Repeater ID="reptItemDet" runat="server" OnItemDataBound="reptItemDet_OnItemDataBound">
                                                        <ItemTemplate>
                                                            <td bgcolor="white" align="center">
                                                                <asp:TextBox ID="txtCharge" runat="server" Width="80" CssClass="rtxt"></asp:TextBox>
                                                            </td>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>--%>

                    <asp:TableRow CssClass="nrow" ID="trPaymentDetails_Own" runat="server" Visible="false">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">

                            <%--<tr style="background-color: White" id="trPaymentDetails_Own" runat="server" visible="false">
                        <td align="left" colspan="4" valign="top">--%>
                            <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <font class="blackfnt"><b>Payment Details</b></font>
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td align="left">
                                        <font class="blackfnt">Standard Contract Amount</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label Width="70px" Style="text-align: left;" Text="0.00" CssClass="bluefnt"
                                            ID="lblStdContractAmountOWN" runat="server"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="blackfnt">Contract Amount</font>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="txtContractAmountOWN"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:TableCell>
                    </asp:TableRow>


                    <asp:TableRow CssClass="nrow" ID="trPaymentDetails" runat="server" Visible="false">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">
                            <%--<tr style="background-color: White" id="trPaymentDetails" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">--%>
                            <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="6">
                                        <font class="blackfnt"><b>Payment Details</b></font>
                                    </td>
                                </tr>
                                <tr style="background-color: White">
                                    <td align="left" colspan="6">
                                        <table width="800px">
                                            <tr>
                                                <td>
                                                    <table cellspacing="1" class="boxbg" style="width: 100%;">
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Standard Contract Amout</td>
                                                            <td align="left">
                                                                <asp:Label Width="70px" Style="text-align: right;" Text="0.00" CssClass="bluefnt"
                                                                    ID="stdpcamt" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Contract Amount (+)</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="contractamt" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Telephone Chargtes
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="tel_chrg" runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Hamali
                                                            <asp:DropDownList ID="loadOpertype" runat="server" onblur="javascript:fbalamt();">
                                                                <asp:ListItem Value="P">(+)</asp:ListItem>
                                                                <asp:ListItem Value="M">(-)</asp:ListItem>
                                                            </asp:DropDownList>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" ID="load_chrg" Text="0.00" onblur="javascript:fbalamt();"
                                                                    runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Mamul (-)
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="mamul_chrg" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">TDS Rate (%)</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="tds_rate" runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">TDS Amount (-)</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="tds_chrg" runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Service Tax Rate (%)</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="svtax_rate" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Service Tax (+)
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="svrcamt" runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Cess (+)
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="cessamt" onblur="javascript:fbalamt();"
                                                                    runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Higher Cess (+)
                                                            </td>
                                                            <td align="left">
                                                                <asp:HiddenField Value="0" ID="txtcwt" runat="server" />
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="hcessamt" onblur="javascript:fbalamt();"
                                                                    runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td valign="top">
                                                    <table cellspacing="1" class="boxbg" style="width: 100%;">
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">TDS Type
                                                            </td>
                                                            <td align="left">
                                                                <asp:HiddenField Value="0" ID="txtheight" runat="server" />
                                                                <asp:HiddenField Value="0" ID="txtdetentionchg" runat="server" />
                                                                <asp:HiddenField Value="0" ID="txtmultipt" runat="server" />
                                                                <asp:DropDownList ID="tdsacccode" runat="server" DataSourceID="MySQLDataSource_TDSAccCode"
                                                                    DataTextField="dispval" DataValueField="acccode">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Party PAN Number
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: left;" onblur="javascript:return validpanno(this);"
                                                                    ID="pan_no" runat="server"></asp:TextBox>
                                                                <asp:HiddenField Value="0" ID="advanceamt_paid" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Advance Amount</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="advanceamt" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">Advance Amount Paid By
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: left;" onblur="javascript:fbalamt();this.value=this.value.toUpperCase();"
                                                                    ID="advpaidby" runat="server"></asp:TextBox>
                                                                <asp:HiddenField runat="server" ID="netpayamt" Value="0" />
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">
                                                                <b>Balance Amount</b>
                                                            </td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Enabled="false" Style="text-align: right;" ID="balamt"
                                                                    runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left">
                                                                <b>Balance Payable At</b></td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: left;" ID="balamtbr" onblur="javascript:return balPayAtBlur(this.value)"
                                                                    runat="server"></asp:TextBox>
																	<asp:HiddenField runat="server" ID="hdnBalamtbr" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table cellspacing="1" class="boxbg" style="width: 100%;">
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left" style="width: 199px">Advance Cash</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="txtAdvanceCash" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left" style="width: 199px">Advance Cheque</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="txtAdvanceCheque" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left" style="width: 199px">Other Advance</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="txtOtherAdvance" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr class="blackfnt" bgcolor="#ffffff">
                                                            <td align="left" style="width: 199px">Total Advance</td>
                                                            <td align="left">
                                                                <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                    ID="txtTotalAdvance" runat="server" Enabled="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow CssClass="nrow" ID="trSubmit" Visible="false">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="6">
                            <%--<asp:Button ID="btnSubmit" Text="Submit" runat="server" CssClass="nbtn" OnClick="btnStep3_Click"
                                OnClientClick="Javascript:return DATACHECK_Step3();" />--%>

                            <asp:Button ID="btnSubmit" Text="Submit" runat="server" CssClass="nbtn" OnClick="btnStep3_Click"
                                OnClientClick="Javascript:return GenerateTHC();" />
								<asp:HiddenField ID="hidClickCount" runat="server" Value="0" />
	
                        </asp:TableCell>
                    </asp:TableRow>

                </asp:Table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 100;">
    </div>
</asp:Content>
