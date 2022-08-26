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
        <tr class="bgbluegrey" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>Bill </b></font>
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
            <td style="width: 339px">
                <a href="Octroi_Bill/octCustBillStep1.aspx"><font class="blklnkund">Prepare Octroi Bill
                </font></a>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Submission </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Collection </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src=" ../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Cancellation </font>
            </td>
        </tr>
        <tr class="bgbluegrey" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>MR</b></font></td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a href="Octroi_MR/Query.aspx"><font class="blklnkund">Prepare Manual Octroi MR</font></td>
        </tr>
        <%--  <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><font class="blklnkund">Update 
                              Manual Octroi MR</font></td>
       </tr>--%>
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
                <font class="blklnkund">Manual Octroi MR Cancellation</font></td>
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
                <a href="Octroi_Bill/Direct_Agent_Voucher.aspx"><font class="blklnkund">Prepare Direct
                    Octroi Payment </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td align="center" valign="middle">
                <font class="bluefnt"><strong><b></b></strong></font>
            </td>
            <td style="width: 339px">
                <a href="Octroi_Bill/Agent_Bill_Entry.aspx"><font class="blklnkund">Prepare Agent Bill
                    Entry </font></a>
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
                <a href="Agent_Voucher/Query.aspx"><font class="blklnkund">Prepare Agent Voucher (From
                    Agent Bill) </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px; height: 25px;" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px; height: 25px;">
                <a href="Octroi_Bill/update_Manual_MR_1.aspx"><font class="blklnkund">Update Maual MR
                </font>
            </td>
        </tr>
        <tr class="bgbluegrey" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>View &amp; Print</b></font>
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
                <font class="blklnkund"><a id="A1" runat="server" href="ViewnPrint/OctroiBill_Step1.aspx">
                    View & Print Octroi Bills</a></font></td>
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
                <a runat="server" href="ViewnPrint/ManualOctroiMr_Step1.aspx"><font class="blklnkund">
                    View & Print Octroi MRs</font></a></td>
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
            <td style="width: 339px">
                <a id="A3" runat="server" href="ViewnPrint/DirectVoucher_Step1.aspx"><font class="blklnkund">
                    View & Print Direct Voucher </font></a>
            </td>
        </tr>
    </table>
</asp:Content>
