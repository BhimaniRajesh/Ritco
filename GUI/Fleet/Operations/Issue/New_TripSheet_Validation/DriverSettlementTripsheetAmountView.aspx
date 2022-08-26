<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DriverSettlementTripsheetAmountView.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_DriverSettlementTripsheetAmountView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table cellspacing="1" style="width: 150%">
                <tr class="bgwhite">
                    <td>
                        <asp:GridView ID="gvDriverSettlementAmount" runat="server" CellSpacing="1" CellPadding="3" AutoGenerateColumns="False"
                            SelectedIndex="1"
                            HeaderStyle-CssClass="bgbluegrey" CssClass="dgRowStyle" AllowPaging="false" PagerStyle-CssClass="pager" ShowFooter="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Driver Name & code">
                                    <HeaderStyle HorizontalAlign="Center" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblDriverName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="100px" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Paid Amount">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblAmtPaidToDriver" Width="50px" Style="text-align: right"
                                            runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AmtPaidToDriver") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="50px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Received Amount">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblReceivedAmount" Text='<%# DataBinder.Eval(Container.DataItem,"AmtRecvdFromDriver") %>'
                                            runat="server" Width="100px" MaxLength="500"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Voucher Number">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblVoucherNo" Text='<%# DataBinder.Eval(Container.DataItem,"VoucherNo") %>'
                                            runat="server"  MaxLength="600"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Voucher Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblVoucherDate" Text='<%# DataBinder.Eval(Container.DataItem,"VoucherDate") %>'
                                            runat="server" Width="100px" MaxLength="500"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                            </Columns>                            
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>


