<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleNo_TyreRotate.aspx.cs"
    Inherits="GUI_popups_vehno" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tyres</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript">
         var controlIdPrefix = "ctl00_MyCPH1_gv_Remould__ctl02_";

         function selectVehno(obj) 
         {
            var returnValue = obj.value.split("~");
            var hf_Opener_VehNo = document.getElementById("hVehNo").value
            var hf_Opener_Id = document.getElementById("hID").value
            var hf_Opener_VehCategory = document.getElementById("hVehCategory").value 
            var hf_Opener_Km = document.getElementById("hKm").value 
            //var hf_Opener_tb_TYRE_NO = document.getElementById("hTyreNo").value 
            window.opener.document.getElementById(hf_Opener_VehNo).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_Id).innerText=returnValue[1];
            window.opener.document.getElementById(hf_Opener_VehCategory).value=returnValue[2];
            window.opener.document.getElementById(hf_Opener_Km).value=returnValue[3];
            //window.opener.document.getElementById(hf_Opener_VehNo).focus();
            //window.opener.document.getElementById(hf_Opener_tb_TYRE_NO).value=returnValue[3];
            window.close();
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
            <asp:HiddenField ID="hVehNo" runat="server" Value=""/>
            <asp:HiddenField ID="hID" runat="server" Value=""/>
            <asp:HiddenField ID="hVehCategory" runat="server" Value=""/>
         
            <asp:HiddenField ID="hKm" runat="server" Value=""/>
                       
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Tyre</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="VEH_INTERNAL_NO" DataSourceID="SqlConn" EmptyDataText="No Records Found..." >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectVehno(this);" value='<%#Eval("VEHNO")%>~<%#Eval("VEH_INTERNAL_NO")%>~<%#Eval("VehCategory")%>~<%#Eval("CURRENT_KM_READ")%>' />
                                    </ItemTemplate>
                                    <ControlStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="VEHNO" HeaderText="Vehicle Number" ReadOnly="True" SortExpression="VEHNO" >
                                    <ControlStyle Width="80%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="select distinct VEHNO,VEH_INTERNAL_NO,VH.CURRENT_KM_READ,
(SELECT CODEDESC FROM Webx_Master_General WHERE CODETYPE='VHCAT'AND codeid=p.TRUCK_TRAILER) as VehCategory
from WEBX_FLEET_TYREPOS P inner join webx_vehicle_type VT
on truck_trailer=vehicle_type_category inner join
webx_vehicle_hdr VH on vh.vehicle_type=vt.type_code">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
