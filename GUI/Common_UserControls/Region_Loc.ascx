<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Region_Loc.ascx.cs" Inherits="GUI_Common_UserControls_Region_Loc" %>

<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />

<div>
    <div id="tabs" style="text-align: left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color: DarkGray">
        <table cellspacing="1" cellpadding ="3" border="0" class="boxbg" width="400">
            <tr id="trRO" style="background-color: white" runat="server">
                <td class="blackfnt" id="Srt" runat="server" width="30%" >
                  Select Region 
                </td>
                <td class="blackfnt" width="70%">
                    <asp:UpdatePanel ID="UP" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="dbR" runat="server" AutoPostBack="true" OnSelectedIndexChanged="dbR_SelectedIndexChanged">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr id="trAO" style="background-color: white" runat="server" width="30%">
                <td class="blackfnt" id="dtAoLbl" runat="server">
                   Select Location
                </td>
                <td class="blackfnt" width="70%">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="dbL" runat="server" AutoPostBack="true" >
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
      </div>
    </div>
