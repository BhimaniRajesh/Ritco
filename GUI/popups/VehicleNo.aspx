<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VehicleNo.aspx.cs"
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
            var hf_Opener_tb_Km = document.getElementById("hKM").value 
            //var hf_Opener_tb_TYRE_NO = document.getElementById("hTyreNo").value 
            window.opener.document.getElementById(hf_Opener_VehNo).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_Id).innerText=returnValue[1];
            if(returnValue[2]=="")
            {
                window.opener.document.getElementById(hf_Opener_tb_Km).value="0.00";
            }
            else
            {
                window.opener.document.getElementById(hf_Opener_tb_Km).value=returnValue[2];
            }
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
            <asp:HiddenField ID="hKM" runat="server" Value=""/>
                       
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Vehicle Number</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="VEH_INTERNAL_NO" DataSourceID="SqlConn" EmptyDataText="No Records Found..." >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectVehno(this);" value='<%#Eval("VEHNO")%>~<%#Eval("VEH_INTERNAL_NO")%>~<%#Eval("CURRENT_KM_READ")%>' />
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
                            SelectCommand="SELECT Vehicle_Type,VEHNO,VENDORTYPE,VENDORCODE,VEHTONS,VEHPERMIT,VEHROUTECD,VEHMADEBY,VEHMODEL,VEHRCBKNO,VEHREGNO,VEHREGDT,VEHCHASISNO,VEHENGINENO,ACTIVEFLAG,UPDTBY,UPDTON,Vendor_Own Insurance_Validity_Date,Fitness_Validity_Date   usedcapacity,mileage,Conrtl_branch,VEHT_CAT,Drivers,length,Height,GVW,Unld_Wt,Payload,rate_km,width,Capacity,Vehicle_Status,THC_Attached_YN,attachdt,Fuel_Tank_Cap,Current_KM_Read,Diesel_Card_YN Diesel_Card_No,ftltype,Veh_Type_Code,VEH_INTERNAL_NO FROM WEBX_VEHICLE_HDR">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
