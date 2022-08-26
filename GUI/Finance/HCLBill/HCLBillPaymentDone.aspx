<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillPaymentDone.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillPaymentDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 400px" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="10" align="center">
                <asp:Label ID="Label1" runat="server" Text="payment Done Successfully" Font-Bold="True" Font-Size="Medium" ForeColor="#006600"></asp:Label>
            </td>
        </tr>
        <tr class="nrow">
            <td>Voucher No :
                <asp:Label ID="lblVoucherNo" runat="server"></asp:Label>
            </td>
            <td>Voucher Date :
                <asp:Label ID="lblVoucherDate" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="nrow">
            <td colspan="2">
                <asp:GridView ID="gv1" runat="server" align="center" BorderWidth="1" CellPadding="2"
                    HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    BackColor="white" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="100"
                    Width="6.7in" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="true"
                    HeaderStyle-Wrap="true" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />

                    <Columns>
                        <asp:BoundField DataField="BillNo"
                            ReadOnly="true"
                            HeaderText="Bill No" />
                        <asp:BoundField DataField="BillDate"
                            ReadOnly="true"
                            HeaderText="Bill Date" />
                        <asp:BoundField DataField="totweight"
                            ReadOnly="true"
                            HeaderText="Total Actual Wgt" />
                        <asp:BoundField DataField="TotPkgs"
                            ReadOnly="true"
                            HeaderText="Total PKG" />
                        <asp:BoundField DataField="Paidamount"
                            ReadOnly="true"
                            HeaderText="Paid Amount" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>

