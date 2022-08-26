<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DDMRPrint_RITCO.aspx.cs"
    Inherits="GUI_Operations_GatePass_ViewPrint_GatePassPrint_RITCO" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gate Pass</title>

    <script type="text/javascript" language="javascript">
       
    </script>

    <style type="text/css">
        .print_sml
        {
            font-family: Lucida Console;
            font-size: 13;
            horizontal-align: left;
        }
        .print_smlr
        {
            font-family: Lucida Console;
            font-size: 12;
            horizontal-align: left;
        }
    </style>
</head>
<body onload="window.print()" style="margin: 10px 0px 0px 0px;" class="print_sml">
    <form id="form1" runat="server">
    <table>
        <asp:Repeater ID="repgatepass" runat="server" OnItemDataBound="repgatepass_ItemDataBound">
            <ItemTemplate>
                <tr style="page-break-after: always;">
                    <td>
                        <asp:Table ID="tblmain" runat="server" Width="7in" HorizontalAlign="Left" CssClass="print_sml"
                            CellSpacing="0" CellPadding="0">
                            <asp:TableRow>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="lbldeladdr" Text="Customer Name: " runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="Label1" Text='<%#DataBinder.Eval(Container.DataItem,"deladdr") %>'
                                        runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="Label3" Text="DDMR No" runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="Label4" Text='<%#DataBinder.Eval(Container.DataItem,"deladdr") %>'
                                        runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="Label5" Text="Date :" runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="font-weight: bold;">
                                    <asp:Label ID="Label6" Text='<%#DataBinder.Eval(Container.DataItem,"deladdr") %>'
                                        runat="server" CssClass="print_sml">
                                    </asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell>
                                    <asp:GridView ID="GV_DDMRList" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                                        CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                        CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                                        Width="100%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                        <PagerStyle VerticalAlign="Bottom" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="30px" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DDMR Sheet No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="150px" HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LblMRSNO" Text='<%# DataBinder.Eval(Container.DataItem, "DDMRNo") %>'
                                                        runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Dockets Given" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="100px" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LblDOCKNO" Text='<%# DataBinder.Eval(Container.DataItem, "DocketCNT") %>'
                                                        runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PKT GIVEN" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LblPktGiven" Text='<%# DataBinder.Eval(Container.DataItem, "PktGiven") %>'
                                                        runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PKT DELIVERED" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LblDeliveredPkt" Text='<%# DataBinder.Eval(Container.DataItem, "DeliveredPkt") %>'
                                                        runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="PENDING PKT" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" Width="100" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="LblPendPkt" Text='<%# DataBinder.Eval(Container.DataItem, "PendPkt") %>'
                                                        runat="server"> </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Print">
                                                <ItemStyle HorizontalAlign="Center" BackColor="White" Wrap="false" />
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Wrap="false" />
                                                <ItemTemplate>
                                                    <%--<a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container, "DataItem.Adviceno") %>','N')" style="text-decoration:underline">View</a>
                                    | --%>
                                                    <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container, "DataItem.DDMRNo") %>','Y')"
                                                        style="text-decoration: underline">Print</a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    </form>
</body>
</html>
