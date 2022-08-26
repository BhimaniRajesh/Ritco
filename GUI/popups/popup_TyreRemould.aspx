<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_TyreRemould.aspx.cs"
    Inherits="GUI_popups_popup_tyres" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tyres</title>
    <script type="text/javascript" language="javascript" src="../../GUI/Js/querystring.js" ></script>  
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript">
         function selectTyre(obj) 
         {
            var qs = new Querystring()
            var returnValue = obj.value.split("~");
            
            window.opener.document.getElementById(qs.get("tyreid")).value=returnValue[0];
            window.opener.document.getElementById(qs.get("km")).value=returnValue[1];
            window.opener.document.getElementById(qs.get("tyre_cost")).value=returnValue[2];
            window.opener.document.getElementById(qs.get("tyreno")).value=returnValue[3];
            window.opener.document.getElementById(qs.get("TyrePattern")).value=returnValue[4];
            window.opener.document.getElementById(qs.get("TyreTDM")).value=returnValue[5];
            window.opener.document.getElementById(qs.get("TyreErr")).innerText="";
            
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
        <asp:Panel ID="Panel2"  runat="server">
        <table style="width: 95%" class="boxbg"  cellpadding="3" cellspacing="0" >
                                    <tr class="bgbluegrey">
                                        <td style="width: 20%">
                                            Select
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lbl_hdr_Tyre_id" runat="server" Text="Tyre Id"></asp:Label>
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="lbl_hdr_Tyre_No" runat="server" Text="Tyre Number"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                </asp:Panel>
                                <asp:Panel ID="Panel1" Width="287px" Height="265px" ScrollBars="Vertical"  runat="server">
                    <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="SELECT TYRE_ID,TYRE_TREAD_DEPTH_32NDS,TYRE_VEHNO,(SELECT Current_KM_Read FROM dbo.webx_VEHICLE_HDR WHERE VEHNO=TYRE_VEHNO) AS KM_Read,TYRE_COST,TYRE_NO,(select Tyre_Pattern_Desc from WEBX_FLEET_TYREPATTERN where tyre_Patternid=WEBX_FLEET_TYREMST.tyre_pattern_code ) as tyre_pattern FROM WEBX_FLEET_TYREMST Where TYRE_STATUS <> 'Mounted'">
                        </asp:SqlDataSource>
                        <asp:DataList ID="DataList1" 
                            HeaderStyle-CssClass="dgHeaderStyle"  runat="server" 
                            DataSourceID="SqlConn" Width="100%" DataKeyField="TYRE_ID" Font-Names="Verdana" Font-Size="8pt">
                            <HeaderStyle CssClass="dgHeaderStyle" />
                            <HeaderTemplate>
                                
                            </HeaderTemplate> 
                            <ItemTemplate>
                                <table style="width: 100%" cellpadding="0" cellspacing="1"  class="boxbg">
                                    <tr  style="background-color: white">
                                        <td style="width: 20%">
                                            <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" value='<%#Eval("TYRE_ID")%>~<%#Eval("KM_Read")%>~<%#Eval("TYRE_COST")%>~<%#Eval("TYRE_NO")%>~<%#Eval("tyre_pattern")%>~<%#Eval("TYRE_TREAD_DEPTH_32NDS") %>'  />
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lbl_TYRE_ID" runat="server" Text='<%#Eval("TYRE_ID")%>'></asp:Label>
                                        </td>
                                        <td style="width: 50%">
                                            <asp:Label ID="TYRE_NO" runat="server" Text='<%#Eval("TYRE_NO")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                
                            </ItemTemplate>
                        </asp:DataList>
                        </asp:Panel>

    </form>
</body>
</html>
