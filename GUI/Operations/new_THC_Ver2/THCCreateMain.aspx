<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCCreateMain.aspx.cs" Inherits="GUI_Operations_THC_THCCreateMain"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_Routes" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_Routes" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="usp_GeneralMaster"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="LTDEP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_RouteNames" runat="server" SelectCommand="usp_RouteNames_For_New_THC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRouteMode" DefaultValue="" Name="routemode" Type="string" />
            <asp:ControlParameter ControlID="hBrCd" DefaultValue="" Name="brcd" Type="string" />        
<%--            <asp:SessionParameter SessionField="brcd" Name="brcd" DefaultValue="" Type="string" />
--%>        </SelectParameters>
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
            <asp:ControlParameter ControlID="hBrCd" DefaultValue="" Name="brcd" Type="string" />        
<%--            <asp:SessionParameter Name="brcd" Type="string" SessionField="brcd" />
--%>        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vehicle_Types" runat="server" SelectCommand="usp_Vehicle_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVehicles" DefaultValue="O" Name="vehicleno" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vehicles" runat="server" SelectCommand="usp_Vendor_Vehicles"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendortype"
                Type="string" />
        </SelectParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendors" DefaultValue="" Name="vendorcode" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_TS" runat="server" SelectCommand="usp_TripSheetListForTHC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVehicles" DefaultValue="" Name="VehicleNo" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_MFAvailable" runat="server" SelectCommand="usp_MF_Available_For_New_THC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboRouteName" DefaultValue="" Name="routename" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_TDSAccCode" runat="server" SelectCommand="SELECT accdesc+':'+Company_acccode as dispval,accdesc,acccode FROM webx_acctinfo WHERE acccode='CLA0015'"
        SelectCommandType="Text"></asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/thc.js?v4" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left" width="75%">
                    
                                                           <%-- <asp:TextBox Width="70px" Style="text-align: left;" ID="TextBox1" onblur="javascript:return balPayAtBlur(this.value)"
                                                                runat="server"></asp:TextBox>--%>
                                                    
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Prepare New THC</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="hBrCd" runat="server" />
                        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMain" runat="server"
                width="1000">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <font class="blackfnt"><b>Select Criteria For Preparing New THC</b></font>
                    </td>
                </tr>
                <!--Row 1-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Manual THC #:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtManualTHCNo" runat="server" MaxLength="25" Width="90" Text="NA" onchange="javascript:return CheckManualDocNo()"></asp:TextBox>
                        <font class="bluefnt">("NA" if Not Applicable)</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">THC/Actual Dept. Date &amp; Time:</font>
                    </td>
                    <td align="left">
                        <asp:HiddenField runat="server" ID="hSysDate" /> 
                        <asp:TextBox ID="txtTHCDate" runat="server" CssClass="input" MaxLength="10" Width="70"></asp:TextBox>
                        <%--OnTextChanged="OnTHCDateChange" AutoPostBack="true"--%>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTHCDate,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <%--<asp:RequiredFieldValidator ID="RFVtxtTHCDate" runat="server" ErrorMessage="*" SetFocusOnError="true" ControlToValidate="txtTHCDate"  ValidationGroup="grpShowMF" ToolTip="THC Date is required"></asp:RequiredFieldValidator>--%>
                        <%--<asp:RegularExpressionValidator ValidationGroup="grpShowMF" ID="REVtxtTHCDate" runat="server" ErrorMessage="!"
                            ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtTHCDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>--%>
                        <font class="blackfnt">[dd/mm/yyyy]</font>
                        <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input"></asp:TextBox>
                        <font class="blackfnt">[HH:MM]</font>
                        <%--<asp:RegularExpressionValidator ValidationGroup="grpShowMF" SetFocusOnError="true" ID="REVtxtHHMM" runat="server" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ErrorMessage="!" ToolTip="Time in HH:MM format" ControlToValidate="txtHHMM"></asp:RegularExpressionValidator>--%>
                        <%--<asp:RequiredFieldValidator ValidationGroup="grpShowMF"  SetFocusOnError="true"  ControlToValidate="txtHHMM" ID="RFVtxtHHMM" runat="server" ErrorMessage="*" ToolTip="Enter Act. Dept. Time"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>
                <%--                <!--Row 2-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vehicle Tracking No.:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="redfnt">&lt; System Generated &gt;</font>
                    </td>
                </tr>
--%>
                <!--Row 3-->
                <%--                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Manual THC #:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtManualTHCNo1" runat="server" MaxLength="25" Width="90"></asp:TextBox>
                        <font class="bluefnt">("NA" if Not Applicable)</font>
                    </td>
                </tr>
