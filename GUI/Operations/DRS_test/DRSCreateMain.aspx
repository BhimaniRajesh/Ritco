<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DRSCreateMain.aspx.cs" Inherits="GUI_Operations_DRS_DRSCreateMain" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_VendorTypes" runat="server" SelectCommand="usp_Vendor_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="D" Name="route_mode" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vendors" runat="server" SelectCommand="usp_Vendors"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendor_type"
                Type="string" />
            <asp:SessionParameter SessionField="brcd" Name="brcd" Type="string" />
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
    <asp:SqlDataSource ID="MySQLDataSource_Vehicle_Types" runat="server" SelectCommand="usp_Vehicle_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVehicles" DefaultValue="O" Name="vehicleno" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="MySQLDataSource_TranMode" runat="server" SelectCommand="usp_TransMode"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/DRS.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upDRSCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px" runat="server" id="tblQry" visible="true">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Create DRS:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="hBrCd" runat="server" />
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocketCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Docket Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="5" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="Docket Date :">
                        </asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboDocketDate" runat="server" AutoPostBack="false">
                            <asp:ListItem Text="--Select--" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Booking Date" Value="B"></asp:ListItem>
                            <asp:ListItem Text="Arrival Date" Value="A"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr style="background-color:White">                    
                    <td align="left">
                        <asp:HiddenField ID="hDateRange" runat="server" Value="3" />
                        <%--<asp:HiddenField ID="hDRSSelected" runat="server" />--%>
                        <%--<asp:RadioButton ID="radFromToDate" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate"" />
                        <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>&nbsp;
                        <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                        &nbsp;
                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                            id="a2">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:Label ID="lblddmmyyyy" runat="server" CssClass="blackfnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radToday" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radLastWeek" GroupName="Dates" runat="server" Text="" Checked="true"/>--%>
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radTillDate" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Docket No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Dely. At:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboDelyAt" runat="server" AutoPostBack="false">
                            <asp:ListItem Text="--Any--" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Door" Value="D"></asp:ListItem>
                            <asp:ListItem Text="Godown" Value="G"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Transition Mode:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboTranMode" runat="server" AutoPostBack="false" DataSourceID="MySQLDataSource_TranMode"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button ID="btnShowDockets" Text="Show Dockets For DRS >>" runat="server" OnClientClick="return ValidateData2()"
                            OnClick="ShowDocketsForDRS" />
                    </td>
                </tr>
            </table>


            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" id="tblNote" runat="server"  visible="false">
                <tr>
                    <td align="left">
                        <font class="redfnt"><b>Note:</b></font>
                        <asp:Label ID="lblDocDateRange" runat="server" CssClass="redfnt" Font-Bold="false">DRS <%=DocDateRange%></asp:Label>
                    </td>
                </tr>
            </table>    
            
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDRSHeader" runat="server" visible="false">
                <tr class="bgbluegrey">
                    <td align="center" colspan="6">
                        <font class="blackfnt"><b>DRS Header Information</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Manual Code:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtManCode" runat="server" Text="" Width="75" MaxLength="10"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Date:</font>
                        <asp:HiddenField runat="server" ID="hSysDate" /> 
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtDate" runat="server" MaxLength="10" Width="70" AutoPostBack="false"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDate,'a3','dd/MM/yyyy'); return false;"
                            id="a3">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                     </td>
                    <td align="left">
                        <font class="blackfnt">Location:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=mBrCd%>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Delivery By:</font>
                    </td>
                    <td align="left" colspan="2">
                        <asp:DropDownList runat="server" ID="cboVendorType" AutoPostBack="true" DataSourceID="MySQLDataSource_VendorTypes"
                            DataTextField="Vendor_Type" DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                        </asp:DropDownList>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Vendor:</font>
                    </td>
                    <td align="left" colspan="2">
                        <asp:DropDownList runat="server" ID="cboVendors" AutoPostBack="true" DataSourceID="MySQLDataSource_Vendors"
                            DataTextField="Vendor_Name" DataValueField="Vendor_Code" OnSelectedIndexChanged="OnVendorChange">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Vendor Vehicles:</font>
                    </td>
                    <td align="left" colspan="5">
                        <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" DataSourceID="MySQLDataSource_Vehicles"
                            DataTextField="DispVehicle" DataValueField="Vehno" OnSelectedIndexChanged="OnVehicleChange">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtVehicle" runat="server" MaxLength="10" Width="100" Visible="false"></asp:TextBox>
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
                    </td>
                    <td align="left">
                        <font class="blackfnt">Insurane Policy Date:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtIPDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Fitness Certificate Date:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtFCDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                    </td>
                </tr>
                
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Driver:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtDriver" runat="server" MaxLength="50" Width="300" CssClass="input"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Actual Dept. Time:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input"></asp:TextBox>
                        <font class="blackfnt">[HH:MM]</font>
                    </td>
                </tr>
                
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Start KM:</font>
                    </td>
                    <td colspan="5">
                        <asp:TextBox ID="txtStartKM" runat="server" CssClass="input" MaxLength="6" Width="50"></asp:TextBox>
                    </td>
                </tr>
            </table>



            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblDocketList" runat="server"
                width="900" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>Dockets available for DRS</b></font>
                        
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgDRS" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%"
                            DataKeyNames="DOCKNO,DOCKSF,PKGSNO,ArrPkgQty,PendPkgQty,ACTUWT,ArrWeightQty,CHRGWT,Freight,SVCTAX,DKTTOT,PayBas,TRN_MOD,DockDT,ORGNCD,DEST_CD">

                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" />
                                        <input type="hidden" name="dockdt" value='<%# DataBinder.Eval(Container.DataItem, "Bkg_Date")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sr. #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <font class="blackfnt"><%# Container.DataItemIndex + 1%></font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Docket #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKNO")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Suffix" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKSF")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Bkg. Location" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ORGNCD")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Bkg_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Pay Basis" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PAYBAS_Str")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Arrv. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Arrival_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Comm. Dely. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_Dely_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>       
                                
                                <asp:TemplateField HeaderText="Pending Pkgs." ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PendPkgQty")%>'
                                            CssClass="redfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>                        
                                
                                <asp:TemplateField HeaderText="Arrived Pkgs." ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ArrPkgQty")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>       
                                
                                <asp:TemplateField HeaderText="Booked Pkgs." ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk10" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PKGSNO")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>                                                                                          
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnCreateDRS" runat="server" Text="Proceed to Create DRS for selected Dockets >>"
                            OnClientClick="return parseDRSData()" OnClick="GenerateDRS"/>
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

