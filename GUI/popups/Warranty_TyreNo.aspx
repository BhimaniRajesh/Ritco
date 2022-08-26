<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Warranty_TyreNo.aspx.cs"
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
            var hf_Opener_tb_MFG = document.getElementById("hfMFG").value;
            var hf_Opener_tb_TyreCost = document.getElementById("hfTyreCost").value;
            var hf_Opener_tb_TotKM = document.getElementById("hfTOTKM").value;
            var hf_Opener_tb_Model = document.getElementById("hfModel").value;
            var hf_Opener_tb_LastTreadDepth = document.getElementById("hfLastTreadDepth").value;
            var hf_Opener_tb_VehId = document.getElementById("hfVehId").value;
            var hf_Opener_tb_TOTAL_COST = document.getElementById("hfTotalCost").value;
            
            window.opener.document.getElementById(hf_Opener_tb_TyreNo).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_tb_Tyreid).value=returnValue[1];
            window.opener.document.getElementById(hf_Opener_tb_MFG).value=returnValue[2];
            window.opener.document.getElementById(hf_Opener_tb_TyreCost).value=returnValue[3];
            window.opener.document.getElementById(hf_Opener_tb_TotKM).value=returnValue[4];
            window.opener.document.getElementById(hf_Opener_tb_Model).value=returnValue[5];
            window.opener.document.getElementById(hf_Opener_tb_LastTreadDepth).value=returnValue[6];
            window.opener.document.getElementById(hf_Opener_tb_VehId).value=returnValue[7];
            window.opener.document.getElementById(hf_Opener_tb_TOTAL_COST).value=returnValue[8];
 
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
        <asp:HiddenField ID="hfMFG" runat="server" />
        <asp:HiddenField ID="hfTyreCost" runat="server" />
        <asp:HiddenField ID="hfTOTKM" runat="server" />
        <asp:HiddenField ID="hfModel" runat="server" />
        <asp:HiddenField ID="hfLastTreadDepth" runat="server" />
        <asp:HiddenField ID="hfVehId" runat="server" />
        <asp:HiddenField ID="hfTotalCost" runat="server" />
        
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
                                        value='<%#Eval("TYRE_NO")%>~<%#Eval("TYRE_ID")%>~<%#Eval("MFG")%>~<%#Eval("TYRE_COST")%>~<%#Eval("TYRE_TOTKM_RUN")%>~<%#Eval("MODEL")%>~<%#Eval("LAST_TERADDEPTH")%>~<%#Eval("VEH_INTERNAL_NO") %>~<%#Eval("TOTAL_COST") %>' />                    
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
