<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true"
    CodeFile="ManageRules.aspx.cs" Inherits="GUI_admin_ManageRules" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Manage Rules.</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table class="boxbg" cellspacing="1" cellpadding="1" border="0" width="400px">
        <tr class="bgbluegrey">
            <td align="center">
                <font class="blackfnt"><b>List of Rules</b></font></td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">Company Setup</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">Business Model Setup</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkStep3" CssClass="bluefnt" Text="Process Choice"
                        PostBackUrl="~/GUI/admin/rules/WebXpressRules_Step3.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkStep4" CssClass="bluefnt" Text="Document Nomenclature Settings"
                        PostBackUrl="~/GUI/admin/rules/WebXpressRules_Step4.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">Document Manual # &amp; Back-dated Entry Settings</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">THC Settings</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="LinkButton2" CssClass="bluefnt" Text="Delivery Process Settings"
                        PostBackUrl="~/GUI/admin/Rules/SetDelyProc.aspx"> </asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:HyperLink ID="lnkdocketrules" runat="server" NavigateUrl="~/GUI/admin/DocketCustomization/DocketCustomization_Step1.aspx">Docket Entry Settings</asp:HyperLink>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">Billing Settings</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li><font class="blackfnt">DCR Settings</font></li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkDcrStt" CssClass="bluefnt" Text="Set DCR Rules"
                        PostBackUrl="~/GUI/admin/rules/DCR_Rules.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="LinkButton1" CssClass="bluefnt" Text="Set Balance Sheet Category"
                        PostBackUrl="~/GUI/admin/BLanceSheet_Category.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkDFM" CssClass="bluefnt" Text="DFM Rules" PostBackUrl="~/GUI/Admin/Rules/Rules_DFM.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkManualrules" CssClass="bluefnt" Text="Manual Vouchers Rules"
                        PostBackUrl="~/GUI/admin/ManualVoucherRules/ManualVouchersRules.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
        <tr style="background: white">
            <td align="left">
                <li>
                    <asp:LinkButton runat="server" ID="lnkAccountMasterrules" CssClass="bluefnt" Text="Account/Group Master Rules"
                        PostBackUrl="~/GUI/admin/AccountMasterRules/AccountingRules.aspx"></asp:LinkButton>
                </li>
            </td>
        </tr>
    </table>
</asp:Content>
