<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SuccessMsg.aspx.cs" Inherits="GUI_admin_PasswordPolicy_SuccessMsg"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <asp:Table ID="Table1" runat="server" HorizontalAlign="left" CellSpacing="1" BorderWidth="0"
            Width="100%" BorderStyle="Groove">
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="left" Font-Bold="true" CssClass="blackfnt" ColumnSpan="10"
                    Style="height: 20px;">
                    <font class="blackfnt"><b>Godown to Godown Transfer </b></font>
                    <hr align="center" size="1" color="#8ba0e5">
                    <br />
                    <br />
                   <%--<font class="blackfnt"><b>SUCCESS ! </b></font>--%>
                    <br />
                    <font class="blackfnt" style="font-weight:bold">Godown is updated for selected docket successfully.</font>                    
                    <br />                                      
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
