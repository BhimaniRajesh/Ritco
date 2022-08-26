<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GatePassPrint_CHAWLA.aspx.cs" Inherits="GUI_Operations_GatePass_ViewPrint_GatePassPrint_CHAWLA" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
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
        .print_sml
        {
           font-family:Lucida Console;
           font-size:12;
           horizontal-align:left;
           text-transform: uppercase;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; width: 0px; font-family: Lucida Console; font-size: 14;
    position: absolute; height: 0px;" onload="window.print();">
    <form id="form1" runat="server">
        <asp:Repeater ID="repgatepass" runat="server" OnItemDataBound="repgatepass_ItemDataBound">
            <ItemTemplate>
                <asp:Table runat="server" Style="margin: 0px 0px 0px 0px;" CssClass="print_sml" Width="6in"
                    CellSpacing="0" CellPadding="0" Height="3.6in" BorderColor="black">
                    <asp:TableRow Style="height: 80px">
                        <asp:TableCell ColumnSpan="4" HorizontalAlign="Left" VerticalAlign="Top">
                            <asp:Table runat="server" Width="100%" Height="100%" CellPadding="0" CellSpacing="0">
                                <asp:TableRow>
                                    <asp:TableCell VerticalAlign="Top">&nbsp;</asp:TableCell>
                                    <asp:TableCell VerticalAlign="Top">
                                        <asp:Label ID="lblcmpname" runat="server" CssClass="print_sml">CHAWLA HIGHWAY CARRIERS</asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell Width="2in" VerticalAlign="Top"></asp:TableCell>
                                    <asp:TableCell VerticalAlign="Top">
                                        <asp:TextBox ID="txtdelladdr" Style="overflow: hidden;" ReadOnly="true" Text='<%#DataBinder.Eval(Container.DataItem,"locaddr") %>'
                                            CssClass="print_sml" BorderStyle="None" TextMode="MultiLine" Width="300px" Height="45px"
                                            Rows="3" runat="server"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>&nbsp;</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="height: 20px">
                        <asp:TableCell ColumnSpan="4">&nbsp;</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="height: 20px">
                        <asp:TableCell Height="18px" Width="80px">&nbsp;</asp:TableCell>
                        <asp:TableCell Wrap="false" Width="90px">
                            <asp:Label ID="lblrecievername" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ptname") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell Width="142px">&nbsp;</asp:TableCell>
                        <asp:TableCell Width="260px">
                            <asp:Label ID="lbldockno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockno") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow Style="height: 20px">
                        <asp:TableCell Height="19px">&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblgatepassno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"gatepassno") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblgodown" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"godown") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Height="20px">&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbldeldate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"deldate") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblfrom" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"fromloc") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Height="20px">&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbldeltime" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"deltime") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbllorryno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thcno") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Height="20px">&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblparty" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"csgenm") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblpkgsno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Height="20px">&nbsp;</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblfreight" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"freight") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblcontents" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"product") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="15px">GatePass</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblgatepasscharge" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG15") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblweight" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"weight") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="15px">LABOUR</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblchrglabor" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"UCHG05") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblpmark" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"privatemark") %>'
                                CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" HorizontalAlign="Left" Height="15px">DOOR-DLY</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblchrgdoordely" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG08") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell><asp:Label ID="lblpaybas" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paymentbas") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="15px">DEMM</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblchrgdemm" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG14") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="15px">OctAmt</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lbloctamt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"col_oct") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbldupremark" runat="server" Text="(Duplicate Copy)" CssClass="print_sml"></asp:Label></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="14px">Oct. Pro.</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lbloctproamt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"col_octprchrg") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>&nbsp;</asp:TableCell>
                        <asp:TableCell>
                            &nbsp;</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="14px">STAX</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblstax" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"servicetax") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">Pay Mode :</asp:TableCell>
                        <asp:TableCell> <asp:Label ID="lblpaymode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"paymode") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml" Height="15px">TOTAL </asp:TableCell>
                        <asp:TableCell Style="border-top: dashed black 1px; border-bottom: dashed black 1px;"
                            HorizontalAlign="Right">
                            <asp:Label ID="lbltotal" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"mramount") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">Cashier :</asp:TableCell>
                        <asp:TableCell> <asp:Label ID="lblcashier" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"name") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4">&nbsp;</asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
