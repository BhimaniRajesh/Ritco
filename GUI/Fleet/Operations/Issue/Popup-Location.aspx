<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup-Location.aspx.cs" Inherits="GUI_popups_Popup_Location" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>Location</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js" ></script>
     <script type="text/javascript" language="javascript">
        
         function selectLocation(obj) 
         {
            var returnValue = obj.value.split("~");
         
            //var hf_Opener_tb_locname = document.getElementById("hlocname").value
            var hf_Opener_tb_loccode = document.getElementById("hloccode").value
           // alert("hi")
            //window.opener.document.getElementById(hf_Opener_tb_locname).value=returnValue[0];
           // alert("hi")
            window.opener.document.getElementById(hf_Opener_tb_loccode).value=returnValue;
                 
            window.close();
        }
    </script>
</head>
<body>h
    <form id="form1" runat="server">
        <div>
          
            <table cellspacing="1" style="width: 100%">
           <tr>
                        
                        <asp:HiddenField ID="hlocname" runat="server" Value=""/>
                        <asp:HiddenField ID="hloccode" runat="server" Value=""/>
                        
           </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 56px">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Select Location</asp:Label>
                        <asp:GridView Width="100%" HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="loccode" DataSourceID="SqlConn" >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <input type="radio" name="radSelect" onclick="javascript:selectLocation(this);" value='<%#Eval("loccode")%>'  />
                                    </ItemTemplate>
                                    <ControlStyle Width="10%" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="locname" HeaderText="Loc Name" ReadOnly="True" SortExpression="locname" >
                                    <ControlStyle Width="30%" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="loccode" HeaderText="Loc Code" ReadOnly="True" SortExpression="loccode" >
                                    <ControlStyle Width="60%" />
                                </asp:BoundField>
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="SELECT LOCNAME,LOCCODE FROM WEBX_LOCATION">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
          
        </div>
    </form>
</body>
</html>
