<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ServiceTaxTransfer.aspx.cs" Inherits="GUI_admin_ServiceTaxTransferUtility_ServiceTaxTransfer" %>

<%@ Register Src="~/GUI/Common_UserControls/MultiCheckCombo.ascx" TagPrefix="UserControl" TagName="MultiCheckCombo" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MyCPH1">
    <script type="text/javascript" src="ServiceTaxTransferUtility.js?14455"></script>

    <script type="text/javascript">

        var serviceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <table align="left" width="900px">
        <tr>
            <td height="30"><font class="blklnkund"><strong>Module</strong></font>
                <font class="bluefnt"><strong>&gt; </strong><strong>Admin</strong> </font>
                <font class="bluefnt"><strong>&gt; </strong><strong>Service Tax Transfer Utility</strong> </font>
            </td>
        </tr>
        <tr>
            <td>
                <table width="900px" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey blackboldfnt" align="center">
                        <td colspan="2">Service Tax Transfer Utility
                        </td>
                    </tr>
                    <%-- <tr class="bgwhite">
                        <td class="blackboldfnt">Select Ledger</td>
                        <td>
                            <asp:DropDownList ID="ddlLedger" runat="server" Width="190px">
                                <asp:ListItem Value="CLO0023" Text="SERVICE TAX PAYABLE"></asp:ListItem>
                                <asp:ListItem Value="ALS0009" Text="SERVICE TAX"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>--%>
                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select Name & Code of Customer
                            <br />
                            (consignor/consignee/receiver)</td>
                        <td>
                            <%-- <UserControl:MultiCheckCombo ID="MultichkCustomer" runat="server" AllowAll="true" DataTextField="CustomerName"
                                 DataValueField="CustomerCode"></UserControl:MultiCheckCombo>--%>

                            <asp:TextBox ID="txtCustomer" runat="server" Width="190px" onblur="javascript:return IsExistCustomer(this)"></asp:TextBox>
                            <asp:HiddenField ID="hdnCustomerCode" runat="server" Value="All" />

                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select Branch / Location </td>
                        <td>
                            <asp:DropDownList ID="ddlLocation" runat="server" Width="190px">
                                <%-- <asp:ListItem Value="All" Text="--All--" Selected="True"></asp:ListItem>--%>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select Date Range </td>
                        <td>
                            <UserControl:RPT_Date runat="server" ID="DateRange" EnableTillDate="true" />
                        </td>
                    </tr>

                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select Division</td>
                        <td>
                            <asp:DropDownList ID="ddlDivision" runat="server" Width="200px">
                                <%--<asp:ListItem Value="All" Text="--All--" Selected="True"></asp:ListItem>--%>
                            </asp:DropDownList></td>
                    </tr>
                    <tr class="bgbluegrey blackboldfnt" align="center">
                        <td colspan="2">OR</td>
                    </tr>
                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select GR</td>
                        <td>
                            <asp:TextBox ID="txtGR" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr class="bgbluegrey blackboldfnt" align="center">
                        <td colspan="2">OR</td>
                    </tr>
                    <tr class="bgwhite">
                        <td class="blackboldfnt">Select Delivery MR</td>
                        <td>
                            <asp:TextBox ID="txtDeliveryMR" runat="server" Width="200px"></asp:TextBox></td>
                    </tr>
                    <tr class="bgbluegrey" align="center">
                        <td colspan="2">
                            <asp:Button ID="btnNext" runat="server" Text="Submit" CssClass="blackboldfnt" OnClick="btnNext_Click" />
                            <UserControl:UserMessage ID="msgBox" runat="server" showclosebutton="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

        <tr runat="server" id="trMRDetails" style="display: none">
            <td>
                <table class="boxbg" border="0" cellpadding="3" cellspacing="1" id="tblList">
                    <tr class="bgbluegrey" id="trHeader" runat="server">
                        <td class="align-center">
                            <asp:CheckBox runat="server" ID="chkCheckAll" Text="" onClick="Javascript:return SelectAll(this);" /></td>
                        <td class="align-center">GR No.</td>
                        <td class="align-center">MR No.</td>
                        <td class="align-center">MR Date</td>
                        <td class="align-center">MR Amount</td>
                        <td class="align-center">S.Tax</td>
                        <td class="align-center">Consignee</td>
                        <td class="align-center">Consignor</td>
                        <td class="align-center">Receiver</td>
                        <td class="align-center">Leger Code</td>
                    </tr>
                    <tr id="trNoRecords" runat="server" visible="false" class="bgwhite">
                        <td colspan="20">No Record Found
                        </td>
                    </tr>
                    <asp:Repeater ID="rptMRDetails" runat="server" Visible="true">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td>
                                    <asp:CheckBox ID="chkSelect" runat="server" onclick="return Checked(this.id,'chkSelect')" />
                                </td>
                                <td>
                                    <asp:Label ID="lblGrNo" runat="server" Text='<%# Eval("GRNo")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblMrNo" runat="server" Text='<%# Eval("MRNo")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblMrDate" runat="server" Text='<%# Eval("MrDate")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblMrAmount" runat="server" Text='<%# Eval("MrAmount")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblSTax" runat="server" Text='<%# Eval("STax")%>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblConsignee" runat="server" Text='<%# Eval("Consignee")%>'></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnConsigneeCode" Value='<%# Eval("ConsigneeCode")%>'></asp:HiddenField>
                                </td>
                                <td>
                                    <asp:Label ID="lblConsignor" runat="server" Text='<%# Eval("Consignor")%>'></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnConsignorCode" Value='<%# Eval("ConsignorCode")%>'></asp:HiddenField>
                                </td>
                                <td>
                                    <asp:Label ID="lblReceiver" runat="server" Text='<%# Eval("Receiver")%>'></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnReceiverCode" Value='<%# Eval("ReceiverCode")%>'></asp:HiddenField>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLegerCode" runat="server" onblur="javascript:return IsExistLeger(this)"></asp:TextBox>
                                    <asp:HiddenField ID="hdnLegerCode" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey" align="center" runat="server" id="trSubmit" style="display: none">
            <td class="align-center">
                <asp:Button runat="server" ID="btnSubmit" Text=" Submit " CssClass="blackboldfnt"
                    OnClientClick="Javascript:return ValidateOnSubmit();"
                    OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
