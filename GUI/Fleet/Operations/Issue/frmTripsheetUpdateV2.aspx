<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="false" CodeFile="frmTripsheetUpdateV2.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmTripsheetUpdateV2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="AJAX_Validator/TripsheetUpdateV2.js?v9"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <progresstemplate>
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
        </progresstemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update Trip Sheet </asp:Label>
            </td>
            <td align="right"></td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <contenttemplate>
            <asp:Panel runat="server" ID="Panel7" Visible="true">
                <table cellspacing="1" cellpadding="3" style="width: 900px" align="left" class="boxbg"
                    border="0">
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                            <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white;display:none;">
                        <td colspan="4" align="center">
                            <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="10" Width="60px"></asp:TextBox>
                            <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="UPDATE VEHICLE ISSUE SLIP"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="center" style="background-color: white">
                            <table border="1" cellpadding="3" cellspacing="1" class="boxbg" width="72%">
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Trip Sheet No</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">Trip Sheet Date</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueDt" runat="server" CssClass="blackfnt"></asp:Label>
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
                                        <font class="bluefnt">Driver License No.</font>
                                    </td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lblLicno" runat="server" CssClass="balckfnt"></asp:Label>
                                        </font>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">License Valid upto</font>
                                    </td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lblValidDt" runat="server" CssClass="balckfnt"></asp:Label>
                                        </font>
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
                                        <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt" Text="Customer Code/Name"
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
                                        <font class="bluefnt">Driver Balance</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <font class="blackfnt">
                                            <asp:Label ID="LblDriverBalance" class="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                        </font>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <table border="0" width="100%">
                                <tr>
                                    <td>
                                       <asp:Panel ID="pnlAdvanceDet" runat="server">
                                    <asp:Table ID="tbl_Driver_Adv" runat="server" CellSpacing="1" CellPadding="3" Style="width: 1000px" class="boxbg" border="0">
                                        <asp:TableRow CssClass="bgbluegrey" Style="background-color: white">
                                            <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                                <font class="blackfnt"><b>Details of Advance Taken</b></font>

                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow CssClass="bgbluegrey" Style="background-color: white;display:none;">
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
                                                                                <asp:Label ID="txtSystemDate"  Text='<%# DataBinder.Eval(Container.DataItem,"SystemDate") %>' runat="server" 
                                                                                    MaxLength="50"></asp:Label>
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
                                                                                <asp:TextBox ID="txtAdvDt" CssClass="input" onblur="CheckAdvDt(this.id)" Text='<%# DataBinder.Eval(Container.DataItem,"AdvDt") %>' runat="server"
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
                                                                                    <asp:ListItem Value="1" Text="Cash"></asp:ListItem>
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
                                                                </asp:GridView>
                                                                <asp:HiddenField ID="hfPaymentAmount" runat="server" />
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:Panel>
                                        <br>
                                    </td>
                                </tr>
                                <tr style="background-color: white" align="center">
                                    <td>
                                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click"
                                            OnClientClick="Javascript: return onSubmitt();" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </contenttemplate>
    </asp:UpdatePanel>
</asp:Content>
