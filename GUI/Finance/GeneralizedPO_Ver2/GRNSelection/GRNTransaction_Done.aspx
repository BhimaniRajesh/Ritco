<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GRNTransaction_Done.aspx.cs" Inherits="GUI_Operations_Voucher_Cancellation_VoucherCancellation_done"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
    function PopupView(VoucherNo) {
        var strPopupURL = "";
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125";
        strPopupURL = "JournalVoucherView.aspx?voucherno=" + VoucherNo + "&printyn=N";
        winNew = window.open(strPopupURL, "_blank", strWinFeature);
    }
    function PopupPrint(VoucherNo) {
        var strPopupURL = "";
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125";
        strPopupURL = "JournalVoucherView.aspx?voucherno=" + VoucherNo + "&printyn=Y";
        winNew = window.open(strPopupURL, "_blank", strWinFeature);
    }
</script>

    <br />
    <br />
    <br />
    <div align="center" style="width: 4.5in;">
        <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1"
            class="boxbg" width="95%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="left" colspan="2">
                    <b>Following GRN Has Been Successfully Accounting Posting </b>
                </td>
            </tr>
            <tr bgcolor="white">
                <%--<td class="blackfnt" align="center">
                <b>Voucher Numbers</b>
            </td>--%>
                <td class="blackfnt" align="center" colspan="2">
                    <%--<strong><font color="red">
                        <asp:Label ID="lblvouchernos" runat="server"></asp:Label></font></strong>--%>
                    <asp:GridView ID="dgPODetails" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5"
                        HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AutoGenerateColumns="false"
                        CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5">
                        <Columns>
                            <asp:TemplateField HeaderText="GRN No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"GRNNO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Voucher No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblVoucherCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VoucherNO") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View/Print">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <a href="JavaScript:PopupView('<%#DataBinder.Eval(Container.DataItem,"VoucherNO") %>',0)">
                                        <font class="blackfnt">View</a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Print">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <a href="JavaScript:PopupView('<%#DataBinder.Eval(Container.DataItem,"VoucherNO") %>',0)">
                                        <font class="blackfnt">View</a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="center">
                    <b>Next Step</b>
                </td>
                <td class="blackfnt" align="center">
                    <a href="GRNSelectionCriteria.aspx">Click here to More GRN Accounting Posting</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
