<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wfrm_Popup_Vehicle.aspx.cs" Inherits="Inbound_GRN_wfrm_Popup_SKU" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Warehouse Management System</title>
   <%-- <link id="Link1" href="~/Images/style.css" rel="Stylesheet" type="text/css" runat="server" />--%>
   
   
<link href="../../../images/style.css" rel="stylesheet"
    type="text/css" />





    <script type="text/javascript" language="javascript">
      
        function selectSKU(obj) {
            var selectedValue = obj.value.split("~");

            var hf_Opener_tb_SKU_Code = document.getElementById("hf_Opener_tb_SKU_Code").value
         

            window.opener.document.getElementById(hf_Opener_tb_SKU_Code).value=selectedValue[0];
          
            window.close();
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <table border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <font class=blackfnt><b><u>Note:</u></b> 
                        <br />- For All Vehicle list, keep blank the input box.
                    </font>
                </td>
            </tr>
        </table>

        <table border=1 cellspacing=1 cellpadding=2>
            <tr class="bgbluegrey">
                <td colspan=2 align=center>
                    <font class=blackfnt>Search by parameter</font>
                </td>
            </tr>
            <tr>
                <td>
                    <font class=blackfnt>Vehicle No.</font>
                </td>
                <td>
                    <font class=blackfnt>
                        <asp:TextBox ID="txtVehNo" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="15" Width="111px"></asp:TextBox>
                    </font>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" colspan="2">
                    <asp:Button ID="btn_Submit" runat="server" Text="Submit" CssClass="blackfnt" Font-Bold="true" CausesValidation="false" OnClick="btn_Submit_Click"></asp:Button>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <font class=blackfnt><b><u>Note:</u></b> 
                        <br>- Click on radio buton to select Vehicle No.
                    </font>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350px">
                        <tr class="bgbluegrey">
                            <td align="left" width="10%">&nbsp;</td>
                            <td align="left" width="30%"><font class="blackfnt">Vehicle No.</font></td>
                          
                        </tr>
                    </table>
                    <asp:DataList ID="dl_VehNo" runat="server">
                        <ItemTemplate>
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="350px">
                                <tr class="bgbluegrey">
                                    <td bgcolor="white" align="left" width="10%">
                                        <input type="radio" onclick="javascript:selectSKU(this);" value='<%#Eval("Vehno")%>' />
                                    </td>
                                    <td bgcolor="white" align="left" width="30%">
                                        <font class="blackfnt"><%#Eval("Vehno")%></font>
                                    </td>
                                     
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:HiddenField ID="hf_Opener_tb_SKU_Code" runat="server" />
                   
  
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
