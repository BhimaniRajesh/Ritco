<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillPaymentView.aspx.cs" Inherits="GUI_Finance_HCLBill_BillPaymentView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <form id="form1" runat="server">
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
            <tr class="hrow">
                <td colspan="3" align="center">
                    <b>From Bill Generation</b>
                </td>
                <td colspan="5" align="center">
                    <b>From Master</b>
                </td>
            </tr>
            <tr class="hrow">
                <td><b>Document Name</b></td>
                <td><b>Type</b></td>
                <td><b>Rate</b></td>
                <td><b>Document Name</b></td>
                <td><b>Type</b></td>
                <td><b>Rate</b></td>
                <td><b>From date</b></td>
                <td><b>To Date</b></td>
            </tr>
            <tr class="nrow">
                <td>Outgoing THC</td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCType"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCRate"></asp:Label></td>
                <td>Outgoing THC</td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCTypeMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCRateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCFromDateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblOutgoingTHCToDateMaster"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td>Incoming THC</td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCType"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCRate"></asp:Label></td>
                <td>Incoming THC</td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCTypeMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCRateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCFromDateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblIncomingTHCToDateMaster"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td>DDMR</td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRType"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRRate"></asp:Label></td>
                <td>DDMR</td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRTypeMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRRateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRFromDateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblDDMRToDateMaster"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td>MR</td>
                <td>
                    <asp:Label runat="server" ID="lblMRType"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblMRRate"></asp:Label></td>
                <td>MR</td>
                <td>
                    <asp:Label runat="server" ID="lblMRTypeMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblMRRateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblMRFromDateMaster"></asp:Label></td>
                <td>
                    <asp:Label runat="server" ID="lblMRToDateMaster"></asp:Label></td>
            </tr>
        </table>
        <br />
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="Table1" runat="server">
            <tr class="hrow">
                <td align="center">
                    <b>Vendor Name</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblVendorName"></asp:Label></td>

                <td align="center">
                    <b>Bill Number</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblBillNo"></asp:Label></td>

                <td><b>Bill Date</b></td>
                <td>
                    <asp:Label runat="server" ID="lblBillDate"></asp:Label></td>
            </tr>
        </table>

        <asp:Repeater ID="RptBillApprovalDetails" runat="server">
            <HeaderTemplate>
                <table id="Dochead" border="1" class="boxbg" cellpadding="1" cellspacing="1" width="900px">
                    <thead>
                        <tr class="hrow">
                            <th><b>Sr No</b></th>
                            <th><b>Document Number</b></th>
                            <th><b>Actual Total Weight</b></th>
                            <th><b>Total Pkgs</b></th>
                            <th><b>Type</b></th>
                            <th><b>Rate</b></th>
                            <th><b>Amount</b></th>
                            <th><b>Remarks</b></th>
                            <th><b>Edited</b></th>
                        </tr>
                    </thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tbody>
                    <tr class="nrow">
                        <td>
                            <asp:Label ID="lblsrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label></td>
                        <td>
                            <asp:Label ID="lbldocumentNo" runat="server" Text='<%# Eval("DocumentNo") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblActualTotalWeight" runat="server" Text='<%# Eval("TOTWT") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblTotalPkg" runat="server" Text='<%# Eval("TOTPKGS") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblType" runat="server" Text='<%# Eval("RAteType") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblEdited" runat="server" Text='<%# Eval("Edited") %>'></asp:Label>
                        </td>
                    </tr>
                </tbody>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 300px; margin-left: 600px;" id="Table2" runat="server">
            <tr class="nrow">
                <td align="center">
                    <b>Total Amount</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblTotalAmount"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td align="center">
                    <b>Rebate</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblRebateAmount"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td align="center">
                    <b>Net Amount</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblNetamount"></asp:Label></td>
            </tr>

            <tr class="nrow">
                <td align="center">
                    <b>Discount</b>
                </td>
                <td>
                <asp:Label runat="server" ID="lblDiscount"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td align="center">
                    <b>Approved Amount</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblApprovedamount"></asp:Label></td>
            </tr>
        </table>
		<table   class="stbl" cellpadding="1" cellspacing="1" width="900px" id="Table3" runat="server">
            <tr class="nrow">
                <td align="center">
                    <b>TDS</b>
                </td>
                <td colspan="7">
                    <asp:Label runat="server" ID="lblTDS"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td align="center">
                    <b>Payable Amount</b>
                </td>
                <td colspan="7">
                    <asp:Label runat="server" ID="lblPayableAmount"></asp:Label></td>
            </tr>
            <tr class="nrow">
                <td align="center">
                    <b>Payment Mode</b>
                </td>
                <td>
                    <asp:Label runat="server" ID="lblPaymentMode"></asp:Label></td>
                <td align="center"><b>Instrument No</b></td>
                <td>
                    <asp:Label runat="server" ID="lblInstrumentNo"></asp:Label></td>

                <td align="center"><b>Instrument Date</b></td>
                <td>
                    <asp:Label runat="server" ID="lblInstrumentDate"></asp:Label></td>
                <td align="center"><b>Bank Name</b></td>
                <td>
                    <asp:Label runat="server" ID="lblBankName"></asp:Label></td>
            </tr>
        </table>
    </form>
</body>
</html>
