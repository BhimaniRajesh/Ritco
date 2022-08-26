<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ReAssign_Paybasis.aspx.cs" Inherits="octroi_octCustBillStep1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <center>
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 70%; height: 263px;" border="0">
                    <tr align="center">
                        <td style="height: 324px" align="center" colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Enter Docket for Re-Assigning of Pay Basis
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" style="height: 25px; width: 100px;">
                                        <asp:Label ID="lbl" CssClass="blackfnt" Text="Docket No :" runat="server" Width="102px"></asp:Label>
                                    </td>
                                    <td align="left" style="height: 25px; width: 100px;">
                                        <asp:TextBox ID="txtdoc" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="left" valign="top" style="height: 25px">
                                        <asp:Button ID="submit1" runat="server" OnClick="submit1_Click" Text="Submit" />
                                    </td>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </center>
</asp:Content>
