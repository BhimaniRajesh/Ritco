<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result_Trail_balance.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Trail_balance_Result_Trail_balance" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />   
  <table id="Table3"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" >
      <tr><td></td></tr>
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 12px"><font class="blackboldfnt">Reports</font> > <a href="../../rpt_finance.aspx"><font class="blklnkund">Finace & Accounts </font></a>></font><font class="bluefnt"> Trail Balance </font></td></tr>  
       <tr> 
          
        </tr>
        </table>
   
<br />          
 <table id="Table1"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 10px"><font class="balckfnt">Branch / Profit Center </font></td><td><asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label></td></tr>  
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 10px"><font class="balckfnt">Date Range </font></td><td><asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td></tr>  
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 10px"><font class="balckfnt">Account </font></td><td><asp:Label ID="lblrpt" runat="server" CssClass="blackfnt"></asp:Label></td></tr>  
        </table>
        <br />
        <br />
<asp:Table id="tblheadache" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
        
        <br />
        <br />
        <table id="Table2"   runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td><asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td></tr>  
 
        </table>
</asp:Content>

