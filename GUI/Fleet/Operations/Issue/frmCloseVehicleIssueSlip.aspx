<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="frmCloseVehicleIssueSlip.aspx.cs" Inherits="Issue_frmCloseVehicleIssueSlip" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/LED/DateSelector.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../../../../GUI/Fleet/Operations/Issue/AJAX_Validator/TripClousre.js"></script>

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
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Close Vehicle Issue Slip </asp:Label>
                
                <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            <td align="right">
                <%--  <asp:UpdateProgress ID="UpdateProgress2" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <%--<table cellspacing="1" cellpadding="3" style="width: 100%" align="left" class="boxbg" border="0">
            
        <tr style="background-color: white">
            <td colspan="4" align="left" >--%>
    <table cellspacing="1" cellpadding="3" style="width: 95%" align="left" class="boxbg"
        border="0">
        <tr style="background-color: white">
            <td colspan="4" align="left">
                <asp:Label ID="lblError" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                <asp:Label ID="lblError1" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                <asp:Label ID="lbl_Closing_KM_Err" runat="server" Text="" CssClass="redfnt" Font-Bold="true"></asp:Label>
                <asp:HiddenField ID="hf_Check_Amt_Rule" runat="server" />
                <asp:HiddenField ID="hf_CloseKMGreater10K" runat="server" />
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td colspan="4" align="left">
                <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CLOSE/UPDATE VEHICLE ISSUE SLIP"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="4" align="left" style="background-color: white">
                <table border="1" cellpadding="1" cellspacing="0" class="boxbg" width="800px">
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Issue Slip Id</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Manual Tripsheet No.</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblManualNo" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Issue Slip Date</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblIssueDt" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Vehicle Type</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblFTLType" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Starting Location</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblStartLoc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <font class="bluefnt">End Location</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblEndLoc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Category</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt" Text="Customer Code"
                                Visible="false"></asp:Label>
                            <asp:Label ID="lblMarketHead" runat="server" CssClass="bluefnt" Text="Market/Own"
                                Visible="false"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblCustcodeMarket" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">External Usages Category : </font>
                        </td>
                        <td align="left" colspan="3">
                            <asp:Label ID="lblExternalCategory" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="row_FTCity" style="background-color: white">
                        <td>
                            <font class="bluefnt">From City</font>
                        </td>
                        <td>
                            <asp:Label ID="lblFromCity" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td>
                            <font class="bluefnt">To City</font>
                        </td>
                        <td>
                            <asp:Label ID="lblToCity" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="row_Route" style="background-color: white">
                        <td>
                            <font class="bluefnt">Route</font>
                        </td>
                        <td colspan="3">
                            <asp:Label ID="lblRoute" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr runat="server" id="row_Vehicle_Mode" style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Vehicle Mode</font>
                        </td>
                        <td align="left" colspan="3">
                            <asp:Label ID="lblVehicleMode" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Vehicle No.</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblVehno" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Driver</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Operational Close Date</font>
                        </td>
                        <td align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="hfOperationalyCloseDate" runat="server" />
                                        <asp:TextBox ID="txtDateOpClose" BorderStyle="Groove" CssClass="input" Width="75px"
                                            runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDateOpClose"
                                            runat="server" />
                                    </td>
                                    <td>
                                        <MKB:TimeSelector ID="tsDateOpClose" runat="server" DisplaySeconds="false">
                                        </MKB:TimeSelector>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Operational/Financial Close Date</font>
                        </td>
                        <td align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:HiddenField ID="hfFinancialCloseDate" runat="server" />
                                        <asp:TextBox ID="txtDateFrom" BorderStyle="Groove" CssClass="input" Width="75px"
                                            runat="server"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDateFrom"
                                            runat="server" />
                                    </td>
                                    <td>
                                        <MKB:TimeSelector ID="tsFinancialCloseDate" runat="server" DisplaySeconds="false">
                                        </MKB:TimeSelector>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Driver License No.</font>
                        </td>
                        <td align="left">
                            <font class="bluefnt">
                                <asp:Label ID="lblLicno" runat="server" CssClass="balckfnt"></asp:Label>
                            </font>
                        </td>
                        <td align="left">
                            <font class="bluefnt">License Valid upto</font>
                        </td>
                        <td align="left">
                            <font class="bluefnt">
                                <asp:Label ID="lblValidDt" runat="server" CssClass="balckfnt"></asp:Label>
                            </font>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Starting Km. Reading</font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblStartKm" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Closing Km. Reading</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtCloseKM" Style="text-align: right" runat="server" BorderStyle="Groove"
                                Width="100" MaxLength="6" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                CssClass="input"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCloseKM" runat="server" Display="Dynamic" Text="!"
                                ValidationGroup="VGDtFromTo" ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Fuel Filled enroute</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtFuelFilledEnroute" runat="server" Text="0" BorderStyle="None"
                                Width="100" MaxLength="6"></asp:TextBox><%--AutoPostBack="true"    OnTextChanged="txtFuelFilledEnroute_TextChanged"--%>
                            <%-- <asp:RequiredFieldValidator ID="ReqFuelFilledEnroute"  ValidationGroup="VGDtFromTo"     runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuelFilledEnroute"></asp:RequiredFieldValidator>--%>
                        </td>
                        <td align="left">
                            <%--<font class="bluefnt">Fuel filled Ltrs.</font>--%>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtFuelFilled" Visible="false" BorderStyle="none" runat="server"
                                CssClass="blackfnt" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Total Kms.</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtTotalKms" Style="text-align: right" runat="server" BorderStyle="none"
                                Width="100" MaxLength="6"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                                Text="!" ValidationGroup="VGDtFromTo" ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <font class="bluefnt">Actual KMPL</font>
                        </td>
                        <td>
                            <asp:TextBox ID="txtKMPL" Style="text-align: right" CssClass="blackfnt" runat="server"
                                BorderStyle="None"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="bluefnt">Approved KMPL.</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtApprKMPL" Style="text-align: right" BorderStyle="None" Width="100"
                                MaxLength="6" CssClass="blackfnt" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                runat="server"></asp:TextBox>
                            <%--<asp:RequiredFieldValidator ID="ReqtxtApprKMPL" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtApprKMPL"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegApprKMPL" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtApprKMPL" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                        </td>
                        <td align="left">
                            <font class="bluefnt">Approved Diesel (liters)</font>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtApprovedDiesel" Style="text-align: right" runat="server" CssClass="blackfnt"
                                Text="" BorderStyle="None" />
                            <asp:HiddenField ID="hfKMPL" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
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
                    </tr>
                    <tr runat="server" id="row_Dockets" style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblDocketsLable" runat="server" CssClass="bluefnt"></asp:Label>
                        </td>
                        <td align="left" colspan="3">
                            <asp:Label ID="lblDockets" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <table border="0" width="100%">
                                <tr>
                                    <td style="text-align: left">
                                        <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                            CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                            BorderWidth="3px" Width="100%" OnItemDataBound="dgAdvanceDet_ItemDataBound">
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
                                                        <asp:TextBox ID="txtAdvPlace" runat="server" ReadOnly="true" CssClass="input" Width="150px"
                                                            BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Advance Date">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAdvDt" CssClass="input" runat="server" MaxLength="10" ReadOnly="true"
                                                            Width="65" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqAdvDt" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtAdvDt"></asp:RequiredFieldValidator>
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
                                                        <asp:TextBox ID="txtAdvAmt" Style="text-align: right" runat="server" Width="60px"
                                                            BorderStyle="None" MaxLength="6"></asp:TextBox>
                                                        <%--  <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                    </ItemTemplate>
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Branch Name">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtBranchCode" runat="server" ReadOnly="true" CssClass="input" Width="100px"
                                                            BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Advance paid by">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtSignature" runat="server" ReadOnly="true" CssClass="input" Width="100px"
                                                            BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtSignature"></asp:RequiredFieldValidator>
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
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey" runat="server" id="rowTHCHdr">
            <td colspan="4" align="left">
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true" Text="THC Details"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: white" runat="server" id="rowTHCRow">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="3" align="left">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="txtAddTHCrow" runat="server" MaxLength="2" Width="30" BorderStyle="Groove"
                            OnTextChanged="add_rowTHC" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                            AutoPostBack="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddTHCrow"
                            ErrorMessage="!!!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white" align="left" runat="server" id="rowTHCDet">
            <td colspan="4">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:GridView ID="gvTHC" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                            OnRowDataBound="gvTHC_RowDataBound" Width="700px" BorderColor="#006699" BorderStyle="None"
                            BorderWidth="3px" CssClass="blackfnt" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="From">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFrom" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"FromCity") %>'
                                            Width="150px" BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="lblHdr" runat="server" Text="Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTo" Text='<%# DataBinder.Eval(Container.DataItem,"ToCity") %>'
                                            runat="server" MaxLength="100" Width="150px" BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC No.">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTHCNo" Text='<%# DataBinder.Eval(Container.DataItem,"THCNo") %>'
                                            runat="server" Width="100px" BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC Date">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTHCDt" Text='<%# DataBinder.Eval(Container.DataItem,"THCDt") %>'
                                            runat="server" Width="65px" BorderStyle="Groove" MaxLength="10" CssClass="input"></asp:TextBox>
                                        <ajaxToolkit:CalendarExtender runat="server" ID="CalTHCDate" TargetControlID="txtTHCDt"
                                            Format="dd/MM/yyyy">
                                        </ajaxToolkit:CalendarExtender>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Freight<br>Amount">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFreightAmt" Text='<%# DataBinder.Eval(Container.DataItem,"FreightAmt") %>'
                                            runat="server" Width="50px" Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            BorderStyle="Groove" MaxLength="6" CssClass="input">
                                        </asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="FooterTotFreightAmt" runat="server" Width="50px" Font-Bold="true"
                                            Style="text-align: right" BorderStyle="NONE"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Labour<br>charge">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtLabourChrg" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LabourChrg") %>'
                                            Style="text-align: right" Width="50px" BorderStyle="Groove" MaxLength="6" CssClass="input"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="FooterTotLabourChrg" runat="server" Width="50px" Font-Bold="true"
                                            Style="text-align: right" BorderStyle="NONE"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Other<br>charge">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtOtherChrg" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OtherChrg") %>'
                                            Style="text-align: right" Width="50px" BorderStyle="Groove" MaxLength="6" CssClass="input"
                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="FooterTotOtherChrg" runat="server" Width="50px" Font-Bold="true"
                                            Style="text-align: right" BorderStyle="NONE"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTHCTotalAmt" Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"TotalChrg") %>'
                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server"
                                            Width="50px" BorderStyle="none" MaxLength="6"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="FooterTotTHCTotalAmt" runat="server" Width="50px" Font-Bold="true"
                                            Style="text-align: right" BorderStyle="NONE"></asp:TextBox>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                CssClass="bgbluegrey" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr class="bgbluegrey" runat="server" id="rowVehicleLogHdr">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>Vehicle Log Details</b></font>
            </td>
        </tr>
        <tr style="background-color: white" runat="server" id="RowVehicleLogRow">
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
        <tr style="background-color: white" align="left" runat="server" id="rowVehicleLogDet">
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
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="From">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFrom" CssClass="input" Width="75px" Style="text-align: left"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"From") %>' BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="To">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTo" CssClass="input" Width="75px" Style="text-align: Left" runat="server"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"To") %>' BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <%--style="text-align:right"  --%>
                                            <asp:TemplateField HeaderText="Start Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <%--<asp:TextBox ID="txtStartDate" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"></asp:TextBox>--%>
                                                    <asp:TextBox ID="txtStartDate" CssClass="input" Width="80px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"StartDate") %>'
                                                        BorderStyle="Groove"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtStartDate"
                                                        runat="server" />
                                                    <%--<asp:RegularExpressionValidator ID="REVStartDt" runat="server" ControlToValidate="txtStartDate"
                                       ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                       Width="1px"></asp:RegularExpressionValidator>--%>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Start Time<br>(HH:MM)">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="tb_StartTime_HH" Text='<%# DataBinder.Eval(Container.DataItem,"StartTime_HH") %>'
                                                        BorderStyle="Groove" CssClass="input" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px"></asp:TextBox>&nbsp;:
                                                    <asp:TextBox ID="tb_StartTime_MM" Text='<%# DataBinder.Eval(Container.DataItem,"StartTime_MM") %>'
                                                        CssClass="input" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Invoice No">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtInvoiceNo" Text='<%# DataBinder.Eval(Container.DataItem,"Invoice_No") %>'
                                                        runat="server" Width="60px" CssClass="input" Style="text-align: left" MaxLength="10"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Start Km">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtStartKm" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"StartKM") %>'
                                                        Width="60px" onkeypress="javascript:return validInt(event);" OnFocus="this.blur()"
                                                        Style="text-align: right" MaxLength="10" BorderStyle="none"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Category">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlCategory" runat="server" Width="100px" Style="text-align: left"
                                                        BorderStyle="Groove">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Type of Product">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlTypeofProduct" runat="server" Style="text-align: left" Width="100px"
                                                        BorderStyle="Groove">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Crates">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtNoOfCrates" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"No_Crates") %>'
                                                        Width="60px" Style="text-align: right" CssClass="input" onkeypress="javascript:return validInt(event);"
                                                        MaxLength="10" BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <%--style="text-align:right" --%>
                                            <asp:TemplateField HeaderText="End Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEndDate" CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem,"EndDate") %>'
                                                        runat="server" MaxLength="10" Width="80px" BorderStyle="Groove"></asp:TextBox>
                                                    <ajaxToolkit:CalendarExtender ID="calExtenderEndDt" Format="dd/MM/yyyy" TargetControlID="txtEndDate"
                                                        runat="server" />
                                                    <%--<asp:RegularExpressionValidator ID="REVEndDt" runat="server" ControlToValidate="txtEndDate"
                                       ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                       Width="1px"></asp:RegularExpressionValidator>--%>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="End Time<br>(HH:MM)">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="tb_EndTime_HH" Text='<%# DataBinder.Eval(Container.DataItem,"EndTime_HH") %>'
                                                        BorderStyle="Groove" CssClass="input" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px"></asp:TextBox>:
                                                    <asp:TextBox ID="tb_EndTime_MM" Text='<%# DataBinder.Eval(Container.DataItem,"EndTime_MM") %>'
                                                        CssClass="input" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="End Km">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEndKm" Style="text-align: right" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EndKM") %>'
                                                        Width="60px" CssClass="input" onkeypress="javascript:return validInt(event);"
                                                        MaxLength="10" BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="KM Run">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtKMRun" Style="text-align: right" Onfocus="this.blur()" runat="server"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"KMRun") %>' Width="60px" MaxLength="10"
                                                        BorderStyle="None"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="15%" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Transit Time<br>(HH:MM)">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="tb_Transit_HH" Onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"Transit_HH") %>'
                                                        BorderStyle="None" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px"></asp:TextBox>&nbsp;:
                                                    <asp:TextBox ID="tb_Transit_MM" Onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"Transit_MM") %>'
                                                        BorderStyle="None" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px" />
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" CssClass="bgwhite" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Idle Time<br>(HH:MM)">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="tb_IdleTime_HH" Onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"IdleTime_HH") %>'
                                                        BorderStyle="None" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px"></asp:TextBox>&nbsp;:
                                                    <asp:TextBox ID="tb_IdleTime_MM" Onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"IdleTime_MM") %>'
                                                        BorderStyle="None" MaxLength="2" onkeypress="javascript:return validInt(event);"
                                                        runat="server" Width="15px" />
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
        <tr class="bgbluegrey">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>HSD/OIL Expenses</b></font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="3" align="left">
                <asp:TextBox ID="txtAddRowOilExp" runat="server" MaxLength="2" Width="30" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                    BorderStyle="Groove" OnTextChanged="add_rowOil" AutoPostBack="true"></asp:TextBox>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="4" align="center">
                <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <table border="0" width="100%">
                            <tr align="left">
                                <td>
                                    <font class="redfnt">
                                        <asp:Label ID="lbl_OilExp_Expense" runat="server" Text=""></asp:Label></font>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                        CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                        BorderWidth="3px" Width="900px" OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound">
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
                                                    <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        MaxLength="50" Enabled="false"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!"
                                                        ValidationGroup="VGDtFromTo" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Last Km Reading">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtLKmRead" Width="50px" onfocus="this.blur()" BorderStyle="None"
                                                        runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="By Card/Cash">
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlPayment" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        Enabled="false" OnSelectedIndexChanged="CardNo_Dispaly" AutoPostBack="true">
                                                        <%--  <asp:ListItem Value="0" Text="select" />
                                               <asp:ListItem Value="1" Text="Cash" />
                                               <asp:ListItem Value="2" Text="Diesel Card" />--%>
                                                        <asp:ListItem Value="select" Text="select" />
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
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="True" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Remarks">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"
                                                        ReadOnly="false" Enabled="false"></asp:TextBox>
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
        <tr>
            <td colspan="4" align="left" style="background-color: white">
                <tr class="bgbluegrey">
                    <td colspan="4" align="left">
                        <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="En-route Expenses"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td width="5%" nowrap>
                        <font class="blackfnt">Enter no. of rows</font>
                    </td>
                    <td colspan="3" align="left">
                        <asp:HiddenField ID="hfRouteDesc" runat="server" />
                        <asp:HiddenField ID="hfRouteCode" runat="server" />
                        <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" Width="20px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                    AutoPostBack="true" BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"
                                    ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr style="background-color: white" align="left">
                    <td colspan="4">
                        <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                <font class="redfnt">
                                    <asp:Label ID="lbl_Enroute_Err" runat="server" Text=""></asp:Label></font>
                                <asp:GridView ID="gvEnroute" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                    SelectedIndex="1" OnRowDataBound="gvEnroute_RowDataBound" Width="700px" BorderColor="#006699"
                                    BorderStyle="None" BorderWidth="3px" CssClass="blackfnt" ShowFooter="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Nature of Expense">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlNExpense" runat="server" Width="200px">
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Amount Spent">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtAmount" CssClass="input" Width="75px" Style="text-align: right"
                                                    runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                    BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:TextBox ID="txtEnAmtTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                    BorderStyle="NONE"></asp:TextBox>
                                            </FooterTemplate>
                                            <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            <FooterStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill No.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBillNo" Text='<%# DataBinder.Eval(Container.DataItem,"BillNo") %>'
                                                    runat="server" CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill date">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Date") %>'
                                                    CssClass="input" Width="75px" BorderStyle="Groove"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                                    runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Standard Amt">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtEAmt" runat="server" Style="text-align: right" CssClass="input"
                                                    Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                    Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>' BorderStyle="Groove"
                                                    MaxLength="50"></asp:TextBox>
                                                <asp:HiddenField ID="hfEAmt" Value='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'
                                                    runat="server" />
                                                <asp:HiddenField ID="hfPolarity" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                            <FooterStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                            <FooterTemplate>
                                                <asp:TextBox ID="txtETotalAmt" Width="75px" Style="text-align: right" runat="server"
                                                    Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Remarks">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtRemark" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>'
                                                    runat="server" CssClass="input" Width="200px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                        CssClass="bgbluegrey" />
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:HiddenField ID="hfEnAmtTotal" runat="server" />
                        <asp:HiddenField ID="hfETotalAmt" runat="server" />
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td colspan="4" align="left" style="height: 19px">
                        <font class="blackfnt"><b>Verifying Authorities</b></font>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td colspan="4">
                        <table cellspacing="1" cellpadding="3" style="width: 700px" align="left" class="boxbg"
                            border="0">
                            <tr style="background-color: white">
                                <td align="center">
                                    <font class="blackfnt">Prepared By</font>
                                </td>
                                <td align="center">
                                    <font class="blackfnt">Checked By</font>
                                </td>
                                <td align="center">
                                    <font class="blackfnt">Apporved By</font>
                                </td>
                                <td align="center">
                                    <font class="blackfnt">Audited By</font>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="center">
                                    <asp:TextBox ID="txtPreparedBy" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                        MaxLength="50"></asp:TextBox>
                                </td>
                                <td align="center">
                                    <asp:TextBox ID="txtCheckedBy" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                        MaxLength="50"></asp:TextBox>
                                </td>
                                <td align="center">
                                    <asp:TextBox ID="txtApprovedBy" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                        MaxLength="50"></asp:TextBox>
                                </td>
                                <td align="center" rowspan="2" valign="top">
                                    <asp:TextBox ID="txtAuditedBy" CssClass="input" runat="server" Width="150px" BorderStyle="Groove"
                                        MaxLength="50"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="center">
                                    <font class="blackfnt">Fleet Accounts</font>
                                </td>
                                <td align="center">
                                    <font class="blackfnt">Fleet Manager</font>
                                </td>
                                <td align="center">
                                    <font class="blackfnt"><b>HOD</b></font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="left" style="background-color: white">
                        <p align="center">
                            <asp:Button ID="cmdOpClose" runat="server" ValidationGroup="VGDtOpClose" OnClientClick="javascript:return CheckOpClose()"
                                Text="Operational Close" OnClick="cmdOpClose_Click" />
                            &nbsp;&nbsp;&nbsp
                            <asp:Button ID="cmdSubmit" runat="server" OnClientClick="javascript:return CheckEnRouteExpDetails()"
                                ValidationGroup="VGDtFromTo" Text="Operational And Financial Close" OnClick="SubmitData" />
                        </p>
                    </td>
                </tr>
    </table>
</asp:Content>
