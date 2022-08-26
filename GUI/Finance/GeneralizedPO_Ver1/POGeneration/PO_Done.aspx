<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PO_Done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
        //    function nwOpenViewWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }
        //    function nwOpenPrintWindow(url) {
        //        window.open(url,'myWindow','height=300,width=950,resizable=yes,scrollbars=yes,left=25,top=100');
        //    }

        function ViewPrint(arg1, arg2) {
            window.open("../ViewPrint/PO_GenerationView.aspx?PONumber=" + arg1 + "," + arg2, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        //function ViewPrintVoucher(arg1, arg2) {
        //    window.open("../ViewPrint/PO_Generation_VoucherView.aspx?VoucherNumber=" + arg1 + "," + arg2, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        //}
		function ViewPrintVoucher(arg1, arg2) {
            window.open("../../ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + arg1 + "&printyn=" + arg2, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
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
                        <td align="left">
                            <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocNo" runat="server" Text="Code" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left">
                            <asp:Label ID="Label1" runat="server" Text="General Purchase Order" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Lbl_POCODE" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <%--<a href="./Purchase_Order.aspx"><font class="blackfnt"> View</font> </a> <font class="blackfnt"> /</font> <a href="~/GUI/Finance/Fix_Asset/PO_Generation/Purchase_Order.aspx"><font class="blackfnt">Print</font> </a>--%>
                            <font class="blackfnt"><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("PONO")%>',0)">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("PONO")%>',1)">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr style="background-color: White" id="advvr" runat="server">
                        <td align="left">
                            <asp:Label ID="Label2" runat="server" Text="Advance Voucherno" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Lbl_voucherno" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <%--<a href="./Purchase_Order.aspx"><font class="blackfnt"> View</font> </a> <font class="blackfnt"> /</font> <a href="~/GUI/Finance/Fix_Asset/PO_Generation/Purchase_Order.aspx"><font class="blackfnt">Print</font> </a>--%>
                            <font class="blackfnt"><font class="blklnkund"><a href="Javascript:ViewPrintVoucher('<%=Request.QueryString.Get("VoucherNo")%>',0)">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrintVoucher('<%=Request.QueryString.Get("VoucherNo")%>',1)">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr style="background-color: White" id="Acctopening" runat="server">
                        <td align="left" colspan="3">
                            <font class="blackfnt"><a href="#" id="Href_Acct_Po" rel="Acct_Po"><b>Show Accounting
                                Treatment For Document </b></a></font>
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
                    <tr class="bgbluegrey">
                        <td align="left" colspan="3">
                            <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" colspan="3" style="height: 21px">
                            <a href="GeneralizePO.aspx"><font class="blackfnt">Prepare New General Purchase Order</font>
                            </a>
                            <%--  &nbsp;<asp:LinkButton ID="lnkStep2" runat="server" Text="Prepare Debit Voucher (With New Date)" CssClass="blackfnt" PostBackUrl="DebitVoucher.aspx?Defaultdate='today'" />--%>
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
