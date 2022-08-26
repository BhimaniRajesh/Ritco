<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProposedIndentCancelDone.aspx.cs" Inherits="GUI_Exception_Indent_ProposedIndentCancelDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <b>Exception >> Operation > Indent Cancellation</b>
    <br />
    <br />
    <asp:Table runat="server" ID="tblmain" Width="60%" CellSpacing="1" CssClass="boxbg">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3" Font-Bold="true">
                <asp:Label ID="lblTitle" CssClass="blackfnt" runat="server" Font-Bold="true"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true">
                Document Name
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" ColumnSpan="2">
                Document Number
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell Font-Bold="true" >
                    Indent Cancelled </asp:TableCell>
            <asp:TableCell ColumnSpan="2">
                <asp:Label ID="lblIndentNo" CssClass="bluefnt" Font-Bold="true" runat="server"></asp:Label>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3">
                    <b>Choose the following Option</b></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3">
                <asp:LinkButton ID="lnkBtnProposedIndentEntry" CssClass="bluefnt" runat="server" Font-Bold="false"
                    PostBackUrl="~/GUI/Operations/Indent/ProposedIndentCancel.aspx"> Click Here to Cancel Indent Entry</asp:LinkButton>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</asp:Content>