--%>
                <!--Row 4-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Route Mode:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboRouteMode" AutoPostBack="True" DataSourceID="MySQLDataSource_Routes"
                            DataTextField="CodeDesc" DataValueField="CodeID" OnSelectedIndexChanged="OnRouteModeChange">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ID="RFVcboRouteMode" ValidationGroup="grpShowMF"
                            ControlToValidate="cboRouteMode" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Route Name:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboRouteName" EnableViewState="true" AutoPostBack="true"
                            DataSourceID="MySQLDataSource_RouteNames" DataTextField="MyRouteName" DataValueField="MyRouteName"
                            OnSelectedIndexChanged="OnRouteNameChange">
                        </asp:DropDownList>
                        <%--<asp:RequiredFieldValidator runat="server" ID="RFVcboRouteName" ValidationGroup="grpShowMF" ControlToValidate="cboRouteName" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                        <%--                        <font class="blackfnt">&nbsp;&nbsp;&nbsp;</font>
                        <asp:Button ID="btnShowMFs" ValidationGroup="grpShowMF" runat="server" Text="Show MF List" OnClick="ShowMFListForNewTHC" />
--%>
                    </td>
                </tr>
                <!--Row 5-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vendor Type :</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboVendorType" AutoPostBack="true" DataSourceID="MySQLDataSource_VendorTypes"
                            DataTextField="Vendor_Type" DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                        </asp:DropDownList>
                        <%--<asp:RequiredFieldValidator ValidationGroup="grpShowMF" ControlToValidate="cboVendorType" ID="RFVcboVendorType" runat="server" ErrorMessage="*" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Vendor Name:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList runat="server" ID="cboVendors" AutoPostBack="true" DataSourceID="MySQLDataSource_Vendors"
                            DataTextField="Vendor_Name" DataValueField="Vendor_Code" OnSelectedIndexChanged="OnVendorChange">
                        </asp:DropDownList>
                        <%--<asp:RequiredFieldValidator ValidationGroup="grpShowMF" ID="RFVcboVendors" ControlToValidate="cboVendors"  runat="server" ErrorMessage="*" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
                        <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" Visible="false"></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ValidationGroup="grpShowMF" ID="RFVtxtMarketVendor" ControlToValidate="txtMarketVendor"  runat="server" ErrorMessage="*" SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
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
                                    <asp:TextBox ID="txtAirlineName" runat="server" Width="200" MaxLength="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Flight No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFlightNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Airway Bill No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtAirwayBillNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
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
                                    <asp:TextBox ID="txtTrainName" runat="server" Width="200" MaxLength="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Train No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtTrainNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">RR No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRRNo" runat="server" Width="75" MaxLength="25"></asp:TextBox>
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
                                    <font class="blackfnt">Vehicle #:</font>
                                </td>
                                <td align="left">
                                    <%--                                    <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" DataSourceID="MySQLDataSource_Vehicles"
                                        DataTextField="DispVehicle" DataValueField="Vehno" OnSelectedIndexChanged="OnVehicleChange">
                                    </asp:DropDownList>
