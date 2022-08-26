<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="operations1.aspx.cs" Inherits="GUI_admin_operations" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Operations</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="40%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Operation Masters</b> </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Routes</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add"
                    PostBackUrl="./RouteMaster/RouteMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./RouteMaster/RouteMasterEdSelect.aspx" />
            </td>
        </tr>
       <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">City Routes</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./City_RouteMaster/RouteMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./City_RouteMaster/RouteMasterEdSelect.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vehicles</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./VehicleMaster/VehicleMasterAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./VehicleMaster/VehicleMasterEdSelect.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vehicle Types</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./VehicleTypeMaster/VehicleTypeMasterAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./VehicleTypeMaster/VehicleTypeMasterEdit.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Transition</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="./TransitionMaster/TransitionMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="./TransitionMaster/TransitionMasterEdSelect.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton21" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Charge" PostBackUrl="ChargeMAsterTest/SuperSetCharge.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton14" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Bill Charge" PostBackUrl="ChargeMAsterTest/BillChargeMaster.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Godowns</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/admin/Godown Master/GodownMASTER.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/admin/Godown Master/GodownMASTER.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Part</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="#" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="#" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">load planner</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton13" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="load planner" PostBackUrl="./load planner/load_planner.aspx" />
            </td>
        </tr>
    </table>
</asp:Content>
