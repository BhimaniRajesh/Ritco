<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CCMFilter.ascx.cs" Inherits="GUI_admin_CustomerContractMaster_CCMFilter" %>

<script type="text/javascript" src="../../../images/commonJs.js"></script>
<asp:Table ID="tblmain" runat="server" CellSpacing="1" CssClass="boxbg" Width="10in">
    <asp:TableRow ID="trone" runat="server" CssClass="bgwhite">
        <asp:TableCell>
            <asp:Label ID="lblmatrixtype" runat="server" CssClass="blackfnt">Matrix Type</asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <asp:DropDownList ID="ddlmatrixtype" runat="server" CssClass="blackfnt">
                <asp:ListItem Value="CLR">All</asp:ListItem>
                <asp:ListItem Value="C">City - City</asp:ListItem>
                <asp:ListItem Value="L">Location - Location</asp:ListItem>
                <asp:ListItem Value="R">Region - Region</asp:ListItem>
            </asp:DropDownList>
        </asp:TableCell>
        <asp:TableCell>
            <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt">Trans Mode</asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <asp:DropDownList ID="ddltransmode" DataTextField="codedesc" DataValueField="codeid"
                runat="server" CssClass="blackfnt">
            </asp:DropDownList>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow ID="trtwo" runat="server" CssClass="bgwhite">
        <asp:TableCell Width="25%">
            <asp:Label ID="lblbasedon1" runat="server" CssClass="blackfnt"></asp:Label>
        </asp:TableCell>
        <asp:TableCell Width="25%">
            <asp:DropDownList ID="ddlbasecode1" Width="200px" DataTextField="codedesc" DataValueField="codeid"
                AutoPostBack="true" OnSelectedIndexChanged="ddlbasecode1_SelectedIndexChanged"
                runat="server" CssClass="blackfnt">
            </asp:DropDownList>
        </asp:TableCell>
        <asp:TableCell Width="25%">
            <asp:Label ID="lblbasedon2" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
        <asp:TableCell Width="25%">
            <asp:DropDownList ID="ddlbasecode2" Width="200px" DataTextField="codedesc" DataValueField="codeid"
                runat="server" CssClass="blackfnt">
            </asp:DropDownList>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow ID="trthree" runat="server" CssClass="bgwhite">
        <asp:TableCell>
       <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt">From</asp:Label>
        </asp:TableCell>
        <asp:TableCell>
            <asp:TextBox ID="txtfrom" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                ></asp:TextBox>
        </asp:TableCell>
        <asp:TableCell> <asp:Label ID="lblto" runat="server" CssClass="blackfnt">To</asp:Label></asp:TableCell>
        <asp:TableCell>
            <asp:TextBox ID="txtto" runat="server" CssClass="blackfnt" BorderStyle="Groove" ></asp:TextBox>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<asp:HiddenField ID="hdnbasedon1" runat="server" />
<asp:HiddenField ID="hdnbasedon2" runat="server" />
