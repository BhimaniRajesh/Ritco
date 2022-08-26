<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MultiEmpSelector.ascx.cs" Inherits="GUI_HR_Payroll_MultiEmpSelector" %>

<table>
    <tr>
        <td align="left" valign="middle">
            <asp:ListBox ID="listEmp" runat="server" Height="110" SelectionMode="Multiple" ToolTip="Employees"
                Width="250px"></asp:ListBox>
        </td>
        <td align="center" valign="middle" width="50">
            <asp:Button ID="linkAddAll" runat="server" BorderStyle="Groove" Font-Bold="true"
                OnClick="linkAddAll_Click" Text=">>" ToolTip="Add all to selected" Width="25" /><br />
            <asp:Button ID="linkAddSelected" runat="server" BorderStyle="Groove" Font-Bold="true"
                OnClick="linkAddSelected_Click" Text=">" ToolTip="Add to selected" Width="25" /><br />
            <asp:Button ID="linkRemoveSelected" runat="server" BorderStyle="Groove" Font-Bold="true"
                OnClick="linkRemoveSelected_Click" Text="<" ToolTip="Remove from selected" Width="25" /><br />
            <asp:Button ID="linkRemoveAll" runat="server" BorderStyle="Groove" Font-Bold="true"
                OnClick="linkRemoveAll_Click" Text="<<" ToolTip="Remove all from selected" Width="25" />
        </td>
        <td align="right" valign="middle">
            <asp:ListBox ID="listSelected" runat="server" Height="110" SelectionMode="Multiple"
                ToolTip="Selected Employees" Width="250px"></asp:ListBox>
        </td>
    </tr>
    <tr align="center">
        <td colspan="3">        
        <asp:Label ID="lblMessage" runat="server" ForeColor="red"></asp:Label></td>
   </tr>
</table>
