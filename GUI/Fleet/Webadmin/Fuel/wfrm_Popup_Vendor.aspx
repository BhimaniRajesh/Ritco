<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wfrm_Popup_Vendor.aspx.cs" Inherits="GUI_Fleet_Webadmin_Fuel_wfrm_Popup_Vendor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script type="text/javascript" language="javascript" src="AJAX_Validator/js_Fuel.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>WebXpress</title>
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    </head>
<body >
    <form id="form1" runat="server">
        <table border=0 cellspacing=1 cellpadding=0>
            <tr>
                <td>
                    <font class=blackfnt><b><u>Note:</u></b> 
                        <br />- For All Vendor list, keep blank both the input box.
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
                    <font class=blackfnt><asp:Label ID="lblCode" runat="server" Text="Vendor Code :"></asp:Label></font>
                </td>
                <td>
                    <font class=blackfnt>
                        <asp:TextBox ID="tb_VendorCode" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="25" Width="111px"></asp:TextBox>
                    </font>
                </td>
            </tr>
            <tr>
                <td>
                    <font class=blackfnt><asp:Label ID="lblName" runat="server" Text="Vendor Name :"></asp:Label></font>
                </td>
                <td>
                    <font class=blackfnt>
                        <asp:TextBox ID="tb_VendorName" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="25" Width="111px"></asp:TextBox>
                    </font>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" colspan="2">
                    <asp:Button ID="btn_Submit" runat="server" Text="Submit" CssClass="blackfnt" Font-Bold="true" CausesValidation="false" OnClick="btn_Submit_Click"></asp:Button>
                </td>
            </tr>
        </table>
        <table border=0 cellspacing=1 cellpadding=0>
            <tr>
                <td>
                    <font class=blackfnt><b><u>Note:</u></b> 
                        <br>- Click on radio buton to select Vendor.
                    </font>
                </td>
            </tr>
        </table>
        <table border=0 cellspacing=1 cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="250px">
                        <tr class="bgbluegrey">
                            <td align="left" width="20px"></td>
                            <td align="left" width="80px"><font class="blackfnt">Vendor Code</font></td>
                            <td align="left"><font class="blackfnt">Vendor Name</font></td>
                        </tr>
                    </table>

                    <asp:DataList ID="dl_Vendor" runat="server">
                        <ItemTemplate>
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="250px">
                                <tr>
                                    <td bgcolor="white" align="left" width="20px">
                                        <input type="radio" onclick="javascript:selectVendor(this);" value='<%# DataBinder.Eval(Container.DataItem, "VendorCode") %>~<%# DataBinder.Eval(Container, "DataItem.VendorName") %>' />
                                    </td>
                                    <td bgcolor="white" align="left" width="80px">
                                        <font class="blackfnt">
                                            <asp:Label ID="lbl_VendorCode" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.VendorCode") %>'></asp:Label>
                                        </font>
                                    </td>
                                    <td bgcolor="white" align="left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lbl_VendorName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.VendorName") %>'></asp:Label>
                                        </font>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
