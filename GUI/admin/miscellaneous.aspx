<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="miscellaneous.aspx.cs" Inherits="GUI_admin_miscellaneous" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Miscellaneous</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="40%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Miscellaneous Masters</b> </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <font class="blackfnt">DCR Series</font>&nbsp;
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/dcr_add.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Allot" PostBackUrl="~/GUI/admin/dcr_series_to_be_alloted.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="View Alloted Series" PostBackUrl="~/GUI/admin/dcr_series_alloted.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton13" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Re-Allot" PostBackUrl="~/GUI/admin/ReDeAllocateSeries.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton14" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="De-Allot" PostBackUrl="~/GUI/admin/ReDeAllocateSeries.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Access Rights" PostBackUrl="~/GUI/admin/access_rights.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Reports Access Rights" PostBackUrl="~/GUI/admin/Reports_acessRights.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Holidays</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./Holiday/Holiday.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./Holiday/HolidayListingNew.aspx" />
            </td>
        </tr>
        <%--<tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <font class="blackfnt">Enter</font>&nbsp;
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="News" PostBackUrl="Updates/EnterNews.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Updates" PostBackUrl="Updates/EnterUpdates.aspx" />
            </td>
        </tr>--%>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <font class="blackfnt">Enter</font>&nbsp;
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="News" PostBackUrl="Updates/EnterNews.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Updates" PostBackUrl="Updates/EnterUpdates.aspx" />
                <font class="blackfnt">For Employee</font>&nbsp;
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <font class="blackfnt">Enter</font>&nbsp;
                <asp:LinkButton ID="custNews" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="News" PostBackUrl="Cust_Updates/EnterNews.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="custUPD" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Updates" PostBackUrl="Cust_Updates/EnterUpdates.aspx" />
                <font class="blackfnt">For Customer</font>&nbsp;
            </td>
        </tr>
        <tr id="tr1" runat="server" style=" display:none" bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Role Master" PostBackUrl="RoleMaster/RoleListing.aspx" />
            </td>
        </tr>
        <tr id="tr2" runat="server" style=" display:none"  bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton16" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Role Master Employee Master Intigration" PostBackUrl="~/GUI/admin/RoleMaster/ROle_EmoloyeeMaster.aspx" />
            </td>
        </tr>
        <tr id="tr3" runat="server" style=" display:none"  bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Create Auto Email Profile" PostBackUrl="AutoEmail/ProfileListing.aspx" />
            </td>
        </tr>
        <tr id="tr4" runat="server" style=" display:none"  bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Select Formats Of Auto Email" PostBackUrl="AutoEmail/ReportList.aspx" />
            </td>
        </tr>
        
    </table>
</asp:Content>
