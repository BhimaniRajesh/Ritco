<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="RemoveVehicleFromCPKM.aspx.cs" Inherits="GUI_admin_VehicleCPKM_RemoveVehicleFromCPKM" %>

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
        function RadioCheck(rb) {
            var gv = document.getElementById("<%=gvVehicleCPKM.ClientID%>");
            var rbs = gv.getElementsByTagName("input");
            var row = rb.parentNode.parentNode;
            for (var i = 0; i < rbs.length; i++) {
                if (rbs[i].type == "radio") {
                    if (rbs[i].checked && rbs[i] != rb) {
                        rbs[i].checked = false;
                        break;
                    }
                }
            }
        }
        function InitializedAutocomplete() {

            var txtVehicleNo = '#<%= txtVehicleNo.ClientID%>';
            var hdnVehicleNo = '<%= hdnVehicleNo.ClientID%>';
            var txtFleetCenter = '#<%= txtFleetCenter.ClientID%>';
            var hdnFleetCenter = '<%= hdnFleetCenter.ClientID%>';
            try {
                AutoCompleteByAjaxV2(txtFleetCenter, ServiceUrl + "/GetFleetCenter", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnFleetCenter, "Invalid Fleet Center", []);
                AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle", []);
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
        function validFloat(e, txtid) {
            var code;
            var tb = document.getElementById(txtid);
            var txt = tb.value;

            if (!e) var e = window.event;
            if (e.keyCode)
                code = e.keyCode;
            else if (e.which)
                code = e.which;
            else
                return true;

            if (code == 13 || code == 8 || code == 9)
                return true;

            if (code == 46)
                if (txt.indexOf('.') != -1)
                    code = 0;

            if ((code < 46 || code > 57) || code == 47)
            { code = 0; return false; }
        }
        function CheckKM(id) {

            var txtFreezeKMs = $("#" + id);
            var lblKMs = $("#" + id.replace("txtFreezeKMs", "lblKMs"));
            if (txtFreezeKMs.val() != "") {


                if (parseFloat(txtFreezeKMs.val()) < parseFloat(lblKMs.text())) {
                    alert("Freeze kms should be equal or more than last billing kms");

                    txtFreezeKMs.focus();
                    return false;
                }
            }
        }
    </script>
    <div style="width: 10in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <UserControl:UserMessage runat="server" ID="umsg" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td height="30">
                                        <font class="bluefnt">
                                            <strong>Remove Vehicle From CPKM</strong> </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="horzblue">
                                        <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr runat="server" id="trCriteria">
                        <td>
                            <table cellpadding="1" cellspacing="1" border="0" style="width: 50%" class="boxbg">
                                <tbody>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Remove Vehicle from CPKM"></asp:Label></td>
                                    </tr>

                                    <tr class="nrow" runat="server">
                                        <td>
                                            <b>Fleet Center</b>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox runat="server" ID="txtFleetCenter" CssClass="ltxt"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnFleetCenter" />
                                        </td>

                                    </tr>
                                    <tr class="nrow">
                                        <td colspan="4" align="center">
                                            <asp:Label runat="server" CssClass="label label-info"> <b>OR</b> </asp:Label></td>
                                    </tr>
                                    <tr class="nrow" runat="server">
                                        <td>
                                            <b>Vehicle No</b>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox runat="server" ID="txtVehicleNo" CssClass="ltxt"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnVehicleNo" />
                                        </td>

                                    </tr>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Button runat="server" ID="btnStep1" Text="Submit" OnClick="btnStep1_OnClick" /></td>
                                    </tr>
                                </tbody>
                            </table>

                        </td>
                    </tr>
                    <tr runat="server" id="trGV" style="display: none">
                        <td>
                            <asp:GridView runat="server" CssClass="boxbg" ID="gvVehicleCPKM" AutoGenerateColumns="False" CellSpacing="1"
                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0" EmptyDataText="No Record Found">

                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemTemplate>
                                            <asp:RadioButton runat="server" ID="rdCPKM" onclick="RadioCheck(this);" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vehicle No">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblVehicleNo" Text='<%# Eval("VehicleNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="CPKM Date">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCPKMDate" Text='<%# Eval("CPKMDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Last generated bill Kms">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblKMs" Text='<%# Eval("KMs") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Freeze Kms">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="txtFreezeKMs" Width="100PX" CssClass="blackfnt ltxt " onkeypress="return validFloat(event,this.id)" onblur="return CheckKM(this.id)"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor Name">
                                        <ItemTemplate>
                                            <asp:HiddenField runat="server" ID="hdnVendor" Value='<%# Eval("VendorCode") %>' />
                                            <asp:Label runat="server" ID="lblVendor" Text='<%# Eval("VendorName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr runat="server" runat="server" id="trSBTBTN" style="display: none">
                        <td align="center">
                            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" OnClick="btnSubmit_OnClick" Text="Submit" OnClientClick="javascript:return Confirmation();" />
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>
</asp:Content>

