<%@ Page Language="C#" AutoEventWireup="true" CodeFile="thcprintview_new.aspx.cs" Inherits="ChiragDesing_thcprintview_new" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
    
    <table border="1" width="100%" cellpadding="0" cellspacing="1" >
    <tr bgcolor="#FFFFFF"> 
      <td width="561" align="left"><%--<img border="0" src="../../../images/"> --%>
          <asp:Image ID="imgLogo" runat="server" ImageUrl="~/GUI/images/webxpress_logo.gif" /></td>
      <td width="433" valign="top"><table border="1" cellpadding="0" cellspacing="0" width="100%" class="std">
          <tr > 
            <td align="left" style="height: 20px"><font class="blackfnt">THC Number :
                <asp:Label ID="LblTHCNo" runat="server" Text="Label" Width="276px"></asp:Label></font></td>
            <td align="left" style="height: 20px">
            
            </td>
          </tr>
          <tr bgcolor="#ffffff"> 
            <td align="left" style="height: 21px"><font class="blackfnt">THC Date :
                <asp:Label ID="LblTHCDt" runat="server" Text="Label" Width="294px"></asp:Label></font></td>
            <td align="left" style="height: 21px">
            
            </td>
          </tr>
          <tr bgcolor="#ffffff"> 
            <td align="left"><font class="blackfnt">THC Updated On :
                <asp:Label ID="LblTHCUpdateOn" runat="server" Text="Label" Width="248px"></asp:Label></font></td>
            <td align="left">
            
            </td>
          </tr>
          <tr > 
            <td align="left"><font class="blackfnt">&nbsp;Manual THC Number&nbsp;:
                <asp:Label ID="LblMTHCNo" runat="server" Text="Label" Width="220px"></asp:Label></font></td>
            <td align="left">
            
            </td>
          </tr>
        </table>
        
        </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td>&nbsp;</td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td><font face="verdana" size="3"><b>Trip Hire Contract </b></font></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td><font face="verdana" size="3">&nbsp;</font></td>
      <td valign="top">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"><table width="100%" border="1" cellspacing="1" cellpadding="0">
          <tr> 
            <td class="blackfnt"  width="13%" ><font class="blackfnt">Route</font></td>
            <td class="blackfnt"  width="16%" >
                <asp:Label ID="LblRoute" CssClass="blackfnt" runat="server" Text="Label" Width="142px"></asp:Label></td>
            <td width="17%" ><font class="blackfnt">Current Location</font></td>
            <td width="17%" >
                <asp:Label ID="LblCurLoc" CssClass="blackfnt" runat="server" Text="Label" Width="142px"></asp:Label></td>
            <td width="16%" ><font class="blackfnt">Vendor Name</font></td>
            <td width="21%" >
                <asp:Label ID="LblVendorName" CssClass="blackfnt" runat="server" Text="Label" Width="188px"></asp:Label></td>
          </tr>
          <tr> 
            <td ><font class="blackfnt">THC Mode</font></td>
            <td >
                <asp:Label ID="lblTHCMode" CssClass="blackfnt" runat="server" Text="Label" Width="142px"></asp:Label></td>
            <td ><font class="blackfnt">Next Stop</font></td>
            <td >
                <asp:Label ID="LblNxtStop" CssClass="blackfnt" runat="server" Text="Label" Width="142px"></asp:Label></td>
            <td ><font class="blackfnt">Vendor Type</font></td>
            <td >
                <asp:Label ID="LblVendorType" CssClass="blackfnt" runat="server" Text="Label" Width="184px"></asp:Label></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td ><font class="blackfnt">Phone</font></td>
            <td >
            
            </td>
          </tr>
          <tr class="bgbluegrey"> 
            <td colspan="6" ><div align="center"><font class="blackfnt">&nbsp;<strong> 
                Vehicle &amp; Driver Summary</strong></font></div></td>
          </tr>
          <tr> 
            <td class="bgbluegrey"><font class="blackfnt">Vehicle Number</font></td>
            <td ><font class="bluefnt"> 
                <asp:Label ID="LblVehNO" runat="server" Text="l" Width="142px"></asp:Label></font></td>
            <td class="bgbluegrey"><font class="blackfnt"> Vehicle Type</font></td>
            <td ><font class="bluefnt">
                <asp:Label ID="LblVehType" runat="server" Text="" Width="142px"></asp:Label></font></td>
            <td class="bgbluegrey"><font class="blackfnt">Fitness Validity Date</font></td>
            <td ><font class="bluefnt"> 
                <asp:Label ID="LblFitValDt" runat="server" Text="" Width="142px"></asp:Label></font></td>
          </tr>
          <tr> 
            <td class="bgbluegrey"><font class="blackfnt">Registration Date</font></td>
            <td ><font class="bluefnt"> 
                <asp:Label ID="LblRegDate" runat="server" Text="Label" Width="142px"></asp:Label></font></td>
            <td class="bgbluegrey"><font class="blackfnt">Insurance Validity Date</font></td>
            <td ><font class="bluefnt">
                <asp:Label ID="LblInsValDt" runat="server" Text="Label" Width="142px"></asp:Label></font></td>
            <td class="bgbluegrey"><font class="blackfnt">Capacity Kg.</font></td>
            <td >
                <asp:Label ID="LblCapacity" CssClass="blackfnt" runat="server" Text="" Width="142px"></asp:Label>&nbsp;</td>
          </tr>
          <tr> 
            <td style="height: 21px" class="bgbluegrey" ><font class="blackfnt">Chassis No.</font></td>
            <td style="height: 21px" ><font class="bluefnt">
                <asp:Label ID="LblChassisNo" runat="server" CssClass="blackfnt" Text="Label" Width="142px"></asp:Label></font></td>
            <td style="height: 21px" class="bgbluegrey"><font class="blackfnt">Engine no.</font></td>
            <td style="height: 21px" ><font class="bluefnt">
                <asp:Label ID="LblEngineNo" runat="server" Text="Label" CssClass="blackfnt" Width="142px"></asp:Label></font></td>
            <td style="height: 21px" class="bgbluegrey"><font class="blackfnt">Usable capacity Kg.</font></td>
            <td style="height: 21px" >
                <asp:Label ID="LblUsableCapacity" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;</td>
          </tr>
          <tr> 
            <td style="height: 21px" class="bgbluegrey"><font class="blackfnt">Current Load Kg.</font></td>
            <td style="height: 21px" ><font class="bluefnt">&nbsp;  
                <asp:Label ID="LblCurrLoad" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label></font></td>
            <td style="height: 21px" class="bgbluegrey"><font class="blackfnt"><strong>Space Available Kg.</strong></font></td>
            <td style="height: 21px" ><font class="bluefnt">&nbsp;  
                <asp:Label ID="LblSpaceAvail" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label></font></td>
            <td style="height: 21px" class="bgbluegrey"><font class="blackfnt"><strong>Load Factor</strong></font></td>
            <td style="height: 21px" >
                <asp:Label ID="LblLoadFactor" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;</td>
          </tr>
		   <tr> 
            <td colspan="6" >&nbsp;</td>
          </tr>
          <tr  align="center"> 
            <td colspan="6" class="bgbluegrey" ><font class="blackfnt">&nbsp;<strong> Vendor Payment 
              details </strong></font></td>
          </tr>
          <tr> 
            <td ><font class="blackfnt"> Advance Amt.</font></td>
            <td colspan="2" ><font class="bluefnt">
                <asp:Label ID="LblAdvAmt" runat="server" Text="Label" CssClass="blackfnt" Width="308px"></asp:Label></font></td>
            <td ><font class="blackfnt">Advance Paidby</font></td>
            <td colspan="2" ><font class="bluefnt">
                <asp:Label ID="LblAdvPaidBy" runat="server" Text="Label" CssClass="blackfnt" Width="344px"></asp:Label></font></td>
          </tr>
		 
          <tr> 
            <td colspan="6" >&nbsp;</td>
          </tr>
          <tr class="bgbluegrey" align="center" > 
            <td ><div align="center"><font class="blackfnt"><strong> Driver Name</strong></font></div></td>
            <td colspan="2"><div align="center"><font class="blackfnt"><strong> License No.</strong></font></div></td>
            <td colspan="2"><div align="center"><font class="blackfnt"><strong> Validity Date</strong></font></div></td>
            <td  colspan="2"><div align="center"><font class="blackfnt"> <strong>Issued by RTO</strong></font></div></td>
            <%--<td colspan="2" rowspan="3" >&nbsp;</td>--%>
          </tr>
         
          <tr> 
            <td ><div align="center"><font class="bluefnt">&nbsp;
                <asp:Label ID="Lbldriver1" runat="server" Text="Label" CssClass="blackfnt" Width="142px"></asp:Label></font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">
                <asp:Label ID="Lbldriver1lic" runat="server" Text="Label" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                </font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">&nbsp;
                <asp:Label ID="Lbldriver1valdt" runat="server" CssClass="blackfnt" Text="Label" Width="142px"></asp:Label></font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">
                <asp:Label ID="Lbldriver1RTO" runat="server" CssClass="blackfnt" Text="Label" Width="142px"></asp:Label>&nbsp;
                </font></div></td>
          </tr>
         
          <tr> 
            <td ><div align="center"><font class="bluefnt">&nbsp;
                <asp:Label ID="Lbldriver2" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label></font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">&nbsp;
                <asp:Label ID="Lbldriver2lic" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label></font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">&nbsp;
                <asp:Label ID="Lbldriver2valdt" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label></font></div></td>
            <td colspan="2"><div align="center"><font class="bluefnt">
                <asp:Label ID="Lbldriver2RTO" runat="server" Text="" CssClass="blackfnt" Width="142px"></asp:Label>&nbsp;
                </font></div></td>
          </tr>
         
        </table>
        
        </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
   
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      <%--<table width="80%" border="1" align="center" cellpadding="0" cellspacing="1">
          <tr class="bgbluegrey"> 
            <td width="31%" ><div align="center"><font class="blackfnt"><strong> 
                Remarks at </strong></font></div></td>
            <td width="39%" ><div align="center"><font class="blackfnt"><strong> 
                Incoming</strong></font></div></td>
            <td width="30%" ><div align="center"><font class="blackfnt"><strong> 
                Outgoing</strong></font></div></td>
          </tr>
          
          <tr> 
            <td ><div align="center"><font class="bluefnt">
                 </font></div></td>
            <td ><div align="center"><font class="bluefnt">
                </font></div></td>
            <td ><div align="center"><font class="bluefnt"> 
                </font></div></td>
          </tr>
         
        </table>--%>
    <asp:GridView ID="GrdPaidFollow" style="width: 100%" EmptyDataText="No Records Found....."  AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1"> 
    <Columns>
    <%--<asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Remarks At" DataField="sourcehb" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>--%>
    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderText="Remarks At" Visible="true">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblfunction1" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"sourcehb")) +" - "+ Convert.ToString(DataBinder.Eval( Container.DataItem,"location")) %>' runat="server"></asp:Label>
                </ItemTemplate> 
    </asp:TemplateField>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="blackfnt" HeaderText="Incoming" DataField="thc_inrem" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Font-Bold="true" HeaderStyle-CssClass="blackfnt" HeaderText="Outgoing" DataField="thc_outrem" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    </Columns> 
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
    </asp:GridView> 
        </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      <table visible="false" border="1" cellspacing="1" cellpadding="0"  width="100%">
          <tr class="bgbluegrey"> 
            
            <td align="center" colspan="11"><font class="blackfnt"><strong>Vehicle 
              Movement Summary</strong></font></td>
          </tr>
          <tr > 
            <td rowspan="2"><font class="blackfnt">Location</font></td>
            <td rowspan="2"><font class="blackfnt">Transit Time</font></td>
            
            <td colspan="4" align="center" bgcolor="#ffffff"><font class="blackfnt">Arrivals 
              [In]</font></td>
            <td colspan="4" align="center" bgcolor="#ffffff"><font class="blackfnt">Departures 
              [Out]</font></TD>
            <td rowspan="2"><font class="blackfnt">Route Code</font></td>
          </tr>
          <tr > 
            <td><font class="blackfnt">STA</font></td>
            <td><font class="blackfnt">ETA</font></td>
            <td><font class="blackfnt">ATA</font></td>
            <td nowrap><font class="blackfnt">Late/ Early [Hrs.]</font></td>
            <td><font class="blackfnt">STD</font></td>
            <td><font class="blackfnt">ETD</font></td>
            <td><font class="blackfnt">ATD</font></td>
            <td nowrap><font class="blackfnt">Late/ Early [Hrs.]</font></td>
          </tr>
    
    </table>
    <%--<%--</td>
    </tr>
    
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      
      
      
      
      
      
      <table width="100%" border="1" cellspacing="1" cellpadding="0">
          <tr class="bgbluegrey"> 
            <td colspan="9"><div align="center"><font class="blackfnt"><strong>Manifest 
                Movement Summary</strong></font></div></td>
          </tr>
          <td align="center"><font class="blackfnt">&nbsp;From-To</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Manifests</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Dockets</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Packages</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Weight</font></td>
          <td width="30" >&nbsp;</td>
          <td align="center"><font class="blackfnt">&nbsp;Branch</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Manifests Loaded</font></td>
          <td align="center"><font class="blackfnt">&nbsp;Manifests Unoaded</font></td>
          </tr>
    <tr class="bgbluegrey"> 
          <tr> 
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td width="30" >&nbsp;</td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
          </tr>
    
    <tr> 
            <td align="center"><font class="bluefnt">&nbsp;<strong>Total</strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td width="30" >&nbsp;</td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;</font></td>
   </tr>
        </table></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"><table width="100%" border="1" cellspacing="1" cellpadding="0">
          <tr class="bgbluegrey"> 
            <td colspan="9"><div align="center"><font class="blackfnt"><strong>THC 
                Profitability Analysis</strong></font></div></td>
          </tr>
          <td width="6%" align="center"><div align="center">Capacity</div></td>
          <td width="10%" align="center"><div align="center"><font class="blackfnt">&nbsp;Usable 
              Cap.</font></div></td>
          <td width="11%" align="center"><div align="center"><font class="blackfnt">&nbsp;Contract 
              Amt</font></div></td>
          <td width="6%" align="center"><div align="center"><font class="blackfnt">&nbsp;Cost/ 
              Kg.</font></div></td>
          <td width="11%" align="center"><div align="center"><font class="blackfnt">&nbsp;Total 
              Weight Moved</font></div></td>
          <td width="11%" ><div align="center"><font class="blackfnt">&nbsp;Total Freight Charged</font></div></td>
          <td width="8%" align="center"><div align="center"><font class="blackfnt">&nbsp;Freight/ 
              Kg.</font></div></td>
          <td width="16%" align="center"><div align="center"><font class="blackfnt">&nbsp;Profit/ 
              Loss<br>
              Total | Per Kg<br>
              </font></div></td>
          <td width="21%" align="center"><div align="center"><font class="blackfnt">&nbsp;Load 
              Factor </font></div></td>
          </tr>
    
    
    <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><div align="center"></div></td>
            <td><div align="center"><font class="bluefnt">&nbsp;</font></div></td>
            <td><div align="center"><font class="bluefnt">&nbsp;</font></div></td>
            <td><div align="center"><font class="bluefnt">&nbsp;</font></div></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table></td>--%>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="9"><div align="center"><font class="blackfnt"><strong> 
                Manifest Movment Summary</strong></font></div></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      <asp:GridView ID="GrdManifestMovment" ShowFooter="true" style="width: 100%" EmptyDataText="No Records Found....."  AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowDataBound="GrdManifestMovment_RowDataBound"> 
            <Columns>
    <%--<asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Remarks At" DataField="sourcehb" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>--%>
             
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="From-To" DataField="fromto"  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Manifests" DataField="tccntr"  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Docktes" DataField="totdkt" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>                
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Packages" DataField="totpkgs" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Weight" DataField="totactuwt" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="" ItemStyle-Font-Size="11 px"  ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Branch" DataField="sourcehb" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Manifests Loaded" DataField="ld_tc" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Manifests Unloaded" DataField="ul_tc" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    </Columns> 
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
    </asp:GridView> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr class="bgbluegrey"> 
            <td colspan="9"><div align="center"><font class="blackfnt"><strong> 
                THC Profitability Analysis</strong></font></div></td>
          </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      <asp:GridView ID="GrdProfitAnalysis" style="width: 100%" EmptyDataText="No Records Found....."  AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1"> 
            <Columns>
    <%--<asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Remarks At" DataField="sourcehb" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>--%>
             
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Capacity"  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Usable Cap."  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Contract Amt."  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>                
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Cost/Kg"  ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Total Weight Moved" DataField="total_wt" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Total Freight Charged" DataFormatString="{0:F2}" DataField="total_freight" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Freight Kg." DataFormatString="{0:F2}"  DataField="frt_per_kg" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Profit | Loss" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Load Factor" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    </Columns> 
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
    </asp:GridView> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr class="bgbluegrey"> 
            <td colspan="9"><div align="center"><font class="blackfnt"><strong> 
                Manifest LOADED at</strong></font></div></td>
          </tr>
      <tr bgcolor="#FFFFFF"> 
      <td colspan="2">
    <asp:GridView ShowFooter="true" ID="GrdManifestLoaded" style="width: 100%" EmptyDataText="No Records Found....."  AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowDataBound="GrdManifestLoaded_RowDataBound"> 
    <Columns>   
    <asp:TemplateField  HeaderText="SR.NO." >
                <ItemTemplate>
                       <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                       </asp:Label>
                </ItemTemplate>
         <HeaderStyle CssClass="blackfnt"  />
    </asp:TemplateField>       
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Manifest No." DataField="tcno"   ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="From" DataField="tcbr" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>                
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="To" DataField="ToBH_Code" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:TemplateField  HeaderText="Number Of Dockets" >
                <ItemTemplate>
                       <asp:Label CssClass="blackfnt" ID="lbl1" text ='<%# Eval("TOT_DKT") %>' runat="server">
                       </asp:Label>
                </ItemTemplate>
         <HeaderStyle CssClass="blackfnt"/>
    </asp:TemplateField>       
    <asp:TemplateField  HeaderText="Packages L/B" >
                <ItemTemplate>
                       <asp:Label CssClass="blackfnt" ID="lbl2" text ='<%# Eval("TOT_LOAD_PKGS") %>' runat="server"></asp:Label>
                       <asp:Label CssClass="blackfnt" ID="Lbldash1" text =" / " runat="server"></asp:Label>
                       <asp:Label CssClass="blackfnt" ID="lbl3" text ='<%# Eval("TOT_PKGS") %>' runat="server"></asp:Label>
                </ItemTemplate>
         <HeaderStyle CssClass="blackfnt"  />
    </asp:TemplateField>       
    <asp:TemplateField  HeaderText="Weight L/B" >
                <ItemTemplate>
                      <asp:Label CssClass="blackfnt" ID="lbl4" text ='<%# Eval("TOT_LOAD_ACTWT") %>' runat="server"></asp:Label>
                       <asp:Label CssClass="blackfnt" ID="lbldash2" text =" / " runat="server"></asp:Label>
                       <asp:Label CssClass="blackfnt" ID="lbl5" text ='<%# Eval("TOT_ACTUWT") %>' runat="server"></asp:Label>
                </ItemTemplate>
         <HeaderStyle CssClass="blackfnt"  />
    </asp:TemplateField>       
    <asp:TemplateField  HeaderText="Airway Bill Amount" >
                <ItemTemplate>
                       <asp:Label CssClass="blackfnt" ID="lbl6" text ='<%# Eval("airbilltotamt") %>' runat="server"></asp:Label>
                </ItemTemplate>
         <HeaderStyle CssClass="blackfnt"  />
    </asp:TemplateField>    
    </Columns> 
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
    </asp:GridView> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
          
    <%--<tr bgcolor="#FFFFFF"> 
      <td colspan="2">
      
      <table width="100%" border="1" cellspacing="1" cellpadding="0">
          <tr class="bgbluegrey"> 
            <td colspan="9"><div align="center"><font class="blackfnt"><strong> 
                Manifest LOADED at</strong></font></div></td>
          </tr>
          <tr> 
            <td align="center"><font class="blackfnt">&nbsp;No.</font></td>
            <td align="center"><font class="blackfnt">&nbsp;Manifest No.</font></td>
            <td align="center"><font class="blackfnt">&nbsp;From</font></td>
            <td align="center"><font class="blackfnt">&nbsp;To</font></td>
            <td align="center"><font class="blackfnt">&nbsp;Number of Dockets</font></td>
            <td align="center"><font class="blackfnt">&nbsp;Package L/B</font></td>
            <td align="center"><font class="blackfnt">&nbsp;Weight L/B</font></td>
           
            <td align="center"><font class="blackfnt">&nbsp;Airway Bill Amount</font></td>
           
          </tr>
          <tr> 
            
          <tr > 
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
            
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp; </font></td>
            
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
           
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
           
            <td align="center" style="height: 17px"><font class="bluefnt">&nbsp;</font></td>
           
          </tr>
          
          <tr> 
            <td align="center" colspan=4><font class="bluefnt">&nbsp;<strong>Total</strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong><strong></strong></font></td>
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong><strong></strong></font></td>
           
            <td align="center"><font class="bluefnt">&nbsp;<strong></strong></font></td>
            
          </tr>
        </table>--%>
        
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2"><table width="100%" border="1" cellspacing="1" cellpadding="0">
          <tr class="bgbluegrey"> 
            <td width="10%" align="center"><font class="blackfnt">&nbsp;Signature Of Driver
