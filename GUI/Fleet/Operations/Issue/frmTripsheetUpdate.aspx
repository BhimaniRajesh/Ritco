<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="false" CodeFile="frmTripsheetUpdate.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmTripsheetUpdate" %>

<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="AJAX_Validator/TripsheetUpdate.js?v9"></script>
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update Trip Sheet </asp:Label>
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <br />
    <%-- <table cellspacing="1" align="left"  cellpadding="3" style="width: 900px"   class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center" >
    --%>
    <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <asp:Panel runat="server" ID="Panel7" Visible="true">
                <table cellspacing="1" cellpadding="3" style="width: 900px" align="left" class="boxbg"
                    border="0">
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                            <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
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
                                        <font class="bluefnt">Issue Slip Id</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">Issue Slip Date</font>
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
                    <%--<tr style="background-color: white">
                <td width="15%"><font class=blackfnt>Enter no. of rows</font></td>
                <td colspan=3><asp:TextBox ID="txtAddRowAdv" runat=server MaxLength="3" Width="30" BorderStyle="Groove"   OnTextChanged="add_rowAdv" AutoPostBack="true"></asp:TextBox></td>
            </tr>--%>
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <table border="0" width="100%">
                                <tr>
                                    <td>
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
                                                        <asp:TextBox ID="txtAdvPlace" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                                            MaxLength="50"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAdvDt" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
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
                                                        <asp:TextBox ID="txtAdvAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove"
                                                            MaxLength="6" OnTextChanged="PopulateAdvamt" AutoPostBack="true"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!"
                                                            ControlToValidate="txtAdvAmt"></asp:RequiredFieldValidator>
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
                                                        <asp:TextBox ID="txtBranchCode" runat="server" CssClass="input" Width="100px" BorderStyle="Groove"
                                                            AutoPostBack="true" MaxLength="15" OnTextChanged="txtBranchCode_TextChanged"></asp:TextBox>
                                                        <asp:HiddenField ID="hdfldBranchCode" runat="server" />
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
                                                        <asp:TextBox ID="txtSignature" runat="server" CssClass="input" Width="100px" BorderStyle="Groove"
                                                            MaxLength="50"></asp:TextBox>
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
                                        <br>
                                        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server">
                                            <ContentTemplate>
                                                <UC2:UCPaymentControl ID="UCPayment" runat="server"></UC2:UCPaymentControl>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <%--       </td>
                 </tr>
        
                 
            </table>
               <br/>--%>
</asp:Content>
