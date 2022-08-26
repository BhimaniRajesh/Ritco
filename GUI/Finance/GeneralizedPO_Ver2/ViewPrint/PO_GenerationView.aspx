<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PO_GenerationView.aspx.cs"
    Inherits="GUI_Finance_Fix_Asset_ViewPrint_PO_GenerationView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PO Generation View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string strDRSNo = Request.QueryString.Get("PONumber");
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
                <tr style="background-color: #ffffff">
                    <td nowrap>
                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                      PO General Information
                        </asp:Label>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td>
                        <label class="blackfnt">
                            P.O. ID :
                        </label>
                    </td>
                    <td>
                        <asp:Label ID="lblPONumber" runat="server" CssClass="blackfnt"></asp:Label></td>
                    <td>
                        <label class="blackfnt">
                            P.O. Date :</label></td>
                    <td>
                        <asp:Label ID="lblPoDate" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td>
                        <label class="blackfnt">
                            Vendor Code :</label>
                    </td>
                    <td class="blackfnt">
                        <asp:Label ID="lblVendorCode" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            Credit Days :</label>
                    </td>
                    <td class="blackfnt">
                        <asp:Label ID="lblCreditDays" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>                    
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td nowrap>
                        <label class="blackfnt">
                            Kind Attn. :</label></td>
                    <td>
                        <asp:Label ID="lblKindAttn" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <td nowrap>
                        <label class="blackfnt">
                            Manual PO Number</label></td>
                    <td>
                        <asp:Label ID="lblManPo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap>
                        <label class="blackfnt">
                            PO Type :</label></td>
                    <td colspan="3">
                        <asp:Label ID="LblPOType" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td>
                        <label class="blackfnt">
                            GRN Code :</label>
                    </td>
                    <td class="blackfnt" colspan="3">
                        <asp:Label ID="lblGRNNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                    <%-- <td>
                        <label class="blackfnt">
                            Fabric Sheet PO :</label>
                    </td>
                    <td>
                        <asp:Label ID="LblFabSheetPo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>--%>
                </tr>
                <tr bgcolor="white">
                    <td>
                        <label class="blackfnt">
                            Vendor Bill No :</label>
                    </td>
                    <td class="blackfnt" colspan="3">
                        <asp:Label ID="LblVenBlNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr class='<%=bgbluegrey %>'>
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">
                                      Assets Details
                        </asp:Label>
                    </td>
                </tr>
                <tr class='<%=bgbluegrey %>'>
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass='<%=bgbluegrey %>'
                            HeaderStyle-Font-Bold="true" FooterStyle-CssClass="balckfnt" PagerStyle-HorizontalAlign="left"
                            ShowFooter="True" Width="6.7in" BackColor="white" CssClass='<%=boxbg %>' OnRowDataBound="GV_D_rowdatabound"
                            AutoGenerateColumns="False" SelectedIndex="1" >
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" Width="10" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Asset Code " HeaderStyle-Width="150">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblAssetCode" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"assetcd")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"narration")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblQty" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"qty")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Qty.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceivedQty" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"ReceivedQty")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Balance Qty.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblbalanceqty" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"balanceqty")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Unit Type">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblUnit" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"UnitType")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate ">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRate" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"rate")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle CssClass="blackfnt" />
                                    <FooterTemplate>
                                        <asp:Label ID="fooRate" Text="Total :" Font-Bold="true" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="% Of Discount">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiscount" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"Discount_Per")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle CssClass="blackfnt" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount Amount">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiscountAmt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"DiscountAmt")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle CssClass="blackfnt" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="% Of Tax ">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblofTax" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"tax_per")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax Amount ">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblofTaxAmt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"TaxAmt")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount ">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalAmount" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"total")) %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="fooTotalAmount" runat="server">
                                        </asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="4" align="center" style="height: 21px">
                        &nbsp;</td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="Right" colspan="3">
                        <asp:Label ID="llll" Text="Advance Amount :" CssClass="blackfnt" Font-Bold="true"
                            runat="server"></asp:Label>
                    </td>
                    <td align="Right" style="height: 21px">
                        <asp:Label ID="lblAdvanceAmt" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td colspan="3" style="width: 90%" align="Right">
                        <asp:Label ID="Label3" Text="Balance Amt. : " CssClass="blackfnt" Font-Bold="true"
                            runat="server"></asp:Label>
                    </td>
                    <td align="Right" style="height: 21px">
                        <asp:Label ID="lblBalAmt" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td nowrap>
                        <label class="blackfnt">
                            Term & condition :
                        </label>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="lblTermsCondition" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #ffffff">
                    <td nowrap>
                        <label class="blackfnt">
                        </label>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <%--<tr style="background-color: #FFFFFF">
                    <td colspan="4" align="center" style="height: 21px">
                        <table border='<%=strborder %>' cellspacing="1" cellpadding="4" width="100%" align="left"
                            class="boxbg">
                            <tr class='<%=bgbluegrey %>'>
                                <td colspan="4" align="center">
                                    <font class="blackfnt"><b>Payment Details</font>
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
                                <td align="left">
                                    <asp:Label ID="Label13" runat="server" Text="Cheque No." CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblChequeNo" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label15" runat="server" Text="Cheque Date" CssClass="blackfnt"></asp:Label>
                                </td>
                                <td align="right">
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
                    </td>
                </tr>--%>
                <tr bgcolor="#FFFFFF">
                    <td colspan="4">
                        <div align="Right">
                            <font class="blackfnt" size="2"><b>For <asp:Label ID="LblCompany" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label> </b></font></div>
                        <br />
                        <br />
                        <div align="Right">
                            <font class="blackfnt">Authorized Signature</font></div>
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
