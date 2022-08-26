<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ErrorPage.aspx.cs" Inherits="GUI_ErrorPage" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fund Transfer</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="39%" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td height="300" valign="top">
                            <br />
                            <br />
                            <br />
                            <table border="1" cellspacing="0" cellpadding="2" width="70%" align="center">
                                <tr>
                                    <td align="center" class="bgbluegrey">
                                        <font class="blackfnt" color="red"><b>Result</b></font></td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <p align="center">
                                            <font class="blackfnt">
                                                <asp:Label ID="lblError" runat="server" Text=""></asp:Label></font><br>
                                            <br /><font class="blackfnt"><a href="javascript:history.go(-1)"><u>Back</u></a>
                                        </p>
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
