<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FleetRelated.aspx.cs" Inherits="GUI_Fleet_Masters" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 45px">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Related</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="600">
        <tr class="bgbluegrey">
            <td align="center" colspan="3" style="width: 10%">
                <font class="blackfnt"><b>Fleet Related</b> </font>
            </td>
        </tr>
                
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Vehicles</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton55" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/VehicleMaster/VehicleMasterAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton66" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/admin/VehicleMaster/VehicleMasterEdSelect.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Driver</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton18" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./Webadmin/Driver/DriverDetVer1.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton23" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./Webadmin/Driver/DriverVer1.aspx" />
            </td>
        </tr>
     
        <tr bgcolor="#FFFFFF" runat="server" id="tr1">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Standard Charges</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton115" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteNew.aspx" />
                <font class="blackfnt">|</font>
                <%-- <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationEdit.aspx?IsRedirect=false" />--%>
                <asp:LinkButton ID="LinkButton116" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteSelectEdit.aspx" />
                <font class="blackfnt">|</font>
                <%--<asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationView.aspx" />--%>
                <asp:LinkButton ID="LinkButton135" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/Fleet/Operations/Issue/New_TripSheet_Validation/StandardExpense_FixedRouteSelectView.aspx" />
            </td>
        </tr>
      
    </table>
</asp:Content>
