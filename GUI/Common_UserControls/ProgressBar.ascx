<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ProgressBar.ascx.cs" Inherits="GUI_Common_UserControls_ProgressBar" %>
<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
        <table cellspacing="2" class="boxbg" style="z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0">
            <tr class="bgwhite">
                <td>
                    <table>
                        <tr class="bgwhite">
                            <td align="right">
                                <asp:Image runat="server" ID="imgloading" ImageUrl="~/GUI/images/loading.gif" />
                            </td>
                            <td class="blackfnt">
                                &nbsp;&nbsp;&nbsp;<b>Please Wait ...</b>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
            opacity: .50; -moz-opacity: .50;" runat="server">
            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                left: 50%;" ID="Panel2" runat="server">
            </asp:Panel>
        </asp:Panel>
    </ProgressTemplate>
</asp:UpdateProgress>