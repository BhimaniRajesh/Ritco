<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelCardProcessDone.aspx.cs" Inherits="GUI_admin_FuelCardProcess_FuelCardProcessDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript"></script>
    <script type="text/javascript" >

        function ViewPrintPay(tVSlipId, tPrintMode) {
            //alert("advance");
            var strurl = "./../../../GUI/Finance/ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + tVSlipId + "&printyn=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,resizable=yes,scrollbars=yes,left=100,top=125");
        }

    </script>
    <div style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Fuel Card Process </u></b></a>&gt; <b><u>Fuel Card Process Done</u></b></font>
                    <td>
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>Fuel card process data are inserted.!</b></font>
                </td>
            </tr>
            <tr style="background-color: White">
                <td align="center">
                    <asp:GridView ID="grdVoucher" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                        CssClass="dgRowStyle" Width="100%" PagerStyle-CssClass="pager" AllowSorting="true" AllowPaging="true"
                        PageSize="25" AutoGenerateColumns="false"
                        EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField ItemStyle-BackColor="white" HeaderText="VoucherNo">
                                <ItemTemplate>
                                    <asp:Label ID="LblVoucherNo" Text='<%# DataBinder.Eval(Container.DataItem,"VoucherNo") %>' runat="server" CssClass="blackfnt"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-BackColor="white"  HeaderText="">
                                <ItemTemplate>
                                    <a href="javascript:ViewPrintPay('<%# DataBinder.Eval(Container.DataItem,"VoucherNo") %>','N')"><font class="blackfnt">View</font></a>
                                    <asp:Label ID="Label6" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                                    <a href="javascript:ViewPrintPay('<%# DataBinder.Eval(Container.DataItem,"VoucherNo") %>','Y')"><font class="blackfnt">Print</font></a>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" Position="TopAndBottom" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <%--<tr style="background-color: White">
                <td align="center">
                    <asp:Label ID="Label4" runat="server" Text="Fuel Card Voucher" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="center">
                    <asp:Label ID="LblVoucherNo" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="center">
                    <a href="javascript:ViewPrintPay('<%=Request.QueryString["VoucherNo"]%>','N')"><font class="blackfnt">View</font></a>
                    <asp:Label ID="Label6" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                    <a href="javascript:ViewPrintPay('<%=Request.QueryString["VoucherNo"]%>','Y')"><font class="blackfnt">Print</font></a>
                </td>
            </tr>--%>
        </table>
    </div>
</asp:Content>

