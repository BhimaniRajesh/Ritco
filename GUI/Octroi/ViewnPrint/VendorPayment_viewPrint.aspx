<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorPayment_viewPrint.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorPayment_viewPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="server">

    <br /><br />
<div align="center">
    <table cellpadding="1" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt">Expense Entry Summary</td>
        </tr>
    </table>
    
    <br /><br />

     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Bill Entry Number : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblbillno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Bill Entry Date : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblentrydt" runat="server"></asp:Label>
            </td>
        </tr>
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Vendor Name : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorname" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Vendor Accounted To : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvendoraccto" runat="server"></asp:Label>
            </td>
        </tr>     
           
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Vendorr Bill Number : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorbillno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Vendor Bill Amount : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblvendorbillamt" runat="server"></asp:Label>
            </td>
        </tr>      
          
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Vendor Bill Date : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblvendorbilldate" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Due Date : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblduedate" runat="server"></asp:Label>
            </td>
        </tr>     
           
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Ref. No. : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblrefno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Remark : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblremark" runat="server"></asp:Label>
            </td>
        </tr>    
            
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Other Deduction : </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblothded" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">Discount Recieved : </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbldiscrec" runat="server"></asp:Label>
            </td>
        </tr>     
          <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">&nbsp;</td>
            <td class="blackfnt" style="width:25%;" align="left">&nbsp;</td>
            <td class="blackfnt" align="left" style="width:25%"><strong>Net Amount</strong></td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblnetamt" runat="server"></asp:Label>
            </td>
        </tr>     
     </table>
<br /><br />


 <table cellpadding="1" cellspacing="1" class="boxbg" width="85%">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt">Details of Account Head</td>
        </tr>
    </table>
<br />


     <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
        <tr bgcolor="#ffffff">
            <td class="blackfnt" style="width:25%;" align="left">Account Head</td>
            <td class="blackfnt" align="left" style="width:25%">Debit</td>
            <td class="blackfnt" style="width:25%" align="left">Narration</td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblacchead" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lbldebit" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblnarraion" runat="server"></asp:Label>
            </td>
        </tr>
    </table>


<br /><br />


                        <%--TAX TABLE--%>
                        
                        
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">
       <tr class="bgbluegrey">
            <td class="blackfnt" align="center" style="width:25%">TAX</td>
            <td class="blackfnt" style="width:25%;" align="center">Account Head</td>
            <td class="blackfnt" align="center" style="width:25%">Approved Rate </td>
            <td class="blackfnt" style="width:25%" align="center">Value</td>
        </tr>     
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Service Tax :
            </td>
            <td class="blackfnt" style="width:25%;" align="left">Service Tax (CENVET) : </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lblsertax" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblsertaxcenvet" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">Education Cess :
            </td>
            <td class="blackfnt" style="width:25%;" align="left">CESS & OTHERS : </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lbleducess" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lblcessnoth" runat="server"></asp:Label>
            </td>
        </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width:25%">TDS :
            </td>
            <td class="blackfnt" style="width:25%;" align="left">TDS PAYABLE CONTRACT : </td>
            <td class="blackfnt" align="left" style="width:25%">
                <asp:Label ID="lbltds" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" style="width:25%" align="left">
                <asp:Label ID="lbltdscontract" runat="server"></asp:Label>
            </td>
        </tr>    
         
        <tr bgcolor="#ffffff">
            <td class="blackfnt" colspan="3" align="left" style="width:25%"><strong>Net Payable Amount</strong>
                
            </td>
            <td class="blackfnt" style="width:25%;" align="left">
                <asp:Label ID="lblnetpay" runat="server"></asp:Label>
            </td>
        </tr>
    
    </table>                        

</div>
</asp:Content>
