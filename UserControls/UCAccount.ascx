<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UCAccount.ascx.cs" Inherits="UserControls_WebUserControl" %>
 <table >
	<tr>
		<td>
		<asp:textbox id="txtAcccode" runat="server" width="75px"    MaxLength="7" CssClass="input" OnTextChanged="getAccountDesc" AutoPostBack="true" BorderStyle="Groove" ></asp:textbox> 
        </td>
        <td>
        <asp:textbox id="txtAccdesc" runat="server" width="150px" CssClass="input" MaxLength="50" ReadOnly="true" BorderStyle="Groove"   ></asp:textbox><asp:Button  runat = "server" ID="cmdctrpopup" Text="..." />
        </td>
	</tr>
</table>