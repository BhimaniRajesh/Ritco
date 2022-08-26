<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustContractInfo.ascx.cs"
    Inherits="GUI_admin_CustomerContractMaster_CustContractInfo" %>
    <br />
<asp:Table ID="Table1" runat="server" CssClass="blackfnt">
    <asp:TableRow BackColor="White">
        <asp:TableCell>
				       &nbsp;ContractID  
        </asp:TableCell>
        <asp:TableCell>
            :
            <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'"
                CssClass="redfnt" Font-Bold="true"></asp:Label>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow BackColor="White">
        <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
        </asp:TableCell>
        <asp:TableCell>
            :
            <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                CssClass="blackfnt" Font-Bold="true"></asp:Label>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<br />
