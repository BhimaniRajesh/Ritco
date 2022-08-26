<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RemoldBillPayment_Msg.aspx.cs" Inherits="GUI_Fleet_Tyre_OldTyres_RemoldBillPayment_Msg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1, arg2, DT, MODE, chqNo, chqDt, amt, PayACC) {
            window.open("./VendorBillVeiw1.aspx?strGenerateBillNo=" + arg1 + "," + arg2 + "," + DT + "," + MODE + "," + chqNo + "," + chqDt + "," + amt + "," + PayACC, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Module</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
    <table width="700px" cellpadding="0" cellspacing="0" border="1" class="boxbg">
        <%--        <tr class="bgbluegrey">
            <td colspan="3" align="center">
                <asp:Label ID="lblTitle" runat="server" CssClass="blackboldfnt" Text="Following Document has been updated successfully:"></asp:Label>
            </td>
        </tr>
                <tr class="bgwhite">
            <td align="left">
                <asp:Label ID="Label1" runat="server" Text="System Generated Voucher No. :      "
                    Font-Bold="true"></asp:Label>
                <asp:Label ID="lblVoucherno" runat="server" CssClass="blackboldfnt" Text=""></asp:Label>
            </td>
        </tr>--%>
        <tr>
            <td>
                <table border="0" align="left" width="100%" cellspacing="1" bgcolor="#000000"
                    cellpadding="4" class="boxbg">
                    <tr class="bgbluegrey">
                        <td width="100%" align="center" colspan="3">
                            <font class="blackfnt"><font class="bluefnt"><b>Following document has been successfully
                                generated </b>&nbsp;</font>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" bgcolor="#FFFFFF"  width="25%" nowrap>
                            <font class="blackfnt">Document name</font>
                        </td>
                        <td align="center" bgcolor="#FFFFFF"  nowrap>
                            <font class="blackfnt">Document Number</font>
                        </td>
                        <td align="center" bgcolor="#FFFFFF" colspan="1">
                            <font class="blackfnt">&nbsp;</font>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" bgcolor="#FFFFFF">
                            <font class="blackfnt">Payment Voucher</font>
                        </td>
                        <td align="center" bgcolor="#FFFFFF" >
                            <font class="blackfnt">
                                <asp:Label ID="lblVoucherno" runat="server" Text=""></asp:Label></font>
                        </td>
                        <td align="right" bgcolor="#FFFFFF">
                            <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',0,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>')">
                                <font class="blklnkund">View</font></a> |<a href="Javascript:ViewPrint('<%=Request.QueryString.Get("VoucherNo")%>',1,'<%=Request.QueryString.Get("VoucherDT")%>','<%=Request.QueryString.Get("MODE")%>','<%=Request.QueryString.Get("chequeNo")%>','<%=Request.QueryString.Get("chequeDT")%>','<%=Request.QueryString.Get("Amount")%>')">
                                    <font class="blklnkund">Print</font></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:LinkButton ID="lnkClaim" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Click here for old tyre stock" Style="text-align: center" OnClick="lnkClaim_Click" />
            </td>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:LinkButton ID="lnkUpdateClaim" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Click here for update Claim Tyre" Style="text-align: center" OnClick="lnkUpdateClaim_Click" />
            </td>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:LinkButton ID="lnkUpdateRemold" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Click here for update Remold Tyre" Style="text-align: center" OnClick="lnkUpdateRemold_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
