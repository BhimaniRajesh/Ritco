<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorPaymentVoucher_Done.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_VendorPaymentVoucher_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1) {
            //alert("Hi");
            var VoucherNo = document.getElementById('ctl00_MyCPH1_HdnVoucherNo').value;
            window.open("../../../../UNI_Net_MIS/THCAdvVendrBillPay/ResultVoucherView.aspx?DocumentNo=" + arg1 + "&VoucherNo=" + VoucherNo, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");

//window.open("../../../../UNI_Net_MIS/THCAdvVendrBillPay/Result.aspx?DocumentNo=" + arg1, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");        
}
    </script>
    <br />
    <div align="left">
        <table border="0" align="left" width="50%" cellspacing="1" bgcolor="#000000"
            cellpadding="4" class="boxbg">
            <tr class="bgbluegrey">
                <td width="100%" align="center" colspan="6">
                    <font class="blackfnt"><font class="bluefnt"><b>Following document has been successfully
                        generated </b>&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF" width="25%" nowrap>
                    <font class="blackfnt">Document name</font></td>
                <td align="center" bgcolor="#FFFFFF"  nowrap>
                    <font class="blackfnt">Vendor Name</font></td>
                <td align="center" bgcolor="#FFFFFF"  nowrap>
                    <font class="blackfnt">Amount</font></td>
                <td align="center" bgcolor="#FFFFFF"  nowrap>
                    <font class="blackfnt">Document Number</font></td>
                <td align="center" bgcolor="#FFFFFF"  nowrap>
                    <font class="blackfnt">Voucher Date</font></td>
                <td align="center" bgcolor="#FFFFFF" >
                    <font class="blackfnt">&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF"  nowrap>
                    <font class="blackfnt">Payment Voucher</font></td>
                <td align="center" bgcolor="#FFFFFF" >
                    <font class="blackfnt">
                        <asp:Label ID="lblVendorName" runat="server" Text=""></asp:Label></font></td>
                <td align="center" bgcolor="#FFFFFF" >
                    <font class="blackfnt">
                        <asp:Label ID="lblAmount" runat="server" Text=""></asp:Label></font></td>
                <td align="center" bgcolor="#FFFFFF" >
                    <font class="blackfnt">
                        <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></font></td>
                <td align="center" bgcolor="#FFFFFF" >
                    <font class="blackfnt">
                        <asp:Label ID="lblVoucherDate" runat="server" Text=""></asp:Label></font></td>
                <td align="right" bgcolor="#FFFFFF" >
                    <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("DocumentNo")%>'"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("DocumentNo")%>')">
                            <font class="blklnkund">View</font></a>
                        <asp:HiddenField ID="HdnVoucherNo" runat="server" />
                </td>
            </tr>
        </table>
        <br>
    </div>
</asp:Content>
