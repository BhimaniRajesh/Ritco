<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TdmTyreNo.aspx.cs"
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
            var hf_Opener_tb_TyreNo = document.getElementById("hfTyreNo").value;
            var hf_Opener_tb_Tyreid = document.getElementById("hTyreID").value;
            var hf_Opener_tb_KmRun = document.getElementById("hfKmRun").value;
            var hf_Opener_tb_TreadDepth = document.getElementById("hfTreadDepth").value;
            var hf_Opener_tb_Position = document.getElementById("hfPosition").value;
            var hf_Opener_tb_VehNO = document.getElementById("hfVehNO").value;
            var hf_Opener_tb_MFG = document.getElementById("hfMFG").value;
            var hf_Opener_tb_Model = document.getElementById("hfModel").value;
            var hf_Opener_tb_AVG_TWI = document.getElementById("hfAVG_TWI").value;
            var hf_Opener_tb_VehId = document.getElementById("hfVehId").value;
            
            
            
            window.opener.document.getElementById(hf_Opener_tb_TyreNo).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_tb_KmRun).value=returnValue[1];
            window.opener.document.getElementById(hf_Opener_tb_TreadDepth).value=returnValue[4];
            window.opener.document.getElementById(hf_Opener_tb_Position).value=returnValue[3];
            window.opener.document.getElementById(hf_Opener_tb_VehNO).value=returnValue[2];
            window.opener.document.getElementById(hf_Opener_tb_MFG).value=returnValue[5];
            window.opener.document.getElementById(hf_Opener_tb_Model).value=returnValue[6];
            window.opener.document.getElementById(hf_Opener_tb_AVG_TWI).value=returnValue[7];
            window.opener.document.getElementById(hf_Opener_tb_Tyreid).value=returnValue[8];
            window.opener.document.getElementById(hf_Opener_tb_VehId).value=returnValue[9];
            window.opener.FillTreadDepth();
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
        <asp:HiddenField ID="hfTyreNo" runat="server" Value=""/>
        <asp:HiddenField ID="hTyreID" runat="server" Value=""/>
        <asp:HiddenField ID="hfKmRun" runat="server" />
        <asp:HiddenField ID="hfTreadDepth" runat="server" />
        
        <asp:HiddenField ID="hfPosition" runat="server" />
        <asp:HiddenField ID="hfVehNO" runat="server" />
        <asp:HiddenField ID="hfMFG" runat="server" />
        <asp:HiddenField ID="hfModel" runat="server" />
        <asp:HiddenField ID="hfAVG_TWI" runat="server" />     
        <asp:HiddenField ID="hfVehId" runat="server" />    
        
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Tyre</asp:Label>
                        
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" 
                                        value='<%#Eval("TYRE_NO")%>~<%#Eval("KM_RUN")%>~<%#Eval("VEHNO")%>~<%#Eval("POSITION")%>~<%#Eval("TYRE_TREAD_DEPTH_32NDS")%>~<%#Eval("MFG")%>~<%#Eval("MODEL")%>~<%#Eval("AVG_TWI")%>~<%#Eval("TYRE_ID") %>~<%#Eval("VEH_INTERNAL_NO") %>' />                    
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
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
