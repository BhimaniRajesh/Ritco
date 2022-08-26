<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCAdvancedVoucher.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorVoucher_viewPrint" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<div align="center">
    <br /><br />


     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" colspan="2" style="width:10%">
                <asp:Label ID="lblheader" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:10%">Voucher No : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:10%">THC Number : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblthcnumber" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:10%">Voucher Date :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvoucherdate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:10%">Route Name : </td>
            <td class="blackfnt" style="width:90%;" align="left" colspan="3">
                <asp:Label ID="lblroutename" runat="server"></asp:Label>
            </td>
        </tr>     
           
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:10%">Manual FM Number : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblmanfmno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:10%">Paid At : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblpaidat" runat="server"></asp:Label>
            </td>
        </tr>      
          
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:10%">Vendor Name : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorname" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:10%">Vehicle Number : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvehicleno" runat="server"></asp:Label>
            </td>
        </tr>     
     </table>
<br /><br />




    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Standard Contract Amount : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblstdcontamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">TDS Type :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbltdstype" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Contract Amount(+) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblcontractamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">TDS Deducted For :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbltdsdeducted" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Telephone Charges(+) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltelchrg" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Party PAN Number :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblpanno" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Hamali(-) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblhamali" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Advanced Paid(-) :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbladpaid" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Mamul(-) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblmamul" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Advanced Amount(-) :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbladamount" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">TDS rate(%) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltdsrate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Advance Amount Paid by :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbladamtpaidby" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">TDS amount(-) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltdsamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Net Amount Paid :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblnetamtpaid" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Service Tax rate(%) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblsertaxreate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Balance Amount :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblbalamt" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Service Tax(+) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblsertax" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Balance Payable At :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblbalpaybleat" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Cess(+) :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblcess" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%"></td>
            <td class="blackfnt" style="width:25%" align="left">
           <%--     <asp:Label ID="lblrswords" runat="server"></asp:Label>--%>
            </td>
        </tr>    
    </table> 
    <br /><br />
        
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<%=boxbg %>"  width="85%">
        <tr class="<%=bgbluegrey %>">
            <td class="blackfnt" colspan="4" align="center" style="width:25%">Payment Details</td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Mode Of Transaction :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lbltransmode" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Payment Account :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblpayacc" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Cheque No :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblchequeno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Cheque Date :</td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblchequedate" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Payment Amount :</td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblpayamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%"></td>
            <td class="blackfnt" style="width:25%" align="left">
           <%--     <asp:Label ID="lbl" runat="server"></asp:Label>--%>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%" colspan="4"><strong>Rs. (In words) Only</strong>
              <asp:Label ID="lblrswordonly" runat="server"></asp:Label>
            </td>
        </tr>    
    </table>
</div>


</asp:Content>
