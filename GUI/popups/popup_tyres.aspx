<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_tyres.aspx.cs"
    Inherits="GUI_popups_popup_tyres" %>

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

         function selectTyre(obj) 
         {
            var returnValue = obj.value.split("~");

            var hf_Opener_tb_Tyreid = document.getElementById("hTyreID").value
            var hf_Opener_tb_km = document.getElementById("hKm").value
            var hf_Opener_tb_TyreCost = document.getElementById("hTyreCost").value 
            var hf_Opener_tb_TYRE_NO = document.getElementById("hTyreNo").value 

            window.opener.document.getElementById(hf_Opener_tb_Tyreid).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_tb_km).innerText=returnValue[1];
            window.opener.document.getElementById(hf_Opener_tb_TyreCost).value=returnValue[2];
            window.opener.document.getElementById(hf_Opener_tb_TYRE_NO).value=returnValue[3];
           
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
            <asp:HiddenField ID="hTyreID" runat="server" Value=""/>
                        <asp:HiddenField ID="hKm" runat="server" Value=""/>
                        <asp:HiddenField ID="hTyreCost" runat="server" Value=""/>
                        <asp:HiddenField ID="hTyreNo" runat="server" Value=""/>
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Tyre</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="TYRE_ID" DataSourceID="SqlConn" >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" value='<%#Eval("TYRE_ID")%>~<%#Eval("KM_Read")%>~<%#Eval("TYRE_COST")%>~<%#Eval("TYRE_NO")%>'  />
                                    </ItemTemplate>
                                    <ControlStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TYRE_ID" HeaderText="Tyre Id" ReadOnly="True" SortExpression="TYRE_ID" >
                                    <ControlStyle Width="30%" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="TYRE_NO" HeaderText="Tyre No" ReadOnly="True" SortExpression="TYRE_NO" >
                                    <ControlStyle Width="60%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="SELECT TYRE_ID,TYRE_VEHNO,(SELECT Current_KM_Read FROM dbo.webx_VEHICLE_HDR WHERE VEHNO=TYRE_VEHNO) AS KM_Read,TYRE_COST,TYRE_NO  FROM WEBX_FLEET_TYREMST">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
