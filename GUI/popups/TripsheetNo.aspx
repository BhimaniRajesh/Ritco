<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripsheetNo.aspx.cs"
    Inherits="TripsheetNo" %>

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

         function TripsheetNo(obj) 
         {
            var returnValue = obj.value.split("~");
            var hf_Opener_TripsheetNo = document.getElementById("hTripsheetNo").value
           // var hf_Opener_Id = document.getElementById("hID").value
          
            window.opener.document.getElementById(hf_Opener_TripsheetNo).value=returnValue[0];
            
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
            <asp:HiddenField ID="hTripsheetNo" runat="server" Value=""/>
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Tripsheet Number</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="VSLIPNO" DataSourceID="SqlConn" EmptyDataText="No Records Found..." >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:TripsheetNo(this);" value='<%#Eval("VSLIPNO")%>' />
                                    </ItemTemplate>
                                    <ControlStyle Width="20%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="VSLIPNO" HeaderText="Vehicle Number" ReadOnly="True" SortExpression="VSLIPNO" >
                                    <ControlStyle Width="80%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient" />
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
