<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopUpControl.ascx.cs" Inherits="GUI_Common_UserControls_PopUpControl" %>
<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<div>
    <div id="tabs" style="text-align: Left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color: DarkGray">
        <table border="0" cellpadding="3" cellspacing="1" class="boxbg" 
            style="width: 100%">
            <tr style="background-color: white">
                <td width="23%" >
                  <asp:Label ID="lbl_Hdr_Text" runat="server" Font-Bold="true"  Text=""></asp:Label> 
                </td>
                
                <td width="77%">
                    <asp:TextBox ID="tb_TextBox" runat="server" Height="50px" 
                        TextMode="MultiLine" Width="93%" BorderStyle="Groove"></asp:TextBox>
                    <asp:Button ID="btn_PopUp" runat="server" Text="..." />
                </td>
            </tr>
        </table>
    </div>
</div>
