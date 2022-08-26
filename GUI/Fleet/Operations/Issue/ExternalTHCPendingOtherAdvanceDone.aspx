<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ExternalTHCPendingOtherAdvanceDone.aspx.cs" Inherits="Issue_ExternalTHCPendingOtherAdvanceDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript">

        function ViewPrint(tVSlipId, tPrintMode) {
            var strurl = "frmViewPrintVehicleIssueSlip.aspx?VSlipNo=" + tVSlipId + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
        }
        function ViewPrintPay(tVSlipId, tPrintMode) {
            //alert("advance");
            var strurl = "../../../../GUI/Finance/ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + tVSlipId + "&printyn=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,resizable=yes,scrollbars=yes,left=100,top=125");
        }

    </script>
    <table cellspacing="1" style="width: 100%">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Fleet </strong></font><font class="bluefnt">
                    <strong>&gt;</strong>
                    <strong>External THC Pending Other Advance  </strong></font><font class="bluefnt">
                        <strong>&gt;</strong>
                        <strong>Done</strong> </font>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table cellspacing="1" class="boxbg" align="left">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" CssClass="blackfnt" Font-Bold="true" runat="server">External THC Pending Other Advance Payment Done Sucessfully</asp:Label>
                        </td>

                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="Label4" runat="server" Text="External Other Advance Payment Voucher" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="LblVoucherNo" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <a href="javascript:ViewPrintPay('<%=Request.QueryString["VoucherNo"]%>','N')"><font class="blackfnt">View</font></a>
                            <asp:Label ID="Label6" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                            <a href="javascript:ViewPrintPay('<%=Request.QueryString["VoucherNo"]%>','Y')"><font class="blackfnt">Print</font></a>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
    </table>


</asp:Content>
