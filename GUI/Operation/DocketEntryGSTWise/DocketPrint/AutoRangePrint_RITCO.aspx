<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AutoRangePrint_RITCO.aspx.cs"
    Inherits="GUI_Operation_DocketEntry_DocketPrint_AutoPrint" Title="Untitled Page" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript"></script>

    <style type="text/css">
        .lit
        {
            font-family: Lucida Console;
            font-size: 12;
            horizontal-align: left;
            text-transform: uppercase;
        }
        .printfnt
        {
            font-family: Lucida Console;
            font-size: 17;
            horizontal-align: left;
            text-transform: uppercase;
        }
        .print_sml
        {
            font-family: Lucida Console;
            font-size: 14;
            horizontal-align: left;
            text-transform: uppercase;
        }
        .print_dktno
        {
            font-family: Lucida Console;
            font-size: 17;
            horizontal-align: left;
            text-transform: uppercase;
        }
    </style>
</head>
<body style="margin: 0px 0px 0px 0px; width: 0px; font-family: Lucida Console; font-size: 14;
    position: absolute;" onload="window.print()">
    <form runat="server" id="frmmain">
    <asp:Repeater ID="rptmain" runat="server" OnItemDataBound="rptmain_ItemDataBound">
        <ItemTemplate>
            <asp:Table runat="server" ID="tblmain" Width="10in" Height="6in">
                <asp:TableRow Style="height: 55px;">
                    <asp:TableCell>&nbsp;</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="height: 92px;">
                    <asp:TableCell CssClass="td">
                        <asp:Table runat="server" Width="100%" Height="100%">
                            <asp:TableRow>
                                <asp:TableCell Width="50%">
                                    <div style="float: left; width: 50%">
                                        <asp:TextBox ID="txtdeladdr" ReadOnly="true" runat="server" CssClass="print_sml"
                                            Text='<%#DataBinder.Eval(Container.DataItem,"deladdr") %>' BackColor="white"
                                            BorderStyle="NONE" TextMode="MultiLine" Style="overflow: hidden;" Font-Size="Small"></asp:TextBox>
                                        <%--</asp:TableCell>
                                <asp:TableCell>--%>
                                    </div>
                                    <div style="float: left; width: 20%">
                                        <asp:Label ID="Label1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"policyno") %>'
                                            CssClass="print_sml"> &nbsp;</asp:Label>
                                    </div>
                                    <div style="float: left; width: 20%">
                                        <%--</asp:TableCell>
                                <asp:TableCell>--%>
                                        <asp:Label ID="Label2" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"policydate") %>'
                                            CssClass="print_sml"> &nbsp;</asp:Label>
                                    </div>
                                </asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="height: 40px;">
                        <asp:Table ID="Table1" runat="server" Width="100%" Height="100%">
                            <asp:TableRow>
                                <asp:TableCell CssClass="td" Style="width: 470px" Wrap="true">
                                    <asp:TextBox ID="txtcsgnaddr" ReadOnly="true" BorderStyle="None" runat="server" CssClass="print_sml"
                                        Text='<%#DataBinder.Eval(Container.DataItem,"csgnaddr") %>' BackColor="white"
                                        Width="300px" TextMode="MultiLine" Style="overflow: hidden;"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 200px;" VerticalAlign="Middle">
                                    <asp:Label ID="lblfromcity" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"fromcity") %>'
                                        CssClass="print_sml"> &nbsp;</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 110px;" HorizontalAlign="Left">
                                    <asp:Label ID="lbldockno" runat="server" Font-Bold="true" Text='<%#DataBinder.Eval(Container.DataItem,"dockno") %>'
                                        CssClass="print_dktno"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="height: 34px;">
                        <asp:Table ID="Table2" runat="server" Width="100%" Height="100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 470px" CssClass="td" Wrap="true">
                                    <asp:TextBox ID="txtcsgeaddr" ReadOnly="true" BorderStyle="None" runat="server" CssClass="print_sml"
                                        Text='<%#DataBinder.Eval(Container.DataItem,"csgeaddr") %>' BackColor="white"
                                        Width="300px" TextMode="MultiLine" Style="overflow: hidden;"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 220px;" VerticalAlign="Middle">
                                    <asp:Label ID="lbltocity" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"tocity") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 90px;">
                                    <asp:Label ID="lbldockdate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockdate") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="height: 35px">
                    <asp:TableCell>&nbsp;</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell CssClass="td" Height="1.7in" Wrap="true">
                        <asp:Table runat="server" ID="tblcharges" Style="width: 100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;">
                                    <asp:Label ID="lblpkgsno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 245px;">
                                    <asp:Label ID="lbldesc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"packprod") %>'
                                        CssClass="print_sml">Liquid Chemical</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;">
                                    <asp:Label ID="lblactwt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"actuwt") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 70px;">
                                    <asp:Label ID="lblchrgwt" runat="server" CssClass="print_sml" Text='<%# DataBinder.Eval(Container.DataItem,"chrgwt") %>'> </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 40px;">
                                    <asp:Label ID="lblrate" Text='<%# DataBinder.Eval(Container.DataItem,"frt_rate") %>'
                                        runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" Style="width: 100px;">
                                    <asp:Label ID="lblchargename" runat="server" CssClass="print_sml">BASIC </asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 85px;">
                                    <asp:Label ID="lblfreightcharge" Text='<%# DataBinder.Eval(Container.DataItem,"freight") %>'
                                        runat="server" CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell Width="400px" Style="vertical-align: bottom;" ColumnSpan="5" VerticalAlign="Bottom">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblpaynote" Text='<%# DataBinder.Eval(Container.DataItem,"paynote") %>'
                                        runat="server" CssClass="printfnt" Font-Bold="true" Font-Size="Medium"></asp:Label><br />
                                    <br />
                                    <br />
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblprivatemark" Text='<%# DataBinder.Eval(Container.DataItem,"privatemark") %>'
                                        runat="server" CssClass="print_sml"></asp:Label>
                                    <br />
                                    <br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDiscount" runat="server"
                                        CssClass="printfnt" Font-Size="small"></asp:Label><br />
                                    <br />
                                </asp:TableCell>
                                <asp:TableCell VerticalAlign="Top" ColumnSpan="2" HorizontalAlign="Right" Width="2in">
                                    <asp:GridView HorizontalAlign="Right" BorderWidth="0" ID="grvcharges" runat="server"
                                        RowStyle-CssClass="bgwhite" CellPadding="0" CellSpacing="0" ShowHeader="false"
                                        CssClass="boxbg" AutoGenerateColumns="false" Width="190px" Height="1.2in">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemStyle HorizontalAlign="Left" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblchargename" Text='<%#DataBinder.Eval(Container.DataItem,"chargename") %>'
                                                        runat="server" CssClass="lit"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemStyle Width="45px" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblchargevalue" Width="75px" Text='<%#DataBinder.Eval(Container.DataItem,"chargevalue") %>'
                                                        runat="server" CssClass="lit"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="Left" Wrap="true" VerticalAlign="Top">
                                    &nbsp;&nbsp;<asp:Label ID="lblorgnloc" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"orgnaddr") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Style="height: 25px" CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table7" Height="100%" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;">
                                
                                </asp:TableCell>
                                <asp:TableCell Style="width: 240px;">
                                    <asp:Label ID="lbldeclval" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"invamt") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 180px;">
                                    <asp:Label ID="lblinvno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"invno") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 100px;" CssClass="print_sml">
                                        &nbsp;
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 90px;">
                                    <asp:Label ID="lbldockettotal" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dkttot") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>&nbsp;</asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="height: 15px;">
                    <asp:TableCell CssClass="td" Wrap="true">
                        <asp:Table runat="server" ID="Table8" Height="100%" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell Style="width: 60px;"></asp:TableCell>
                                <asp:TableCell Style="width: 240px;" VerticalAlign="Bottom">
                                    <asp:Label ID="lblremarks" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"spl_svc_req") %>'
                                        CssClass="print_sml"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Style="width: 55px;"></asp:TableCell>
                                <asp:TableCell Style="width: 50px;"></asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" CssClass="printfnt" Font-Bold="true"
                                    Style="width: 145px;">
                                    <asp:Label ID="lbldupcop1" Visible="false" runat="server">DUPLICATE</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Left" CssClass="printfnt" Font-Bold="true"
                                    Style="width: 45px;">
                                    <asp:Label ID="lbldupcop2" Visible="false" runat="server">COPY</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Wrap="true" HorizontalAlign="Right" Style="width: 90px;">
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblprintby" runat="server"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="border: solid red 1px;">
                    <asp:TableCell>&nbsp;</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ItemTemplate>
    </asp:Repeater>
    <asp:HiddenField ID="hdnchargerule" runat="server" />
    </form>
</body>
</html>
