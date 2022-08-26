<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocketView.aspx.cs" Inherits="GUI_Operation_DocketEntry_DocketPrint_DocketView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        <%=dkt_call %>
        View
        <% %>
    </title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js">
    <script type="text/javascript" language="javascript">
        dropdowncontent.init("lbloperation", "right-bottom", 500, "mouseover");
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="divmain" runat="server" Width="10in">
        <asp:Table runat="server" Width="100%" CssClass="boxbg" CellSpacing="1">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center">Docket View</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:LinkButton ID="lbloperation" runat="server" Font-Bold="true" CssClass="blackfnt">
                    
                    Operational</asp:LinkButton>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:LinkButton ID="lblfinancial" runat="server" Font-Bold="true" CssClass="blackfnt">Financial</asp:LinkButton>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:LinkButton ID="lblstatus" runat="server" Font-Bold="true" CssClass="blackfnt">Status</asp:LinkButton>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center">
                    <asp:LinkButton ID="lblparties" runat="server" Font-Bold="true" CssClass="blackfnt">Party Details</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:LinkButton ID="lblinvoice" runat="server" Font-Bold="true" CssClass="blackfnt">Invoice & Document Details</asp:LinkButton>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:LinkButton ID="lbluserinfo" runat="server" Font-Bold="true" CssClass="blackfnt">User Entry Information</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="4">
                    <asp:Panel ID="divoperational" runat="server" Width="100%">
                        <asp:Table runat="server" Width="100%" CellSpacing="1" CssClass="boxbg">
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell Width="16.5%"><%=dkt_call %> Number</asp:TableCell>
                                <asp:TableCell Width="16%">
                                    <asp:Label ID="lbldockno" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell ><%=dkt_call %> Date</asp:TableCell>
                                <asp:TableCell Width="16.5%">
                                <asp:Label ID="lbldockdate" runat="server" CssClass="blackfnt"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Width="16%">Payment Basis</asp:TableCell>
                                <asp:TableCell Width="16.5%"><asp:Label ID="lblpaybas" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell>Origin</asp:TableCell>
                                <asp:TableCell>
                                <asp:Label ID="lblorgnloc" runat="server" CssClass="blackfnt"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell>Destination</asp:TableCell>
                                <asp:TableCell>
                                <asp:Label ID="lbldelloc" runat="server" CssClass="blackfnt"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>Transit Mode</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lbltransmode" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                <asp:TableCell>Service Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblservicetype" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                <asp:TableCell>FTL Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblftltype" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>PickUp Delivery Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblpickupdel" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                <asp:TableCell>
                                    <asp:Label ID="lblfromcity" runat="server" CssClass="blackfnt">From City</asp:Label>
                                </asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                 <asp:TableCell>
                                    <asp:Label ID="lbltocity" runat="server" CssClass="blackfnt">To City</asp:Label>
                                 </asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblto" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>Packaging Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblpacktype" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                <asp:TableCell>Product Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblprodtype" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                                <asp:TableCell>Business Type</asp:TableCell>
                                <asp:TableCell> <asp:Label ID="lblbusinesstype" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>&nbsp;</asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                                <asp:TableCell></asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:Panel>
                    <asp:Panel ID="divfinancial" runat="server" Width="100%">
                    </asp:Panel>
                    <asp:Panel ID="divstatus" runat="server" Width="100%">
                    </asp:Panel>
                    <asp:Panel ID="divparties" runat="server" Width="100%">
                    </asp:Panel>
                    <asp:Panel ID="divinvoice" runat="server" Width="100%">
                    </asp:Panel>
                    <asp:Panel ID="divuserinfo" runat="server" Width="100%">
                    </asp:Panel>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    </form>
</body>
</html>
