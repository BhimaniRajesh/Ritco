<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Account_Reports_Balance_sheet_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table id="Table1" horizontalalign="left" runat="server" cellpadding="3" cellspacing="1"
        style="width: 8.5in;" cssclass="boxbg">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Accounts </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Balance Sheet </strong></font>
            </td>
        </tr>
       <%-- <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>--%>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="../../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <table border="0" horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 4.5in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Branch</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Report Sub Type</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                    
                </table>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
        <tr>
            <td valign="top" align="left">
                <br />
                <table id="Table2" runat="server" cellpadding="3" cellspacing="1" style="width: 8.5in;"
                    cssclass="boxbg">
                    <tr>
                        <td valign="top">
                            <asp:Table HorizontalAlign="left" ID="TBL_BS_Det" border="0" runat="server" CellPadding="3"
                                CellSpacing="1" Style="width: 5.6in;" CssClass="boxbg">
                            </asp:Table>
                        </td>
                        <td valign="top">
                            <asp:Table ID="TBL_BS" border="0" HorizontalAlign="left" runat="server" CellPadding="3"
                                CellSpacing="1" Style="width: 4.5in;" CssClass="boxbg">
                            </asp:Table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
