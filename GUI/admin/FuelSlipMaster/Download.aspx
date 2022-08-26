<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Download.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_Download" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>General Master</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">

        function printPage() {
            var hdnflagprint = document.getElementById("hdnflagprint");
            if (hdnflagprint.value == "Y")
                window.print();

            return false;
        }

        function popupPrint() {
            var hdnCode = document.getElementById("hdnCode");
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            window.open("GeneralMasterView.aspx?mastercode=" + hdnCode.value + "&print=Y", "", winOpts);
            return false;
        }
    </script>

</head>
<body onload="javascript:return printPage()">
    <form id="frmmain" runat="server">
    <table width="6in">
        <tr>
            <td align="right">
                <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print"
                    OnClientClick="javascript:return popupPrint();">
                </asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Table ID="tblmain" runat="server" Width="6in" HorizontalAlign="center" CssClass="ftbl">
                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell HorizontalAlign="Right" runat="server">
                            <asp:GridView CssClass="ftbl" AutoGenerateColumns="false" RowStyle-CssClass="nrow"
                                CellSpacing="1" HorizontalAlign="center" ID="grvgeneral" runat="server" BorderWidth="0"
                                 HeaderStyle-CssClass="bgbluegrey" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                    <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Truck No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="UserSlipNo" HeaderText="Slip No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="FillingDate" HeaderText="Filling Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Ltrs" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                </Columns>
                              <%--  <Columns>
                                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />
                                </Columns>--%>
                                
                                <Columns>
                                    <asp:BoundField DataField="InstrumentNo" HeaderText="Instrument No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="InstrumentDate" HeaderText="InstrumentDate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="BankName" HeaderText="Bank Name" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <%--<asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ReadOnly="true" />--%>
                                </Columns>

                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </td>
        </tr>

        <tr>
            <td>
                <asp:Table ID="tblVoucher" runat="server" Width="6in" HorizontalAlign="center" CssClass="ftbl">
                     <asp:TableRow CssClass="hrow" >
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="13">
                           <h2> Voucher detail</h2>
                        </asp:TableCell>
                        </asp:TableRow> 
                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="1">
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="1">
                           Vendor Name:
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                             <asp:Label ID="lblVendorName" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                           Voucher No:
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                             <asp:Label ID="lblVoucherNo" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                            &nbsp;&nbsp;&nbsp; Voucher Date:
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                             <asp:Label ID="lblVoucherDate" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="nrow">
                        <asp:TableCell HorizontalAlign="Right" runat="server" ColumnSpan="13">
                            <asp:GridView CssClass="ftbl" AutoGenerateColumns="false" RowStyle-CssClass="nrow"
                                CellSpacing="1" HorizontalAlign="center" ID="grvVoucher" runat="server" BorderWidth="0"
                                HeaderStyle-CssClass="bgbluegrey" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Bill_No" ItemStyle-HorizontalAlign="Left" HeaderText="Bill No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                    <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Vehicle No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField DataField="SlipNo" HeaderText="Slip No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="FillingDate" HeaderText="Filling Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Ltrs" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                    <asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="FuelDiscount" HeaderText="Discount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="SpecialDiscount" HeaderText="Special Discount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="NetBillAmount" HeaderText="Net Bill Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                    <asp:BoundField DataField="PaidAmount" HeaderText="Paid Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                   <asp:BoundField DataField="PendingAmount" HeaderText="Balance Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>

                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell>
                        </asp:TableCell>                        
                    </asp:TableRow>
                     <asp:TableRow CssClass="hrow">
                        <asp:TableCell>
                        </asp:TableCell>                        
                    </asp:TableRow>
                     <asp:TableRow CssClass="hrow">
                        <asp:TableCell>
                        </asp:TableCell>                        
                    </asp:TableRow>

                    <asp:TableRow CssClass="hrow">
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="5">
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                           Instrument Date:
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                             <asp:Label ID="lblInstrumentDate" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                         <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                           Total Amount:
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                             <asp:Label ID="lblTotalAmount" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnflagprint" runat="server" />
    <asp:HiddenField ID="hdnCode" runat="server" />
    
    </form>
</body>
</html>