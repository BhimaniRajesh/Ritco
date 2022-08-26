<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Vehicle_Mapping_TollCard_View.aspx.cs" Inherits="GUI_admin_VehicleMappingTollCard_Vehicle_Mapping_TollCard_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
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
                AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle", []);
            } catch (e) {
                //alert(e);
            }
        }
    </script>
    <div style="width: 8in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>Vehicle Mapping Fuel/Toll Card Master </u></b></font>
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
                    <font class="blackfnt"><b>Vehicle Mapping With Fuel/Toll Card</b></font>
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
                    <asp:Button Text="View" runat="server" Visible="true" OnClick="btnStep1_Click" class="btn btn-primary" ID="btnStep1" />
                </td>
            </tr>
            <tr id="trxsl" runat="server">
                <td align="right" colspan="5">
                    <br />
                    <asp:LinkButton ID="XlSDownload" runat="server" OnClick="XlSDownload_Click" Visible="false">Download XLS</asp:LinkButton>
                </td>
            </tr>
            <tr id="view" runat="server" visible="false">
                <td colspan="5">
                    <table width="100%" id="tblstep2" class="stbl">
                        <tr class="bgwhite">
                            <td align="center"><b>Sr. No.</b></td>
                            <td align="center"><b>Vehicle No.</b></td>
                            <td align="center"><b>Fuel/Toll Card</b></td>
                            <td align="center"><b>Date</b></td>
                            <td align="center"><b>Card No.</b></td>
                            <td align="center"><b>Confirm Card No.</b></td>
                            <td align="center"><b>Status</b></td>
                        </tr>
                        <asp:Repeater ID="BindFuelCardMappingDetails" runat="server">
                            <ItemTemplate>
                                <tr class="bgwhite">
                                    <td align="center">
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label></td>
                                    <td align="left">
                                        <asp:Label ID="lblVehicleNo" runat="server" Text='<%# Eval("VehicleNo") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblFuelCard" runat="server" Text='<%# Eval("FuelWallet") %>'></asp:Label></td>
                                    <td align="left">
                                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("FuelCardDate") %>'></asp:Label></td>
                                    <td align="left">
                                        <asp:Label ID="lblCardNo" runat="server" Text='<%# Eval("CardNo") %>'></asp:Label></td>
                                    <td align="left">
                                        <asp:Label ID="lblConfirmCardNo" runat="server" Text='<%# Eval("ConfirmCardNo") %>'></asp:Label></td>
                                    <td align="left">
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

