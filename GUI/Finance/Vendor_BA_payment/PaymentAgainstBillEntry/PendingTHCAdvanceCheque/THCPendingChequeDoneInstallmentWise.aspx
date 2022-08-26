<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCPendingChequeDoneInstallmentWise.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_THCPendingChequeDoneInstallmentWise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1, arg2) {
            window.open("../../../ViewPrint/Voucher Register/Print/JournalVoucherView.aspx?voucherno=" + arg1 + "&printyn=N, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    </script>
    <br />
    <div align="left">
        <table border="0" align="left" style="width: 9.5in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
            <tr class="bgbluegrey">
                <td width="100%" align="center" height="18" colspan="4">
                    <font class="blackfnt"></font><font class="bluefnt"><b>Pending THC Advance (Cheque)  Updated Successfully !!!.  
                       &nbsp;&nbsp;&nbsp; </b></font>
                    <asp:Label ID="lblTHCNo" runat="server" Text="Label"></asp:Label>
                    &nbsp;</td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td>
                    <table border="0" align="left" style="width: 9.5in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
                        <tr align="left" bgcolor="#FFFFFF">
                            <td align="right">
                                <asp:UpdatePanel ID="u1" UpdateMode="Always" runat="server">
                                    <ContentTemplate>
                                        <asp:DataGrid ID="DataGrid1" runat="server" PageSize="1000" AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left">
                                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                            <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                            <Columns>
                                                <asp:BoundColumn DataField="ColoumnName" HeaderText="Coloumn Name">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Width="2in" />
                                                </asp:BoundColumn>
                                                <asp:BoundColumn DataField="VoucherNo" HeaderText="Voucher No">
                                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                </asp:BoundColumn>
                                                <asp:HyperLinkColumn DataNavigateUrlField="VoucherNo" Target="_blank" DataNavigateUrlFormatString="../../../ViewPrint/Voucher Register/Print/JournalVoucherView.aspx?voucherno={0}&printyn=N" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemStyle CssClass="bluefnt" />
                                                    <HeaderStyle Width="50px" />
                                                </asp:HyperLinkColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
	    <tr bgcolor="#FFFFFF">
	     <td>
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Click here for more payment</asp:LinkButton>
	     </td>
            </tr>
        </table>
    </div>
</asp:Content>
