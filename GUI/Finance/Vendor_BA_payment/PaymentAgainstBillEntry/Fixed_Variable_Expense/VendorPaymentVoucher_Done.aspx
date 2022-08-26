<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="VendorPaymentVoucher_Done.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorPaymentVoucher_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2,DT,MODE,chqNo,chqDt,amt,PayACC) 
        { 
        window.open("./VendorBillVeiw1.aspx?strGenerateBillNo=" + arg1 + "," + arg2 + "," + DT + "," + MODE + "," + chqNo + "," + chqDt + "," + amt + "," + PayACC , "es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=850,height=550,status=no,left=60,top=100"); 
        }
    </script>

    <br />
    <div align="left">
        <table border="0" align="left" width="50%" cellspacing="1" bgcolor="#000000"
            cellpadding="4" class="boxbg">
            <tr class="bgbluegrey">
                <td width="100%" align="center"  colspan="4">
                    <font class="blackfnt"><font class="bluefnt"><b>Following document has been successfully
                        generated </b>&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF"  colspan="2" width="25%" nowrap>
                    <font class="blackfnt">Document name</font></td>
                <td align="center" bgcolor="#FFFFFF"  colspan="1" nowrap>
                    <font class="blackfnt">Document Number</font></td>
                <td align="center" bgcolor="#FFFFFF"  colspan="1">
                    <font class="blackfnt">&nbsp;</font></td>
            </tr>
            <tr>
                <td align="center" bgcolor="#FFFFFF"  colspan="2" nowrap>
                    <font class="blackfnt">Payment Voucher</font></td>
                <td align="center" bgcolor="#FFFFFF"  colspan="1">
                    <font class="blackfnt">
                        <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></font></td>
                <td align="right" bgcolor="#FFFFFF"  colspan="1">
                    <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',0,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>','<%=Request.QueryString.Get("PayACC")%>')">
                        <font class="blklnkund">View</font></a> |<a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',1,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>','<%=Request.QueryString.Get("PayACC")%>')">
                        <font class="blklnkund">Print</font></a>
                </td>
            </tr>
            <tr>
                <td align="left" bgcolor="#FFFFFF"  colspan="4">
                    <font class="blackfnt"><b>Your Next Step:</b></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%"  bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../../../images/clear.gif" width="4" ></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF"  colspan="3">
                    <font class="blackfnt" >Enter Vendor
                        Payment Bills for <a href="../../VendorBillEntry/Fixed_Variable_Expense/ExpenseQuery.aspx"><font class="blklnkund">Fixed/Variable</font></a>
                        OR <a href="../../VendorBillEntry/DieselExpense/DieselExpenseNew.aspx"><font class="blklnkund">Fuel</font></a>
                        </font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%"  bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../../../images/clear.gif" width="4" ></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF"  colspan="3">
                    <font class="blackfnt" >Prepare Vendor
                        Payment Voucher for <a href="THCSearch.aspx?doctype=GENEXP"><font class="blklnkund">Fixed/Variable</font></a> OR <a href="THCSearch.aspx?doctype=FUEL"><font class="blklnkund">Fuel</font></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td width="2%" bgcolor="#FFFFFF">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="bullet">
                                <img src="../../../../images/clear.gif" width="4" ></td>
                        </tr>
                    </table>
                </td>
                <td width="100%" align="left" bgcolor="#FFFFFF"  colspan="3">
                    <font class="blackfnt" color="#0000FF"><a href="../../View_N_Print/FrmCriteria.aspx"><font
                        class="blklnkund">View & Print Vendor Payment Vouchers</a></font></td>
            </tr>
        </table>
        <br>
        <%--<table	 border="0" style="height:6in;width:9.5in" >
							<tr>
							<td><img src="../../../../images/clear.gif" alt="" width="4" height="4" /></td>
							</tr>
							</table>	--%>				

    </div>
</asp:Content>
