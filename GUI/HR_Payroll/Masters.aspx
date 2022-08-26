<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Masters.aspx.cs" Inherits="GUI_HR_Payroll_Masters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">HR & Payroll :- Masters</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>HR & Payroll :- Masters</b> </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width="8%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">PF Master </font>
            </td>
            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add / Edit" PostBackUrl="PF MAster/PF_MASTER.aspx?pa=1" />
                 
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width="8%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">ESI Master </font>
            </td>
            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="ESI MAster/ESI_MASTER.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="ESI MAster/list_ESI.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width="8%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Salary Head Master </font>
            </td>
            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton11" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="salary head/SAL_HEAD_MASTER.aspx?pa=1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton12" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit"   PostBackUrl="salary head/SAL_HEAD_EDIT.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle" width="8%">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Leave Master </font>
            </td>
            <td align="center" nowrap>
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="~/GUI/HR_Payroll/Master/Leave_master/Leave_Master_Step1.aspx?N,1" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="~/GUI/HR_Payroll/Master/Leave_master/Leave_Master_Step2.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">PT Master </font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="#" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="#" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
                <font class="bluefnt" size="25"><b>.</b></font>
            </td>
            <td align="left" width="80%">
                <font class="blackfnt">Salary Head Master</font>
            </td>
            <td align="center">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Add" PostBackUrl="#" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false"
                    Text="Edit" PostBackUrl="#" />
            </td>
        </tr>
    </table>
</asp:Content>