--%>
                                    <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" OnSelectedIndexChanged="OnVehicleChange">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtMktVeh" runat="server" Width="200" MaxLength="10"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Vehicle Type:</font>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:DropDownList runat="server" ID="cboVehicleTypes" AutoPostBack="false" DataSourceID="MySQLDataSource_Vehicle_Types"
                                        DataTextField="Type_Name" DataValueField="TypeCode">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: White" id="trTS" runat="server" visible="false">
                                <td align="left">
                                    <font class="blackfnt">Tripsheet #:</font>
                                </td>
                                <td align="left" colspan="5">
                                    <asp:DropDownList runat="server" ID="cboTripSheet" AutoPostBack="true" DataSourceID="MySQLDataSource_TS"
                                        DataTextField="VSlipNo" DataValueField="CodeSlipNo" OnSelectedIndexChanged="OnTSChange">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Engine No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEngineNo" CssClass="input" runat="server" MaxLength="20" Width="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Chasis No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtChasisNo" CssClass="input" runat="server" MaxLength="20" Width="100"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">RC Book No.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRCBookNo" CssClass="input" runat="server" MaxLength="20" Width="100"></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Vehicle Regn Date.:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtVRDate" CssClass="input" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtVRDate,'a2','dd/MM/yyyy'); return false;"
                                        id="a2">
                                        <img src="./../../images/calendar.jpg" border="0" />
                                    </a>
                                    <asp:RegularExpressionValidator ValidationGroup="grpShowMF" ID="REVtxtVRDate" runat="server"
                                        ErrorMessage="!" ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtVRDate"
                                        ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Insurane Policy Date:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIPDate" CssClass="input" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtIPDate,'a3','dd/MM/yyyy'); return false;"
                                        id="a3">
                                        <img src="./../../images/calendar.jpg" border="0" />
                                    </a>
                                    <asp:RegularExpressionValidator ValidationGroup="grpShowMF" ID="REVtxtIPDate" runat="server"
                                        ErrorMessage="!" ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtIPDate"
                                        ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Fitness Certificate Date:</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtFCDate" CssClass="input" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFCDate,'a4','dd/MM/yyyy'); return false;"
                                        id="a4">
                                        <img src="./../../images/calendar.jpg" border="0" />
                                    </a>
                                    <asp:RegularExpressionValidator ValidationGroup="grpShowMF" ID="REVtxtFCDate" runat="server"
                                        ErrorMessage="!" ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtFCDate"
                                        ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
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
                                <td align="left" colspan="2">
                                    <font class="blackfnt">Driver Name</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Licence #</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Issue By RTO</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Licence Validity Date</font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Driver 1</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtDriver1" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLicence1" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIssuedBy1" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLVDate1" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtLVDate1,'a5','dd/MM/yyyy'); return false;"
                                        id="a5">
                                        <img src="./../../images/calendar.jpg" border="0" />
                                    </a>
                                    <asp:RegularExpressionValidator ID="REVLVDate1" runat="server" ErrorMessage="!" ToolTip="Date Format dd/MM/yyyy"
                                        ControlToValidate="txtLVDate1" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Driver 2</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtDriver2" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLicence2" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtIssuedBy2" runat="server" MaxLength="20" Width="80"></asp:TextBox>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtLVDate2" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtLVDate2,'a5','dd/MM/yyyy'); return false;"
                                        id="a6">
                                        <img src="./../../images/calendar.jpg" border="0" />
                                    </a>
                                    <asp:RegularExpressionValidator ID="REVLVDate2" runat="server" ErrorMessage="!" ToolTip="Date Format dd/MM/yyyy"
                                        ControlToValidate="txtLVDate2" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Out Veh. Free Space:</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtOVFS" runat="server" CssClass="input" Width="30" MaxLength="3">
                                    </asp:TextBox>
                                    <font class="blackfnt">%</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Seal No.:</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtSealNo" runat="server" CssClass="input" Width="100" MaxLength="10">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!--Row 8-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Sch. Dept. Time:</font>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblSchdDeptTime" runat="server" Text="" CssClass="bluefnt"></asp:Label>
                        <font class="blackfnt">[HH:MM]</font>
                        <asp:HiddenField ID="hSchdDeptTime" runat="server" />
                    </td>
                    <td align="left">
                        <font class="blackfnt">Late Dept. Reason [if any]:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboLateDeptReason" runat="server" DataSourceID="MySQLDataSource_GeneralMaster"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--                <!--Row 9-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Act. Dept. Date/Time:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
--%>
                <%--                <!--Row 10-->
                <tr style="background-color: White">
                </tr>
--%>
                <!--Row 11-->
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Loading Supervisor/Emp Code:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtLoadSupCode" CssClass="input" runat="server" Width="100" MaxLength="50"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Outgoing Remarks:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtOutRemarks" CssClass="input" TextMode="MultiLine" runat="server"
                            Rows="2" Width="150"></asp:TextBox>
                    </td>
                </tr>
                <!--Row 12-->
                <%--                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Financial Completion At:</font>
                    </td>
                    <td align="left" colspan="3">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>
                <!--Row 13-->
--%>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Starting KMs.:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtStartKM" runat="server" CssClass="input" Width="50" MaxLength="6">
                        </asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblTHCwoMF" runat="server"
                visible="false" width="1000">
                <tr style="background-color: White">
                    <td align="left">
                        <%--                        <asp:CheckBox ID="chkNoMF" runat="server" Text="I want to generate THC without MF" CssClass="redfnt" Font-Bold="true"/>
--%>
                        <input type="CheckBox" name="chkNoMF"  onclick="ConfirmNoMF(this)">
                        <font class="redfnt"><b>I want to generate THC without MF</b></font>
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMFList" runat="server"
                width="1000" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>MFs available for New THC/Journey</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgMFs" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataSourceID="MySQLDataSource_MFAvailable"
                            DataKeyNames="TCNO,TOT_DKT,TOT_LOAD_PKGS,TOT_LOAD_ACTWT">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMF" EnableViewState="true" Text="" />
                                        <%--                                        AutoPostBack="true" OnCheckedChanged="PopulateContractAmt"/>
--%>
                                        <%--                                        <asp:TextBox runat="server" ID="tcdt" Text='<%# DataBinder.Eval(Container.DataItem, "tcdt_ddmmyyyy")%>'></asp:TextBox>
