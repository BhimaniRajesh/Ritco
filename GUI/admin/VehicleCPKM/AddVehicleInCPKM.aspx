<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AddVehicleInCPKM.aspx.cs" Inherits="GUI_admin_VehicleCPKM_AddVehicleInCPKM" %>

<%@ Register Src="~/GUI/Common_UserControls/DatePicker1.ascx" TagName="DTP" TagPrefix="DateP" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">
        var ServiceUrl = '<%=ResolveClientUrl("~/RestService/MasterService.svc")%>';
        $(document).ready(function () {
            InitializedAutocomplete();
            //var prm = Sys.WebForms.PageRequestManager.getInstance();
            //if (prm != null) {
            //    prm.add_endRequest(function (sender, e) {
            //        if (sender._postBackSettings.panelsToUpdate != null) {
            //            InitializedAutocomplete();
            //        }
            //    });
            //};
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

            function EndRequestHandler(sender, args) {
                InitializedAutocomplete();
            }

        });

        function InitializedAutocomplete() {

            var txtVendor, hdnVendor,txtVehicleNo,hdnVehicleNo;
            var tbl = document.getElementById("<%=gvVehicleCPKM.ClientID%>");
                  var rows = tbl.rows.length;
                  for (var i = 2; i <= rows ; i++) {
                      if (i < 10) {
                          txtVendor = "#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtVendor";
                          hdnVendor = "ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnVendor";
                          txtVehicleNo = "#ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_txtVehicleNo";
                          hdnVehicleNo = "ctl00_MyCPH1_gvVehicleCPKM_ctl0" + i + "_hdnVehicleNo";
                      } else {
                          txtVehicleNo = "#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtVehicleNo";
                          hdnVehicleNo = "ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnVehicleNo";
						  txtVendor = "#ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_txtVendor";
                          hdnVendor = "ctl00_MyCPH1_gvVehicleCPKM_ctl" + i + "_hdnVendor";
                      }
                      try {
                          AutoCompleteByAjaxV2(txtVendor, ServiceUrl + "/GetCPKMVendor", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVendor, "Invalid Vendor", []);
                          AutoCompleteByAjaxV2(txtVehicleNo, ServiceUrl + "/GetCPKMVehicle", "POST", "application/json; charset=utf-8", "json", "Prefix", 'l', 'l', 'l', 'v', hdnVehicleNo, "Invalid Vehicle", []);
                      } catch (e) {
                          //alert(e);
                      }
                  }


        }
function checkVehicleDetail(id) {
    var hdnVehicleNo;
    var txtVehicleNo = id
    
        hdnVehicleNo = $("#" + id.id.replace("txtVehicleNo", "hdnVehicleNo"));
   
    if (hdnVehicleNo.val() == "" || $(txtVehicleNo).val() == "") {
        return false;
    }
    var param = { VehicleNo: hdnVehicleNo.val() };
    $.ajax({
        type: "POST",
        url: "AddVehicleInCPKM.aspx/CheckVehicle",
        data: JSON.stringify(param),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function (response) {
            
            // as ajax request is complete
            var objArray = JSON.parse(response.d);
            if (objArray[0].STATUS == 'N') {
                $(txtVehicleNo).val('');
                alert("Vehicle has more then 1 tyres are attched. Not allowed for CPKM .");
                $(txtVehicleNo).focus();
                return false;
            }
        }
    });
    return true;
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
        function Confirmation() {
            if (confirm("Are you sure to submit this details")) {
                return true;
            }
            return false;
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
                                            <strong>Add Vehicle in CPKM</strong> </font>
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
                    <tr>
                        <td>
                            <table cellpadding="1" cellspacing="1" border="0" style="width: 80%" class="boxbg">
                                <thead>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Add Vehicle in CPKM"></asp:Label></td>
                                    </tr>
                                    <tr class="nrow">

                                        <td colspan="4">
                                            <asp:GridView runat="server" CssClass="boxbg" ID="gvVehicleCPKM" AutoGenerateColumns="False" CellSpacing="1"
                                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" OnRowDataBound="gvVehicleCPKM_OnRowDataBound" OnRowCommand="gvVehicleCPKM_OnRowCommand" OnRowCreated="gvVehicleCPKM_OnRowCreated"
                                                PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                                                <Columns>
                                                    <asp:TemplateField HeaderText="Vehicle No">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtVehicleNo" Text='<%# Eval("VehicleNo") %>' onblur="checkVehicleDetail(this);" Width="200PX" CssClass="blackfnt ltxt"></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="hdnVehicleNo" Value='<%# Eval("VehicleNo") %>'/>
                                                             <asp:HiddenField runat="server" ID="hdnExist" Value='<%# Eval("IsExist") %>'/>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="CPKM Date">
                                                        <ItemTemplate>
                                                            <DateP:DTP runat="server" ID="txtCPKMDate" AllowFutureDate="True" AllowPastDate="True" Text='<%# Eval("CPKMDate") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="KMs">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtKMs" Text='<%# Eval("KMs") %>' Width="100PX" CssClass="blackfnt ltxt "  onkeypress="return validFloat(event,this.id)"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Link with Vendor">
                                                        <ItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtVendor" Text='<%# Eval("VendorName") %>' Width="200PX" CssClass="blackfnt ltxt "></asp:TextBox>
                                                            <asp:HiddenField runat="server" ID="hdnVendor" Value='<%# Eval("VendorCode") %>'/>
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
                                    
                                </thead>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-primary" OnClick="btnSubmit_OnClick" Text="Submit" OnClientClick="javascript:return Confirmation();"/>
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
        </asp:UpdatePanel>

    </div>

</asp:Content>

