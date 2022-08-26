<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FA.aspx.cs" Inherits="GUI_admin_operations" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <font class="blklnkund"><b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt">
                        <b>Asset Management</b></font></a>
            </td>
        </tr>
    </table>
    <br /><br /><br />
    <table border="0" class="boxbg" cellpadding="4" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Fix Assets</b> </font>
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
                    Text="Payment" PostBackUrl="~/gui/finance/fix_asset/PAYMENT_1.aspx" />
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
                    Text="Assign" PostBackUrl="~/gui/finance/fix_asset/Assing_Asset_Qry.aspx?pa=1" />
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
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt"><b>. </b></font>
            </td>
            <td align="left">
                <font class="blackfnt">Asset Register</font>
            </td>
            <td align="left">
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="View" PostBackUrl="~/gui/finance/fix_asset/FA_REG_1.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Reconciliation " PostBackUrl="" />
            </td>
        </tr>
    </table>
</asp:Content>
