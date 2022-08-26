<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CPKM_Contract.aspx.cs" Inherits="GUI_admin_Vendor_contract_Ver1_CPKM_Contract" %>

<%@ Register Src="~/GUI/Common_UserControls/DatePicker1.ascx" TagName="DTP" TagPrefix="DateP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%-- <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>--%>
    <script type="text/javascript" language="javascript" src="VendorCPKM.js?V<%=DateTime.Now.Ticks.ToString() %>"></script>

    <script language="JavaScript" type="text/javascript">
        var serviceUrl = '<%=ResolveClientUrl("~/services/GSTCommonService.asmx")%>';
        var gvVehicleCPKMID = '<%=gvVehicleCPKM.ClientID%>'
        //var cal = new CalendarPopup("testdiv1");
        //cal.setCssPrefix("TEST");
        //cal.showNavigationDropdowns();


        //Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        //function EndRequestHandler(sender, args) {
        //    var cal = new CalendarPopup("testdiv1");
        //    cal.setCssPrefix("TEST");
        //    cal.showNavigationDropdowns();

        //}
    </script>


    <div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 5.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <b>Vendor Contract Step 2 : CPKM Vendors Contract</b>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td colspan="2" align="Left">
                                        <asp:Label ID="Lbl_ADD_Edit" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">Vendor Type:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField ID="hdnVendorName" runat="server" ></asp:HiddenField>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">Vendor Code & Name:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_Vendor" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;"
                                        width="190px" cellpadding="0" bgcolor="white">
                                        <tr>
                                            <td align="right">
                                                <img src="../../images/loading.gif" alt="" /></td>
                                            <td>
                                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                                        runat="server">
                                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                                            ID="Panel2" runat="server">
                                        </asp:Panel>
                                    </asp:Panel>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <br />
                            <table border="0" style="width: 8.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <b>Contract Matrix</b>
                                    </td>
                                </tr>

                                <tr bgcolor="#ffffff" runat="server" id="trADDEDIT">
                                    <td align="Left" colspan="2">
                                        <asp:GridView runat="server" CssClass="boxbg" ID="gvVehicleCPKM" AutoGenerateColumns="False" CellSpacing="1"
                                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" OnRowDataBound="gvVehicleCPKM_OnRowDataBound" OnRowCommand="gvVehicleCPKM_OnRowCommand" OnRowCreated="gvVehicleCPKM_OnRowCreated"
                                            PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                                            <Columns>
                                                <asp:TemplateField HeaderText="VenodrName">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ReadOnly="True" ID="txtVendorName" Text='<%# Eval("VendorName") %>' Width="200PX"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnContractID" Value='<%# Eval("ContractID") %>'></asp:HiddenField>

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Station">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtStation" Text='<%# Eval("Station") %>' Width="100PX" onblur="return onValidateLocationExist(this);"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnStation" Value='<%# Eval("StationID") %>'></asp:HiddenField>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="From Date">
                                                    <ItemTemplate>
                                                        <DateP:DTP ID="txtFromDate" AllowFutureDate="true" AllowPastDate="true" runat="server" ImageUrl="../../images/calendar.jpg" />
                                                        <%--<asp:TextBox runat="server" ID="txtFromDate" Text='<%# Eval("StartDate") %>' Width="170PX"></asp:TextBox>--%>
                                                        <asp:HiddenField runat="server" ID="hdnFromDate" Value='<%# Eval("StartDate") %>'></asp:HiddenField>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="To Date">
                                                    <ItemTemplate>
                                                        <DateP:DTP ID="txtToDate" AllowFutureDate="true" AllowPastDate="true" runat="server" ImageUrl="../../images/calendar.jpg" />
                                                        <%--<asp:TextBox runat="server" ID="txtToDate" Text='<%# Eval("EndDate") %>' Width="170PX"></asp:TextBox>--%>
                                                        <asp:HiddenField runat="server" ID="hdnToDate" Value='<%# Eval("EndDate") %>'></asp:HiddenField>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Base Rate">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtBaseRate" Text='<%# Eval("BaseRate") %>' Width="100PX" onkeypress="return validateFloatKeyPress(this,event);" onchange="return AmontCalculation(this);"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="GST %">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtGSTper" Text='<%# Eval("GSTPer") %>' Width="100PX" onkeypress="return validateFloatKeyPress(this,event);" onchange="return AmontCalculation(this);"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="GST Amount">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtGSTAmount" Text='<%# Eval("GStAmount") %>' Enabled="false" Width="100PX" onkeypress="return ValidAlphaNumeric(event,float);"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnGSTAmount" Value='<%# Eval("GStAmount") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Net Rate">
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="txtNetAmount" Text='<%# Eval("NetRate") %>' Enabled="false" Width="100PX" onkeypress="return ValidAlphaNumeric(event,float);"></asp:TextBox>
                                                        <asp:HiddenField runat="server" ID="hdnNetAmount" Value='<%# Eval("NetRate") %>'/>

                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="GST Credit">
                                                    <ItemTemplate>
                                                        <asp:RadioButtonList runat="server" ID="rbGSTCredit" onclick="return AmontCalculation(this);" RepeatDirection="Horizontal" Width="100PX">
                                                            <asp:ListItem Text="Yes" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="No" Value="1"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                        <asp:HiddenField runat="server" ID="hdnGSTCredit" Value='<%# Eval("GstCredit") %>'></asp:HiddenField>

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="" HeaderStyle-Width="100PX">
                                                    <ItemStyle Width="100px" />
                                                    <ItemTemplate>
                                                        <asp:LinkButton runat="server" ID="lbAdd" CommandName="Add" Visible="false" OnClientClick="return ValidRow(this);"><asp:Image runat="server" ImageUrl="~/images/png/24/button-add.png"/></asp:LinkButton>
                                                        <asp:LinkButton runat="server" ID="lbRemove" CommandName="Remove"><asp:Image runat="server" ImageUrl="~/images/png/24/button-cross.png"/></asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>



                                    </td>
                                </tr>
                                <tr class="bgbluegrey" runat="server" id="trSunmit">
                                    <td align="center" colspan="2">
                                        <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Submit Matrix Data" OnClick="Btn_Submit_Click" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff" runat="server" id="trDownload" visible="false">
                                    <td align="Left" colspan="2">
                                        <b>Vendor Contract Added Successfully </b>
                                        <asp:GridView runat="server" CssClass="boxbg" ID="gridDownload" AutoGenerateColumns="False" CellSpacing="1"
                                            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                            PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
                                            <Columns>
                                                <%--<asp:BoundField DataField="ContractID" HeaderText="Contract ID" />--%>
                                                <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code" />
                                                <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" />
                                            </Columns>
                                        </asp:GridView>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>

