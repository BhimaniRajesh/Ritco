<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCCreateMain.aspx.cs" Inherits="GUI_Operations_THC_THCCreateMain"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_Routes" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_Routes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_RouteNames" runat="server" SelectCommand="usp_RouteNames_For_New_THC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRouteMode" DefaultValue="" Name="routemode" Type="string" />
            <asp:SessionParameter SessionField="brcd" Name="brcd" DefaultValue="" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_VendorTypes" runat="server" SelectCommand="usp_Vendor_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRouteMode" DefaultValue="" Name="route_mode"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vendors" runat="server" SelectCommand="usp_Vendors"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendor_type"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vehicle_Types" runat="server" SelectCommand="usp_Vehicle_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVehicles" DefaultValue="O" Name="vehicleno"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MySQLDataSource_Vehicles" runat="server" SelectCommand="usp_Vendor_Vehicles"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendortype"
                Type="string" />
        </SelectParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendors" DefaultValue="" Name="vendorcode"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MySQLDataSource_MFAvailable" runat="server" SelectCommand="usp_MF_Available_For_New_THC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRouteName" DefaultValue="" Name="routename"
                Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
        
        
    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Prepare New THC</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMain" runat="server"
                width="800">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <font class="blackfnt"><b>Select Criteria For Preparing New THC</b></font>
                    </td>
                </tr>
                <!--Row 1-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">THC No.:</font>
                    </td>
                    <td align="left">
                        <font class="redfnt">&lt; System Generated &gt;</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">THC Date.:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtTHCDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="REVtxtTHCDate" runat="server" ErrorMessage="!"
                            ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtTHCDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <!--Row 2-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vehicle Tracking No.:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="redfnt">&lt; System Generated &gt;</font>
                    </td>
                </tr>
                <!--Row 3-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Manual THC No.:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtManualTHCNo" runat="server" MaxLength="25" Width="90"></asp:TextBox>
                        <font class="bluefnt">("NA" if Not Applicable)</font>
                    </td>
                </tr>
                <!--Row 4-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Route Mode:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboRouteMode" AutoPostBack="True" DataSourceID="MySQLDataSource_Routes"
                            DataTextField="CodeDesc" DataValueField="CodeID" OnSelectedIndexChanged="OnRouteModeChange">
                        </asp:DropDownList>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Route Name:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboRouteName" AutoPostBack="true" DataSourceID="MySQLDataSource_RouteNames"
                            DataTextField="MyRouteName" DataValueField="MyRouteName" OnSelectedIndexChanged="OnRouteNameChange">
                        </asp:DropDownList>
                    </td>
                </tr>
                <!--Row 5-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vendor Type:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboVendorType" AutoPostBack="true" DataSourceID="MySQLDataSource_VendorTypes"
                            DataTextField="Vendor_Type" DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                        </asp:DropDownList>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Vendor Name:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboVendors" AutoPostBack="true" DataSourceID="MySQLDataSource_Vendors"
                            DataTextField="Vendor_Name" DataValueField="Vendor_Code">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <!--Row 6-->
                <tr style="background-color: White" id="trCities" runat="server" visible="true">
                    <td align="left">
                        <font class="blackfnt">Destination City:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtCities" runat="server" MaxLength="250" Width="350"></asp:TextBox>
                        <font class="blackfnt">&nbsp;</font> <font class="bluefnt">(Seperated by Comma "," if
                            multiple)</font>
                    </td>
                </tr>
                <!--Row 7.1 (Air)-->
                <tr style="background-color: White" id="trForRouteModeA" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" colspan="6">
                                    <font class="blackfnt"><b>Flight Information</b></font>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="blackfnt">Airline Name:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Flight No.:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Airway Bill No.:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!--Row 7.2 (Rail/Train)-->
                <tr style="background-color: White" id="trForRouteModeR" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" colspan="6">
                                    <font class="blackfnt"><b>Train Information</b></font>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <font class="blackfnt">Train Name:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Train No.:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">RR No.:</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!--Row 7.3 (Road)-->
                <tr style="background-color: White" id="trForRouteModeS" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" colspan="6">
                                    <font class="blackfnt"><b>Vehicle Information</b></font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Vehicle No.:</font>
                                </td>
                                <td align="left" colspan="5">
                                    <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" DataSourceID="MySQLDataSource_Vehicles"
                                        DataTextField="DispVehicle" DataValueField="Vehno">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Vehicle Type:</font>
                                </td>
                                <td align="left" colspan="5">
                                    <asp:DropDownList runat="server" ID="cboVehicleTypes" AutoPostBack="false" DataSourceID="MySQLDataSource_Vehicle_Types"
                                        DataTextField="Type_Name" DataValueField="TypeCode">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Engine No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEngineNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Chasis No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtChasisNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">RC Book No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRCBookNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Vehicle Regn Date.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtVRDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="REVtxtVRDate" runat="server" ErrorMessage="!"
                                        ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtVRDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Insurane Policy Date:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIPDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="REVtxtIPDate" runat="server" ErrorMessage="!"
                                        ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtIPDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Fitness Certificate Date:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFCDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="REVtxtFCDate" runat="server" ErrorMessage="!"
                                        ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtFCDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left" colspan="6">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left" colspan="3">
                                    <font class="blackfnt">Driver 1</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">Driver 2</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Driver Name:</font>
                                </td>
                                <td align="left" colspan="3">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Licence No.:</font>
                                </td>
                                <td align="left" colspan="3">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Issue By RTO:</font>
                                </td>
                                <td align="left" colspan="3">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Licence Validity Date.:</font>
                                </td>
                                <td align="left" colspan="3">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Out Veh. Free Space:</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Seal No.:</font>
                                </td>
                                <td align="left" colspan="2">
                                    <font class="blackfnt">&nbsp;</font>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!--Row 8-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Sch. Dept. Date/Time:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 9-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Act. Dept. Date/Time:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 10-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Late Dept. Reason [if any]:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 11-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Loading Supervisor/Emp Code:</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Outgoing Remarks:</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 12-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Financial Completion At:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 13-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Starting KMs.:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
            </table>
            
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMFList" runat="server" width="800" visible="false">
                <tr style="background-color:White">
                    <td align="center">
                        <font class="blackfnt"><b>MFs available for New THC/Journey</b></font>
                    </td>
                </tr>
                
                <tr style="background-color:White">
                    <td align="left">
                        <asp:GridView ID="dgMFs" runat="server" CellSpacing="1"
                            CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataSourceID="MySQLDataSource_MFAvailable">
                            
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkMF" EnableViewState="true" Text="" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        
                            <asp:BoundField DataField="TCNO" HeaderText="Sys. MF #" ReadOnly="True"/>
                            <asp:BoundField DataField="Manual" HeaderText="Manual MF #" ReadOnly="True"/>
                            <asp:BoundField DataField="TCBR" HeaderText="MF Br." ReadOnly="True" />
                            <asp:BoundField DataField="TC_Date" HeaderText="MF Date" ReadOnly="True" />
                            <asp:BoundField DataField="ToBH_CODE" HeaderText="Next Stop" ReadOnly="True" />
                            <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dkts." ReadOnly="True" />
                            <asp:BoundField DataField="Packages" HeaderText="Pkgs L/B" ReadOnly="True"/>
                            <asp:BoundField DataField="Weight" HeaderText="Wt. L/B" ReadOnly="True"/>
                        </Columns>

                        
                        </asp:GridView>                
                    </td>
                </tr>
            </table>
            
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
