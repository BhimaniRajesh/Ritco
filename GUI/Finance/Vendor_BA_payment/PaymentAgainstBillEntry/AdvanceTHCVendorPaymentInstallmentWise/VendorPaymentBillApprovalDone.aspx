<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorPaymentBillApprovalDone.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_VendorPaymentBillApprovalDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
    </script>
    <br />
    <div align="left">
        <table border="0" align="left" width="50%" cellspacing="1" bgcolor="#000000"
            cellpadding="4" class="boxbg">
            <tr class="bgbluegrey">
                <td width="100%" align="center" colspan="6">
                    <font class="blackfnt"><font class="bluefnt"><b>Following bill document has been successfully Approved
                        </b>&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF" width="25%" nowrap>
                    <font class="blackfnt">Document name</font></td>
                <td align="center" bgcolor="#FFFFFF" nowrap>
                    <font class="blackfnt">Document Number</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF" nowrap>
                    <font class="blackfnt">Bill Approval</font></td>
                <td align="center" bgcolor="#FFFFFF">
                    <font class="blackfnt">
                        <asp:Label ID="lblBillNo" runat="server" Text=""></asp:Label></font></td>
            </tr>
        </table>
        <br/>
    </div>
</asp:Content>
