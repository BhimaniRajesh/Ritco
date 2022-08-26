<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="PDCVoucher_xls.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_PDCVoucher_xls" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<div align="center">
    <br /><br />


     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr bgcolor="#ffffff">
            <td style="font-family:Bookman Old Style; font-size:medium;width:25%" align="left" colspan="2">
                <asp:Label ID="lblheader" runat="server"><strong>RunSheet - Advance Payment Voucher</strong></asp:Label>
            </td>
            
            <td class="blackfnt" align="left" style="width:25%">RunSheet Branch : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblrunsheet" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Voucher No : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
            </td>
            
            <td class="blackfnt" align="left" style="width:25%">Voucher Date :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvoucherdate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">RunSheet No : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblrunsheetno" runat="server"></asp:Label>
            </td>
            
            <td class="blackfnt" align="left" style="width:25%">RunSheet Date :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblrunsheetdate" runat="server"></asp:Label>
            </td>
        </tr>
         <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Vendor Name : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorname" runat="server"></asp:Label>
            </td>
            
            <td class="blackfnt" align="left" style="width:25%">Vehicle Number : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvehicleno" runat="server"></asp:Label>
            </td>
        </tr>     
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Ref No. : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblrefno" runat="server"></asp:Label>
            </td>
            
             <td class="blackfnt" align="left" style="width:25%">Run Sheet Type : </td>
             <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblrunsheettype" runat="server"></asp:Label>
            </td>
        </tr>     
           
          
       
     </table>
<br /><br />




    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4" align="center" style="width:25%">Payment Information</td>
        </tr>  
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Contract Amount(+) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblcontractamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">&nbsp;</td>
            <td class="blackfnt" style="width:25%;" align="left">&nbsp;</td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Other Charges(+):</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblothchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Party PAN Number :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblpanno" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">TDS rate(%) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltdsrate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">TDS Type :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbltdstype" runat="server"></asp:Label>
            </td>
           
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">TDS amount(-) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltdsamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">TDS Deducted For :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbltdsdeducted" runat="server"></asp:Label>
            </td>
        </tr>    
       
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Net Payable :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblnetpay" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Paid by :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblpaidby" runat="server"></asp:Label>
            </td>
        </tr>    
        
        
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4" align="center" style="width:25%">Payment Details</td>
        </tr>    
        
        
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Mode of Transaction : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltransmode" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Payment Account</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblpayacc" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Cheque No.</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblchequeno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Cheque Date :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblchequedate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Amount</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">&nbsp;</td>
            <td class="blackfnt" style="width:25%;" align="left">&nbsp;</td>
        </tr>   
         
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Balance Amount :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblbalamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Balance Payable At :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblbalpaybleat" runat="server"></asp:Label>
            </td>
        </tr>    
    </table> 
    <br /><br />
 
</div>





</asp:Content>