--%>
                                        <input type="hidden" name="tcdt" value='<%# DataBinder.Eval(Container.DataItem, "tcdt_ddmmyyyy")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TCNO" HeaderText="Sys. MF #" ReadOnly="True" />
                                <asp:BoundField DataField="Manual" HeaderText="Manual MF #" ReadOnly="True" />
                                <asp:BoundField DataField="TCBR" HeaderText="MF Br." ReadOnly="True" />
                                <asp:BoundField DataField="TC_Date" HeaderText="MF Date" ReadOnly="True" />
                                <asp:BoundField DataField="ToBH_CODE" HeaderText="Next Stop" ReadOnly="True" />
                                <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dkts." ReadOnly="True" />
                                <asp:BoundField DataField="Packages" HeaderText="Pkgs L/B" ReadOnly="True" />
                                <asp:BoundField DataField="Weight" HeaderText="Wt. L/B" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnConfirmOpData" runat="server" ValidationGroup="grpShowMF" Text="Confirm THC Operational Data >>"
                            OnClientClick="return ValidateData()" OnClick="ConfirmOpData" />
                    </td>
                </tr>
                <!--Payment Section-->
                <tr style="background-color: White" id="trPaymentDetails_Own" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" colspan="4">
                                    <font class="blackfnt"><b>Payment Details</b></font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left">
                                    <font class="blackfnt">Standard Contract Amount</font>
                                </td>
                                <td align="left">
                                    <asp:Label Width="70px" Style="text-align: left;" Text="0.00" CssClass="bluefnt"
                                        ID="lblStdContractAmountOWN" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">Contract Amount</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="txtContractAmountOWN"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: White" id="trPaymentDetails" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <table cellpadding="3" cellspacing="1" width="100%" border="0" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" colspan="6">
                                    <font class="blackfnt"><b>Payment Details</b></font>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td align="left" colspan="6">
                                    <table width="800px">
                                        <tr>
                                            <td>
                                                <table cellspacing="1" class="boxbg" style="width: 100%;">
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Standard Contract Amout</td>
                                                        <td align="left">
                                                            <asp:Label Width="70px" Style="text-align: right;" Text="0.00" CssClass="bluefnt"
                                                                ID="stdpcamt" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Contract Amount (+)</td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="contractamt" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Telephone Chargtes
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="tel_chrg" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Hamali
                                                            <asp:DropDownList ID="loadOpertype" runat="server" onblur="javascript:fbalamt();">
                                                                <asp:ListItem Value="P">(+)</asp:ListItem>
                                                                <asp:ListItem Value="M">(-)</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" ID="load_chrg" Text="0.00" onblur="javascript:fbalamt();"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Mamul (-)
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="mamul_chrg" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            TDS Rate (%)</td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="tds_rate" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            TDS Amount (-)</td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="tds_chrg" runat="server" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Service Tax Rate (%)</td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="svtax_rate" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Service Tax (+)
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="svrcamt" runat="server" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Cess (+)
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="cessamt" onblur="javascript:fbalamt();"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Higher Cess (+)
                                                        </td>
                                                        <td align="left">
                                                            <asp:HiddenField Value="0" ID="txtcwt" runat="server" />
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" ID="hcessamt" onblur="javascript:fbalamt();"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td valign="top">
                                                <table cellspacing="1" class="boxbg" style="width: 100%;">
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            TDS Type
                                                        </td>
                                                        <td align="left">
                                                            <asp:HiddenField Value="0" ID="txtheight" runat="server" />
                                                            <asp:HiddenField Value="0" ID="txtdetentionchg" runat="server" />
                                                            <asp:HiddenField Value="0" ID="txtmultipt" runat="server" />
                                                            <asp:DropDownList ID="tdsacccode" runat="server" DataSourceID="MySQLDataSource_TDSAccCode"
                                                                DataTextField="dispval" DataValueField="acccode">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Party PAN Number
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: left;" onblur="javascript:return validpanno(this);"
                                                                ID="pan_no" runat="server"></asp:TextBox>
                                                            <asp:HiddenField Value="0" ID="advanceamt_paid" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Advance Amount</td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: right;" Text="0.00" onblur="javascript:fbalamt();"
                                                                ID="advanceamt" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            Advance Amount Paid By
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: left;" onblur="javascript:fbalamt();this.value=this.value.toUpperCase();"
                                                                ID="advpaidby" runat="server"></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="netpayamt" Value="0" />
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            <b>Balance Amount</b>
                                                        </td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Enabled="false" Style="text-align: right;" ID="balamt"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt" bgcolor="#ffffff">
                                                        <td align="left">
                                                            <b>Balance Payable At</b></td>
                                                        <td align="left">
                                                            <asp:TextBox Width="70px" Style="text-align: left;" ID="balamtbr" onblur="javascript:return balPayAtBlur(this.value)"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="background-color: White" id="trSubmit" runat="server" visible="false">
                    <td align="left" colspan="4" valign="top">
                        <asp:Button ID="btnGenerateTHC" runat="server" Text="Generate THC" OnClientClick="return GenerateTHC(this)"
                            OnClick="GenerateTHC" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>
