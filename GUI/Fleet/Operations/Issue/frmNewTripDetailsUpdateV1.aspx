<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmNewTripDetailsUpdateV1.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewTripDetailsUpdateV1" %>

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
    <table cellspacing="1" style="width: 800px">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Update Trip Details </asp:Label>
                <asp:HiddenField ID="hdnTextBoxUserIdM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxVehicleNoM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxTripsheetNoM" runat="server" />
                <asp:HiddenField ID="hdnTextBoxBalancePaymentM" runat="server" />
            </td>
            <td align="right"></td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <ajaxToolkit:TabContainer runat="server" ID="tabVehicleStatus" Height="150px" ActiveTabIndex="0"
        CssClass="ajax__tab_technorati-theme" Width="820px">
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Trip Sheet Summary">
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
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="Driver Details">
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
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel4" HeaderText="Advance Details">
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
    <asp:Table ID="Table8" CellSpacing="0" CellPadding="0" runat="server" class="boxbg"
        Width="800px" BorderWidth="0">
        <asp:TableRow bgcolor="white">
            <asp:TableCell class="blackfnt" colspan="3" Style="vertical-align: middle; text-align: left; height: 25px;">
                <asp:Button ID="cmdSubmit" runat="server" Text="Enter Leg Wise Details" OnClick="SubmitData" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
 <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Always" RenderMode="Inline" runat="server">
                    <ContentTemplate>
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
                                                    <asp:TextBox ID="TextBoxUserIdM" runat="server"  TabIndex='<%# TabIndex %>' MaxLength="50" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxUserIdM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vehicle No." Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxVehicleNoM" runat="server" TabIndex='<%# TabIndex %>' MaxLength="50" Width="100px"
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxVehicleNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tripsheet No." Visible="false">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTripsheetNoM" runat="server" TabIndex='<%# TabIndex %>' MaxLength="50"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTripsheetNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Customer Type">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlCustomerType" runat="server" Width="200px" TabIndex='<%# TabIndex %>' onchange="CheckCustomerType(this);">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="From Master" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Walk-in-customer" Value="2"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Customer Name">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxCustomerTypeM" runat="server"  MaxLength="50" TabIndex='<%# TabIndex %>' onblur="return checkCustomerCode(this);"
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxCustomerTypeM") %>'></asp:TextBox>
                                                    <ajaxToolkit:AutoCompleteExtender ID="extCustomerName" runat="server" Enabled="True"
                                                        MinimumPrefixLength="1" ServiceMethod="GetCustomerNameCodeList" CompletionListItemCssClass="autocomplete_listItem"
                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../../../services/WebService.asmx"
                                                        TargetControlID="textBoxCustomerTypeM">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                    <asp:Label ID="lbl_FromCity_Err" runat="server" CssClass="redfnt"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="25%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transporter Name.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTransporterNameM" runat="server"  MaxLength="50" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTransporterNameM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From City">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxFromCityM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxFromCityM") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hdnFromCityNEM" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To City">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxToCityM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxToCityM") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hdntoCityNEM" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transporter’s  Challan No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxTransporterChallanNoM" runat="server"  MaxLength="50" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxTransporterChallanNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Challan Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtChallanDateM" CssClass="input" Width="80px" runat="server"  TabIndex='<%# TabIndex %>'
                                                        BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"txtChallanDateM") %>'></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderChallanDate" Format="dd/MM/yyyy" TargetControlID="txtChallanDateM"
                                                        runat="server" PopupPosition="TopRight" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Loading Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TexLoadingDateM" CssClass="input" Width="80px" runat="server"  TabIndex='<%# TabIndex %>'
                                                        BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"TexLoadingDateM") %>'></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="CalendarExtenderLoadingDate" Format="dd/MM/yyyy"
                                                        TargetControlID="TexLoadingDateM" runat="server" PopupPosition="TopRight" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Contact No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxContactNoM" runat="server"  MaxLength="50" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" onkeypress="javascript:return validInt(event);" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxContactNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Broker Name">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBrokerNameM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBrokerNameM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mobile No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxMobileNoM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" onkeypress="javascript:return validInt(event);" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxMobileNoM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Weight">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxWeightM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxWeightM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Nug.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxNugM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxNugM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Commodity">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxCommodityM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxCommodityM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Contract Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxContractAmountM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxContractAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advance Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxAdvanceAmountM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxAdvanceAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advance Taken By">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlAdvanceTakenBy" runat="server" Width="200px" TabIndex='<%# TabIndex %>' onchange="CheckAdvanceTakenBy(this);">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Driver" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Branch" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Both" Value="3"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advance Taken By Driver">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxAdvanceAmountByDriverM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxAdvanceAmountByDriverM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Advance Taken By Branch">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxAdvanceAmountByBranchM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxAdvanceAmountByBranchM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Balance Amount">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBalanceAmountM" runat="server"  MaxLength="20"
                                                        Width="100px" CssClass="ltxtm" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" TabIndex='<%# TabIndex %>'
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBalanceAmountM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Remarks">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxRemarksM" runat="server"  MaxLength="20" Width="100px" TabIndex='<%# TabIndex %>'
                                                        CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxRemarksM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Balance Payment at" Visible="true">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="TextBoxBalancePaymentM" runat="server"  MaxLength="20" TabIndex='<%# TabIndex %>'
                                                        Width="100px" CssClass="ltxtm" Text='<%# DataBinder.Eval(Container.DataItem,"TextBoxBalancePaymentM") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Upload Document" Visible="true">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:FileUpload ID="fUThcDoc" EnableViewState="true" CssClass="input" runat="server"  TabIndex='<%# TabIndex %>' />
                                                    <asp:Label ID="lblUloadLink" runat="server" class="blackfnt" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem,"lblUloadLink") %>'></asp:Label>
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
                    
            </td>
        </tr>
        <tr bgcolor="white" style="width: 100%">
            <td class="blackfnt" colspan="5" style="vertical-align: middle; text-align: left; width: 100%; height: 25px;">
                <asp:Button ID="btnNext" runat="server" Text="Next Step" OnClick="SubmitExternalTHCNoMulti"
                    Visible="false" OnClientClick="javascript:return CheckValidationETMULTI()" />
            </td>
        </tr>
    </table>
</ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnNext" />
                    </Triggers>
                </asp:UpdatePanel>
    <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
</asp:Content>