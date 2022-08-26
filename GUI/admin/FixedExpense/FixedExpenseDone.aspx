<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FixedExpenseDone.aspx.cs" Inherits="GUI_admin_FixedExpense_FixedExpenseDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="50%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
        <tr>
            <td>
                <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                    <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>Fixed Expense </u></b></font>
            </td>
            <td>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <table border="0" width="50%" cellpadding="1" cellspacing="1" class="boxbg">
        <tr class="bgbluegrey">
            <td align="center" style="height: 21px">
                <font class="blackfnt"><b>Fixed Expense</b></font>
            </td>
        </tr>
    </table>

    <table border="1" width="50%">
        <!--Row 1-->
        <tr bgcolor="#ffffff">
            <td align="left" colspan="2">
                <strong>
                    <asp:Label CssClass="bluefnt" runat="server" ID="lblDisplay"></asp:Label></strong>
            </td>
        </tr>
    </table>
</asp:Content>

