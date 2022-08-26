<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewRunsheetAdvance.aspx.cs"
    Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_RunSheet_ViewRunsheetAdvance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>RunSheet Advance Payment</title>
    <link href="../../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string strGenerateBillNo = Request.QueryString.Get("advvoucher");
               string[] Split = strGenerateBillNo.Split(new Char[] { ',' });
               string GenerateBillNo = Convert.ToString(Split[0]);
               string print_yn = Convert.ToString(Split[1]);
               string boxbg = "boxbg";
               string bgbluegrey = "bgbluegrey";
               string strborder = "border='0'";
               if (print_yn == "1")
               {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "border='1'";
               }

            %>
            <br />
            <table border='<%=strborder %>' cellspacing="1" cellpadding="0" class='<%=boxbg %>'
                style="width:6.7in">
                <tr bgcolor="white">
                    <td width="60%" valign="top">
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                    </tr>
                    </table>
            <table border='<%=strborder %>' style="width:6.7in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                class='<%=boxbg%>'>
                <tr bgcolor="#FFFFFF">
                    <td align="center" colspan="2">
                        <font face="verdana" size="3"><b>RunSheet</b></font></td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' style="width:6.7in" bgcolor="#808080" cellpadding="2" cellspacing="1"
                class='<%=boxbg%>'>
                <tr bgcolor="#FFFFFF">
                    <td align="right" style="width: 2in">
                        <font class="blackfnt">&nbsp;Voucher No</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblVoucherNo" runat="server"></asp:Label>
                        </font>
                    </td>
                    <td align="right" style="width: 2in">
                        <font class="blackfnt">&nbsp;Voucher Date</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblVoucherDt" runat="server"></asp:Label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="right" style="width: 2in">
                        <font class="blackfnt">Manual Voucher No</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblManualVoucherNo" runat="server"></asp:Label>
                        </font>
                    </td>
                    <td align="right" style="width: 2in">
                        <font class="blackfnt">PAN No</font></td>
                    <td align="left">
                        <font class="bluefnt">
                            <asp:Label ID="lblPANNo" runat="server"></asp:Label>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="dockdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass='<%=bgbluegrey%>'
                AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass='<%=boxbg%>' BackColor="white" FooterStyle-CssClass='<%=bgbluegrey%>'
                ShowFooter="false" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                style="width:6.7in">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <center>
                                <asp:Label ID="TotalNetamt" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                            </center>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"pdcno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Contract Amount (+)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indpcamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"pdc_amt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--<asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Other Amount(+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indothamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"mis_chg") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSRate" Style="text-align: center" CssClass="blackfnt" Text="TDS Rate"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indtds_rate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"tdsrate") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSdeduction" Style="text-align: center" CssClass="blackfnt" Text="TDS Dedn.(-)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indtdsded" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"tdsamt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblAdvamt" Style="text-align: center" CssClass="blackfnt" Text=" Advance Amt. (-) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indadvamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"advamt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                        <%-- <FooterTemplate >
                 <center>
                 <asp:Label ID="TotalAdvanceAmt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"advamt") %>'></asp:Label>  
                     </center>                                                          
                 </FooterTemplate>--%>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblNetPayable" Style="text-align: center" CssClass="blackfnt" Text="Net Balance Amt."
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indnetpay" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"balamt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                        <%--<FooterTemplate >
                 <center>
                 <asp:Label ID="TotalNetamtvalue" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"balamt") %>'></asp:Label>  
                     </center>                                                          
                 </FooterTemplate>--%>
                    </asp:TemplateField>
                </Columns>
                <RowStyle />
                <PagerStyle HorizontalAlign="Center" CssClass='<%=bgbluegrey%>' />
                <HeaderStyle CssClass='<%=bgbluegrey%>' />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass='<%=bgbluegrey%>' />
            </asp:GridView>
        </div>
        <br />
        <div align="left">
            <table style="width:6.7in" border='<%=strborder %>' cellspacing="1" cellpadding="3" bgcolor="#808080"
                class='<%=boxbg%>'>
                <tr class='<%=bgbluegrey%>'>
                    <td colspan="4" align="center">
                        <font class="blackfnt">Payment Details</td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Mode Of Transaction </font>
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="lblMode" runat="server"></asp:Label></font>
                    </td>
                    <td>
                        <font class="blackfnt">Payment Account</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="lblPaymentAcc" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Cheque No </font>
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="lblChequeNo" runat="server"></asp:Label></font>
                    </td>
                    <td>
                        <font class="blackfnt">Cheque Date</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="lblChequeDt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td>
                        <font class="blackfnt">Payment Amount</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="lblPaymentAmt" runat="server"></asp:Label></font>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td colspan="4">
                        <font class="blackfnt"><b>Rs. (in words) : </b>
                            <asp:Label ID="lblWords" runat="server"></asp:Label></font></td>
                </tr>
            </table>
            <br />
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
        </div>
    </form>
</body>
</html>
