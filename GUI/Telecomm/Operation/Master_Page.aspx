<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Master_Page.aspx.cs" Inherits="Operation_Master_Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Communication Master</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communication Master Type"></asp:Label><br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
        <br />
        <table bgcolor="#000000" border="0" cellpadding="4" cellspacing="1" class="boxbg"
            style="font-size: 12pt; left: 0px; width: 80%; font-family: Times New Roman;
            position: relative; top: 0px; height: 48px">
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" width="2%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4" /></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" style="width: 52%">
                    <font class="blackfnt" color="#0000ff"><a>Communication Device Type Master</a></font></td>
                <td align="left" colspan="1" width="90%">
                    &nbsp;<asp:LinkButton ID="lbtnTypeAdd" runat="server" CssClass="blackfnt" PostBackUrl="~/GUI/Telecomm/Operation/Device_Type_Add.aspx">Add</asp:LinkButton>
                    |
                    <asp:LinkButton ID="lbtnTypeEdit" runat="server" CssClass="blackfnt" PostBackUrl="~/GUI/Telecomm/Operation/Device_Type_Edit.aspx">Edit</asp:LinkButton></td>
            </tr>
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" width="2%" style="height: 21px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img src="../images/clear.gif" width="4" /></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" style="width: 52%; height: 21px;">
                    <font class="blackfnt" color="#0000ff"><a>Communication Device Master</a></font></td>
                <td align="left" colspan="1"  width="90%" style="height: 21px">
                    &nbsp;<asp:LinkButton ID="lbtnDeviceAdd" runat="server" PostBackUrl="~/GUI/Telecomm/Operation/Device_Master_Add.aspx">Add</asp:LinkButton>
                    |
                    <asp:LinkButton ID="lbtnDeviceEdit" runat="server" PostBackUrl="~/GUI/Telecomm/Operation/Device_Master_Edit.aspx">Edit</asp:LinkButton></td>
            </tr>
        </table>
   </asp:Content>
