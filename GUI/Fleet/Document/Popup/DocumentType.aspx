<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocumentType.aspx.cs"
    Inherits="GUI_popups_vehno" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Document Type</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript">
         var controlIdPrefix = "ctl00_MyCPH1_gv_Remould__ctl02_";

         function selectDocType(obj) 
         {
            var returnValue = obj.value.split("~");
            
            var hf_Opener_DocType = document.getElementById("hDocType").value
            var hf_Opener_DocTypeId = document.getElementById("hDocTypeId").value

            window.opener.document.getElementById(hf_Opener_DocType).value=returnValue[0];
            window.opener.document.getElementById(hf_Opener_DocTypeId).innerText=returnValue[1];
          
            window.close();
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
            <asp:HiddenField ID="hDocType" runat="server" Value=""/>
            <asp:HiddenField ID="hDocTypeId" runat="server" Value=""/>
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Document Type</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="DOCU_TYPE_ID" DataSourceID="SqlConn" EmptyDataText="No Records Found..." >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectDocType(this);" value='<%#Eval("DOCU_TYPE")%>~<%#Eval("DOCU_TYPE_ID")%>' />
                                    </ItemTemplate>
                                    <ControlStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="DOCU_TYPE" HeaderText="Document Type" ReadOnly="True" SortExpression="DOCU_TYPE" >
                                    <ControlStyle Width="30%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DECS" HeaderText="Description" ReadOnly="True" SortExpression="DECS" >
                                    <ControlStyle Width="50%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="SELECT [DOCU_TYPE],[DOCU_TYPE_ID],[DECS] FROM [WEBX_FLEET_DOCU_TYPE_MST] ">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
