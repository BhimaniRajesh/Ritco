<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmDetail.aspx.cs" Inherits="FrmDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="MR Summary" Width="714px"></asp:Label>
        <table style="width: 716px" title="MR Summary">
            <tr>
                <td style="width: 150px; height: 21px">
                    MR No.</td>
                <td style="width: 215px; height: 21px">
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                <td style="width: 127px; height: 21px">
                    Date</td>
                <td style="height: 21px">
                    <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px; height: 21px">
                    MR Type:</td>
                <td style="width: 215px; height: 21px">
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                <td style="width: 127px; height: 21px">
                    MR Branch</td>
                <td style="height: 21px">
                    <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px">
                    Docket No.</td>
                <td style="width: 215px">
                    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
                <td style="width: 127px">
                    Docket Date</td>
                <td>
                    <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px">
                    Party</td>
                <td colspan="3">
                    <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px">
                    Booking Branch</td>
                <td style="width: 215px">
                    <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></td>
                <td style="width: 127px">
                    Delivery Branch</td>
                <td>
                    <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px; height: 21px">
                    No. Of Packages</td>
                <td style="width: 215px; height: 21px">
                    <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></td>
                <td style="width: 127px; height: 21px">
                    Charged Weight</td>
                <td style="height: 21px">
                    <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox></td>
            </tr>
        </table>
    
    </div>
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Collection Details"
            Width="714px"></asp:Label><br />
        <table style="width: 713px">
            <tr>
                <td style="width: 142px">
                    Freight Amount</td>
                <td style="width: 58px">
                    <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox></td>
                <td style="width: 342px">
                    TDS rate ( % )</td>
                <td>
                    <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 142px">
                    Service Tax</td>
                <td style="width: 58px">
                    <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox></td>
                <td style="width: 342px">
                    TDS Amount ( - )</td>
                <td>
                    <asp:TextBox ID="TextBox17" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 142px">
                </td>
                <td style="width: 58px">
                </td>
                <td style="width: 342px">
                    Other Deduction ( - )</td>
                <td>
                    <asp:TextBox ID="TextBox18" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 142px">
                    Total</td>
                <td style="width: 58px">
                    <asp:TextBox ID="TextBox14" runat="server"></asp:TextBox></td>
                <td style="width: 342px">
                    Net Amount</td>
                <td>
                    <asp:TextBox ID="TextBox19" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 142px">
                    Payment Mode</td>
                <td style="width: 58px">
                    <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox></td>
                <td style="width: 342px">
                </td>
                <td>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
