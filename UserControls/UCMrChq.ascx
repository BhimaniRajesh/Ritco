<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCMrChq.ascx.cs" Inherits="UserControls_UCMrChq" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="atlasToolkit" %>
     <atlas:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></atlas:ScriptManager>
   <link id="Link1" href="../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
      
 <Table  cellSpacing="1" cellPadding="3" border="0" bgcolor="#808080" width="95%" class=boxbg >
    <tr class="bgbluegrey">
        <td><font class="blackfnt">Cheque No</font></td>
        <td><font class="blackfnt">Cheque Date</font></td>
        <td><font class="blackfnt">Cheque Amount</font></td>
        <td><font class="blackfnt">On Account Balance</font></td>
        <td><font class="blackfnt">Accounted Amount</font></td>
        <td><font class="blackfnt">Bank Name</font></td>
        <td><font class="blackfnt">Branch</font></td>
    </tr>
     <tr class="bgwhite">
		<td>
		    <asp:textbox id="txtChqNo" runat="server" width="75px" MaxLength="6"  AutoPostBack="true" BorderStyle="Groove" ></asp:textbox> 
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel1"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtChqDt" runat="server" AutoPostBack="true" MaxLength="7" width="75px" OnTextChanged="getChqInfo" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
</atlas:UpdatePanel>
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel2"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtChqAmt" runat="server" MaxLength="11" width="75px" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
<Triggers>
<atlas:ControlEventTrigger ControlID="txtChqDt" EventName="TextChanged"></atlas:ControlEventTrigger>
</Triggers>
</atlas:UpdatePanel>
        
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel3"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtOnAcctAmt" runat="server" MaxLength="11" width="75px" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
<Triggers>
<atlas:ControlEventTrigger ControlID="txtChqDt" EventName="TextChanged"></atlas:ControlEventTrigger>
</Triggers>
</atlas:UpdatePanel>
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel4"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtIndClAmt" runat="server" MaxLength="11" width="75px" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
<Triggers>
<atlas:ControlEventTrigger ControlID="txtChqDt" EventName="TextChanged"></atlas:ControlEventTrigger>
</Triggers>
</atlas:UpdatePanel>
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel5"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtBankName" runat="server" MaxLength="50" width="75px" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
<Triggers>
<atlas:ControlEventTrigger ControlID="txtChqDt" EventName="TextChanged"></atlas:ControlEventTrigger>
</Triggers>
</atlas:UpdatePanel>
        </td>
        <td>
		<atlas:UpdatePanel id="UpdatePanel6"  Mode="Conditional" RenderMode="Inline" runat="server" ><ContentTemplate>
<asp:textbox id="txtBankBranch" runat="server" MaxLength="50" width="75px" BorderStyle="Groove"></asp:textbox> 
</ContentTemplate>
<Triggers>
<atlas:ControlEventTrigger ControlID="txtChqDt" EventName="TextChanged"></atlas:ControlEventTrigger>
</Triggers>
</atlas:UpdatePanel>
        </td>
      </tr>   
 </table>