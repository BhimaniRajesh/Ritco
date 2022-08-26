<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CompayFilter.ascx.cs"
    Inherits="GUI_Common_UserControls_CompayFilter" %>
<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<asp:UpdatePanel ID="UP" runat="server">
    <ContentTemplate>
        <asp:Table ID="TBL_HRCHY" border="0" HorizontalAlign="left" runat="server" CellPadding="3"
            CellSpacing="1" Style="width: 4.5in;" CssClass="boxbg">
            <asp:TableRow style="background-color: white">
                <asp:TableCell>
                    <asp:DropDownList ID="ddlCompanyList" DataTextField="NAME" DataValueField="CODE"
                        runat="server" Width="200px" CssClass="blackfnt">
                    </asp:DropDownList>
                </asp:TableCell></asp:TableRow>
        </asp:Table>
    </ContentTemplate>
</asp:UpdatePanel>
