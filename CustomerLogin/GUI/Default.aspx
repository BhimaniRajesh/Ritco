<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/CustomerLogin/GUI/MasterPageLogin.master"     CodeFile="Default.aspx.cs" Inherits="GUI_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPHLogin" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr>
            <td style="width: 45%">
            </td>
            
            <td align="center" valign="top" style="width: 15%">
                <table cellspacing="1" cellpadding="1" style="border-color: #8ba0e5; width: 100%" bgcolor="#8ba0e5">
                    <tr bgcolor="#ffffff">
                        <td valign="top" align="center" >
                            <asp:Image ID="img1" ImageUrl="~/GUI/images/midimg.jpg" runat="server" />
                        </td>
                    </tr>

                </table>
            </td>
            
            <td valign="top" align="center" style="width: 40%">
                <asp:Login ID="Login1"  runat="server" BackColor="White" BorderColor="#E6E2D8" BorderPadding="3"
                    BorderStyle="Solid" BorderWidth="1px" CssClass="blackfnt" 
                    ForeColor="#333333" OnAuthenticate="Login1_Authenticate" Width="226px" TextBoxStyle-Width="100" DisplayRememberMe="False">
                    <TitleTextStyle BackColor="#D4E0E7" Font-Bold="True" Font-Size="0.9em" ForeColor="Black" HorizontalAlign="Left" />
                    <InstructionTextStyle Font-Italic="True" ForeColor="Black" HorizontalAlign="Left" />
                    <TextBoxStyle Font-Size="0.8em" Width="100px" />
                    <LoginButtonStyle CssClass="loginbut" />
<LabelStyle HorizontalAlign="Left" VerticalAlign="Top"/>
                </asp:Login>
            </td>
        </tr>
    </table>

</asp:Content>

