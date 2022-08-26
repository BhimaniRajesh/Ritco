<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="underconstrcut.aspx.cs" Inherits="underconstrcut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table style="width: 100%">

        <tr>
            <td align="left"  >
                <asp:Label ID="lblWelcome" runat="server" Text="Fleet Reports" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    
        <tr>
            
            
            <td valign="top" align="center" style="width: 50%">
             <br><br><asp:Image ID="Image1" ImageUrl="~/GUI/images/under.jpg" runat="server" />
           </td>
        </tr>
    </table>

</asp:Content>
