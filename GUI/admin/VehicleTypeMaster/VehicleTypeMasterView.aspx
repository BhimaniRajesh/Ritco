<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleTypeMasterView.aspx.cs"
    Inherits="GUI_admin_VehicleTypeMaster_VehicleTypeMasterAdd"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
     function printPage() 
     {
        var hdnflagprint = document.getElementById("hdnflagprint");   
         
        if(hdnflagprint.value == "Y")
        {
          window.print();
        }
        return false;
     }
     
     function popupPrint()
     {
            var hdnCode = document.getElementById("hdnCode");
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
            window.open("VehicleTypeMasterView.aspx?vehicleTypeCode="+hdnCode.value+"&print=Y","", winOpts);
            return false;
     }
    </script>

</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
        <asp:Panel runat="server" Width="10in">
            <br />
            <table width="100%" align="center">
                <tr>
                    <td align="right">
                        <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print |"
                            OnClientClick="javascript:return popupPrint();"></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
                    </td>
                </tr>
            </table>
            <asp:Table HorizontalAlign="center" CellSpacing="1" Width="100%" CssClass='<%=boxbg %>'
                runat="server" ID="tblMain">
                <asp:TableRow CssClass='<%=bgbluegrey %>' ID="trVehicleTypeMaster" runat="server">
                    <asp:TableCell HorizontalAlign="center" CssClass="blackfnt" ColumnSpan="6" ID="tdVehicleTypeMaster"
                        runat="server">
                   <b>Vehicle Type Master</b></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Style="width: 150px" CssClass="blackfnt" ID="tdVehicleTypeCode" runat="server">
                    Vehicle Type Code </asp:TableCell>
                    <asp:TableCell Style="width: 150px" ID="lbltdVehicleTypeCode" runat="server">
                        <asp:Label ID="lblVehicleTypeCode" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell Style="width: 175px" CssClass="blackfnt" ID="tdVehicleManufactureName"
                        runat="server">
                    Vehicle Manufacturer Name 
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="3" Style="width: 150px" ID="lbltdVehicleManufactureName"
                        runat="server">
                        <asp:Label ID="lblVehicleManufactureName" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ID="tdVehicleName" CssClass="blackfnt" runat="server">
                    Vehicle Name. </asp:TableCell>
                    <asp:TableCell ID="lbltdVehicleName" runat="server">
                        <asp:Label ID="lblVehicleName" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdVehicleModelNo" CssClass="blackfnt" runat="server">
                    Model No.</asp:TableCell>
                    <asp:TableCell ColumnSpan="3" ID="lbltdVehicleModelNo" runat="server">
                        <asp:Label ID="lblVehicleModelNo" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ID="tdTruck" CssClass="blackfnt" runat="server">
                    Truck / Trailer </asp:TableCell>
                    <asp:TableCell ID="lbltdTruck" runat="server">
                        <asp:Label ID="lblVehicleTypeCat" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdTyreStation" CssClass="blackfnt" runat="server">
                    Tyre Rotation at Km</asp:TableCell>
                    <asp:TableCell ColumnSpan="3" ID="lbltdTyreStation" runat="server">
                        <asp:Label ID="lblTyreStation" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell VerticalAlign="top" CssClass="blackfnt" ID="tdVehicleTypeDecs" runat="server">
                    Type Description 
                    </asp:TableCell>
                    <asp:TableCell VerticalAlign="top" ID="lbltdVehicleTypeDecs" runat="server">
                        <asp:Label ID="lblVehicleTypeDesc" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" CssClass="blackfnt" VerticalAlign="top" ID="tdActiveFlag"
                        runat="server">
                    Active Flag</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" VerticalAlign="top" ColumnSpan="3" ID="lbltdActiveFlag"
                        runat="server">
                        <asp:Label ID="lblActiveFlag" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass='<%=bgbluegrey %>' ID="trCapacityInfo" runat="server">
                    <asp:TableCell HorizontalAlign="left" ColumnSpan="6" Font-Bold="true" ID="tdCapecityInfo"
                        runat="server" CssClass="blackfnt">
                   Capacity Information in Ton</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell VerticalAlign="top" CssClass="blackfnt" ID="tdGrossVehicleWeight"
                        runat="server"> 
                    Gross Vehicle Weight                    
                    </asp:TableCell>
                    <asp:TableCell VerticalAlign="top" CssClass="blackfnt" ID="lbltdGrossVehicleWeight"
                        runat="server">
                        <asp:Label ID="lblVehicleGrossWeight" runat="server" CssClass="blackfnt"></asp:Label>
                        (Ton)
                    </asp:TableCell>
                    <asp:TableCell ID="tdUnledenWeight" runat="server" CssClass="blackfnt">
                    Unladen Weight 
                    </asp:TableCell>
                    <asp:TableCell Style="width: 150px" ID="lbltdUnledenWeight" runat="server" CssClass="blackfnt">
                        <asp:Label ID="lblUnladen" runat="server" CssClass="blackfnt"></asp:Label>
                        (Ton)
                    </asp:TableCell>
                    <asp:TableCell Style="width: 100px" ID="tdPayload" runat="server" CssClass="blackfnt">
                    Capacity </asp:TableCell>
                    <asp:TableCell ID="lbltdPayload" runat="server" CssClass="blackfnt">
                        <asp:Label ID="lblPayload" runat="server" CssClass="blackfnt"></asp:Label>
                        (Ton)
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ID="tdRate" runat="server" CssClass="blackfnt">
                    Rate per KM</asp:TableCell>
                    <asp:TableCell ID="lbltdRate" runat="server">
                        <asp:Label ID="lblRate" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdFuelType" runat="server" CssClass="blackfnt">
                    Fuel Type</asp:TableCell>
                    <asp:TableCell ID="lbltdFuelType" runat="server">
                        <asp:Label ID="lblFuelType" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdHeight" runat="server" CssClass="blackfnt">
                    Height</asp:TableCell>
                    <asp:TableCell ID="lbltdHeight" runat="server">
                        <asp:Label ID="lblHeight" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ID="tdUpdateby" runat="server" CssClass="blackfnt">
                    Length</asp:TableCell>
                    <asp:TableCell ID="lbltdUpdateby" runat="server">
                        <asp:Label ID="lblLength" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdUpdateon" runat="server" CssClass="blackfnt">
                    Last Update By </asp:TableCell>
                    <asp:TableCell ColumnSpan="3" ID="lbltdUpdateon" runat="server">
                        <asp:Label ID="lblUpdateBy" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ID="tdLength" runat="server" CssClass="blackfnt">
                     Width</asp:TableCell>
                    <asp:TableCell ID="lbltdLength" runat="server">
                        <asp:Label ID="lblWidth" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ID="tdWidth" runat="server" CssClass="blackfnt">
                     Last Update Date</asp:TableCell>
                    <asp:TableCell Style="width: 150px" ColumnSpan="3" ID="lbltdWidth" runat="server">
                        <asp:Label ID="lblUpdateOn" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:HiddenField ID="hdnflagprint" runat="server" />
            <asp:HiddenField ID="hdnCode" runat="server" />
        </asp:Panel>
    </form>
</body>
</html>
