<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PO_BillPaymentView.aspx.cs"
    Inherits="GUI_Finance_Fix_Asset_ViewPrint_PO_BillPaymentView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PO BillPayment View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string strDRSNo = Request.QueryString.Get("Voucherno");
               string[] Split = strDRSNo.Split(new Char[] { ',' });
               string DRSNo = Convert.ToString(Split[0]);
               string print_yn = Convert.ToString(Split[1]);
               string boxbg = "boxbg";
               string bgbluegrey = "bgbluegrey";
               string strborder = "0";
               string strspace = "1";
               if (print_yn == "1")
               {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "1";
                   strspace = "1";
               }

            %>
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr bgcolor="white">
                    <td colspan="4" valign="top">
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="Left">
                        <font class="blackfnt">Payment Voucherno</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt"><asp:Label ID="lblVoucherNo" runat="server" CssClass="blackfnt"></asp:Label></font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">Voucher Date </font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt"><asp:Label ID="lblVoucherDate" runat="server" CssClass="blackfnt"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="Left">
                        <font class="blackfnt">Vendor Name</font>
                    </td>
                    <td align="Left" colspan="3">
                        <font class="blackfnt">
                            <asp:Label ID="lblVendor" runat="server" Text=""></asp:Label></font>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td>
                        <label class="blackfnt">
                            Vendor Credit Accounts :</label></td>
                    <td style="width: 343" colspan="3">
                        <asp:Label ID="LblCr_Account" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="Left">
                        <font class="blackfnt">Vendor Service TaxNO.</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                            <asp:Label ID="V_Staxno" runat="server" Text=""></asp:Label></font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">Vendor PAN NO.</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                        <asp:HiddenField ID="hdnvendor" runat="server" />
                            <asp:Label ID="V_PANNO" runat="server" Text=""></asp:Label></font>
                    </td>
                </tr>
            </table>
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr bgcolor="white">
                    <td align="Left">
                        <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="100"
                            Width="6.7in" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="true"
                            HeaderStyle-Wrap="true" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found..." OnRowDataBound="GV_Booking_RowDataBound">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill No" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblBillno" Text='<%# DataBinder.Eval(Container.DataItem, "billno") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill Date" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="LBLBilldt" Text='<%# DataBinder.Eval(Container.DataItem, "billdt") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Paid Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "paidamt") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pending  Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblPendamt" Text='<%# DataBinder.Eval(Container.DataItem, "pendamt") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total  Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblTotal" Text='<%# DataBinder.Eval(Container.DataItem, "totalamt") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="Lbltotal" Font-Bold="true" runat="server" Text="Total Amount" CssClass="blackfnt"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Current  Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="false" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="TXTCurramt" Text='<%# DataBinder.Eval(Container.DataItem, "currentamt") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="Txt_Total_netamt" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle Wrap="true" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center">
                        <font class="blackfnt"><b>TDS Details</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="Left">
                        <font class="blackfnt">TDS Rate (%)</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                            <asp:Label ID="TxtTds_Rate" runat="server"></asp:Label>
                        </font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">TDS Amt</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                            <asp:Label ID="TxtTds_Amt" runat="server"></asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="Left">
                        <font class="blackfnt">Tds Type</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                            <asp:Label ID="lblTDSType" runat="server"></asp:Label></font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">TDS Deducted For</font>
                    </td>
                    <td align="Left">
                        <font class="blackfnt">
                            <asp:Label ID="lblTDSDeductedFor" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            <br />
             <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center">
                        <font class="blackfnt"><b>Payment Details</b></font>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <asp:Label ID="Label1" runat="server" Text="Payment Mode" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblPaymentMode" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label4" runat="server" Text="Amount Applicable" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblAmountApplicable" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <asp:Label ID="Label5" runat="server" Text="Cash Amount" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblCashAmount" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label7" runat="server" Text="Cash Account" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblCashAccount" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <asp:Label ID="Label9" runat="server" Text="Cheque Amount" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblChequeAmount" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label11" runat="server" Text="Bank Account" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblBankAccount" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left" style="height: 4px">
                        <asp:Label ID="Label13" runat="server" Text="Cheque No." CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right" style="height: 4px">
                        <asp:Label ID="lblChequeNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="left" style="height: 4px">
                        <asp:Label ID="Label15" runat="server" Text="Cheque Date" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right" style="height: 4px">
                        <asp:Label ID="lblChequeDate" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                    </td>
                    <td align="right">
                    </td>
                    <td align="right">
                        <asp:Label ID="Label19" runat="server" Text="Net Payable" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td align="right">
                        <asp:Label ID="lblNetPayable" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
            </table>
           
        </div>
        <%
            if (print_yn == "1")
            {
         
        %>

        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
        </script>

        <%} %>
    </form>
</body>
</html>
