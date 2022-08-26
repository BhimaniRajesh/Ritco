<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="welcome.aspx.cs" Inherits="welcome" Title="WebXpress Warehouse Management System" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.0in" align="left">
        <tr>
            <td align="left" colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr>
            <td valign="top" style="width: 400px">
                <table cellpadding="3" cellspacing="1">
                    <tr class="bgbluegrey" style="height: 20px">
                        <td align="center">
                            <asp:Label ID="lbl1" Text="   " runat="server"></asp:Label>
                            <asp:Label ID="lblUpdates_head" CssClass="blackfnt" Font-Bold="true" Text="" runat="server"></asp:Label></td>
                    </tr>
                    <tr style="height: 30px">
                        <td>
                            <marquee direction="left"><asp:Label id="lblUpdates" runat="server" Font-Bold="true" CssClass="blackfnt" Text=""></asp:Label></marquee>
                        </td>
                    </tr>
                    <tr class="bgbluegrey" style="height: 20px">
                        <td align="center">
                            <asp:Label ID="lblNews_head" Width="380" CssClass="blackfnt" Font-Bold="true" Text=""
                                runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <iframe id="Iframe1" src="News/news.aspx" height="350" width="380" runat="server"></iframe>
                        </td>
                    </tr>
                </table>
            </td>
            <td align="center" valign="top" style="width: 100px">
                <table cellspacing="1" cellpadding="1" style="border-color: #8ba0e5; width: 100%"
                    bgcolor="#8ba0e5">
                    <tr bgcolor="#ffffff">
                        <td valign="top" align="center">
                          
                            <asp:Image ID="img1" ImageUrl="~/GUI/images/midimg.jpg" runat="server" />
                     
                        </td>
                    </tr>
                </table>
            </td>
            <td valign="top">
                <table style="width: 4.5in" cellpadding="3" cellspacing="1">
                    <tr align="left" class="bgbluegrey" style="height: 20px">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblTracklineHeading" CssClass="blackfnt" Font-Bold="true" Text=""
                                runat="server"></asp:Label></td>
                    </tr>
                    <tr align="left" style="height: 20px">
                        <td align="center">
                            <table style="width: 4.5in" cellpadding="3" cellspacing="1" class="boxbg" border="0">
                                <tr bgcolor="#ffffff">
                                    <td align="left" ><asp:Label ID="lbldocknt" CssClass="blackfnt" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                    <asp:TextBox ID="txtdktno" runat="server"  Width="150" ></asp:TextBox>
                                   <asp:Button id="btnSearch" Width="60" Text="Search" runat="server" OnClick="btnSearch_Click" ></asp:Button>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
