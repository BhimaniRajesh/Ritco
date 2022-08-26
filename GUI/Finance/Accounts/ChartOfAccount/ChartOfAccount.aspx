<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  EnableEventValidation="false"  AutoEventWireup="true" CodeFile="ChartOfAccount.aspx.cs" Inherits="GUI_Finance_Accounts_ChartOfAccount_ChartOfAccount" Title="Chart Of Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <div style="width: 10in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" border="0" src="../../../images/back.gif" /></a>
    </div>
    <br />
    <div style="text-align: center; width: 10.0in">
    <table cellspacing="1" class="boxbg" width="800">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Label ID="lblHeading" runat="server" Font-Bold="True" Text="Chart Of Account "></asp:Label></td>
        </tr>
    </table>
    <br />
    <table cellspacing="1"  width="800">
        <tr>
            <td style="text-align: left">
                <asp:TreeView ID="trvAcc" runat="server"  ImageSet="Arrows" Target="_Self">
                    <ParentNodeStyle Font-Bold="True"  />
                    <HoverNodeStyle ForeColor="#5555DD" />
                    <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" HorizontalPadding="0px"
                        VerticalPadding="0px" />
                    <NodeStyle Font-Names="Verdana"  Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
                        NodeSpacing="0px" VerticalPadding="0px" />
                    <RootNodeStyle Font-Bold="True" />
                </asp:TreeView>
            </td>
        </tr>
    </table>
        <br />
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>
                        <asp:Button ID="btnXsl" runat="server" OnClick="btnXsl_Click" Text="XLS Download" /></strong>
                        </td>
            </tr>
        </table>
    </div>
</asp:Content>

