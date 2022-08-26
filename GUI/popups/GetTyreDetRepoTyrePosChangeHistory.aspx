<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetTyreDetRepoTyrePosChangeHistory.aspx.cs"
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

            var hf_Opener_TyreId = document.getElementById("hTyreID").value;
            var hf_Opener_TyreNO = document.getElementById("hfTyreNo").value;
            var hf_Opener_MFG = document.getElementById("hfMFG").value;
            var hf_Opener_Model= document.getElementById("hfModel").value;
            var hf_Opener_Size = document.getElementById("hfTyreSize").value;
            var hf_Opener_Pattern = document.getElementById("hfTyrePattern").value; 
            var hf_Opener_Type = document.getElementById("hfType").value; 
            window.opener.document.getElementById(hf_Opener_TyreId).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_TyreNO).innerText=returnValue[1];
            window.opener.document.getElementById(hf_Opener_MFG).value=returnValue[2];
            window.opener.document.getElementById(hf_Opener_Model).value=returnValue[3];
            window.opener.document.getElementById(hf_Opener_Size).value=returnValue[4];
            window.opener.document.getElementById(hf_Opener_Pattern).value=returnValue[5];
            window.opener.document.getElementById(hf_Opener_Type).value=returnValue[6];
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
                <asp:HiddenField ID="hfTyreNo" runat="server" Value=""/>
                <asp:HiddenField ID="hfMFG" runat="server" Value=""/>
                <asp:HiddenField ID="hfModel" runat="server" Value=""/>
                <asp:HiddenField ID="hfTyreSize" runat="server" Value=""/>
                <asp:HiddenField ID="hfTyrePattern" runat="server" Value=""/>
                <asp:HiddenField ID="hfType" runat="server" Value=""/>
             
            
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
                                        <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" 
                                        value='<%#Eval("TYRE_ID")%>~<%#Eval("TYRE_NO")%>~<%#Eval("MFG")%>~<%#Eval("MODEL")%>~<%#Eval("TYRESIZE")%>~<%#Eval("PATTERN")%>~<%#Eval("TYRETYPE")%>' />
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
                            SelectCommand="SELECT *FROM vw_Get_Tyre_Det_Repo_Tyre_PosChange_History">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
