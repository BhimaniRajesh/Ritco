<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmMenifestView.aspx.cs"
    Inherits="GUI_Operations_TCS_PrintTCS_FrmMenifestView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
<!--

function TABLE1_onclick() {

}

// -->
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <table bgcolor="white" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2"
            width="100%">
            <tr bgcolor="white">
                <td align="left" rowspan="3" style="width: 62%">
                    <asp:Image ID="imgLogo" ImageUrl="~/GUI/images/webxpress_logo.gif" runat="server" /><br />
                    <br />
                    <strong><span style="font-size: 8pt; font-family: Verdana">MANIFEST</span></strong></td>
                <td align="left">
                    <font class="blackfnt"><b><span>MF No</span></b></font></td>
                <td align="left" style="font-size: 8pt; font-family: Verdana; width: 210px;">
                    <font class="blackfnt"><strong>&nbsp;<asp:Label ID="lblMFNo" runat="server" Width="97%"
                        Font-Bold="False"></asp:Label></strong></font></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                <td align="left" style="width: 16%">
                    <font class="blackfnt"><b>MF Date</b></font></td>
                <td align="left" style="width: 210px">
                    <font class="blackfnt">&nbsp;<asp:Label ID="lblMFDate" runat="server" Width="97%"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width: 16%">
                    <font class="blackfnt"><b>Manual MF No</b></font></td>
                <td align="left" style="width: 210px">
                    <font class="blackfnt">&nbsp;<asp:Label ID="lblMMFNo" runat="server" Width="97%"></asp:Label></font></td>
            </tr>
        </table>
        <br />
        <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            colspan="2" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()"
            width="100%">
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt"><b>Route</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblRoute" runat="server" Width="97%" CssClass="blackfnt"></asp:Label></font></td>
                <td align="left" class="blackfnt">
                    <b>From-To&nbsp;</b></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblFromTo" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
                <td align="left">
                    <font class="blackfnt"><b>THC Start Location</b></font></td>
                <td align="left">
                    <font class="blackfnt">
                        <asp:Label ID="LblTHCLocation" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt"><b>THC No</b></font></td>
                <td align="left">
                    <asp:Label ID="LblTHCNo" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
                <td align="left" class="blackfnt">
                    <b>THC Date</b></td>
                <td align="left">
                    <asp:Label ID="LblTHCDate" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
                <td align="left">
                    <b><font class="blackfnt"><b>Vehicle</b></font></b></td>
                <td align="left">
                    <b>
                        <asp:Label ID="LblVehicle" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></b></td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GrdPaidFollow" Style="width: 100%" ShowFooter="True" EmptyDataText="No Records Found....."
            PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey"
            BackColor="White" runat="server" SelectedIndex="1" OnRowDataBound="GrdPaidFollow_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Sr.No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket No./Pay Basis">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lblfunction1" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"dockno")) +" - "+ Convert.ToString(DataBinder.Eval( Container.DataItem,"Payment_Basis")) %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField HeaderText="Mode/ServiceType" DataField="Mode">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataFormatString="{0:dd-MMM-yy}" HeaderText="Booking Date" DataField="BookingDate">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Origin - Delivery Location" DataField="Location">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="From - To" DataField="LocationTo">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Consignor" DataField="Cnor_Name">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Consignee" DataField="Cnee_name">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Packages L/B" DataField="Pkgs_LB">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Weight L/B -- kg-Freight" DataField="Freight">
                    <ItemStyle CssClass="blackfnt" Font-Size="11px" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <br />
        <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            colspan="2" style="width: 100%">
            <tr class="bgbluegrey" bgcolor="#ffffff">
                <td align="center" style="width: 210px">
                    <font class="blackfnt"><b>Prepared At - Date</b></font>
                </td>
                <td align="center" style="width: 169px">
                    <font class="blackfnt"><b>Prepared by Staff Name</b></font>&nbsp;</td>
                <td align="center" style="width: 120px">
                    <font class="blackfnt"><b>Approval Sign</b></font></td>
                <td align="center" style="width: 104px">
                    <font class="blackfnt"><b>Driver Sign</b></font></td>
                <td align="center" style="width: 167px">
                    <font class="blackfnt"><b>Entered At - Date</b></font></td>
                <td align="center" class="blackfnt">
                    <b>Entered by</b>
                </td>
            </tr>
            <tr align="center" bgcolor="#ffffff">
                <td align="center" style="width: 210px">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblPreparedAt" runat="server" Font-Bold="False" Width="94%"></asp:Label></b></font></td>
                <td align="center" style="width: 169px">
                    <asp:Label ID="LblStaffName" CssClass="blackfnt" runat="server" Width="88%"></asp:Label></td>
                <td align="center" style="width: 120px">
                    <asp:Label ID="LblSign" runat="server" CssClass="blackfnt" Width="89%"></asp:Label></td>
                <td align="center" style="width: 104px">
                    <asp:Label ID="LblDriverSign" CssClass="blackfnt" runat="server" Width="88%"></asp:Label></td>
                <td align="center" style="width: 167px">
                    <font class="blackfnt">
                        <asp:Label ID="LblAt" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
                <td align="center">
                    <asp:Label ID="LblPreparedBy" runat="server" CssClass="blackfnt" Width="87%"></asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:Label ID="LblMFLocation" CssClass="blackfnt" runat="server" Width="100%" Visible="False"></asp:Label><br />
        <asp:Label ID="LblNextLocation" CssClass="blackfnt" runat="server" Width="100%" Visible="False"></asp:Label>
    </form>
</body>
</html>
