<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_CBS.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_TRIALBALANCE_PARTYWISE_Result_Trailbalance"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table id="Table3" runat="server" cellpadding="3" cellspacing="1" style="width: 5.5in;">
        <tr>
            <td>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td class="blackfnt" style="height: 12px">
                <font class="blackboldfnt">Reports</font> > <a href="../../rpt_finance.aspx"><font
                    class="blklnkund">Finace & Accounts </font></a>></font><font class="bluefnt"> Cash &
                        Bank Statement </font>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <br />
                <table align="left" style="width: 9.5in;" border="0" cellpadding="3" cellspacing="1"
                    class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="width: 211px; height: 10px">
                            <label class="blackfnt">
                                Date</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="width: 211px" class="blackfnt">
                            Location</td>
                        <td style="width: 343px">
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <br />
                <asp:Table ID="TBL_CBS" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1"
                    Style="width: 8.5in;" CssClass="boxbg">
                </asp:Table>
               
            </td>
        </tr>
        <tr>
        <td> <table id="Table2" runat="server" cellpadding="3" cellspacing="1" style="width: 5.5in;"
                    class="boxbg">
                    <tr style="background-color: #FFFFFF">
                        <td>
                            <asp:Button ID="btnShow" runat="server" Text="XLS Download" OnClick="btnShow_Click"
                                Width="75px" /></td>
                    </tr>
                </table></td>
        </tr>
    </table>
</asp:Content>
