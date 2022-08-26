<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_M.aspx.cs" Inherits="GUI_Exception_Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WebxPress</title>
    <link href="GUI/Images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Table runat="server" ID="tblmain" CssClass="boxbg" CellSpacing="1" Width="10in">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Left" Height="20px">
                        <asp:Label ID="lblheading" runat="server" Font-Bold="true">Module Under Mainteinance</asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow BackColor="White">
                    <asp:TableCell Height="3in" CssClass="blackfnt" Font-Bold="true" VerticalAlign="Top">
                        <asp:Table runat="server" Width="100%">
                            <asp:TableRow>
                                <asp:TableCell Width="50%" VerticalAlign="Top">
                                    <asp:Table runat="server" Width="100%" Height="100%">
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br /><br />&nbsp;
                                                        Action being performed
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lbldetail1" runat="server" CssClass="blackfnt" >Server is Shifting</asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbldetail2" runat="server" CssClass="blackfnt" ></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                         <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br /></asp:TableCell>
                                        </asp:TableRow>
                                        
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br />&nbsp;
                                                Possible Suggesions
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true"><br />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" CssClass="blackfnt" >Please wait till tomorrow</asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br />&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Label ID="lblsuggesion1" runat="server" CssClass="blackfnt" ></asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow>
                                            <asp:TableCell Font-Bold="true">
                                            <br />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblsuggesion2" runat="server" CssClass="blackfnt" >&nbsp;</asp:Label>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                                <asp:TableCell Width="50%">
                                    <asp:Image runat="server" ImageUrl="~/GUI/images/maintainance.jpg" />
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
