<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelCardProcess.aspx.cs" Inherits="GUI_admin_FuelCardProcess_FuelCardProcess" %>

<%@ Register Src="~/GUI/Common_UserControls/DatePicker1.ascx" TagName="DTP" TagPrefix="DateP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <script src="../../images/commonJs.js" type="text/javascript"></script>


    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        var serviceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';

        var CurrentUser = '<%= SessionUtilities.CurrentEmployeeID %>';

        var gvVehicleCPKMID = '<%=gvVehicleCPKM.ClientID%>';



    </script>
    <script type="text/javascript">
        function RefreshIt(selectObj) {
            __doPostBack('<%= Page.ClientID %>', selectObj.name);
        }
    </script>
    <script src="JS/FuelCardProcessV1.js?V=<%=System.DateTime.Now.Ticks %>" type="text/javascript"></script>

    <div style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Fuel Card Process </u></b></a>&gt; <b><u>Fuel Card Process </u></b></font>
                    <td>
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>Fuel Card Process</b></font>
                </td>
            </tr>
        </table>
        <hr />
        <br />
        <br />
        <%--<table border="1" width="100%" runat="server" id="tblMain">
            <tr class="hrow">

                <td>
                    <font class="blackfnt"><b>System Date</b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Vehicle No.<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Tripsheet No.<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Tripsheet Date</b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Fuel Card no.</b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Fuel Type<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>City<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Swapping Date<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Transaction ID<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>QTY (Ltr)<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Rate (Ltr)<font class="redfnt">*</font></b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Amount</b></font>
                </td>
                <td>
                    <font class="blackfnt"><b>Remarks<font class="redfnt">*</font></b></font>
                </td>
                <td></td>
            </tr>
            <tr>
                <td align="left">
                    <%=System.DateTime.Now.ToString("dd/MM/yyyy") %>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtVehicleNo" onblur="return Bindtripsheet()"></asp:TextBox>
                    <asp:HiddenField ID="hdnVehicleNo" runat="server" />
                </td>
                <td align="left">
                    <select id="ddlTripsheetNo" onchange="GetTripSheetDetail()">
                        <option value="0">--Select TripsheetNo--</option>
                    </select>
                    <asp:HiddenField ID="hdnTripSheetNo" runat="server" />
                </td>
                <td align="left">
                    <asp:Label Text="" runat="server" ID="lblTripSheetDate" Width="150" />
                </td>
                <td align="left">
                    <asp:Label Text="" runat="server" ID="lblFuelCardNo" Width="100" />
                </td>
                <td align="left">
                    <asp:DropDownList runat="server" ID="ddlFuelType">
                        <asp:ListItem Text="Diesel" Value="Diesel" Selected="True" />
                        <asp:ListItem Text="Add Blue" Value="AddBlue" />
                        <asp:ListItem Text="CNG" Value="CNG" />
                    </asp:DropDownList>

                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtCity"></asp:TextBox>
                    <asp:HiddenField ID="hdnCity" runat="server" />
                </td>
                <td align="left">
                    <asp:TextBox ID="txtSwappingDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtSwappingDate, 'CaltxtSwappingDate', 'dd/MM/yyyy'); return false;"
                        id="CaltxtSwappingDate">
                        <img src="../../images/calendar.jpg" border="0" alt="" />
                    </a>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtTransactionId"></asp:TextBox>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtQTY" Text="0.00" onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount();"></asp:TextBox>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtRate" Text="0.00" onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount();"></asp:TextBox>
                </td>
                <td align="left">
                    <asp:Label Text="" runat="server" ID="lblAmount" />
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtRemarks" MaxLength="400" onpaste="return false"></asp:TextBox>
                </td>
                <td><a id="aAdd_1" onclick="AddRow(this.id)">
                    <img src="../../../../images/png/24/button-add.png" /></a><a id="aRemove_1" onclick="RemoveRow(this.id)"><img src="../../../../images/png/24/button-cross.png" /></a></td>
            </tr>
            -
            <tr align="center" class="hrow">
                <td colspan="13">


                    <input type="button" value="Submit" class="btn btn-primary" id="btnSubmit" onclick="javascript: SubmitClick();" />
                </td>
            </tr>
        </table>--%>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
    <UserControl:ProgressBar runat="server" ID="ProgressBar" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <table>


                <tr>
                    <td>
                        <asp:GridView runat="server" CssClass="boxbg" ID="gvVehicleCPKM" AutoGenerateColumns="False" CellSpacing="1"
                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" OnRowDataBound="gvVehicleCPKM_OnRowDataBound" OnRowCommand="gvVehicleCPKM_OnRowCommand" OnRowCreated="gvVehicleCPKM_OnRowCreated"
                            PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle No">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtVehicleNo" AutoPostBack="True" Text='<%# Eval("VehicleNo") %>'
                                            CssClass="blackfnt ltxt" OnTextChanged="txtVehicleNo_OnTextChanged" onblur="javascript:RefreshIt(this);"></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnVehicleNo" Value='<%# Eval("VehicleNo") %>' />
                                        <asp:HiddenField runat="server" ID="hdnExist" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tripsheet No">
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlTripsheet" onchange="GetTripSheetDetail(this)">
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnTripsheetNo" Value='<%# Eval("TripsheetNo") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tripsheet Date ">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblTripsheetDate" Text='<%# Eval("TripsheetDate") %>' Width="100" />
                                        <asp:HiddenField runat="server" ID="hdnTripsheetDate" Value='<%# Eval("TripsheetDate") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FuelWallet">
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" AutoPostBack="true" ID="ddlFuelWallet" OnSelectedIndexChanged="ddlFuelWallet_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnFuelWallet" Value='<%# Eval("FuelAccCode") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fuel Card no.">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblFuelCardNo" Text='<%# Eval("FuelCardNo") %>' Width="100" />
                                        <asp:HiddenField runat="server" ID="hdnFuelCardNo" Value='<%# Eval("FuelCardNo") %>' />

                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fuel Type">
                                    <ItemTemplate>
                                        <asp:DropDownList runat="server" ID="ddlFuelType">
                                            <asp:ListItem Text="Diesel" Value="Diesel" Selected="True" />
                                            <asp:ListItem Text="Add Blue" Value="AddBlue" />
                                            <asp:ListItem Text="CNG" Value="CNG" />
                                        </asp:DropDownList>
                                        <asp:HiddenField runat="server" ID="hdnFuelType" Value='<%# Eval("FuelType") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtCity" Text='<%# Eval("City") %>' onblur="return CheckCity(this);" ></asp:TextBox>
                                        <asp:HiddenField ID="hdnCity" runat="server" Value='<%# Eval("CityID") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Swapping Date ">
                                    <ItemTemplate>
                                        <DateP:DTP runat="server" ID="txtCPKMDate" AllowFutureDate="True" AllowPastDate="True" Text='<%# Eval("SwappingDate") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Transaction ID">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtTransactionID" Text='<%# Eval("TransactionID") %>' Width="100PX" CssClass="blackfnt ltxt " onkeypress="return validFloat(event,this.id)"></asp:TextBox>

                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="QTY (Ltr)">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtQty" Text='<%# Eval("Qty") %>' Width="100PX" CssClass="blackfnt ltxt " onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount(this);"></asp:TextBox>

                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Rate (Ltr)">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtRate" Text='<%# Eval("Rate") %>' Width="100PX" CssClass="blackfnt ltxt " onkeypress="javascript:return validFloat(event,this.id);" onchange="javascript: CalculateAmount(this);"></asp:TextBox>

                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtAmount" ReadOnly="True" Text='<%# Eval("Amount") %>' Width="100PX" CssClass="blackfnt ltxt "></asp:TextBox>
                                        <asp:HiddenField ID="hdnAmount" runat="server" Value='<%# Eval("Amount") %>' />

                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtReamrks" Text='<%# Eval("Reamrks") %>' Width="100PX" CssClass="blackfnt ltxt "></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="" HeaderStyle-Width="10%">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="lbAdd" CommandName="Add" Visible="false"><asp:Image runat="server" ImageUrl="~/images/png/24/button-add.png"/></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="lbRemove" CommandName="Remove"><asp:Image runat="server" ImageUrl="~/images/png/24/button-cross.png"/></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btnSubmit" Text="Submit" OnClick="btnSubmit_OnClick" OnClientClick="javascript: Validate();" ></asp:Button>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

