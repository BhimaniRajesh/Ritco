
<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GatePassPrint_RITCO.aspx.cs"
    Inherits="GUI_Operations_GatePass_ViewPrint_GatePassPrint_RITCO" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gate Pass</title>

    <script type="text/javascript" language="javascript">
       
    </script>

    <style type="text/css">
        .print_sml
        {
           font-family:Lucida Console;
           font-size:14;
           horizontal-align:left;
        }
       
    </style>
</head>
<body onload="window.print()" style="margin: 10px 0px 0px 0px;" class="print_sml">
    <form id="form1" runat="server">
        <%--<asp:Repeater ID="repgatepass" runat="server" OnItemDataBound="repgatepass_ItemDataBound">--%>
        <asp:DataList ID="repgatepass" runat="server" RepeatDirection="Vertical"  OnItemDataBound="repgatepass_ItemDataBound">

            <ItemTemplate>
                <asp:Table ID="tblmain" runat="server" Width="5.6in" HorizontalAlign="Left" CssClass="print_sml"
                    CellSpacing="0" CellPadding="0">
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4" Style="font-weight: bold;">
                            <asp:Label ID="lbldeladdr" Text='<%#DataBinder.Eval(Container.DataItem,"deladdr") %>'
                                runat="server" CssClass="print_sml">
                            </asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblpaymode" Text='<%#DataBinder.Eval(Container.DataItem,"paymode") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                            Delivery
                        </asp:TableCell>
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell>D.R.</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lbldrno" CssClass="print_sml" Text='<%#DataBinder.Eval(Container.DataItem,"mrsno") %>'
                                runat="server" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell VerticalAlign="Top" CssClass="print_sml">Rcd :</asp:TableCell>
                        <asp:TableCell Wrap="true">
                            <asp:Label ID="lblrecievedfrom" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"receivername") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>Dated.</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lbldeldate" Text='<%#DataBinder.Eval(Container.DataItem,"mrsdate") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml">Through..> </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblthrough" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"ptname") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>Station</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblstation" Text='<%#DataBinder.Eval(Container.DataItem,"mrbranch") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2" CssClass="print_sml">---------------------------</asp:TableCell>
                        <asp:TableCell>Freight</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblfreightcharge" Text='<%#DataBinder.Eval(Container.DataItem,"freight") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml">G.R.Number </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblgrno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockno") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell CssClass="print_sml">Freight Diff</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblrebate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"freight_diff") %>'
                                CssClass="print_sml"></asp:Label>
                            <%--<asp:Label ID="lblrebate" runat="server" Text=0.00
                                CssClass="print_sml"></asp:Label> --%>   
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2" Width="50%">
                            <asp:Table runat="server" BorderWidth="0">
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">Booked On> </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lbldockdate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"dockdate") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">From </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblfrom" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"from_loc") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">Packages </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblpackages" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"pkgsno") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">Contents </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblpacktype" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"packtype") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">Weight</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblweight" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"chrgwt") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">Private Mark </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblprivatemark" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"privatemark") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell CssClass="print_sml">PkgsType</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblPkgtype" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"Packing_Type") %>'
                                            CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                        <asp:TableCell ColumnSpan="2" Width="50%">
                            <asp:Table runat="server" CellPadding="0" CssClass="print_sml" CellSpacing="0" Width="100%"
                                Height="100%">
                                <asp:TableRow>
                                    <asp:TableCell>Docket Charges</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lbldktchrg" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG01") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>Misc. Charge</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lblmischrg" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG03") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>Door Dly Chrg</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lbldoordlychrg" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG08") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>Handling Charges</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lbldemchrg" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG14") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>SurCharges</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lblsurchrg" Text='<%#DataBinder.Eval(Container.DataItem,"SCHG17") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>Labour</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lbllaboutchrg" Text='<%#DataBinder.Eval(Container.DataItem,"UCHG06") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <%--<asp:TableRow>
                                    <asp:TableCell>Cartage</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lblcartagechrg" Text='<%#DataBinder.Eval(Container.DataItem,"UCHG08") %>'
                                            runat="server" CssClass="print_sml">NIL</asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>--%>
                                <asp:TableRow>
                                    <asp:TableCell>Oct. Charges</asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Right">
                                        <asp:Label ID="lbloctcharges" Text='<%#DataBinder.Eval(Container.DataItem,"octamt") %>'
                                            runat="server" CssClass="print_sml"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml">GST No.</asp:TableCell>
                        <asp:TableCell>
                         <asp:Label ID="lblGSTno" Text='<%#DataBinder.Eval(Container.DataItem,"GSTIN") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>Oct. Proc. Chrg</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblproccharges" Text='<%#DataBinder.Eval(Container.DataItem,"octprocchrg") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell CssClass="print_sml">GoDown..> </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lblgodown" Text='<%#DataBinder.Eval(Container.DataItem,"godownname") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>GST.. <asp:Label ID="lblSvtaxRate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"STaxRate") %>'
                                CssClass="print_sml"></asp:Label>%</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lblstax" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"stax") %>'
                                CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4">
                                ---------------------------------------------------------------
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>Ul Date.</asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="lbluldate" Text='<%#DataBinder.Eval(Container.DataItem,"uldate") %>' runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>Total</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label ID="lbltotal" Text='<%#DataBinder.Eval(Container.DataItem,"mrsamt") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="4">
                                ---------------------------------------------------------------
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ColumnSpan="2">&nbsp;</asp:TableCell>
                        <asp:TableCell>Coll. Amt</asp:TableCell>
                        <asp:TableCell HorizontalAlign="Right">
                            <asp:Label Font-Bold="true" ID="Label2" Text='<%#DataBinder.Eval(Container.DataItem,"netamt") %>'
                                runat="server" CssClass="print_sml"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </ItemTemplate>
</asp:DataList>
        <%--</asp:Repeater>--%>
    </form>
</body>
</html>
