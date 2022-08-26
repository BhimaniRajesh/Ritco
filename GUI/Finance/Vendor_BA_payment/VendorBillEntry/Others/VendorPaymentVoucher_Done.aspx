<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="VendorPaymentVoucher_Done.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorPaymentVoucher_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2,DT,MODE,chqNo,chqDt,amt,PayACC) 
        { 
        window.open("./VendorBillVeiw1.aspx?strGenerateBillNo=" + arg1 + "," + arg2 + "," + DT + "," + MODE + "," + chqNo + "," + chqDt + "," + amt + "," + PayACC , "es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

    <br />
    <div align="left">
        <table border="0" align="left" style="width: 9.5in" cellspacing="1" bgcolor="#000000"
            cellpadding="4" class="boxbg">
            <tr class="bgbluegrey">
                <td width="100%" align="center" height="18" colspan="4">
                    <font class="blackfnt"><font class="bluefnt"><b>Following document has been successfully
                        generated </b>&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF" height="18" colspan="2" width="25%" nowrap>
                    <font class="blackfnt">Document name</font></td>
                <td align="center" bgcolor="#FFFFFF" height="18" colspan="1" nowrap>
                    <font class="blackfnt">Document Number</font></td>
                <td align="center" bgcolor="#FFFFFF" height="18" colspan="1">
                    <font class="blackfnt">&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF" height="18" colspan="2">
                    <font class="blackfnt">Payment Voucher</font></td>
                <td align="center" bgcolor="#FFFFFF" height="18" colspan="1">
                    <font class="blackfnt">
                        <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></font></td>
                <td align="right" bgcolor="#FFFFFF" height="18" colspan="1">
                    <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',0,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>')">
                        <font class="blklnkund">View</font></a> |<a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',1,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>')">
                        <font class="blklnkund">Print</font></a>
                </td>
            </tr>
            <tr>
                <td align="left" bgcolor="#FFFFFF" height="18" colspan="4">
                    <font class="blackfnt"><b>Your Next Step:</b></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%" height="25" bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../images/clear.gif" width="4" height="4"></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3">
                    <font class="blackfnt" color="#0000FF"><a href="#"><font class="blklnkund">Enter Vendor
                        Payment Bills</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%" height="25" bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../images/clear.gif" width="4" height="4"></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3">
                    <font class="blackfnt" color="#0000FF"><a href="#"><font class="blklnkund">Prepare Vendor
                        Payment Voucher</font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%" height="25" bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../images/clear.gif" width="4" height="4"></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3">
                    <font class="blackfnt" color="#0000FF"><a href="vendorpayvoucher_vpStep1.asp"><font
                        class="blklnkund">View & Print Vendor Payment Vouchers</a></font></td>
            </tr>
        </table>
        <table	 border="0" style="height:6in;width:9.5in" >
							<tr>
							<td><img src="../../../../images/clear.gif" alt="" width="4" height="4" /></td>
							</tr>
							</table>					

    </div>
</asp:Content>
