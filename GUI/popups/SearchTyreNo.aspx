<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchTyreNo.aspx.cs"
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

         function selectTyre(obj) 
         {
            var returnValue = obj.value.split("~");

            var hf_Opener_tb_Tyreid = document.getElementById("hTyreID").value;
            var hf_Size = document.getElementById("hfTyreSize").value;
            var hf_Pattern = document.getElementById("hfTyrePattern").value;
            var hf_Position = document.getElementById("hfTyrePos").value;
            var hf_Mfg = document.getElementById("hfMFG").value;
            var hf_Vehno = document.getElementById("hfVehNo").value; 
            var hf_lbl7 = document.getElementById("hflbl7").value; 
            var hf_pnlM = document.getElementById("hfPnlMount").value; 
            var hf_pnlD = document.getElementById("hfPnlDisMount").value; 
            var hf_TyreID = document.getElementById("hfTyreID").value;
            var a="";
            if(returnValue[5]!="")
            {
                a=returnValue[5];
                window.opener.document.getElementById(hf_lbl7).innerText="Vehicle Number :";
                window.opener.document.getElementById(hf_pnlM).style.visibility="hidden";
                window.opener.document.getElementById(hf_pnlD).style.visibility="visible";
            }                       
            else
            {
                a=returnValue[6];
                window.opener.document.getElementById(hf_lbl7).innerText="Location :";
                window.opener.document.getElementById(hf_pnlM).style.visibility="visible";
                window.opener.document.getElementById(hf_pnlD).style.visibility="hidden";
            }
            window.opener.document.getElementById(hf_Opener_tb_Tyreid).value=returnValue[0];
            window.opener.document.getElementById(hf_Size).innerText=returnValue[1];
            window.opener.document.getElementById(hf_Pattern).value=returnValue[2];
            window.opener.document.getElementById(hf_Position).value=returnValue[3];
           
            window.opener.document.getElementById(hf_Mfg).value=returnValue[4];
            window.opener.document.getElementById(hf_Vehno).value=a;
            window.opener.document.getElementById(hf_TyreID).value=returnValue[7];
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
            <asp:HiddenField ID="hfTyreSize" runat="server" Value=""/>
            <asp:HiddenField ID="hfTyrePattern" runat="server" Value=""/>
            <asp:HiddenField ID="hfTyrePos" runat="server" Value=""/>
            <asp:HiddenField ID="hfMFG" runat="server" Value=""/>
            <asp:HiddenField ID="hfVehNo" runat="server" Value=""/>
            <asp:HiddenField ID="hflbl7" runat="server" Value=""/>
            <asp:HiddenField ID="hfPnlMount" runat="server" Value=""/>
            <asp:HiddenField ID="hfPnlDisMount" runat="server" Value=""/>
            <asp:HiddenField ID="hfTyreID" runat="server" Value=""/>
            
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
                                        <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" value='<%#Eval("TYRE_NO")%>~<%#Eval("TYRE_SIZENAME")%>~<%#Eval("TYRE_PATTERN_DESC")%>~<%#Eval("TYREPOS_CODE")%>~<%#Eval("MFG_NAME")%>~<%#Eval("VEHNO")%>~<%#Eval("LOCNAME")%>~<%#Eval("TYRE_ID")%>' />
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
                            SelectCommand="SELECT S.TYRE_SIZENAME, (SELECT TYRE_PATTERN_DESC FROM WEBX_FLEET_TYREPATTERN WHERE ACTIVE_FLAG='Y' AND TYRE_PATTERNID=TM.TYRE_PATTERN_Code) AS TYRE_PATTERN_DESC, PO.TYREPOS_CODE, M.MFG_NAME,V.VEHNO,TM.TYRE_VEHNO,V.VEH_INTERNAL_NO,LOC.LOCNAME,TM.* FROM WEBX_FLEET_TYREMST AS TM LEFT OUTER JOIN WEBX_FLEET_TYREPOS AS PO ON TM.TYREPOS_ID = PO.TYREPOS_ID LEFT OUTER JOIN WEBX_FLEET_TYREMFG AS M ON TM.MFG_ID = M.MFG_ID  LEFT OUTER  JOIN WEBX_FLEET_TYRESIZEMST AS S ON TM.TYRE_SIZEID = S.TYRE_SIZEID  LEFT OUTER  JOIN WEBX_VEHICLE_HDR AS V ON TM.VEH_INTERNAL_NO = V.VEH_INTERNAL_NO LEFT OUTER JOIN WEBX_LOCATION AS LOC ON TM.TYRE_LOCATION=LOC.LOCCODE">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
