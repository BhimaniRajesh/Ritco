<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PO_BillEntryView.aspx.cs"
    Inherits="GUI_Finance_Fix_Asset_ViewPrint_PO_BillEntryView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PO Bill Entry View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string strDRSNo = Request.QueryString.Get("Billno");
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
                style="width: 7.0in">
                <tr bgcolor="white">
                    <td valign="top">
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="center">

                        <font class="blackfnt"><b>Purchase Order Bill Entry Details</b></font>
                    </td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 7.0in">

                <tr bgcolor="white">
                    <td>

                        <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                            style="width: 7.0in">
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Bill Number</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblPaymentVoucherno" runat="server"></asp:Label></font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Bill Entry Date </font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblBillEntryDate" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Vendor Name</font>
                                </td>
                                <td align="Left" colspan="3">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendor" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr style="background-color: #FFFFFF">
                                <td style="width: 205">
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
                                        <asp:Label ID="V_Staxno" runat="server"></asp:Label></font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Vendor PAN NO.</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="V_PANNO" runat="server"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Vendor Billno</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendorBillno" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Vendor Bill Date</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblVendorBillDt" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Due Days</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblDueDays" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">Due Date</font>
                                </td>
                                <td align="Left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblDueDate" runat="server" CssClass="blackfnt"></asp:Label></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="left">
                                    <font class="blackfnt">Net Amount</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblNetAmt" runat="server" CssClass="blackfnt"></asp:Label></font>
                                    <asp:HiddenField ID="hdnNetAmt" runat="server" />
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Pending Amount</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblPendAmt" runat="server" CssClass="blackfnt"></asp:Label></font>
                                    <asp:HiddenField ID="hdnPendAmt" runat="server" />
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="Left">
                                    <font class="blackfnt">Remarks</font>
                                </td>
                                <td align="Left" colspan="3">
                                    <font class="blackfnt">
                                        <asp:Label ID="lblRemarks" runat="server" CssClass="blackfnt"></asp:Label></font>
                                    <asp:HiddenField ID="hdnvendor" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                            BackColor="white" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="100"
                            Width="7.0in" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="true"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnRowDataBound="GV_Booking_RowDataBound">
                            <PagerStyle VerticalAlign="Bottom" Wrap="false" />
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" Wrap="false" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PO Code">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="false" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblPOCODE" Text='<%# DataBinder.Eval(Container.DataItem, "DOCNO") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="PO Date" ItemStyle-Wrap="false">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LBLPODT" Text='<%# DataBinder.Eval(Container.DataItem, "podt") %>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Adv. VoucherNo" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="LBLVoucherno" Text='<%# DataBinder.Eval(Container.DataItem, "Adv_voucherno") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Adv. VoucherDate" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="LBLVoucherno1" Text='<%# DataBinder.Eval(Container.DataItem, "Adv_voucherDT") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Center" />
                                    <FooterTemplate>
                                        <asp:Label ID="Total" runat="server" Text="Total" Font-Bold="true"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Advance Paid Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "ADVPAID") %>'
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="Txt_Total_AdvAmt" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <%--<asp:TemplateField HeaderText="Pending  Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="LblPendamt" Text='<%# DataBinder.Eval(Container.DataItem, "pendamt") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="Txt_Total_Pendamt" runat="server"></asp:Label>

                                    </FooterTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Bill  Amount" ItemStyle-Wrap="false">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" Wrap="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="TXTCurramt" Text='<%# DataBinder.Eval(Container.DataItem, "netpay") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle HorizontalAlign="Right" />
                                    <FooterTemplate>
                                        <asp:Label ID="Txt_Total_netamt" runat="server"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle Wrap="false" />
                        </asp:GridView>
                    </td>
                </tr>


                <%
                    if (print_yn == "1")
                    {
         
                %>

                <script language="javascript" type="text/javascript">

                    function loadme() {
                        window.print();
                    }
                    window.load = loadme()
                </script>

                <%} %>
            </table>
        </div>
    </form>
</body>
</html>
