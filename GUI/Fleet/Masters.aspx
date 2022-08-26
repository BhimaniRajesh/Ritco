<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Masters.aspx.cs" Inherits="GUI_Fleet_Masters" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        function lnkbtnView_Click() {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Webadmin/FuelRateMaster/FuelRateMasterEntryReport.aspx"

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 45px">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Masters</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="600">
        <tr class="bgbluegrey">
            <td align="center" colspan="3" style="width: 10%">
                <font class="blackfnt"><b>Fleet Masters</b> </font>
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Vehicle Part</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Webadmin/VehiclePart/Part_Add.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Webadmin/VehiclePart/Part_Edit.aspx" />
            </td>
        </tr>
        <%--     <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Trip Rule Master</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton17" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="TripRuleMaster.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton18" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="TripRuleMaster.aspx" />
            </td>
        </tr>--%>
		
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
		
        <tr bgcolor="#FFFFFF" runat="server" id="trbuttons">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Validation Form</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationEdit.aspx?IsRedirect=false" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton24" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FuelSlipMaster/TripsheetValidationView.aspx" />
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Document Type Master</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton19" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Document/DocumentTypeEntry.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton20" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Document/DocumentTypeSearch.aspx" />
            </td>
        </tr>


        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Vehicle Document</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton21" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Document/DocumentEntry.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton22" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Document/DocumentEntry.aspx" />
            </td>
        </tr>
        <%-- <tr bgcolor="#ffffff">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Vehicle Document</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Webadmin/Vehicle_Doc_master/Vehicle_doc_step1.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Webadmin/Vehicle_Doc_master/Vehicle_doc_step1.aspx" />
            </td>
        </tr>--%>

        <!-- <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Driver</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/Fleet/Webadmin/Driver/DriverDet.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/Fleet/Webadmin/Driver/Driver.aspx" />
            </td>
        </tr> -->



        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Fuel Brand Master</font>
            </td>

            <td align="center" style="width: 40%">
                <a class="bluefnt" href="Webadmin/Fuel/wfrm_Fuel_Brand_Master_Add.aspx?Fuel_Brand_ID=0">Add</a>
                <font class="blackfnt">|</font>
                <a class="bluefnt" href="Webadmin/Fuel/wfrm_Fuel_Brand_Master_Edit.aspx">Edit</a>
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Fuel Card Master</font>
            </td>

            <td align="center" style="width: 40%">
                <a class="bluefnt" href="Webadmin/Fuel/wfrm_Fuel_Card_Master_Add.aspx?Fuel_Card_ID=0">Add</a>
                <font class="blackfnt">|</font>
                <a class="bluefnt" href="Webadmin/Fuel/wfrm_Fuel_Card_Master_Edit.aspx">Edit</a>
            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Trip Route Master</font>
            </td>

            <td align="center" style="width: 40%">



                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="../../GUI/Fleet/TripRouteMaster/RouteMaster.aspx?Flag=Add" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="../../GUI/Fleet/TripRouteMaster/RouteMasterCriteria.aspx?Flag=Edit" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="View" PostBackUrl="../../GUI/Fleet/TripRouteMaster/RouteMasterCriteria.aspx?Flag=View" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton15" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Download XLS" PostBackUrl="../../GUI/Fleet/TripRouteMaster/RouteMasterXls.aspx" />

            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Trip Route Expense Master (Others)</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="../../GUI/Fleet/TripRouteExpense/TripRouteExpMst.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="../../GUI/Fleet/TripRouteExpense/TripRouteExpSearch.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="View" PostBackUrl="../../GUI/Fleet/TripRouteExpense/ViewTripRouteExp.aspx" />

            </td>
        </tr>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Trip Route Expense Master - Fuel</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/Fleet/TripRouteExpense-Fuel/TripRouteExpMst.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton13" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/Fleet/TripRouteExpense-Fuel/TripRouteExpSearch.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton14" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="View" PostBackUrl="~/GUI/Fleet/TripRouteExpense-Fuel/ViewTripRouteExp.aspx" />

            </td>
        </tr>
        <%--<tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Average Diesel Rate</font>
            </td>

            <td align="center" style="width: 40%">
              <asp:LinkButton ID="LinkButton15" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add/Edit" PostBackUrl="~/GUI/Fleet/AvgDieselRate/AvgDieselRate.aspx" />
            </td>
        </tr>--%>
        <%-- <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Trip Expense Master</font>
            </td>

            <td align="center" style="width: 40%">
              <asp:LinkButton ID="LinkButton15" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add/Edit" PostBackUrl="~/GUI/Fleet/TripExpenseMst/TripExpense.aspx" />
            </td>
        </tr>--%>

        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">CheckList</font>
            </td>

            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton25" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add/Edit" PostBackUrl="~/GUI/Fleet/Operations/Issue/frmCheckListEdit.aspx" />
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="center" valign="middle" style="width: 10%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Fuel Rate Master</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="../../GUI/Fleet/Webadmin/FuelRateMaster/FuelRateMasterEntry.aspx?Flag=Add" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton16" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="../../GUI/Fleet/Webadmin/FuelRateMaster/FuelRateMasterEntry.aspx?Flag=Edit" />
                <font class="blackfnt">|</font>
                <%--<asp:LinkButton ID="LinkButton17" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="View" PostBackUrl="../../GUI/Fleet/Webadmin/FuelRateMaster/FuelRateMasterEntryReport.aspx" />--%>
                <asp:LinkButton ID="lnkbtnView" runat="server" OnClientClick="Javascript: return lnkbtnView_Click();" CssClass="bluefnt" Font-Bold="false">View</asp:LinkButton>
                <font class="blackfnt">|</font>
                <%--<asp:LinkButton ID="LinkButton18" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Download XLS" PostBackUrl="../../GUI/Fleet/Webadmin/FuelRateMaster/FuelRateMasterXls.aspx" />--%>
                <asp:LinkButton ID="LinkButton17" runat="server" OnClientClick="Javascript: return lnkbtnView_Click();" CssClass="bluefnt" Font-Bold="false">Download XLS</asp:LinkButton>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Vehicle Mapping With Fuel Card</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton26" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/VehicleMappingFuelCard/Vehicle_Mapping_FuelCard_Add.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton27" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/VehicleMappingFuelCard/Vehicle_Mapping_FuelCard_Edit.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton28" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/VehicleMappingFuelCard/Vehicle_Mapping_FuelCard_View.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Vehicle Mapping With Toll Card</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton29" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/VehicleMappingTollCard/Vehicle_Mapping_TollCard_Add.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton30" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/VehicleMappingTollCard/Vehicle_Mapping_TollCard_Edit.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton31" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/VehicleMappingTollCard/Vehicle_Mapping_TollCard_View.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%" style="width: 40%">
                <font class="blackfnt">Fixed Expense</font>
            </td>
            <td align="center" style="width: 40%">
                <asp:LinkButton ID="LinkButton32" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpense.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton33" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpense.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton34" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpenseView.aspx" />
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
		
        <%--<tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="70%">
                <font class="blackfnt">Fixed Expense</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton235" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpense.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton236" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpense.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2435" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View" PostBackUrl="~/GUI/admin/FixedExpense/FixedExpenseView.aspx" />
            </td>
        </tr>--%>
    </table>
</asp:Content>
