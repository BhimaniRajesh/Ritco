<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewSSC.ascx.cs" Inherits="GUI_admin_CustomerContractMaster_ViewSSC" %>
<asp:Table ID="tblmain" runat="server" CellSpacing="1" CssClass="boxbg" Width="10in" > 

<asp:TableRow CssClass="bgwhite">
    <asp:TableCell>
        Matrix Type
    </asp:TableCell>
    <asp:TableCell>
        <asp:DropDownList ID="ddlmatrixtype" runat="server" CssClass="blackfnt">
            <asp:ListItem Value="CLR">All</asp:ListItem>
            <asp:ListItem Value="C">City - City</asp:ListItem>
            <asp:ListItem Value="L">Location - Location</asp:ListItem>
            <asp:ListItem Value="R">Region - Region</asp:ListItem>
        </asp:DropDownList>
    </asp:TableCell>
    
    <asp:TableCell>Trans Mode</asp:TableCell>
    <asp:TableCell>
        <asp:DropDownList ID="ddltransmode" DataTextField="codedesc" DataValueField="codeid" runat="server" CssClass="blackfnt"></asp:DropDownList>
    </asp:TableCell>
</asp:TableRow>
<asp:TableRow CssClass="bgwhite">
    <asp:TableCell>
        <asp:Label ID="lblbasedon1" runat="server" CssClass="blackfnt"></asp:Label>
    </asp:TableCell>
    <asp:TableCell><asp:DropDownList ID="ddlbasecode1" DataTextField="codedesc" DataValueField="codeid" AutoPostBack="true" OnSelectedIndexChanged="ddlbasecode1_SelectedIndexChanged" runat="server" CssClass="blackfnt"></asp:DropDownList>
    </asp:TableCell>
    <asp:TableCell><asp:Label ID="lblbasedon2" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
    <asp:TableCell>
    <asp:DropDownList ID="ddlbasecode2" DataTextField="codedesc" DataValueField="codeid" runat="server" CssClass="blackfnt"></asp:DropDownList>
    </asp:TableCell>
</asp:TableRow>
<asp:TableRow CssClass="bgwhite">
    <asp:TableCell>
       From
    </asp:TableCell>
    <asp:TableCell>
        <asp:TextBox ID="txtfrom" runat="server" CssClass="blackfnt" BorderStyle="Groove" onkeypress="javascript:return validAlfaNum(event);"></asp:TextBox>
    </asp:TableCell>
    <asp:TableCell>To</asp:TableCell>
    <asp:TableCell>
    <asp:TextBox ID="txtto" runat="server" CssClass="blackfnt" BorderStyle="Groove" onkeypress="javascript:return validAlfaNum(event);"></asp:TextBox>
    </asp:TableCell>
</asp:TableRow>
</asp:Table>
<asp:HiddenField ID="hdnbasedon1" runat="server" />
<asp:HiddenField ID="hdnbasedon2" runat="server" />