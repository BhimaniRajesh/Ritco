<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_step2.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_step2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


<table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance & Accounts</strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class=bluefnt><strong> &gt; </strong>
		  <strong>New Contract </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

   
        
        <tr> 
          <td align=right><img src="./../../images/back.gif" border=0></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 


<table align="center"  border="0" cellPadding="7" cellSpacing="1" width="80%" class="boxbg">
 
<tr class="bgbluegrey">
<td colspan=3 align="center"><font class=blackfnt><b>VENDOR CONTRACT MASTER </b></font></td>
</tr>
<TR>
<td bgcolor="#FFFFFF">
<table id="tblPenalty1" runat="server"    BORDER="0" align="center" cellSpacing="1" cellpadding=6 style="width: 9.0in;" class="boxbg">
<tr >
<td colspan=4 class="bgbluegrey"><font class=blackfnt><strong><U>Step : 2</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Summary of Charges</b> </strong></font></td>
</tr><tr >
<td colspan=4 bgcolor="#ffffff">
<table id="tblPenalty" runat="server"  BORDER=0 align=center cellSpacing=1 cellpadding=6 style="width: 9.0in;" class="boxbg">

<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class=blackfnt>Late penalty</font></td>
<td width="25%" nowrap><font class=blackfnt>Per hour</font></td>
                            <td width="25%">&nbsp;<asp:TextBox ID="txtpenperhour" runat="server" Width="30px"></asp:TextBox></td>
<td width="25%"><font class=blackfnt>% of contract</font></td>
                            <td width="25%">&nbsp;<asp:TextBox ID="txtpenperctr" runat="server" Width="30px"></asp:TextBox></td>
                          </tr>
<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class=blackfnt>Incentive</font></td>
<td width="25%" nowrap><font class=blackfnt>Per hour</font></td>
                            <td width="25%">&nbsp;<asp:TextBox ID="txtincperhour" runat="server" Width="30px"></asp:TextBox></td>
<td width="25%"><font class=blackfnt>% of contract</font></td>
                            <td width="25%"><font class=blackfnt>
                                <asp:TextBox ID="txtincperctr" runat="server" Width="30px"></asp:TextBox></td>
                          </tr>  
</table>
</td>
</tr>
</table>
<br>
<table  BORDER=0 align=center cellSpacing=1 cellpadding=6 style="width: 7.0in;" class="boxbg">
<tr class="bgbluegrey">
<td colspan=4><font class=blackfnt><strong><U></U>&nbsp;&nbsp;&nbsp;&nbsp<b>Select Charge Matrices</b> </strong></font></td>
</tr><tr bgcolor="#ffffff">
<td colspan=4><table  BORDER=0 align=center cellSpacing=1 cellpadding=6 WIDTH="100%" class="boxbg">
                          <tr  bgcolor="#ffffff"> 
                            <td align=center width="5%"><font class=blackfnt>Selection</font></td>
                            <td align=center><font class=blackfnt>Matrix</font></td>
                           
                          </tr>
                         
                          <tr id="long_trip"  visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center >&nbsp;
                                <asp:RadioButton ID="m1" GroupName="abc" runat="server" />&nbsp;</td>
                            <td align=center><font class=blackfnt>Long haul-road-Per 
                              trip (Route Matrix)</font></td>
                           
                          </tr>
                          
                          <tr id="long_trip_city"  visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center >&nbsp;
                                <asp:RadioButton ID="m11" GroupName="abc" runat="server" />&nbsp;</td>
                            <td align=center><font class=blackfnt>Long haul-road-Per 
                              trip (City Wise Route Matrix)</font></td>
                           
                          </tr>
                         
                          <tr id="long_trip_km" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m2"  GroupName="abc" runat="server" /></td>
                            <td width="15%" nowrap align=center><font class=blackfnt>Long 
                              haul-road-Per Km.</font></td>
                           
                          </tr>
                        
                          <tr id="Mileage" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m9" Enabled="false"  GroupName="abc" runat="server" /></td>
                            <td width="15%" nowrap align=center><font class=blackfnt>Mileage 
                              basis</font></td>
                           
                          </tr>
                         
                          <tr id="Col" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m3" GroupName="abc" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Co-Load</font></td>
                          
                          </tr>
                         
                          <tr id="Air" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m4"  GroupName="abc" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Air 
                              Route</font></td>
                           
                          </tr>
                         
                          <tr id="Rail" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m5" GroupName="abc" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Rail 
                              Route</font></td>
                           
                          </tr>
                        
                          <tr id="Dely" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m6" GroupName="abc1" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Delivery 
                              Charges</font></td>
                           
                          </tr>
                          <tr id="Bkg" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m7" GroupName="abc1" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Booking 
                              Charges</font></td>
                           
                          </tr>
                          
                          <tr id="month_fix" visible="false" bgcolor="#ffffff" runat="server"> 
                            <td width="5%" nowrap align=center>&nbsp;<asp:RadioButton ID="m10" GroupName="abc23" runat="server" /></td>
                            <td width="20%" nowrap align=center><font class=blackfnt>Monthly Fix Charges</font></td>
                           
                          </tr>
      
                          <tr bgcolor="#FFFFFF"> 
                            <td colspan=4 align=center>&nbsp;<asp:Button ID="Submit" runat="server"  Text="Submit" OnClick="Submit_Click" /></td>
                          </tr>
                        </table>
</td>
</tr>
</TABLE>
<br>
</td>
</tr>
</table>

					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

</asp:Content>

