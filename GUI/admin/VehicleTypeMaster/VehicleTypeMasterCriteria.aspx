<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="VehicleTypeMasterCriteria.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleMasterEdSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>

    <script language="javascript" type="text/javascript">

        function onSubmitCheckValue(Flag) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var ddVehicleType = document.getElementById("ctl00_MyCPH1_ddVehicleType");

            if (ddVehicleType.value == "0") {
                alert("Please select Vehicle Type Name.");
                ddVehicleType.focus();
                return false;
            }
            else {
                if (Flag == "View") {
                    window.open("VehicleTypeMasterView.aspx?vehicleTypeCode=" + ddVehicleType.value + "&print=N", "", winOpts);
                    return false;
                }
            }
            return true;
        }
    </script>

    <asp:Panel runat="server" Width="10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table ID="tblMain" runat="server" HorizontalAlign="left" CssClass="stbl" CellSpacing="1"
            BorderWidth="0" Width="60%" BorderStyle="Groove">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="3">
                  <b>Select Vehicle Type Criteria</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="left" Width="25%">                               
                                   Select Vehicle Type                               
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:DropDownList ID="ddVehicleType" Width="325px" CssClass="blackfnt" runat="server">
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="btnEdit" runat="server" CssClass="fbtn" Width="50px" Text="Edit" OnClick="btnEdit_Click"
                        Visible="false" OnClientClick="javascript:return onSubmitCheckValue('Edit')" />
                    <asp:Button ID="btnView" runat="server" CssClass="fbtn" Width="50px" Text="View" OnClientClick="javascript:return onSubmitCheckValue('View')"
                        Visible="false" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
