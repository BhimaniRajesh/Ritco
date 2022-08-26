<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewCrossingChallan.aspx.cs"
    Inherits="GUI_Operations_Crossing_ViewCrossingChallan" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Crossing Challan Detail</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
            BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="4" Font-Bold="true">
            <center>
                Crossing Challan Detail
                </center>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Company Name
                </asp:TableCell>
                <asp:TableCell Font-Bold="true" ColumnSpan="3">
                    <asp:Label ID="Label1" runat="server" Text="Rajdhani Interstate Transport Co. Regd."></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Address
                </asp:TableCell>
                <asp:TableCell Font-Bold="true" ColumnSpan="3">
                    <asp:Label ID="Label2" runat="server" Text="336,Udyog Vihar,Phase-2, Gurgaon, Haryana"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Crossing challan no
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblCrossChallanNo" runat="server"></asp:Label>
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
           Date
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblVoucherDt" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Challan Location
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblChallanLocation" runat="server" Text=""></asp:Label>
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
           Vehicle No
                </asp:TableCell>
                <asp:TableCell Font-Bold="true">
                    <asp:Label ID="lblVehicleEntry" runat="server"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
           Vendor
                </asp:TableCell>
                <asp:TableCell Font-Bold="true" ColumnSpan="3">
                    <asp:Label ID="lblVendor" runat="server" Text=""></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />
        <asp:Table ID="Table2" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
            BorderWidth="1">
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
                    <asp:GridView ID="DocketDetail" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                        CellSpacing="1" CssClass="boxbg" EmptyDataText="No Dockets Found...for Challan Preparation"
                        EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-BorderColor="AliceBlue"
                        EmptyDataRowStyle-BorderWidth="1" EmptyDataRowStyle-Font-Bold="true" EmptyDataRowStyle-HorizontalAlign="Center"
                        EmptyDataRowStyle-CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-FirstPageText="[First]"
                        PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                        Style="width: 9.0in" ShowFooter="True" OnRowDataBound="dgDocket_RowDataBound">
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                        <Columns>
                            <asp:TemplateField FooterStyle-CssClass="bgbluegrey" HeaderText="Sr. No" HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket Number" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Wrap="True" HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <font class="blackfnt">
                                            <asp:Label ID="lbldockno" Text='<%# DataBinder.Eval(Container.DataItem,"DockNo") %>'
                                                runat="server"></asp:Label>
                                        </font>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket Date" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Wrap="True" HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <font class="blackfnt">
                                            <asp:Label ID="lbldockdt" Text='<%# DataBinder.Eval(Container.DataItem,"DockDate") %>'
                                                runat="server"></asp:Label>
                                        </font>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Paybas" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <font class="blackfnt">
                                            <asp:Label ID="lblPaybas" Text='<%# DataBinder.Eval(Container.DataItem,"Paybas") %>'
                                                runat="server"></asp:Label>
                                        </font>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Origin" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblOrigin" Text='<%# DataBinder.Eval(Container.DataItem,"from_loc") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Destn" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Left" />
                                <ItemTemplate>
                                    <asp:Label ID="lblDestn" Text='<%# DataBinder.Eval(Container.DataItem,"to_loc") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pkgs" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblPkgs" Text='<%# DataBinder.Eval(Container.DataItem,"Pkgs") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                <FooterTemplate>
                                    <right>
                                            <asp:Label ID="lblTotPackages" runat="server"></asp:Label>
                                        </right>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Weight" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblActualWt" Text='<%# DataBinder.Eval(Container.DataItem,"ActuWeight") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" />
                                <FooterTemplate>
                                    <right>
                                            <asp:Label ID="lblTotWeight" runat="server"></asp:Label>
                                        </right>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket Total" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblToPay" Text='<%# DataBinder.Eval(Container.DataItem,"DKTTOT") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <right>
                                            <asp:Label ID="lblTotToPay" runat="server"></asp:Label>
                                        </right>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate Basis" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblRate" Text='<%# DataBinder.Eval(Container.DataItem,"Ratetype") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Vendor Rate" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="lblVendorRate" Text='<%# DataBinder.Eval(Container.DataItem,"VendorRate") %>'
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Crossing Charges" HeaderStyle-CssClass="blackfnt"
                                FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblCrossingChrg" Text='<%# DataBinder.Eval(Container.DataItem,"CrossingChrg") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <right>
                                            <asp:Label ID="lblTotCrossing" runat="server"></asp:Label>
                                        </right>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Delivery Charge" HeaderStyle-CssClass="blackfnt"
                                FooterStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblDDC" Text='<%# DataBinder.Eval(Container.DataItem,"DoorDelyChrg") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <right>
                                            <asp:Label ID="lblTotDoorDeliveryChrg" runat="server"></asp:Label>
                                        </right>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bulky Charge" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                                HeaderStyle-Font-Bold="true">
                                <ItemStyle HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <center>
                                        <asp:Label ID="lblbulkychrg" Text='<%# DataBinder.Eval(Container.DataItem,"BulkyCharge") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </ItemTemplate>
                                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                                <FooterStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <center>
                                        <asp:Label ID="lblTotBulkyChrg" Text='<%# DataBinder.Eval(Container.DataItem,"BulkyCharge") %>'
                                            runat="server"></asp:Label>
                                    </center>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell Font-Bold="true">
                    <asp:Table ID="Table3" runat="server" CssClass="boxbg" Width="5in" CellSpacing="1"
                        BorderWidth="0">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell Font-Bold="true" ColumnSpan="2" HorizontalAlign="Center">
           SUMMARY
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Total To Pay (+)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTotalTOPay" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
          Total Crossing (-)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTotalCrossing" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Door delivery Charges (-)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTotalDDCharges" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Bulky Charges (-)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTotalBulkyCharges" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Truck Freight (-)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTruckFreight" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Advance Truck Freight (+)
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblAdvanceTruckFreight" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell>
           Balance Freight
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblBalanceFreight" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell Font-Bold="true">
           Net Payable
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                                <asp:Label ID="lblTotalNetPayable" runat="server"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    </form>
</body>
</html>
