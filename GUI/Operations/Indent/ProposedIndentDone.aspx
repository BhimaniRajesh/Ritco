<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProposedIndentDone.aspx.cs" Inherits="GUI_Operations_Indent_ProposedEntryDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        function popupView() {
            var IndentNo = document.getElementById("ctl00_MyCPH1_lblIndentNo");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("ViewPrint/IndentView.aspx?print=N&IndentNo=" + IndentNo.innerText, "", winOpts);
            return false;
        }
        function popupPrint() {
            var IndentNo = document.getElementById("ctl00_MyCPH1_lblIndentNo");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("ViewPrint/IndentView.aspx?print=Y&IndentNo=" + IndentNo.innerText, "", winOpts);
            return false;
        }
        function popupView1() {
            var PrIndentNo = document.getElementById("ctl00_MyCPH1_lblProposedIndentNo");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("ViewPrint/ProposedIndentView.aspx?print=N&ProposedIndentNo=" + PrIndentNo.innerText, "", winOpts);
            return false;
        }
        function popupPrint1() {
            var PrIndentNo = document.getElementById("ctl00_MyCPH1_lblProposedIndentNo");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("ViewPrint/ProposedIndentView.aspx?print=Y&ProposedIndentNo=" + PrIndentNo.innerText, "", winOpts);
            return false;
        }
    </script>
    <b>Operation >> Booking > Indent</b>
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
            <asp:TableCell Font-Bold="true">
                Document Number
            </asp:TableCell>
            <asp:TableCell Font-Bold="true">
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite" ID="trindent" runat="server" Visible="false">
            <asp:TableCell Font-Bold="true">
                    Indent Entry </asp:TableCell>
            <asp:TableCell>
                <asp:Label ID="lblIndentNo" CssClass="bluefnt" Font-Bold="true" runat="server"></asp:Label>
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
                <asp:LinkButton ID="lnkBtnIndentView" OnClientClick="javascript:return popupView()"
                    CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" />|
                 <asp:LinkButton ID="lnkBtnIndentPrint" OnClientClick="javascript:return popupPrint()"
                     CssClass="bluefnt" runat="server" Font-Bold="false" Text="Print" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite" ID="trPindet" runat="server">
            <asp:TableCell Font-Bold="true">
                    Proposed Indent Entry </asp:TableCell>
            <asp:TableCell>
                <asp:Label ID="lblProposedIndentNo" CssClass="bluefnt" Font-Bold="true" runat="server"></asp:Label>
            </asp:TableCell>
            <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
                <asp:LinkButton ID="lnkBtnProposedIndentView" OnClientClick="javascript:return popupView1()"
                    CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" />|
                 <asp:LinkButton ID="lnkBtnProposedIndentPrint" OnClientClick="javascript:return popupPrint1()"
                     CssClass="bluefnt" runat="server" Font-Bold="false" Text="Print" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="3">
                    <b>Choose the following Option</b></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3">
                <asp:LinkButton ID="lnkBtnProposedIndentEntry" CssClass="bluefnt" runat="server" Font-Bold="false"
                    PostBackUrl="~/GUI/Operations/Indent/ProposedEntry.aspx?Type=P"> Click Here to Proposed Indent Entry</asp:LinkButton>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell ColumnSpan="3">
                <asp:LinkButton ID="lnkBtnIndentFinalization" CssClass="bluefnt" runat="server" Font-Bold="false"
                    PostBackUrl="~/GUI/Operations/Indent/ProposedEntry.aspx?Type=F"> Click Here to Indent Finalization</asp:LinkButton>
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
</asp:Content>

