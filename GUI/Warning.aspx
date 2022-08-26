<%@ Page Language="C#" AutoEventWireup="true" CodeFile="warning.aspx.cs" Inherits="GUI_Exception_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebxPress</title>
    <link href="GUI/Images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table runat="server" ID="tblmain" BorderColor="red" BorderStyle="Double" BorderWidth="1" CellSpacing="1" Width="13in">
                <asp:TableRow BackColor="Red">
                    <asp:TableCell HorizontalAlign="Left" Height="20px">
                        <asp:Label ID="lblheading" runat="server" Font-Bold="true">Warning Message</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow BackColor="White">
                    <asp:TableCell Height="3in" CssClass="blackfnt" Font-Bold="true" VerticalAlign="Top">
                        <asp:Table ID="Table1" runat="server" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell Width="50%" VerticalAlign="Middle">
                                    <asp:Table ID="Table2" runat="server" >
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true"><br />
                                                <asp:Label ID="Label3" runat="server" ForeColor="Black" Font-Size="20"  Font-Names="Book antiqua" >You can not login with this browser. </asp:Label> 
                                                <br />
                                                <br />
                                                <br />
                                                <asp:Label ID="Label1" runat="server" ForeColor="Black" Font-Size="20"  Font-Names="Book antiqua" >Please always use Internet Explorer for this site. </asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        
                                    </asp:Table>
                                </asp:TableCell>
                                <asp:TableCell Width="50%">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/GUI/images/warning.jpg"/>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </div>
    </form>
</body>
</html>
