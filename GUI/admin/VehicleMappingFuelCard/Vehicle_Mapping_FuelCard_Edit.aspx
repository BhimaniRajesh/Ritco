<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Vehicle_Mapping_FuelCard_Edit.aspx.cs" Inherits="GUI_admin_VehicleMappingFuelCard_Vehicle_Mapping_FuelCard_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript">
        var ServiceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
        $(document).ready(function () {
            InitializedAutocomplete();

            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function EndRequestHandler(sender, args) {
                InitializedAutocomplete();
            }

        });

        function InitializedAutocomplete() {
            var txtVehicleNo = '#<%= txtVehicleNo.ClientID%>';
            var hdnVehicleNo = '<%= hdnVehicleNo.ClientID%>';
            try {
                AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle No", []);
            } catch (e) {
                //alert(e);
            }
        }
        function Confirmation() {
            if (confirm("Are you sure to submit this details")) {
                return true;
            }
            return false;
        }
        function ValidRow(e) {
            var CurrentRow = $(e).closest('tr');
            var txtCardNo = $(e).closest('tr').find('input[id*="txtCardNo"]');
            var ddlFuelWallet = $(e).closest('tr').find('input[id*="ddlFuelWallet"]');
            if (txtCardNo.val() == '') {
                alert("Please enter card no !");
                txtCardNo.focus();
                return false;
            }
            else if (ddlFuelWallet.val() == '') {
                alert("Please select fuel wallet !");
                ddlFuelWallet.focus();
                return false;
            }
            return true;
        }

    </script>
    <div style="width: 8in">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <UserControl:ProgressBar runat="server" ID="ProgressBar" />
                <UserControl:UserMessage runat="server" ID="umsg" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
                    <tr>
                        <td>
                            <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                                <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>Vehicle Mapping Fuel Card Master </u></b></font>
                            <td>
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a>
                            </td>
                        </td>
                    </tr>
                </table>
                <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" style="height: 21px">
                            <font class="blackfnt"><b>Vehicle Mapping With Fuel Card</b></font>
                        </td>
                    </tr>
                </table>
                <table border="1" width="100%">
                    <!--Row 1-->
                    <tr bgcolor="#ffffff">
                        <td align="left" colspan="2">
                            <font class="blackfnt">Select Vehicle</font>
                        </td>
                        <td align="left" colspan="3" style="display: inline">
                            <asp:TextBox runat="server" ID="txtVehicleNo" CssClass="ltxt"></asp:TextBox>
                            <asp:HiddenField runat="server" ID="hdnVehicleNo" />
                        </td>
                    </tr>
                    <tr class="hrow">
                        <td align="center" colspan="5">
                            <asp:Button Text="Step-1" runat="server" Visible="true" class="btn btn-primary" OnClick="btnStep1_Click" ID="btnStep1" />
                        </td>
                    </tr>
                    <tr class="nrow">
                        <td colspan="4">
                            <asp:GridView runat="server" CssClass="boxbg" ID="gvFuelCard" AutoGenerateColumns="False" CellSpacing="1"
                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" OnRowDataBound="gvFuelCard_RowDataBound"
                                PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemStyle CssClass="alignCenter" />
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="SrNo" Text='<%# Container.DataItemIndex + 1 %>' CssClass="blackfnt"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnSrNo" Value='<%# Eval("SrNo") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle No">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblVehicleNo" Text='<%# Eval("VehicleNo") %>' CssClass="blackfnt"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fuel Wallet">
                                        <ItemTemplate>
                                            <asp:DropDownList runat="server" ID="ddlFuelWallet" CssClass="blackfnt ltxt">
                                            </asp:DropDownList>
                                            <asp:HiddenField runat="server" ID="hdnFuelWallet" Value='<%# Eval("FuelWallet") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblDate" Text='<%# Eval("Date")%>' CssClass="blackfnt"></asp:Label>
                                            <asp:HiddenField runat="server" ID="hdnDate" Value='<%# Eval("Date") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Card No.">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtCardNo" Text='<%# Eval("CardNo") %>' CssClass="blackfnt ltxt"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active">
                                        <ItemStyle CssClass="alignCenter" />
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkActive" CssClass="blackfnt"></asp:CheckBox>
                                            <asp:HiddenField runat="server" ID="hdnActive" Value='<%# Eval("IsActive") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="hrow">
                        <td align="center" colspan="5">
                            <asp:Button Text="Submit" runat="server" Visible="true" class="btn btn-primary" OnClientClick="javascript:return Confirmation();" OnClick="btnSubmit_Click" ID="btnSubmit" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

