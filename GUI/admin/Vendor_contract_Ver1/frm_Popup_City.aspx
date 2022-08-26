<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frm_Popup_City.aspx.cs" Inherits="frm_Popup_City" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebXpress</title>
    <link id="Link1" href="../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />    
</head>

<body>
    <script type="text/javascript" language="javascript">
        function selectLocation(obj) {
            var selectedValue = obj.value.split("~");
            window.opener.document.getElementById("<%=CtrlID %>").value = selectedValue[0];
            window.close();
        }
    </script>
    
    <form id="form1" runat="server">
        <table border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <font class="blackfnt"><b><u>Note:</u></b> 
                        <br />- For All City list, keep blank the input box.
                    </font>
                </td>
            </tr>
        </table>

        <table border="1" cellspacing="1" cellpadding="2">
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <font class="blackfnt">Search by parameter</font>
                </td>
            </tr>            
            <tr>
                <td>
                    <font class="blackfnt">City Name</font>
                </td>
                <td>
                    <font class="blackfnt">
                        <asp:TextBox ID="tb_Location_Name" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="15" Width="111px"></asp:TextBox>
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
                    <font class="blackfnt"><b><u>Note:</u></b> 
                        <br/>- Click on radio buton to select City.
                    </font>
                </td>
            </tr>
        </table>
        <table border="0" cellspacing="1" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="250px">
                        <tr class="bgbluegrey">
                            <td align="left" width="10%">&nbsp;</td>                            
                            <td align="left" width="50%"><font class="blackfnt">City Name</font></td>
                        </tr>
                    </table>
                    <asp:DataList ID="dl_Location" runat="server">
                        <ItemTemplate>
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="250px">
                                <tr bgcolor="white">
                                    <td align="left" width="10%">
                                        <input type="radio" onclick="javascript:selectLocation(this);" value='<%#Eval("Location")%>' />
                                    </td>                                    
                                    <td align="left" width="50%">
                                        <label class="blackfnt"><%#Eval("Location")%></label>                                        
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:HiddenField ID="hf_Opener_Location" runat="server" />
                    <asp:HiddenField ID="hf_Selected_Locations" runat="server" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
