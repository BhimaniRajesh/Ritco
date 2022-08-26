<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewTHCBalance.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PrepareVoucher_Vendor_ViewTHCBalance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>THC Balance Payment View</title>
    <link href="../../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin-top: 0px; margin-left: 0px">
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
            <table border='<%=strborder %>' cellspacing="1" cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr bgcolor="white">
                    <td width="60%" valign="top">
                        <asp:image height="50" id="imgLogo" runat="server" />
                    </td>
                </tr>
            </table>
            <table border='<%=strborder %>' style="width: 6.7in" bgcolor="#808080" cellpadding="2"
                cellspacing="1" class='<%=boxbg%>'>
                <tr bgcolor="#FFFFFF">
                    <td align="center" colspan="2">
                        <font face="verdana" size="3"><b>Trip Hire Contract (THC)</b></font></td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' style="width: 6.7in" bgcolor="#808080" cellpadding="2"
                cellspacing="1" class='<%=boxbg%>'>
                <tr bgcolor="#FFFFFF">
                    <td align="left" style="width: 2in">
                        <font class="blackfnt">&nbsp;Voucher No</font></td>
                    <td align="center">
                        <font class="bluefnt">
                            <asp:label id="lblVoucherNo" runat="server"></asp:label>
                        </font>
                    </td>
                    <td align="left" style="width: 2in">
                        <font class="blackfnt">&nbsp;Voucher Date</font></td>
                    <td align="center">
                        <font class="bluefnt">
                            <asp:label id="lblVoucherDt" runat="server"></asp:label>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <asp:gridview id="dockdata" runat="server" borderwidth="1" cellpadding="2" headerstyle-cssclass='<%=bgbluegrey%>'
                allowsorting="true" allowpaging="true" pagesize="100" pagerstyle-horizontalalign="left"
                cssclass='<%=boxbg%>' backcolor="white" footerstyle-cssclass='<%=bgbluegrey%>'
                showfooter="True" pagersettings-mode="NumericFirstLast" autogeneratecolumns="false"
                pagersettings-firstpagetext="[First]" pagersettings-lastpagetext="[Last]" emptydatatext="No Records Found..."
                style="width: 6.7in">
                <Columns>
                    <%--<asp:TemplateField HeaderText="SRNo.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="DocumentNo" CssClass="blackfnt" Text="DocumentNo" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="thcno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblActualUnloadingDate" CssClass="blackfnt" Text="Un load Date"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="actualDt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"actarrv_dt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblUnloadingWeight" CssClass="blackfnt" Text="Un load Wt" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="UnloadingWeight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"UnloadActualWeight") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblcontractAmt" Style="text-align: center" CssClass="blackfnt" Text="Cont Amt (+)"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indpcamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"PCAMT") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="lblOtherAmt" Style="text-align: center" CssClass="blackfnt" Text="Oth Amt(+) "
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indothamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"OTHCHRG") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblAdvamt" CssClass="blackfnt" Text=" Adv Paid (-) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indadvamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ADVAMT") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblSvctaax" CssClass="blackfnt" Text="SvcTax Cess H.Cess (+) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indtSvctax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Svctax_cess") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblTDSdeduction" CssClass="blackfnt" Text="TDS Dedn.(-) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indtdsded" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"tdsded") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblNetbalamt" CssClass="blackfnt" Text="Bal. Amt." runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indbalamt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"netbalamt") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblIncentive" CssClass="blackfnt" Text="Incen tive (+) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="incentive" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"incentive") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblPenalty" CssClass="blackfnt" Text="Pen alty(-) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indpenalty" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"penalty") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblClaim" CssClass="blackfnt" Text="Claim(-) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indclaim" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Claim_chrg") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblHamali" CssClass="blackfnt" Text="Hamali" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indhamali" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"unload_chrg") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblDetention" CssClass="blackfnt" Text="Deten tion (+)" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="inddetention" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"deten_chrg") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lbldeduction" CssClass="blackfnt" Text="Dedu ctions (-) " runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indothded" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"oth_ded") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:Label ID="lblNetPayable" CssClass="blackfnt" Text="Net Pay able" runat="server"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <asp:Label ID="indnetpay" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"TOTALAMTPAID") %>'></asp:Label>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle />
                <PagerStyle HorizontalAlign="Center" CssClass='<%=bgbluegrey%>' />
                <HeaderStyle CssClass='<%=bgbluegrey%>' />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass='<%=bgbluegrey%>' />
            </asp:gridview>
        </div>
        <br />
        <div align="left">
            <table style="width: 6.7in" border='<%=strborder %>' cellspacing="1" cellpadding="3"
                bgcolor="#808080" class='<%=boxbg%>'>
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
                            <asp:label id="lblMode" runat="server"></asp:label>
                        </font>
                    </td>
                    <td>
                        <font class="blackfnt">Payment Account</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:label id="lblPaymentAcc" runat="server"></asp:label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Cheque No </font>
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:label id="lblChequeNo" runat="server"></asp:label>
                        </font>
                    </td>
                    <td>
                        <font class="blackfnt">Cheque Date</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:label id="lblChequeDt" runat="server"></asp:label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td>
                        <font class="blackfnt">Payment Amount</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:label id="lblPaymentAmt" runat="server"></asp:label>
                        </font>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" colspan="2">
                        <font class="blackfnt">Behati NO/Date/Amount</font></td>
                    <td align="left" colspan="2">
                        <font class="blackfnt"><font class="blackfnt">
                            <asp:label id="lblBehati" runat="server"></asp:label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" colspan="2">
                        <font class="blackfnt">Narration</font></td>
                    <td align="left" colspan="2">
                        <font class="blackfnt"><font class="blackfnt">
                            <asp:label id="lblNarration1" runat="server"></asp:label>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td colspan="4">
                        <font class="blackfnt"><b>Rs. (in words) :
                            <asp:label id="lblWords" runat="server"></asp:label>
                        </b></font>
                    </td>
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
