<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoPrint_RITCO.aspx.cs"
    Inherits="GUI_Operation_DocketEntry_DocketPrint_AutoPrint" Title="Untitled Page" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript"></script>

    <style type="text/css">
        td
        {
           font-family:Lucida Console;
           font-size:13;
           vertical-align:top;
           horizontal-align:left;
        }
        
        td1
        {
           font-family:Lucida Console;
           font-size:14;
           border-left:solid black 1px;
           vertical-align:top;
           horizontal-align:left;
        }
        
        printfnt
        {
           font-family:Lucida Console;
           font-size:14;
           horizontal-align:left;
           text-transform: uppercase;
        }
        print_sml
        {
           font-family:Lucida Console;
           font-size:14;
           horizontal-align:left;
           text-transform: uppercase;
        }
    </style>
</head>
<body style="margin: 10px 0px 0px 0px; width: 0px; font-family: Lucida Console; font-size: 14;
    position: absolute; height: 0px;" onload="window.print()">
    <form runat="server" id="frmprint">
        <asp:Panel runat="server" ID="divres" Style="width: 8in; height: 8in;">
            <asp:Table runat="server" ID="tblmain" Style="width: 100%;">
                <asp:TableRow>
                    <asp:TableCell CssClass="td" Style="height: 62px;" ColumnSpan="5">
                        <asp:Label ID="lbldeladdr" runat="server" CssClass="printfnt">delivery address</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell CssClass="td" Style="height: 45px; width: 411px" ColumnSpan="3" Wrap="true">
                        <asp:Label ID="lblcsgnaddr" runat="server" CssClass="printfnt">consignor address</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Style="width: 240px;" VerticalAlign="Middle">
                        <asp:Label ID="lblfromcity" runat="server" CssClass="printfnt"> &nbsp;</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Style="width: 90px;">
                        <asp:Label ID="lbldockno" runat="server" Font-Bold="true" 
                            Font-Size="Medium" CssClass="printfnt"> </asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="height: 70px; width: 411px" CssClass="td" ColumnSpan="3" Wrap="true">
                        <asp:Label ID="lblcsgeaddr" runat="server" CssClass="printfnt">consignee address</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Style="width: 240px;" VerticalAlign="Middle">
                        <asp:Label ID="lbltocity" runat="server" CssClass="printfnt"> to city</asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Style="width: 90px;">
                        <asp:Label ID="lbldockdate" runat="server" CssClass="printfnt"> docket date</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5">
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="width: 100%" ColumnSpan="5" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="tblcharges" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;">
                                    <asp:Label ID="lblpkgsno" runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 240px;">
                                    <asp:Label ID="lbldesc" runat="server" CssClass="print_sml">Liquid Chemical</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;">
                                    <asp:Label ID="lblactwt" runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 50px;">
                                    <asp:Label ID="lblchrgwt" runat="server" CssClass="print_sml">chrgwt</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 38px;">
                                    <asp:Label ID="lblrate" runat="server" CssClass="print_sml">rate.00</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 100px;">
                                    <asp:Label ID="lblchargename" runat="server" CssClass="print_sml">BASIC </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 85px;">
                                    <asp:Label ID="lblfreightcharge" runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true">
                                    <asp:Label ID="lblorgnaddr" Style="position: absolute; left: 680px; top: 200px; width: 100px;"
                                        runat="server" CssClass="print_sml">orgn addr</asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="5" Width="100%" runat="server" CssClass="td" Wrap="true">
                        <asp:Table runat="server" Width="100%" CellSpacing="0" CellPadding="0">
                            <asp:TableRow>
                                <asp:TableCell Style="vertical-align: bottom;" VerticalAlign="Bottom">
                                    &nbsp;&nbsp;&nbsp;<asp:Label ID="lblpaynote" runat="server" CssClass="printfnt" Font-Bold="true"
                                        Font-Size="Medium"></asp:Label><br />
                                    &nbsp;&nbsp;&nbsp;<asp:Label ID="lblprivatemark" runat="server" CssClass="print_sml">private mark</asp:Label><br />
                                    &nbsp;
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:GridView HorizontalAlign="Right" BorderWidth="0" ID="grvcharges" runat="server"
                                        RowStyle-CssClass="bgwhite" CellPadding="0" CellSpacing="0" ShowHeader="false"
                                        AllowSorting="true" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" AutoGenerateColumns="false"
                                        EmptyDataText="No Records Found..." Width="2in">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblchargename" Text='<%#DataBinder.Eval(Container.DataItem,"chargename") %>'
                                                        runat="server" CssClass="print_sml"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemStyle Width="45px" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblchargevalue" Width="75px" Text='<%#DataBinder.Eval(Container.DataItem,"chargevalue") %>'
                                                        runat="server" CssClass="print_sml"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell Width="125px"></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="width: 100%" ColumnSpan="5" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table11" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell ColumnSpan="2" VerticalAlign="Bottom" Style="width: 330px; height: 30px;">
                                    &nbsp;
                                    
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;"></asp:TableCell>
                                <asp:TableCell Style="width: 50px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 45px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 100px;">
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 90px;">
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="width: 100%" ColumnSpan="5" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table7" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;">
                                
                                </asp:TableCell>
                                <asp:TableCell Style="width: 240px;">
                                    <asp:Label ID="lbldeclval" runat="server" CssClass="print_sml">DeclVal</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;">
                                    <asp:Label ID="lblinvno" runat="server" CssClass="print_sml">Invoice No</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 50px;">
                                
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 55px;">
                                
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 70px;">
                                
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 90px;">
                                    <asp:Label ID="lbldockettotal" runat="server" CssClass="print_sml">dockettotal</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="width: 100%" ColumnSpan="5" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table9" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;">
                                &nbsp;
                                </asp:TableCell>
                                <asp:TableCell Style="width: 240px;" VerticalAlign="Bottom">
                               &nbsp;
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;"></asp:TableCell>
                                <asp:TableCell Style="width: 50px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 45px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 100px;">
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 85px;">
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="width: 100%" ColumnSpan="5" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table8" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;"></asp:TableCell>
                                <asp:TableCell Style="width: 240px;" VerticalAlign="Bottom">
                                    <asp:Label ID="lblremarks" runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;"></asp:TableCell>
                                <asp:TableCell Style="width: 50px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 45px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 100px;">
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 90px;">
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:Panel>
    </form>
</body>
</html>
