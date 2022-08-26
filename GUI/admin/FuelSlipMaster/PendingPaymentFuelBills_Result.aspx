<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingPaymentFuelBills_Result.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_admin_FuelSlipMaster_PendingPaymentFuelBills_Result" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript">
        function nwOpen() {

            
            <%--var lblVoucherNo = $("#" + '<%=lblVoucherNo.ClientID%>').text();
            window.open("../../Finance/ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + lblVoucherNo + "&printyn=N", "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");--%>

            var lblVoucherNo = $("#" + '<%=lblVoucherNo.ClientID%>').text();
            window.open('./PendingFuelBillsApproval_Result_View.aspx?Billno=' + lblVoucherNo + '&PrintMode=0', '_blank'
             , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');
        }
        function ViewPrint(ctrl) {
            window.open('./PendingFuelBillsApproval_Result_View.aspx?Billno=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }
    </script>
    <table cellspacing="0" style="width: 40%" cellpadding="0" border="1" class="dgRowStyle">
        <tr style="background-color: white">
            <td align="left" style="height: 26px" colspan="4">
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Fuel Bill vendor Payment successfully made</asp:Label>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td>Voucher No.</td>
            <td>Voucher Date</td>
            <td colspan="2">Amount</td>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:Label ID="lblVoucherNo" runat="server"></asp:Label></td>
            <td>
                <asp:Label ID="lblVoucherDate" runat="server"></asp:Label></td>
            <td>
                <asp:Label ID="lblVoucherAmt" runat="server"></asp:Label></td>
            <td>
                <%--<asp:LinkButton ID="lnkView" runat="server" OnClick="nwOpen()">View</asp:LinkButton>
                <asp:LinkButton ID="lnkPrint" runat="server" OnClick="nwOpen()">Print</asp:LinkButton>--%>
                <a href="JavaScript:nwOpen()" style="text-decoration: underline">View</a>
                <a href="JavaScript:nwOpen()" style="text-decoration: underline">print</a>
            </td>
        </tr>
    </table>
</asp:Content>
