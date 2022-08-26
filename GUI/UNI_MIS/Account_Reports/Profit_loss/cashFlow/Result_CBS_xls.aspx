<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result_CBS_xls.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance" Title="Untitled Page" %>

    
 
                                                            
<br />
    <br />
    <table align="center" cellspacing="1" style="width: 5.0in" border="1">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                     Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label>
               </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px" class="blackfnt">
                Location</td>
            <td style="width: 343px">
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        
    </table>
       
    <br />
    <br />
        <asp:Table id="tblheadache" runat="server"  style="width:9.0in;" border="1">
        
        </asp:Table>
    <br/>
       
    <br/>
       <table cellspacing="1" style="width: 9.0in" border="1" >
       
        <tr bgcolor="#FFFFFF">
       
        <td><label class="blackfnt">Prepare By</label></td>
       
        <td height="24"  align="right"><font class="bluefnt"><asp:Label cssclass="blackfnt" ID="lblPrepareBy" runat="server" Font-Bold="false">
                                                                            </asp:Label></font></td>
        <td><label class="blackfnt">At </label></td>
       
      <td height="24"  align="right"><font class="bluefnt"><asp:Label cssclass="blackfnt" ID="lblAt" runat="server" Font-Bold="false">
                                                                            </asp:Label></font></td>
        <td><label class="blackfnt">Date & Time </label></td>
        <td height="24"  align="right"><font class="bluefnt"><asp:Label cssclass="blackfnt" ID="lblDateTime" runat="server" Font-Bold="false">
                                                                            </asp:Label></font></td>
       
       
                                               
        </tr>
        
        <tr bgcolor="#FFFFFF">
       
        <td><label class="blackfnt">Certified & Approved By</label></td>
       
        <td><label class="blackfnt"></label></td>
        <td><label class="blackfnt"> </label></td>
       
        <td><label class="blackfnt"></label></td>
        <td><label class="blackfnt"></label></td>
       
       <td height="28"  > 
      <center>
        <font class="blackfnt"></font> 
      </center>
    </td>
                                               
        </tr>
        </table>
                     <br />                      
    
                                                 <br />
    <br/>     
                                                     
                                                  

