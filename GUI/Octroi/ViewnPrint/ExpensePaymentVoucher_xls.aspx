<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ExpensePaymentVoucher_xls.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorPaymentVoucher_xls" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

    <br /><br />

<div align="center">

     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4" align="center" style="width:25%">Payment Details</td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Voucher No : </td>
            <td class="blackfnt">
                <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Voucher Date : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblvoucherdate" runat="server"></asp:Label>
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Vendor : </td>
            <td class="blackfnt"  align="left" colspan="3">
                <asp:Label ID="lblvendor" runat="server"></asp:Label>
            </td>
        </tr>
                   
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Vendor Service Tax No. : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorservtaxno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Vendor PAN No. : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvendorpanno" runat="server"></asp:Label>
            </td>
        </tr>      
          
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">&nbsp;</td>
            <td class="blackfnt" align="left">&nbsp;</td>
            <td class="blackfnt" align="left"><strong>Net Payable : </strong></td>
            <td class="blackfnt" style="width:25%" align="left">
                <strong><asp:Label ID="lblnetpayable" runat="server"></asp:Label></strong>
            </td>
        </tr>     
     </table>
<br /><br />


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" align="center">Vendor Bill Details</td>
        </tr>    
    </table>
<br /><br />


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" align="center">Bill Entry Number : </td>
            <td class="blackfnt" align="center">Vendor Bill Number : </td>
            <td class="blackfnt" align="center"> Vendor Bill Date :</td>
            <td class="blackfnt" align="center">Due Date :</td>
            <td class="blackfnt" align="center">Net Payable :</td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="center">
                <a href="VendorVoucherBill_xls.aspx?billno=<%=billno %>"><asp:Label ID="lblbillno" runat="server"></asp:Label></a>
            </td>
            <td class="blackfnt" align="center">
                <asp:Label ID="lblvendorbillno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="center">
                <asp:Label ID="lblvendorbilldate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="center">
                <asp:Label ID="lblduedate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="center">
                <asp:Label ID="lblnetpayable2" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="center">&nbsp;</td>
            <td class="blackfnt" align="center">&nbsp;</td>
            <td class="blackfnt" align="center">&nbsp;</td>
            <td class="blackfnt" align="center"><strong>Total :</strong></td>
            <td class="blackfnt">
                <strong><asp:Label ID="lbltotal" runat="server"></asp:Label></strong>
            </td>
        </tr>    
    </table>    
    <br /><br />
        



        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
                <tr class="<%=bgbluegrey %>">
                    <td class="blackfnt" align="center">Payment Summary</td>
                </tr>    
            </table>
        <br /><br />





    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>"  width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4" align="center" style="width:25%">Payment Details</td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Mode Of Transaction :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltransmode" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Issued From Account :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblissuedfromacc" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Cheque No :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchequeno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Cheque Date :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchequedate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Cheque Amount :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchequeamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">&nbsp;</td>
            <td class="blackfnt" style="width:25%" align="left">&nbsp;</td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Payment Amount :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblpayamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt" align="left">
            </td>
        </tr>    
    </table>
</div>
</asp:Content>
