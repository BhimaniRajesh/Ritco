<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmNewTripDetailsUpdate.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewTripDetailsUpdate" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
<%@ Register TagName="AutoComplete1" TagPrefix="xac" Src="~/GUI/Fleet/Operations/Issue/AutoComplete1/AMAC.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="auc" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MAC.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="aucD2" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACD2.ascx" %>
<%@ Register TagName="AutoComplete" TagPrefix="aucCl" Src="~/GUI/Fleet/Operations/Issue/AutoComplete/MACCl.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripClosureV2.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripDetailsUpdate.js"></script>
    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 800px">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Update Trip Details </asp:Label>
                <asp:HiddenField ID="hdnTextBoxUserIdM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxVehicleNoM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxTripsheetNoM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxBalancePaymentM" runat="server" />
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <ajaxToolkit:TabContainer runat="server" ID="tabVehicleStatus" Height="150px" ActiveTabIndex="0"
        CssClass="ajax__tab_technorati-theme" Width="820px">
        <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Trip Sheet Summary">
            <ContentTemplate>
                <asp:Table ID="Table2" runat="server" CellSpacing="1" CellPadding="3" Width="800px"
                    class="boxbg" border="0">
                    <asp:TableRow Style="background-color: white">
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Sheet No. </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                            <asp:TextBox ID="lblTripsheetno" runat="server" Width="200px" BorderStyle="None"
                                onfocus="this.blur()"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Sheet Date & time </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                            <asp:TextBox ID="lblTripDateTime" runat="server" Width="200px" BorderStyle="None"
                                onfocus="this.blur()"></asp:TextBox>
                            <asp:HiddenField ID="hdnTripSheetDate" runat="server" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="background-color: white">
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">Manual Trip Sheet No. </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                            <asp:TextBox ID="txtManualTripSheetNo" runat="server" Width="200px" BorderStyle="None"
                                onfocus="this.blur()"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">Trip Sheet Start KM </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" ColumnSpan="3" HorizontalAlign="Left">
                            <asp:Label ID="lblStartKm" runat="server" Width="200px"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="background-color: white">
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">Start location </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                            <asp:TextBox ID="lblStartLoc" runat="server" Width="200px" BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                     <font class="bluefnt">End location </font>
                        </asp:TableCell>
                        <asp:TableCell Width="25%" HorizontalAlign="Left">
                            <asp:TextBox ID="lblEndLoc" runat="server" Width="200px" BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="Vehicle Details">
            <ContentTemplate>
                <asp:Table ID="Table1" runat="server" CellSpacing="1" CellPadding="3" Width="800px"
                    class="boxbg" border="0">
                    <asp:TableRow ID="TableRow2" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Select Vehicle No.</font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtVehno" runat="server" BorderStyle="None" MaxLength="15" Width="75px"
                                onfocus="this.blur()"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Model </font>
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
                                            <font class="bluefnt">Capacity </font>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtVehCapacity" runat="server" BorderStyle="None" onfocus="this.blur()"
                                MaxLength="10" Width="200px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="TableRow4" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Opening KM</font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="600px" ColumnSpan="3">
                            <asp:TextBox ID="txtVehOpnKM" runat="server" BorderStyle="None" MaxLength="10" onfocus="this.blur()"
                                Width="200px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="TableRow6" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Diesel Balance Qty. (in Ltr)</font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDieselCarryForward" MaxLength="25" runat="server" Style="text-align: right"
                                BorderStyle="None"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                    <font class="bluefnt">Diesel Balance Amount </font>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDieselCarryForwardAmt" MaxLength="25" runat="server" Style="text-align: right"
                                BorderStyle="None"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Driver Details">
            <ContentTemplate>
                <asp:Table ID="Table4" runat="server" CellSpacing="1" CellPadding="3" Width="800px"
                    class="boxbg" border="0">
                    <asp:TableRow ID="TableRow15" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Driver Type</font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDriver1" runat="server" Style="text-align: left" BorderStyle="None"
                                Width="150px" onfocus="this.blur()" Text="Driver1" Font-Bold="true"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDriver2" runat="server" Style="text-align: left" BorderStyle="None"
                                Width="150px" onfocus="this.blur()" Text="Driver2" Font-Bold="true"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDriver3" runat="server" Style="text-align: left" BorderStyle="None"
                                Width="150px" onfocus="this.blur()" Text="Cleaner" Font-Bold="true"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="TableRow8" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Select Driver</font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDriver1Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                Width="100px" BorderStyle="None"></asp:TextBox><br />
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtDriver2Name" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                Width="100px" BorderStyle="None"></asp:TextBox><br />
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="txtCleanerName" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                Width="100px" BorderStyle="None"></asp:TextBox><br />
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
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="lblDriver2ValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                Width="150px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                            <asp:TextBox ID="lblCleanerValidDt" runat="server" BorderStyle="None" MaxLength="10"
                                onfocus="this.blur()" Width="150px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="tabVehicleInfo" HeaderText="Route Selection">
            <ContentTemplate>
                <asp:Table ID="is2" runat="server" CellSpacing="1" CellPadding="3" Width="800px"
                    class="boxbg" border="0">
                    <asp:TableRow ID="TableRow1" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> 
                                <font class="bluefnt">Route Type </font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="600px" ColumnSpan="3">
                            <asp:TextBox ID="txtRouteType" runat="server" BorderStyle="None" onfocus="this.blur()"
                                Width="150px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="TableRow5" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px">
                                    <font class="bluefnt">Route Name</font>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="600px" ColumnSpan="3">
                            <asp:TextBox ID="txtRouteName" runat="server" BorderStyle="None" MaxLength="10" onfocus="this.blur()"
                                Width="150px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="Advance Details">
            <ContentTemplate>
                <asp:Table ID="Table3" runat="server" CellSpacing="1" CellPadding="3" Width="800px"
                    class="boxbg" border="0">
                    <asp:TableRow ID="TableRow7" Style="background-color: white" runat="server">
                        <asp:TableCell HorizontalAlign="left" Width="200px"> 
                                <font class="bluefnt">Advance given </font> 
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" Width="600px" ColumnSpan="3">
                            <asp:TextBox ID="txtAdvancegiven" runat="server" BorderStyle="None" onfocus="this.blur()"
                                Width="150px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
    <asp:Label runat="server" ID="lbl_Page_Err" Text=""></asp:Label>
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel9">
        <ContentTemplate>
            <br />
            <div id="Tripbilling" runat="server">
                <asp:Table ID="Table6" CellSpacing="1" CellPadding="3" runat="server" class="boxbg"
                    Width="800px" BorderWidth="0">
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
                                            <asp:Label ID="pnlTripSelectionError" runat="server" Font-Bold="True">Show...</asp:Label></asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="1" align="center">
                                <tr align="center">
                                    <td align="left">
                                        <asp:Panel ID="pnlTripSelectionDet" runat="server">
                                            <asp:Table ID="Table9" CellSpacing="1" CellPadding="3" runat="server" class="boxbg"
                                                Width="800px" BorderWidth="0">
                                                <asp:TableRow ID="TableRow26" Style="background-color: white" runat="server">
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
                                                                        Width="100px" CssClass="ltxtm" autocomplete="off" ></asp:TextBox>-<asp:TextBox ID="txtCustomerName"
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
                                                 <asp:TableRow ID="TableRowWalkincust" Style="background-color: white" runat="server"
                                                    >
                                                    <asp:TableCell HorizontalAlign="left" Width="120px">
                                                    <font class="blackfnt" color="red">*</font>
                                                     <font class="bluefnt">Customer Name</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="60px"  ColumnSpan="3">
                                                        <asp:TextBox ID="txtWalkinCustomerName" BorderStyle="Groove" runat="server" Width="200px" CssClass="input" />
                                                        <asp:Label ID="lbl_WalkinCustomerName_Err" CssClass="blackfnt" runat="server" ForeColor="red"></asp:Label>
                                                        <asp:HiddenField ID="hdnWalkinCustomerName" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRowfrom_city" Style="background-color: white" runat="server"
                                                    Visible="false">
                                                    <asp:TableCell HorizontalAlign="left" Width="120px">
                                                    <font class="blackfnt" color="red">*</font>
                                                     <font class="bluefnt">From City</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="60px">
                                                        <asp:HiddenField ID="hfLOCAL_CITY" runat="server" />
                                                        <asp:TextBox ID="txtFromCity" BorderStyle="Groove" runat="server" Width="100px" CssClass="input" />
                                                        <asp:Label ID="lbl_FromCity_Err" CssClass="blackfnt" runat="server" ForeColor="red"></asp:Label>
                                                        <asp:HiddenField ID="hdnFromCity" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCellfrom_city" runat="server"
                                                        Visible="true">
                                                        <font class="blackfnt" color="red">*</font>
                                                        <asp:Label ID="Labelto_city" class="bluefnt" runat="server" Text="To City"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCellto_city" runat="server">
                                                        <asp:TextBox ID="txtToCity" BorderStyle="Groove" runat="server" Width="100px" CssClass="input" />
                                                        <asp:Label ID="lbl_ToCity_Err" CssClass="blackfnt" runat="server" ForeColor="red"></asp:Label>
                                                        <asp:HiddenField ID="hdnToCity" runat="server" />
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
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow class="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Button ID="Button1" runat="server" Text="Next Step >>" ValidationGroup="main"
                                OnClick="SubmitDataTripBilling" OnClientClick="javascript:return validtripbilling(this)" /></asp:TableCell></asp:TableRow>
                </asp:Table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel1">
        <ContentTemplate>
            <br />
            <div id="Div1" runat="server">
                <asp:Table ID="Table5" CellSpacing="1" CellPadding="3" runat="server" class="boxbg"
                    Width="800px" BorderWidth="0">
                    <asp:TableRow Style="background-color: white" ID="TableRow11" runat="server">
                        <asp:TableCell>
                            <table cellspacing="1" class="boxbg" border="0" width="800px">
                                <tr class="bgbluegrey">
                                    <td width="75%">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Trip Billing Selection</asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="1" align="center">
                                <tr align="center">
                                    <td align="left">
                                        <asp:Panel ID="Panel4" runat="server">
                                            <asp:Table ID="Table7" CellSpacing="1" CellPadding="3" runat="server" class="boxbg"
                                                Width="800px" BorderWidth="0">
                                                <asp:TableRow ID="TableRow12" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="120px"> <font class="bluefnt">Billing Type Available</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="60px">
                                                        <asp:TextBox ID="lblTripBillingType" runat="server" Width="200px" BorderStyle="None"
                                                            onfocus="this.blur()"></asp:TextBox>
                                                        <asp:HiddenField ID="HiddTripBillingType" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell3" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label3" class="bluefnt" runat="server" Text="Enter Customer Details :"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell4" runat="server">
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="lblTripBillingWise" runat="server" Width="200px" BorderStyle="None"
                                                                        onfocus="this.blur()"></asp:TextBox>
                                                                    <asp:HiddenField ID="HiddTripBillingWise" runat="server" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:TableCell></asp:TableRow>
                </asp:Table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Table ID="Table8" CellSpacing="0" CellPadding="0" runat="server" class="boxbg"
        Width="800px" BorderWidth="0">
        <asp:TableRow bgcolor="white">
            <asp:TableCell class="blackfnt" colspan="3" Style="vertical-align: middle; text-align: left;
                height: 25px;">
                <asp:Button ID="cmdSubmit" runat="server" Text="Enter Leg Wise Details" OnClick="SubmitData" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel2">
        <ContentTemplate>
            <br />
            <div id="Div2" runat="server">
                <asp:Table ID="TableEXTERNALTHCDetails" CellSpacing="1" CellPadding="3" runat="server"
                    class="boxbg" Width="800px" BorderWidth="0" Visible="false">
                    <asp:TableRow Style="background-color: white" ID="TableRow13" runat="server">
                        <asp:TableCell>
                            <table cellspacing="1" class="boxbg" border="0" width="800px">
                                <tr class="bgbluegrey">
                                    <td width="75%">
                                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">EXTERNAL THC Details</asp:Label>
                                    </td>
                                    <td width="5%">
                                        <asp:Panel ID="Panel3" runat="server" Width="25px">
                                            <asp:Label ID="pnlEXTERNALTHCDetailsError" runat="server" Font-Bold="True">Show...</asp:Label></asp:Panel>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="1" align="center">
                                <tr align="center">
                                    <td align="left">
                                        <asp:Panel ID="Panel5" runat="server">
                                            <asp:Table ID="Table10" CellSpacing="1" CellPadding="3" runat="server" class="boxbg"
                                                Width="800px" BorderWidth="0">
                                                <asp:TableRow ID="TableRow14" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">External THC No.</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:Label ID="LabelSystemGenerated" class="blackfnt" color="red" Text="System Generated"
                                                            runat="server"></asp:Label>
                                                        <asp:Label ID="LabelExternalTHCNo" class="bluefnt" runat="server"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell5" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label5" class="bluefnt" runat="server" Text="User Id"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell6" runat="server">
                                                        <asp:TextBox ID="TextBoxUserId" runat="server" TabIndex="1" MaxLength="50" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                        <ajaxToolkit:AutoCompleteExtender ID="Extender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                                                            ServiceMethod="GetUserListET" CompletionListItemCssClass="autocomplete_listItem"
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../../../services/WebService.asmx"
                                                            TargetControlID="TextBoxUserId">
                                                        </ajaxToolkit:AutoCompleteExtender>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow16" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Vehicle No.</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxVehicleNo" runat="server" TabIndex="2" MaxLength="50" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell7" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label6" class="bluefnt" runat="server" Text="Tripsheet No."></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell8" runat="server">
                                                        <asp:TextBox ID="TextBoxTripsheetNo" runat="server" TabIndex="3" MaxLength="50" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow17" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Customer Type</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxCustomerType" runat="server" TabIndex="4" MaxLength="50"
                                                            Width="100px" CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell9" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label7" class="bluefnt" runat="server" Text="Transporter Name."></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell10" runat="server">
                                                        <asp:TextBox ID="TextBoxTransporterName" runat="server" TabIndex="5" MaxLength="50"
                                                            Width="100px" CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow18" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">From City</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxFromCity" runat="server" TabIndex="6" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnFromCityNE" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell11" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label8" class="bluefnt" runat="server" Text="To City"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell12" runat="server">
                                                        <asp:TextBox ID="TextBoxToCity" runat="server" TabIndex="7" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                        <asp:HiddenField ID="hdntoCityNE" runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow19" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Transporter’s  Challan No.</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxTransporterChallanNo" runat="server" TabIndex="8" MaxLength="50"
                                                            Width="100px" CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell13" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label9" class="bluefnt" runat="server" Text="Challan Date"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell14" runat="server">
                                                        <asp:TextBox ID="txtChallanDate" CssClass="input" Width="80px" runat="server" TabIndex="9"
                                                            BorderStyle="Groove"></asp:TextBox>
                                                        <ajaxToolkit:CalendarExtender ID="calExtenderChallanDate" Format="dd/MM/yyyy" TargetControlID="txtChallanDate"
                                                            runat="server" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow20" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Loading Date</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TexLoadingDate" CssClass="input" Width="80px" runat="server" TabIndex="50"
                                                            BorderStyle="Groove"></asp:TextBox>
                                                        <ajaxToolkit:CalendarExtender ID="CalendarExtenderLoadingDate" Format="dd/MM/yyyy"
                                                            TargetControlID="TexLoadingDate" runat="server" />
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell15" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label10" class="bluefnt" runat="server" Text="Contact No."></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell16" runat="server">
                                                        <asp:TextBox ID="TextBoxContactNo" runat="server" TabIndex="11" MaxLength="50" Width="100px"
                                                            CssClass="ltxtm" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow21" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Broker Name</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxBrokerName" runat="server" TabIndex="12" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell17" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label11" class="bluefnt" runat="server" Text="Mobile No."></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell18" runat="server">
                                                        <asp:TextBox ID="TextBoxMobileNo" runat="server" TabIndex="13" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow22" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Weight</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxWeight" runat="server" TabIndex="14" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            Style="text-align: right"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell19" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label13" class="bluefnt" runat="server" Text="Nug."></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell20" runat="server">
                                                        <asp:TextBox ID="TextBoxNug" runat="server" TabIndex="15" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow23" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Commodity</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxCommodity" runat="server" TabIndex="16" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell21" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label14" class="bluefnt" runat="server" Text="Contract Amount"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell22" runat="server">
                                                        <asp:TextBox ID="TextBoxContractAmount" runat="server" TabIndex="17" MaxLength="20"
                                                            Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            Style="text-align: right"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow24" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Advance Amount</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxAdvanceAmount" runat="server" TabIndex="18" MaxLength="20"
                                                            Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            Style="text-align: right"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell23" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label15" class="bluefnt" runat="server" Text="Balance Amount"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell24" runat="server">
                                                        <asp:TextBox ID="TextBoxBalanceAmount" runat="server" TabIndex="19" MaxLength="20"
                                                            Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            Style="text-align: right"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                                <asp:TableRow ID="TableRow25" Style="background-color: white" runat="server">
                                                    <asp:TableCell HorizontalAlign="left" Width="200px"> <font class="bluefnt">Remarks</font> 
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="170px">
                                                        <asp:TextBox ID="TextBoxRemarks" runat="server" TabIndex="20" MaxLength="20" Width="100px"
                                                            CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" Width="200px" ID="TableCell25" runat="server"
                                                        Visible="true">
                                                        <asp:Label ID="Label16" class="bluefnt" runat="server" Text="Balance Payment @"></asp:Label>
                                                    </asp:TableCell>
                                                    <asp:TableCell HorizontalAlign="left" ID="TableCell26" runat="server">
                                                        <asp:TextBox ID="TextBoxBalancePayment" runat="server" TabIndex="21" MaxLength="20"
                                                            Width="100px" CssClass="ltxtm"></asp:TextBox>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:Panel>
                                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                            TargetControlID="Panel5" Collapsed="false" ExpandControlID="Panel3" CollapseControlID="Panel3"
                                            AutoCollapse="False" TextLabelID="pnlEXTERNALTHCDetailsError" CollapsedText="Show"
                                            ExpandedText="Hide" ExpandDirection="Vertical" SuppressPostBack="true" />
                                    </td>
                                </tr>
                            </table>
                        </asp:TableCell></asp:TableRow>
                    <asp:TableRow class="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Button ID="Button2" runat="server" Text="Next Step >>" ValidationGroup="main"
                                OnClick="SubmitExternalTHCNo" OnClientClick="javascript:return SubmitExternalTHCNoDet(this)" /></asp:TableCell></asp:TableRow>
                </asp:Table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <table id="table1646" runat="server" visible="false" cellspacing="1" cellpadding="3"
        style="width: 100%" align="left" class="boxbg" border="0">
        <tr class="bgbluegrey" runat="server" id="rowVehicleLogHdr" visible="false">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>Trip Movement Leg Wise</b></font>
            </td>
        </tr>
        <tr style="background-color: white" runat="server" id="RowVehicleLogRow" visible="false">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="3" align="left">
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="txtAddVehicleLogRow" runat="server" Text="0" MaxLength="3" Width="30"
                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))" BorderStyle="Groove"
                            OnTextChanged="Add_RowVehicleLog" AutoPostBack="true"></asp:TextBox>
                        <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white" align="left" runat="server" id="rowVehicleLogDet"
            visible="false">
            <td colspan="4" align="center">
                <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Always" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <table border="0" width="100%">
                            <tr align="left">
                                <td>
                                    <font class="redfnt">
                                        <asp:Label ID="lbl_VehicleLog_Err" runat="server" Text=""></asp:Label></font>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:GridView ID="gvVehicleLogEntry" runat="server" CellPadding="2" CellSpacing="1"
                                        AutoGenerateColumns="False" SelectedIndex="1" ShowFooter="false" OnRowDataBound="gvVehicleLogEntry1_RowDataBound"
                                        Width="700px" BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr. No.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="External THC No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LabelSystemGeneratedM" class="blackfnt" color="red" Text="System Generated"
                                                        runat="server"></asp:Label>
                                                    <asp:Label ID="LabelExternalTHCNoM" class="bluefnt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LabelExternalTHCNoM") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="User Id" Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxUserIdM" runat="server" TabIndex="1" MaxLength="50" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxUserIdM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vehicle No." Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxVehicleNoM" runat="server" TabIndex="2" MaxLength="50" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxVehicleNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tripsheet No." Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTripsheetNoM" runat="server" TabIndex="3" MaxLength="50"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTripsheetNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Customer Name">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxCustomerTypeM" runat="server" TabIndex="4" MaxLength="50"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxCustomerTypeM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transporter Name.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTransporterNameM" runat="server" TabIndex="5" MaxLength="50"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTransporterNameM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From City">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxFromCityM" runat="server" TabIndex="6" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxFromCityM") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hdnFromCityNEM" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To City">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxToCityM" runat="server" TabIndex="7" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxToCityM") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hdntoCityNEM" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transporter’s  Challan No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTransporterChallanNoM" runat="server" TabIndex="8" MaxLength="50"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTransporterChallanNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Challan Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtChallanDateM" CssClass="input" Width="80px" runat="server" TabIndex="9"
                                                        BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"txtChallanDateM") %>'></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderChallanDate" Format="dd/MM/yyyy" TargetControlID="txtChallanDateM"
                                                        runat="server"  PopupPosition="TopRight"/>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Loading Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TexLoadingDateM" CssClass="input" Width="80px" runat="server" TabIndex="50"
                                                        BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"TexLoadingDateM") %>'></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtenderLoadingDate" Format="dd/MM/yyyy"
                                                        TargetControlID="TexLoadingDateM" runat="server" PopupPosition="TopRight" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Contact No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxContactNoM" runat="server" TabIndex="11" MaxLength="50" Width="100px"
                                                        CssClass="ltxtm" onkeypress="javascript:return validInt(event);" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxContactNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Broker Name">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBrokerNameM" runat="server" TabIndex="12" MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBrokerNameM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxMobileNoM" runat="server" TabIndex="13" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" onkeypress="javascript:return validInt(event);" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxMobileNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <%------------------%>
                                            <asp:TemplateField HeaderText="Weight">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxWeightM" runat="server" TabIndex="14" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxWeightM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nug.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxNugM" runat="server" TabIndex="15" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxNugM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Commodity">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxCommodityM" runat="server" TabIndex="16" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxCommodityM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Contract Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxContractAmountM" runat="server" TabIndex="17" MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxContractAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advance Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxAdvanceAmountM" runat="server" TabIndex="18" MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxAdvanceAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Balance Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBalanceAmountM" runat="server" TabIndex="19" MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBalanceAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxRemarksM" runat="server" TabIndex="20" MaxLength="20" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxRemarksM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Balance Payment at" Visible="true">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBalancePaymentM" runat="server" TabIndex="21" MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBalancePaymentM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="white" style="width: 100%">
            <td class="blackfnt" colspan="5" style="vertical-align: middle; text-align: left;
                width: 100%; height: 25px;">
                <asp:Button ID="btnNext" runat="server" Text="Next Step" OnClick="SubmitExternalTHCNoMulti"
                    Visible="false" OnClientClick="javascript:return CheckValidationETMULTI()" />
            </td>
        </tr>
    </table>
</asp:Content>
