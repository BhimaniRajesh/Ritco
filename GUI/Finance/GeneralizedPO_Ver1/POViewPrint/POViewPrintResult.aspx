<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POViewPrintResult.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        function Popup(Path) {
            window.open(Path, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    
    </script>

    <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
        align="left">
        <tr class="nrow" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr class="hrow" align="center">
                        <td align="left" colspan="2">
                            <asp:Label ID="lblWelcome" runat="server" Text="General PO Details" CssClass="blackfnt"
                                Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Date Selection</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblDate" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>Vendor Code & Name</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblVendorCode" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="left">
                            <font class="blackfnt"><b>PO Code</b></font>
                        </td>
                        <td align="left">
                            <font class="blackfnt">
                                <asp:Label ID="lblPOCode" runat="server"></asp:Label></font>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="nrow" align="center">
            <td align="left" colspan="2">
                <table border="0" cellpadding="3" width="600" bgcolor="#ffffff" cellspacing="1" class="boxbg"
                    align="left">
                    <tr class="nrow" align="center">
                        <td align="left" colspan="2">
                            <asp:GridView ID="dgPODetails" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5"
                                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AutoGenerateColumns="false"
                                CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                                Width="600" >
                                <Columns>
                                    <asp:TemplateField HeaderText="PO Code">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pocode") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual PO">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblManPOCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Manual_PO_No") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPODate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"podate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Name">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="170" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblVendorName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"VENDORCD") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"TotalQty") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Balance Qty.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblBalanceQty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"BalanceQty") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Amt">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="70" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalAmt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"totalamt") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PO Status">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="150" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" Wrap="false" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblPOStatus" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"POSTATUS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="View">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=<%#DataBinder.Eval(Container.DataItem,"pocode") %>,0')">
                                                <font class="blackfnt">
                                                    View</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Print">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="50" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <a href="JavaScript:Popup('../ViewPrint/PO_GenerationView.aspx?PONumber=<%#DataBinder.Eval(Container.DataItem,"pocode") %>,1')">
                                                <font class="blackfnt">
                                                    Print</a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                <PagerStyle HorizontalAlign="Left" />
                                <HeaderStyle CssClass="dgHeaderStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
