<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmNewVehicleIssueSlipNewWORequest.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewVehicleIssueSlipNewWORequest" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
<%@ Register TagName="AutoComplete1" TagPrefix="xac" Src="~/GUI/Fleet/Operations/Issue/AutoComplete1/AMAC.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="auc" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MAC.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="aucD2" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACD2.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="aucCl" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACCl.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripGenerate_New.js?vs=1236"></script>
    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">
       
    </script>
    <script type="text/javascript">
        var foo = false;
        var styleToSelect;
        function onOk() { }


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
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel9">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="800px">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell HorizontalAlign="left" Width="45%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="TRIP SHEET >> ISSUE NEW WITHOUT REQUEST" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:Table ID="Table2" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                class="boxbg" Width="800px" BorderWidth="0">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">TRIPSHEET SUMMARY</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlTripSummaryHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblTripHdrError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlTripSummaryDet" runat="server">
                                        <asp:Table ID="Table3" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                            class="boxbg" Width="800px" BorderWidth="0">
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
                                                                <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10"
                                                                    Width="60px"></asp:TextBox><ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt"
                                                                        Format="dd/MM/yyyy" TargetControlID="txtDate" runat="server" />
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
                                                        <asp:Label ID="lbl_Manual_TS_Err" runat="server" CssClass="balckfnt" ForeColor="Red"></asp:Label><asp:UpdatePanel
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
                                            <asp:TableRow Style="background-color: white">
                                                <asp:TableCell HorizontalAlign="left">
                  <font class="bluefnt">Start Location</font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left">
                                                    <font class="bluefnt">
                                                        <asp:TextBox ID="txtStartLoc" runat="server" BorderStyle="None" Width="50" MaxLength="5"
                                                            ReadOnly="true"></asp:TextBox>
                                                        <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                                                        <asp:HiddenField ID="hfAttached" runat="server" Value="" />
                                                        <asp:HiddenField ID="hdndieselCF" runat="server" />
                                                    </font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color="red">*</font> <font class="bluefnt">End Location</font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left">
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
                                                        <asp:RequiredFieldValidator ID="ReqEndLoc" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtEndLoc" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                    </font>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server"
                                        TargetControlID="pnlTripSummaryDet" Collapsed="false" ExpandControlID="pnlTripSummaryHdr"
                                        CollapseControlID="pnlTripSummaryHdr" AutoCollapse="False" TextLabelID="lblTripHdrError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Vehicle Details</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlVehicleHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblVehicleError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlVehicleDet" runat="server">
                                        <asp:Table ID="tblVehicleHdr" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                            class="boxbg" Width="800px" BorderWidth="0">
                                            <asp:TableRow ID="TableRow2" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Select Vehicle No.</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Always">
                                                        <ContentTemplate>
                                                            <asp:TextBox ID="txtVehno" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10"
                                                                Width="75px"></asp:TextBox>
                                                            <asp:TextBox ID="txtVehno_Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                                Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                                            <%--<xac:WebxComplete ID="xacVehicle" MinPrefixLength="2" WebxEntity="Vehicle" runat="server"
                                                                CodeTarget="txtVehno" NameTarget="txtVehno_Name" />--%>
                                                            <xac:AutoComplete1 ID="xacVehicle" MinPrefixLength="2" runat="server" WebxEntity="Vehicle"
                                                                CodeTarget="txtVehno" NameTarget="txtVehno_Name" />
                                                            <asp:HiddenField ID="hfVehicleLocation" runat="server" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <font class="blackfnt" color="red">*</font> <font class="bluefnt">Model </font>
    
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtVehModel" runat="server" BorderStyle="None" MaxLength="10" onfocus="this.blur()"
                                                        Width="200px"></asp:TextBox>
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
                                            <font class="blackfnt" color="red">*</font> <font class="bluefnt">Capacity </font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtVehCapacity" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                        MaxLength="10" Width="200px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow4" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Opening KM</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtVehOpnKM" runat="server" BorderStyle="None" MaxLength="10" onfocus="this.blur()"
                                                        Width="200px"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <font class="blackfnt" color="red">*</font> <font class="bluefnt">Opening Fuel (LTRS) </font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtVehOpnFuel" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                        MaxLength="10" Width="200px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow5" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Vendor Name</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left">
                                                    <asp:TextBox ID="txtVendorName" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                        Width="200px"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                            <font class="blackfnt" color="red">*</font> <font class="bluefnt">Opening Fuel Amount </font>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtVehOpnFuelAmt" runat="server" BorderStyle="None" onfocus="this.blur()"
                                                        MaxLength="10" Width="200px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="ROW_DIESEL_BALANCE" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Diesel Balance Qty. (in Ltr)</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="txtDieselCarryForward" MaxLength="25" runat="server" Style="text-align: right"
                                                        BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
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
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                        TargetControlID="pnlVehicleDet" Collapsed="false" ExpandControlID="pnlVehicleHdr"
                                        CollapseControlID="pnlVehicleHdr" AutoCollapse="False" TextLabelID="lblVehicleError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="TableRow16436" Style="background-color: white" runat="server">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Driver Details</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlDriverHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblDriverError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlDriverDet" runat="server">
                                        <asp:Table ID="Table4" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                            class="boxbg" Width="800px" BorderWidth="0">
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
                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline" UpdateMode="always">
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
                                                    <asp:TextBox ID="txtDriver1" runat="server" BorderStyle="Groove" MaxLength="10" CssClass="input"
                                                        Width="75px"></asp:TextBox>
                                                    <asp:TextBox ID="txtDriver1Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                        Width="100px" BorderStyle="Groove"></asp:TextBox><br />
                                                    <asp:TextBox ID="txtDriver1NotFromRoster" runat="server" BorderStyle="Groove" Enabled="false"
                                                        CssClass="input" Width="150px" Visible="false"></asp:TextBox>
                                                    <asp:HiddenField ID="hfDriver1ID" runat="Server" Value="" />
                                                    <%--<xac:WebxComplete ID="xacDriver" MinPrefixLength="2" WebxEntity="Driver" runat="server"
                                                        CodeTarget="txtDriver1" NameTarget="txtDriver1Name" />--%>
                                                    <auc:AutoComplete ID="aucDriver" MinPrefixLength="1" runat="server" WebxEntity="Driver"
                                                        CodeTarget="txtDriver1" NameTarget="txtDriver1Name" />
                                                    <asp:HiddenField ID="hf_Manual_Driver1_Code" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_Photo" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_photo_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriverLic_Validity" runat="server" />
                                                    <asp:HiddenField ID="hfDriverLic_Validity_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_TripCount" runat="server" />
                                                    <asp:HiddenField ID="hfDriver_TripCount_Rule" runat="server" />
                                                    <asp:HiddenField ID="hfTot_No_Trip" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
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
                                            <asp:TableRow ID="TableRow9" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">License no.</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblDriver1Licno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblDriver2Licno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblCleanerLicno" runat="server" Style="text-align: left" BorderStyle="None"
                                                        onfocus="this.blur()" Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow10" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Valid upto date</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblDriver1ValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        Width="150px"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" TargetControlID="lblDriver1ValidDt"
                                                        runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblDriver2ValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        Width="150px"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender4" Format="dd/MM/yyyy" TargetControlID="lblDriver2ValidDt"
                                                        runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="lblCleanerValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                                        onfocus="this.blur()" Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
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
                                                    <asp:TextBox ID="TextBox20" runat="server" BorderStyle="None" Text="NA" MaxLength="10"
                                                        onfocus="this.blur()" Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:TextBox ID="TextBox22" runat="server" BorderStyle="None" Text="NA" MaxLength="10"
                                                        onfocus="this.blur()" Width="150px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="TableRow13" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Advance to be paid</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px" ColumnSpan="3">
                                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                        <ContentTemplate>
                                                            <asp:CheckBox ID="chkAdvanceFlag" runat="server" AutoPostBack="true" OnCheckedChanged="chkAdvanceFlag_CheckedChanged" />
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="chkAdvanceFlag" EventName="CheckedChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                                        TargetControlID="pnlDriverDet" Collapsed="false" ExpandControlID="pnlDriverHdr"
                                        CollapseControlID="pnlDriverHdr" AutoCollapse="False" TextLabelID="lblDriverError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="background-color: white" ID="tblTripBilling" runat="server">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="lbllablel444" CssClass="blackfnt" Font-Bold="true" runat="server"
                                        Width="500px">Trip Billing Selection</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlTripSelectionHdr" runat="server" Width="25px">
                                        <asp:Label ID="pnlTripSelectionError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlTripSelectionDet" runat="server">
                                        <asp:Table ID="Table8" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                            class="boxbg" Width="800px" BorderWidth="0">
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
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender622" runat="Server"
                                        TargetControlID="pnlTripSelectionDet" Collapsed="false" ExpandControlID="pnlTripSelectionHdr"
                                        CollapseControlID="pnlTripSelectionHdr" AutoCollapse="False" TextLabelID="pnlTripSelectionError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Route Selection</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlRouteSelectionHdr" runat="server" Width="25px">
                                        <asp:Label ID="pnlRouteSelectionError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlRouteSelectionDet" runat="server">
                                        <asp:Table ID="Table5" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                            class="boxbg" Width="800px" BorderWidth="0">
                                            <asp:TableRow ID="TableRow14" Style="background-color: white" runat="server">
                                                <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Route Type</font> 
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="left" Width="200px">
                                                    <asp:UpdatePanel ID="UpdatePanel6" runat="server" RenderMode="Inline" UpdateMode="always">
                                                        <ContentTemplate>
                                                            <asp:DropDownList ID="ddlRouteType" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlRouteType_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                            <asp:Label ID="lblRouteError" runat="server" Text=""></asp:Label>
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
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender5" runat="Server"
                                        TargetControlID="pnlRouteSelectionDet" Collapsed="false" ExpandControlID="pnlRouteSelectionHdr"
                                        CollapseControlID="pnlRouteSelectionHdr" AutoCollapse="False" TextLabelID="pnlRouteSelectionError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="tblAdvanceEntry" Style="background-color: white" runat="server"
                    Visible="false">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
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
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlAdvanceDet" runat="server">
                                        <asp:Table ID="tbl_Driver_Adv" runat="server" CellSpacing="1" CellPadding="3" Style="width: 800px"
                                            class="boxbg" border="0">
                                            <asp:TableRow class="bgbluegrey" Style="background-color: white">
                                                <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                        <font class=blackfnt><b>Details of Advance Taken</b></font></asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow Style="background-color: white">
                                                <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                                    <asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Label ID="lbl_dgAdvanceDet_Err" CssClass="redfnt" runat="server" Text=""></asp:Label>
                                                            <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                                CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                                BorderWidth="3px" Width="800px">
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
                                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                    </asp:TemplateColumn>
                                                                    <asp:TemplateColumn HeaderText="Place">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtAdvPlace" CssClass="input" runat="server" Width="150px" BorderStyle="Groove"
                                                                                MaxLength="50"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                    </asp:TemplateColumn>
                                                                    <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtAdvDt" CssClass="input" onblur="CheckAdvDt()" runat="server"
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
                                                                    </asp:TemplateColumn>
                                                                    <asp:TemplateColumn HeaderText="Amount">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtAdvAmt" CssClass="input" onblur="FillPaymentAmt()" runat="server"
                                                                                Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                            <%--OnTextChanged="PopulateAdvamt"  AutoPostBack="true"--%>
                                                                            <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                                SetFocusOnError="true" ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                    </asp:TemplateColumn>
                                                                    <asp:TemplateColumn HeaderText="Branch Code">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtBranchCode" CssClass="input" runat="server" onBlur="CheckValidBranchCode(this)"
                                                                                Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                    </asp:TemplateColumn>
                                                                    <asp:TemplateColumn HeaderText="Advance Paid By">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtSignature" CssClass="input" runat="server" Width="100px" BorderStyle="Groove"
                                                                                MaxLength="50"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                            Font-Underline="False" Wrap="False" />
                                                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                            <asp:HiddenField ID="hfPaymentAmount" runat="server" />
                                                            <asp:UpdatePanel ID="UpdatePanelpayment" runat="server" UpdateMode="Always">
                                                                <ContentTemplate>
                                                                    <UC2:UCPaymentControl ID="UCPayment" runat="server"></UC2:UCPaymentControl>
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:TableCell>
                                                    </asp:TableRow>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                                        TargetControlID="pnlAdvanceDet" Collapsed="false" ExpandControlID="pnlAdvanceHdr"
                                        CollapseControlID="pnlAdvanceHdr" AutoCollapse="False" TextLabelID="lblAdvanceError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <%--//////////////////////////////////////////////////////////////////////////////--%><asp:TableRow
                    ID="TableFuelSlip" Style="background-color: white" runat="server" Visible="false">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Fuel Slip Details</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlFuelSlipHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblFuelSlipError" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlFuelSlipDet" runat="server">
                                        <asp:Table ID="Table7" runat="server" CellSpacing="1" CellPadding="3" Style="width: 800px"
                                            class="boxbg" border="0">
                                            <asp:TableRow class="bgbluegrey" Style="background-color: white">
                                                <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                        <font class=blackfnt><b>Details of Fuel Slip</b></font></asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow Style="background-color: white">
                                                <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                                    <asp:TableRow>
                                                        <asp:TableCell>
                                                            <asp:Table ID="TableFuelSlip123" runat="server" CellSpacing="1" CellPadding="3" Style="width: 800px"
                                                                class="boxbg" border="0">
                                                                <asp:TableRow class="bgbluegrey">
                                                                    <asp:TableCell ColumnSpan="4" HorizontalAlign="center"><font class=blackfnt><b>Fuel Slip Entrip</b></font></asp:TableCell>
                                                                </asp:TableRow>
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
                                                                                <asp:Label ID="Label4" CssClass="redfnt" runat="server" Text=""></asp:Label>
                                                                                <asp:GridView ID="gvFuelSlip" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                                                                    SelectedIndex="1" ShowFooter="true" OnRowDataBound="gvFuelSlip_RowDataBound"
                                                                                    Width="700px" BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Sr. No.">
                                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Slip Type (Fuel/Cash)">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                                    <ContentTemplate>
                                                                                                        <asp:DropDownList ID="ddlFuelType" runat="server" Width="130px" Style="text-align: left"
                                                                                                            BorderStyle="Groove" OnSelectedIndexChanged="ddlFuelType_SelectedIndexChanged"
                                                                                                            AutoPostBack="true">
                                                                                                        </asp:DropDownList>
                                                                                                    </ContentTemplate>
                                                                                                </asp:UpdatePanel>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Fuel Slip No.">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:TextBox ID="txtFuelSlipNo" CssClass="input" Width="120px" Style="text-align: left"
                                                                                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FuelSlipNo") %>'
                                                                                                    BorderStyle="Groove"></asp:TextBox>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            <FooterTemplate>
                                                                                                <asp:Label ID="lblHdr6764" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                                                                            </FooterTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Fuel Vendor">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:DropDownList ID="ddlFuelVendor" runat="server" Width="250px" Style="text-align: left"
                                                                                                    BorderStyle="Groove">
                                                                                                </asp:DropDownList>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                        </asp:TemplateField>

                                                                                        <%--Added By Anupam --%>
                                                                                        <asp:TemplateField HeaderText="Fuel Type">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="always">
                                                                                                    <ContentTemplate>
                                                                                                        <asp:DropDownList ID="ddlFuelTypePD" runat="server" Width="130px" Style="text-align: left"
                                                                                                            BorderStyle="Groove"
                                                                                                            AutoPostBack="true">
                                                                                                        </asp:DropDownList>
                                                                                                    </ContentTemplate>
                                                                                                </asp:UpdatePanel>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                        </asp:TemplateField>

                                                                                        <asp:TemplateField HeaderText="From City">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:TextBox ID="txtFromCity" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'
                                                                                                    Width="120px" CssClass="input" MaxLength="20" BorderStyle="Groove"></asp:TextBox>
                                                                                                <div class="blackfnt">
                                                                                                    <ajaxToolkit:AutoCompleteExtender ID="Extender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                                                                        ServiceMethod="GetFUelCity" CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                                                                        ServicePath="../../../services/WebService.asmx" TargetControlID="txtFromCity">
                                                                                                    </ajaxToolkit:AutoCompleteExtender>
                                                                                                </div>
                                                                                                <asp:HiddenField ID="hdFromCityCode" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"FromCityCode") %>' />
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            <FooterTemplate>
                                                                                                <asp:TextBox ID="txtFromCityFoo" Width="120px" Style="text-align: right" runat="server"
                                                                                                    Font-Bold="true" BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                                                                            </FooterTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <%--Added By Anupam --%>


                                                                                        <asp:TemplateField HeaderText="Quantity in Liter">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:TextBox ID="txtQtyLiter" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"QtyLiter") %>'
                                                                                                    Width="120px" Style="text-align: right" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                                                                    MaxLength="10" BorderStyle="Groove"></asp:TextBox>
                                                                                                <%--<asp:RegularExpressionValidator ID="RegtxtQtyLiter" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                SetFocusOnError="true" ControlToValidate="txtQtyLiter" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            <FooterTemplate>
                                                                                                <asp:TextBox ID="txtTotalDieselFilled" Width="120px" Style="text-align: right" runat="server"
                                                                                                    Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                                                            </FooterTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <%--style="text-align:right" --%>
                                                                                        <asp:TemplateField HeaderText="Rate">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:TextBox ID="txtRate" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Rate") %>'
                                                                                                    Width="120px" MaxLength="10" onfocus="this.blur()" CssClass="input" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                                                                <%-- <asp:RegularExpressionValidator ID="RegRate" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                SetFocusOnError="true" ControlToValidate="txtRate" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Amount">
                                                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                                                                            <ItemTemplate>
                                                                                                <asp:TextBox ID="txtAmount" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'
                                                                                                    Width="120px" MaxLength="10" BorderStyle="None"></asp:TextBox>
                                                                                                <asp:HiddenField ID="hdSrNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>' />


                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                                                                            <FooterTemplate>
                                                                                                <asp:TextBox ID="txtTotalAmount" Width="120px" Style="text-align: right" runat="server"
                                                                                                    Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                                                            </FooterTemplate>
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                                                                        CssClass="bgbluegrey" />
                                                                                </asp:GridView>
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
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender99" runat="Server"
                                        TargetControlID="pnlFuelSlipDet" Collapsed="false" ExpandControlID="pnlFuelSlipHdr"
                                        CollapseControlID="pnlFuelSlipHdr" AutoCollapse="False" TextLabelID="lblFuelSlipError"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <%--//////////////////////////////////////////////////////////////////////////////--%><asp:TableRow
                    class="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" ValidationGroup="main"
                            OnClick="SubmitData" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
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
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
