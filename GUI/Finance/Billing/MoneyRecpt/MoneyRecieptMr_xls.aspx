<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="MoneyRecieptMr_xls.aspx.cs" Inherits="GUI_Finance_MoneyRecpt_MoneyRecieptMr_xls" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="aaaa" runat="server">

<div align="center">

<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<% boxbg%>" width="85%">
        <tr class="<%bgbluegrey %>">
            <td colspan="4" class="blackfnt" align="center"><strong>MR Summary</strong></td>
        </tr>    
    </table>
<br /><br />


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<% boxbg%>" width="85%">
       <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">MR Number :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblmrno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Date : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblmrdate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left"> Mr Type : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblmrtype" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Mr Branch :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblmrbranch" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Docket Number :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbldocketno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Docket Date :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbldocketdate" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Party : </td>
            <td class="blackfnt" align="left" colspan="3">
                <asp:Label ID="lblparty" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Booking Branch</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblbookbranch" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"> Delivery Branch : </td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbldelbranch" runat="server"></asp:Label>
            </td>
        </tr>    
        
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">No of Packages :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblpackno" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Charged Weight :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblchrgweight" runat="server"></asp:Label>
            </td>
        </tr>    
    </table>    
    <br /><br />
        
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<% boxbg%>" width="85%">
        <tr class="<%bgbluegrey %>">
            <td class="blackfnt" align="center"><strong>Collection Details</strong></td>
        </tr>    
    </table>
    <br /><br />
    
     
      <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="<% boxbg%>" width="85%">
       <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Freight Amount :</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblfreightamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">TDS Rate (%):</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltdsrate" runat="server"></asp:Label>
            </td>
       </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Serviec Tax (+)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblsertax" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">TDS Amount (-)</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltdsamt" runat="server"></asp:Label>
            </td>
       </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt" align="left">
                <asp:Label ID="Label7" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left">Other Deduction</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblothded" runat="server"></asp:Label>
            </td>
       </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left"><strong>Total</strong></td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lbltotal" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"><strong>Net Amount</strong></td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblnetamt" runat="server"></asp:Label>
            </td>
       </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Collection Amount</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblcolamt" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt" align="left">
                <asp:Label ID="Label12" runat="server"></asp:Label>
            </td>
       </tr>    
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left">Remark</td>
            <td class="blackfnt" align="left">
                <asp:Label ID="lblremark" runat="server"></asp:Label>
            </td>
            <td class="blackfnt" align="left"></td>
            <td class="blackfnt" align="left">
                <asp:Label ID="Label14" runat="server"></asp:Label>
            </td>
       </tr>    
      </table>
 </div>
 </asp:Content>
