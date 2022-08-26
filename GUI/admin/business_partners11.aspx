<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="business_partners.aspx.cs" Inherits="GUI_admin_business_partners" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Company Structure</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="40%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Business Partners Masters</b> </font>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Customers</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./CustomerMaster/CustomerMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./CustomerMaster/CustomerMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="lnkDownloadXls" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Download XLS" PostBackUrl="./CustomerMaster/ListAll.aspx" />
            </td>
            
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Customer Groups</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./CustomerGroupMaster/CustomerGroupMasterAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./CustomerGroupMaster/CustomerGroupMasterEdit.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vendors</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./Vendor/VendorMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./Vendor/VendorMasterEdit.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Download XLS" PostBackUrl="./Vendor/ListAll.aspx" />
            </td>
        </tr>
    </table>

</asp:Content>

