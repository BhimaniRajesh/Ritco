<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewChallanPayment.aspx.cs"
    Inherits="GUI_Operations_Crossing_ViewChallanPayment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Crossing challan payment detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
            BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center">
            Crossing challan payment detail
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Company Name
                </asp:TableCell>
                <asp:TableCell Font-Bold="true" ColumnSpan="3">
                    <asp:Label ID="Label1" runat="server" Text="Rajdhani Interstate Transport Co. Regd."></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Address
                </asp:TableCell>
                <asp:TableCell Font-Bold="true" ColumnSpan="3">
                    <asp:Label ID="Label2" runat="server" Text="336,Udyog Vihar,Phase-2, Gurgaon, Haryana"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Voucher No
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblVoucherno" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
           Voucher Date
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblVoucherDt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true" ColumnSpan="4">
                    <asp:GridView ID="CrossingChallanDetail" runat="server" AutoGenerateColumns="False"
                        BorderWidth="0px" CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..."
                        FooterStyle-CssClass="boxbg" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                        PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left" Style="width: 9.0in"
                        ShowFooter="True">
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                        <Columns>
                            <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Sr. No" HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Crossing challan number" HeaderStyle-CssClass="blackfnt"
                                FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblCrossingno" Text='<%# DataBinder.Eval(Container.DataItem,"CrossingChallanNo") %>'
                                                runat="server"></asp:Label>
                                        </font>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Challan Date" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblChallanDate" Text='<%# DataBinder.Eval(Container.DataItem,"ChallanDate") %>'
                                                runat="server"></asp:Label>
                                        </font>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount payable" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                FooterStyle-CssClass="bgbluegrey">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblChallanDate" Text='<%# DataBinder.Eval(Container.DataItem,"AmountPayable") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                <FooterTemplate>
                                    <center>
                                        <asp:Label ID="lblChallanDate" Text='<%# DataBinder.Eval(Container.DataItem,"AmountPayable") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Deductions" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                FooterStyle-CssClass="bgbluegrey">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblDeductions" Text='<%# DataBinder.Eval(Container.DataItem,"Deduction") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                <FooterTemplate>
                                    <center>
                                        <asp:Label ID="lblFooDeductions" Text='<%# DataBinder.Eval(Container.DataItem,"Deduction") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true"
                                FooterStyle-CssClass="bgbluegrey">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblNetPayable" Text='<%# DataBinder.Eval(Container.DataItem,"NetPayable") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                <FooterTemplate>
                                    <center>
                                        <asp:Label ID="lblFooNetPayable" Text='<%# DataBinder.Eval(Container.DataItem,"NetPayable") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
           SUMMARY
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">
                       Payment details 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
           Total Amount payable (+)
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblTotalAmountPayables" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
           Mode of payment
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblModeofPayments" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
           Total deductions (-)
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblTotaldeductions" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
           Cheque Number
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblChqNo" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
           Net payable (-)
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblTotalNetPayables" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
           Date
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblDate" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
          
                </asp:TableCell>
                <asp:TableCell>
         
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblCash_Bank" runat="server" Text="Cash"></asp:Label>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:Label ID="lblCashAmt" runat="server" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    </form>
</body>
</html>
