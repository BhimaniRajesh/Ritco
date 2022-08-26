<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Done.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillGeneration_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        function OpenInWindow(arg1) {
            window.open("../Billview.aspx?Voucherno=" + arg1, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }

    </script>
    <asp:Panel runat="server" Width="8in" ID="divmain">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 50%">
            <tr>
                <td height="30">
                    <font class="bluefnt">
                        <strong>CPKM Bill Payment Done</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
            </tr>

        </table>

        <asp:Table runat="server" ID="tblmain" Width="90%" CellSpacing="1"
            CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="6" Font-Bold="true">
                    <b>
                        <asp:Label ID="lblTitle" runat="server"></asp:Label></b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell>Vendor Name</asp:TableCell>
                <asp:TableCell>Fleet Center</asp:TableCell>
                <asp:TableCell>Voucher No.</asp:TableCell>
                <asp:TableCell>Voucher Date</asp:TableCell>
                <asp:TableCell>No. of Vehicle</asp:TableCell>
                <asp:TableCell>Voucher Amount</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblVendorName"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblMonth"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <a href="JavaScript: OpenInWindow('<%=Convert.ToString(Request.QueryString.Get("VoucherNo")) %>')">
                        <asp:Label runat="server" ID="lblBillNo"></asp:Label>

                    </a>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblBillDate"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblNoVehicle"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label runat="server" ID="lblBillAmount"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="6">
                   Choose the following Option</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" ColumnSpan="6">
                    <asp:LinkButton ID="lnkBtnAddVehicle" CssClass="bluefnt" runat="server" Font-Bold="false"
                        PostBackUrl="BillPaymentCriteria.aspx">Click Here to Payment More Bill</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

