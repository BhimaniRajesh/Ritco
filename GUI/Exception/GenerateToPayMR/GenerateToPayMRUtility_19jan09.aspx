<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GenerateToPayMRUtility.aspx.cs" Inherits="GUI_Operation_GenerateToPayMRUtility" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br /><br />
<asp:Panel runat="server" Width="10in">
<asp:Table runat="server" HorizontalAlign="Center"  Width="50%" CssClass="boxbg" CellSpacing="1">
    <asp:TableRow CssClass="bgbluegrey">
        <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                To Pay MR Generation
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow BackColor="white">
    <asp:TableCell HorizontalAlign="Left">Docket Number</asp:TableCell>
        <asp:TableCell HorizontalAlign="Left">
                <asp:TextBox ID="txtdockno" runat="server" BorderStyle="Groove"></asp:TextBox>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow CssClass="bgbluegrey">
        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
            <asp:Button ID="btnsubmit" Text="Submit" CssClass="blackfnt" OnClick="btnsubmit_Click" runat="server" />
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
</asp:Panel>
</asp:Content>

