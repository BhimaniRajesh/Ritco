<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result_Gen_Doc.aspx.cs" Inherits="Bill_Entry_Result_Gen_Doc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;<asp:HyperLink ID="HlEntryBill" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Expense Bill</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="hlVendor" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Bill Entry/Query.aspx">Vendor Selection</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Bill Entry"></asp:Label>
    &gt;
    <a href="javascript:window.history.go(-1)" title="back">
    <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:Label
        ID="Label2" runat="server" Text="Document is Generated" CssClass="blackfnt"></asp:Label><br />
    <br />
    <br />
        <table id="TABLE1" align="center" cellpadding="0" cellspacing="1" class="boxbg" style="width: 80%">
            <tr>
                <td align="center" class="bgbluegrey" style="height: 27px">
                    <font class="blackfnt"><strong><span style="font-size: 8pt; font-family: Verdana">Following
                        Document is Generated</span></strong></font></td>
            </tr>
        </table>
        <table id="Table2" align="center" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
            width="85%">
            <tr bgcolor="white">
                <td class="field1" style="width: 105px; height: 18px">
                    <font class="blackfnt">&nbsp;Document Name</font></td>
                <td align="left" class="blackfnt" style="width: 210px; height: 18px">
                    &nbsp;Document Number</td>
                <td class="field1" colspan="2" style="height: 18px">
                    <font class="blackfnt"></font>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="field1" style="width: 105px">
                    <font class="blackfnt">&nbsp;Bill Entry</font></td>
                <td align="left" class="blackfnt" style="width: 210px">
                    &nbsp;<asp:Label ID="lblDocNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                <td class="field1" colspan="2" align="right">
                    <font class="blackfnt">
                        <asp:HyperLink ID="hplView" runat="server" CssClass="blackfnt" Font-Underline="True">View</asp:HyperLink>
                        |
                        <asp:HyperLink ID="hplPrint" runat="server" CssClass="blackfnt" Font-Underline="True">Print</asp:HyperLink>
                        |
                        <asp:HyperLink ID="hplXLS" runat="server" CssClass="blackfnt" Font-Underline="True">XLS</asp:HyperLink>
                        |
                        <asp:HyperLink ID="hplEmail" runat="server" CssClass="blackfnt" Font-Underline="True">E-Mail</asp:HyperLink>&nbsp;</font></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td class="field1" colspan="4" style="height: 23px">
                    <font class="blackfnt"><strong>&nbsp;&nbsp; Your Next Step:</strong></font><%--<label id="lblTotAmt" runat="server" class="blackfnt"></label>--%></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td bgcolor="#ffffff" style="height: 25px; width: 105px;">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet" style="width: 5px">
                                <img  src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" colspan="3" style="font-size: 12pt; font-family: Times New Roman">
                    &nbsp;<asp:HyperLink ID="hplVendorBill" runat="server" CssClass="blackfnt" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Bill Entry/Query.aspx">Enter More Communication Vendor Bills</asp:HyperLink></td>
            </tr>
            <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman">
                <td bgcolor="#ffffff" style="height: 25px; width: 105px;">
                <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet" style="width: 5px">
                                <img  src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" colspan="3">
                    &nbsp;<asp:HyperLink ID="hplVoucher" runat="server" CssClass="blackfnt" Font-Underline="True" NavigateUrl="~/GUI/Finance/VendorPayment_new/Vendorpymt_new.aspx">Prepare Vendor Payment Voucher</asp:HyperLink></td>
            </tr>
            <tr bgcolor="white">
                <td bgcolor="#ffffff" style="height: 25px; width: 105px;">
                   <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet" style="width: 5px">
                                <img  src="../images/clear.gif" width="4"/></td>
                        </tr>
                    </table>
                </td>
                <td align="left" colspan="3">
                    &nbsp;<asp:HyperLink ID="hplBillEntry" runat="server" CssClass="blackfnt" Font-Underline="True">View & Print Bill Entries</asp:HyperLink></td>
                &nbsp;</tr>
        </table>
   </asp:Content>
