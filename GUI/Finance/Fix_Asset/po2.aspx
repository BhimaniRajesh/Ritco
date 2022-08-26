<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="po2.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

function check(roww,btnAdd)
{

}

    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">Fix Assets</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
        align="center">
        <tr class="bgbluegrey">
            <td colspan="3" align="center" style="height: 21px">
                <asp:Label ID="lblQry" CssClass="bluefnt" Font-Bold="True" runat="server">Following Document has Successfully Generated/Updated</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 420px">
                <font class="blackfnt">PO Code</td>
            <td style="width: 188px">
                <font class="blackfnt">Vendor</font></td>
            <td style="width: 188px">
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 420px">
                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                </asp:Label>
                <td>
                    <asp:Label ID="lblven" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                    </asp:Label>
                </td>
                <td>
                    <asp:LinkButton ID="ln1" runat="server" Font-Underline="true" CssClass="blackfnt"
                        Text="View"></asp:LinkButton>
                    <font class="blackfnt">|<u> Print</u></font>
                </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Choose Following Options</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Fix Assets </b></font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt"><b>. </b></font>
            </td>
            <td align="left">
                <font class="blackfnt">Fix Asset Master</font>
            </td>
            <td align="left">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add"
                    PostBackUrl="~/gui/finance/fix_asset/Fix_asset_Master.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton13" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/gui/finance/fix_asset/listall.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt"><b>. </b></font>
            </td>
            <td align="left">
                <font class="blackfnt">Purchase Order</font>
            </td>
            <td align="left">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="New" PostBackUrl="~/gui/finance/fix_asset/Purchase_Order.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Goods Reciept Note" PostBackUrl="~/gui/finance/fix_asset/Goods_RCPT_1.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Payment" PostBackUrl="" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt"><b>. </b></font>
            </td>
            <td align="left">
                <font class="blackfnt">Asset Management</font>
            </td>
            <td align="left">
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Assign" PostBackUrl="~/gui/finance/fix_asset/AssignAsset.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Transfer " PostBackUrl="" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Sell " PostBackUrl="" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Font-Underline="true" Text="Descard " PostBackUrl="~/gui/finance/fix_asset/Asset_cancellation.aspx?pa=1" />
            </td>
        </tr>
    </table>
</asp:Content>
