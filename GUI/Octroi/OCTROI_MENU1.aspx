<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="OctRcptOption.aspx.cs" Inherits="octroi_OctRcptOption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <font class="blklnkund"><b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt">
                        <b>Octroi Management</b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 60%"
        align="left">
        <tr bgcolor="white" style="height: 25px">
            <td align="center" valign="middle">
                <font class="bluefnt"><strong><b></b></strong></font>
            </td>
            <td colspan="3" style="width: 339px">
                <a href="Octroi_Bill/Agent_Bill_Entry.aspx"><font class="blklnkund">Enter Octroi Agent
                    Bills </font></a>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blackfnt">Prepare Octroi Payment Voucher </font>
            </td>
            <td style="width: 339px">
                <a href="Agent_Voucher/Query.aspx"><font class="blklnkund">From Agent Bills </font>
            </td>
            <td style="width: 339px">
                <a href="Octroi_Bill/Direct_Agent_Voucher.aspx"><font class="blklnkund">Direct Octroi
                    Payment </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" valign="middle">
                            <font class="bluefnt"><b></b></font>
                        </td>
                    </tr>
                </table>
            </td>
            <td colspan="3" align="center">
                <font class="blckfnt"><b>View & Print </b></font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td colspan="3" style="width: 339px">
                <font class="blklnkund"><a id="A2" runat="server" href="ViewnPrint/AgentBill_Step1.aspx">
                    View & Print Agent Bills</a> </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td colspan="3" style="width: 339px">
                <a id="A3" runat="server"  href="ViewnPrint/DirectVoucher_Step1.aspx"><font class="blklnkund">
                    View & Print Direct Voucher </font></a>
            </td>
        </tr>
    </table>
</asp:Content>
