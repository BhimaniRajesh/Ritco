<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BillEntry_Done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">

        //    function nwOpenViewWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }
        //    function nwOpenPrintWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }


        function ViewPrint(arg1, VoucherType) {
            var Voucherno = "";
            Voucherno_Arr = arg1.split("~");
            if (VoucherType == "BE") {
                Voucherno = Voucherno_Arr[0];
            }
            else if (VoucherType == "BillPayment") {
                Voucherno = Voucherno_Arr[1];
            }

            window.open("BalanceVoucher.aspx?Voucherno=" + Voucherno + "&VoucherType=" + VoucherType, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Voucher Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document has been successfully Generated:"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="lblDocType" runat="server" Text="Doucment Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocNo" runat="server" Text="Document NO" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="Lbl_GRN" runat="server" Text="Vendor Billno" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Lbl_GRN_Billno" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <font class="blackfnt"><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("Voucherno")%>','BE')">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("Voucherno")%>','BE')">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr style="background-color: White" id="PaymentVoucher_TR" runat="server">
                        <td align="center">
                            <asp:Label ID="Label1" runat="server" Text="Payment Voucherno" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Lbl_GRN_Voucherno" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <font class="blackfnt"><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("Voucherno")%>','BillPayment')">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("Voucherno")%>','BillPayment')">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr style="background-color: White" id="Acctopening" runat="server">
                        <td align="Left" colspan="3">
                            <font class="blackfnt"><a href="#" id="Href_Acct_Po" rel="Acct_Po"><b>Show Accounting
                                Treatment For BillEntry </b></a></font>
                            <div align="left" id="Acct_Po" style='position: absolute; visibility: hidden; border: 1px solid black;
                                background-color: AliceBlue; width: 600px; height: 200; padding: 1px;'>
                                <div>
                                    <%=ToolTip_Str%>
                                </div>
                            </div>

                            <script type="text/javascript">
                                // alert(Href_Acct_Po)
                                dropdowncontent.init("Href_Acct_Po", "right-middle", 500, "mouseover")
                                //alert(Href_Acct_Po)
                            </script>

                        </td>
                    </tr>
                    <tr style="background-color: White" id="Tr1" runat="server">
                        <td align="Left" colspan="3">
                            <font class="blackfnt"><a href="#" id="Href_Acct_Po1" rel="Acct_Po1"><b>Show Accounting
                                Treatment For Bill Entry Payment Voucher </b></a></font>
                            <div align="left" id="Acct_Po1" style='position: absolute; visibility: hidden; border: 1px solid black;
                                background-color: AliceBlue; width: 600px; height: 200; padding: 1px;'>
                                <div>
                                    <%=ToolTip_Str1%>
                                </div>
                            </div>

                            <script type="text/javascript">
                                // alert(Href_Acct_Po)
                                dropdowncontent.init("Href_Acct_Po1", "right-middle", 500, "mouseover")
                                //alert(Href_Acct_Po)
                            </script>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
