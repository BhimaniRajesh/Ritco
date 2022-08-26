<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MRDotmatrixViewPrint.aspx.cs" Inherits="GUI_Finance_Billing_Ver1_MRDotmatrixViewPrint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        function printPage() {
            window.print();
            return false;
        }
    </script>
</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
        <div>
            <table class="bgwhite" border="0" cellpadding="0" cellspacing="0" style="height: 5in; width: 6.75in;">
                <tr>
                    <td colspan="4" style="height: 1.50in"></td>
                </tr>
                 <tr>
                    <td style="width: 0.70in;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblGSTNo" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <%--<asp:Label runat="server" ID="Label2" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>--%>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblMrNo" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblMrDate" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblReceiver" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblStation" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblThrough" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                        &nbsp;</td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblFreigth" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblGrNo" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblFreightDiff" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblBookedOn" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblDocketcharges" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblFrom" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblMiscCharges" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblPackeges" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblDlyCharges" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblContents" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblHandlingCharges" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblWeigth" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblSurcharge" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblPvtMark" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblLabour" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblPakgtype" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblServicetax" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 0.70in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1in; height: 22px;">
                        <asp:Label runat="server" ID="lblGodown" Font-Size="16px" Width="170px" Style="margin-right: 0.20in"></asp:Label>
                    </td>
                    <td style="width: 0.40in; height: 22px;"></td>
                    <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                        <asp:Label runat="server" ID="lblTotal" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                    </td>
                    <%--</tr>
                 <tr>
                <td  style="width:0.70in ;height:22px;">

                </td>
                <td align="left" valign="middle" style="width:1in ;height:22px;">
                    <asp:Label runat="server" ID="Label1" Font-Size="16px" Width="170px"  style="margin-right:0.20in"></asp:Label>
                </td>
                <td style="width:0.40in ; height:22px;">

                </td>
                <td align="left" valign="middle" style="width:1.50in ; height:22px;">
                    <asp:Label runat="server" ID="Label2" Font-Size="16px" Width="90px"  style="margin-left:0.10in"></asp:Label>
                </td>
            </tr>--%>
                    <tr>
                        <td style="width: 0.70in; height: 22px;"></td>
                        <td align="left" valign="middle" style="width: 1in; height: 22px;">
                            <asp:Label runat="server" ID="lblUIDate" Font-Size="16px" Width="90px" Style="margin-right: 0.20in"></asp:Label>
                        </td>
                        <td style="width: 0.40in; height: 22px;"></td>
                        <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                            <asp:Label runat="server" ID="lblCollectedAmt" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 0.70in; height: 22px;"></td>
                        <td align="left" valign="middle" style="width: 1in; height: 22px;">
                            <asp:Label runat="server" ID="lblCashCredit" Font-Size="16px" Width="90px" Text="Cash" Style="margin-right: 0.20in"></asp:Label>
                        </td>
                        <td style="width: 0.40in; height: 22px;"></td>
                        <td align="left" valign="middle" style="width: 1.50in; height: 22px;">
                            <asp:Label runat="server" ID="Label4" Font-Size="16px" Width="90px" Style="margin-left: 0.10in"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4">
                            <asp:Label ID="lblRemark" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="height: 0.12in"></td>
                    </tr>
            </table>
        </div>
    </form>
</body>
</html>