</font></td>
            <td width="10%" align="center"><font class="blackfnt">&nbsp;Signature Of Loading Staff</font></td>
            <td width="10%" align="center"><font class="blackfnt">&nbsp;Signature Of Driver</font></td>
            <td width="10%" align="center"><font class="blackfnt">&nbsp;Signature Of Unloading Staff
</font></td>
            <td width="28%" align="center"><font class="blackfnt">&nbsp;Prepared by</font></td>
            <td width="12%" align="center"><font class="blackfnt">&nbsp;At</font></td>
            <td width="27%" align="center"><font class="blackfnt">Entry Date &amp; 
              Time</font></td>
           
          </tr>
          <tr> 
            <td><div align="center"></div></td>
            <td><div align="center"></div></td>
            <td><div align="center"></div></td>
            <td><div align="center"></div></td>
            <td align="left"><div align="center"><font class="bluefnt">&nbsp;<asp:Label ID="LblPreparedBy" runat="server" Text="LblPreparedBy" Width="252px"></asp:Label></font>&nbsp;</div></td>
            <td align="left"><div align="center"><font class="bluefnt">&nbsp;<asp:Label ID="LblAt" runat="server" Text="LblAt" Width="104px"></asp:Label></font>&nbsp;</div></td>
            <td align="left"><div align="center"><font class="bluefnt">
                <asp:Label ID="LblDatetime" runat="server" Text="Label" Width="180px"></asp:Label>&nbsp;</font>&nbsp;</div></td>
          </tr>
        </table></td>
    </tr>
  </table>
    
    </div>
    </form>
</body>
</html>
