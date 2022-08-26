<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="VehicleViewPrint.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleViewPrint"
    Title="Untitled Page" %>

<head runat="server">
    <script lang="javascript" type="text/javascript">
        function printme() {
            //var qs = new Querystring()
            //var mPrintMode = qs.get("PrintMode");
            //if (mPrintMode == "1") {
            //    window.print();
            //}
        }
    </script>
</head>
<body onload="printme()">

    <form id="form1" runat="server">
        <div align="left" style="width: 10in">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="300" valign="top" style="width: 907px">
                        <!--START-->
                        <table align="center" border="0" cellpadding="5" cellspacing="1" width="95%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center">
                                    <font class="blackfnt"><b>VEHICLE VIEW</b></font>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center">
                                    <font class="bluefnt"><b>Vehicle Information</b></font>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" bgcolor="#FFFFFF">
                                    <table border="0" cellspacing="0" width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <font class="blackfnt">Vehicle Type &nbsp;&nbsp;:</font>
                                            </td>
                                            <td style="width: 169px">
                                                <asp:Label ID="lblVehicleType" runat="server" Text=''  CssClass="blackfnt" ></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt">Controlling Branch</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblControllingBranch" runat="server" Text=''  CssClass="blackfnt" ></asp:Label>
                                            </td>
                                            <td class="blackfnt">Vehicle No. &nbsp; &nbsp;:
                                            </td>
                                            <td class="blackfnt">
                                                <asp:Label ID="lblVhclNo" runat="server" CssClass="blackfnt" ForeColor="#FF8080"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <span style="font-size: 8pt; font-family: Verdana">Vendor Type</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVendorType" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <span style="font-size: 8pt; font-family: Verdana">Vendor Name :</span>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVendorName" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt">Permit Type &nbsp;:
                                            </td>
                                            <td class="blackfnt">
                                                <asp:Label ID="lblPermitType" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="blackfnt" valign="top">Routes:
                                            </td>
                                            <td class="blackfnt">
                                                <asp:Label ID="lblRoutes" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt" valign="top">No. Of Drivers :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblNoOfDrivers" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt" valign="top">No of Tyres Attached with Vehicle :
                                            </td>
                                            <td>
                                                <asp:Label ID="lblNoOfTyreAttached" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center" height="18">
                                    <font class="bluefnt"><b />Other Information</font>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" bgcolor="#FFFFFF">
                                    <table border="0" cellspacing="0" width="100%" cellpadding="3">
                                        <tr>
                                            <td>
                                                <font class="blackfnt">RC Book No.</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRCBookNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt">Registration No.</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRegistrationNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt">Registration Date
                                            </td>
                                            <td>
                                                <asp:Label ID="lblRegistrationDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Registered State</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblRegisteredState" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Registered RTO</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblRegisteredRTO" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Invoice No</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblInvoiceNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="blackfnt">Vehicle Insurance
                                                                                <br />
                                                Validity Date
                                            </td>
                                            <td>
                                                <asp:Label ID="lblVehicleInsuranceValidityDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt">Fitness Certificate Date
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFitnessCertificateDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt">Date Of Attaching</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDateOfAttaching" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="blackfnt">Chasis No.
                                            </td>
                                            <td class="blackfnt">
                                                <asp:Label ID="lblChasisNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt">Engine No.
                                            </td>
                                            <td class="blackfnt">
                                                <asp:Label ID="lblEngineNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td class="blackfnt">Active Flag
                                            </td>
                                            <td>
                                                <asp:Label ID="lblActiveFlag" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <%-- ********************* 1 START ************************ --%>
                                        <tr>
                                            <td>
                                                <font class="blackfnt"> Manufacturer Year</font>
                                            </td>
                                            <td style="width: 129px">
                                                <asp:Label ID="lblManufacturerDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt"> National Permit</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblNationalPermitDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt"> 5 Year Permit</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl5YearPermitDate" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>


                                        <%-- ******************** 1 END ************************ --%>



                                        <%-- ********************* 2 START ************************ --%>
                                        <tr>
                                            <td>
                                                <font class="blackfnt"> Road Tax</font>
                                            </td>
                                            <td style="width: 129px">
                                                <asp:Label ID="lblRoadTax" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt"> Fuel Efficiency</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFuelEfficiency" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <font class="blackfnt"> Body Type</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblBodyType" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <%-- ******************** 2 END ************************ --%>


                                        <%-- ******************** 3 START ************************ --%>

                                        <tr>
                                            <td>
                                                <font class="blackfnt"> CNo./Policy No.</font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCNoPolicyNo" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td>
                                                <span style="font-size: 8pt; font-family: Verdana">Engine Type</span>
                                            </td>
                                            <td style="width: 169px">
                                                <asp:Label ID="lblEngineType" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td><font class="blackfnt"> Horse Type </font>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblHorseType" runat="server" CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Insurance Name</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblInsuranceName" runat="server" CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Manufacturer Name</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblManufacturerName" runat="server" CssClass="blackfnt" ></asp:Label>
                                            </td>
                                            <td style="height: 28px">
                                                <font class="blackfnt">Fuel Econommy</font>
                                            </td>
                                            <td style="width: 129px; height: 28px;">
                                                <asp:Label ID="lblFuelEconommy" runat="server" CssClass="blackfnt" ></asp:Label>
                                            </td>
                                        </tr>

                                        <%-- ******************** 3 END ************************ --%>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td colspan="8">
                                    <div align="center">
                                        <font class="bluefnt"><b>Inner Dimension in ft</b></font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td>
                                    <font class="blackfnt">Length&nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <asp:Label ID="lblLength" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <font class="blackfnt">Width &nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px">
                                    <asp:Label ID="lblWidth" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Height &nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <asp:Label ID="lblHeight" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td colspan="8">&nbsp;
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td colspan="8">
                                    <div align="center">
                                        <font class="bluefnt"><b>Payload Capacity as per RC in Ton</b></font>
                                    </div>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td>
                                    <font class="blackfnt">GVW&nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <asp:Label ID="lblGVW" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Unladen&nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px">
                                    <asp:Label ID="lblUnladen" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Payload &nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <asp:Label ID="lblPayload" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                                <td>
                                    <font class="blackfnt">Capacity &nbsp;&nbsp;&nbsp;:</font>
                                </td>
                                <td style="width: 129px; height: 28px;">
                                    <asp:Label ID="lblCapacity" runat="server" Text=''  CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td colspan="8">&nbsp;
                                </td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td colspan="8">
                                    <font class="blackfnt">* GVW : Gross Vehicle Weight as per RC Book
                                                                        <br />
                                                                        * Unladen Weight: Empty vehicle weight as per RC Book </font>
                                </td>
                            </tr>
                        </table>

                        <!--END-->
                    </td>
                </tr>
                <tr>
                    <td style="width: 907px">&nbsp;
                    </td>
                </tr>
                <tr>
                    <td style="width: 907px"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
