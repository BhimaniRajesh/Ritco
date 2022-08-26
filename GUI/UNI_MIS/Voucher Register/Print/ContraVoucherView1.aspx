<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContraVoucherView1.aspx.cs"
    Inherits="GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
// <!CDATA[

function TABLE1_onclick() {

}

// ]]>
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
    
            <%-- <asp:Panel ID="pnl_Journal" runat="server" Visible="false" Width="934px">
                <table align="center" border="0" width="98%" bgcolor="#FFFFFF" cellspacing="1" cellpadding="2"
                    id="TABLE1" onclick="return TABLE1_onclick()">
                    <tr>
                        <td width="25%" bgcolor="#FFFFFF">
                            <font face="Verdana" size="2">&nbsp;</font></td>
                        <td width="35%" bgcolor="#FFFFFF" align="center" valign="center">
                            <font face="Verdana" size="2"><b>
                                <%=typ%>
                                VOUCHER</b></font></td>
                        <td width="40%" bgcolor="#FFFFFF">
                            <table border="0" width="100%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Number :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=Voucherno%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Date :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=transdate%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Branch Code</font><br>
                                        <font face="Verdana" size="2">
                                            <%=brcd1%>
                                        </font>
                                    </td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Branch Name<br>
                                            <%=brnm%>
                                        </font>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <table align="center" border="0" width="98%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                    <tr>
                        <td bgcolor="#FFFFFF" align="center" valign="top" style="height: 20px">
                            <font size="2" face="Verdana"><b>A/C CODE</b></font></td>
                        <td bgcolor="#FFFFFF" align="center" valign="top" style="height: 20px">
                            <font size="2" face="Verdana"><b>A/C NAME</b></font></td>
                        <td bgcolor="#FFFFFF" align="center" valign="top" colspan="2" style="height: 20px">
                            <font size="2" face="Verdana"><b>AMOUNT</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=acccoded%>
                            </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=accdescd%>
                            </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>DR</b></font></td>
                        <td bgcolor="#FFFFFF" align="right" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=debit%>
                            </b></font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>&nbsp;</font></td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>&nbsp;</b></font></td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>TOTAL :</b></font></td>
                        <td bgcolor="#FFFFFF" align="right" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=debit%>
                            </b></font>
                        </td>
                        <%inwords=debit%>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=acccodedn%>
                            </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=accdescdn%>
                            </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>DR</b></font></td>
                        <td bgcolor="#FFFFFF" align="right" valign="top">
                            <font size="2" face="Verdana"><b>
                                <%=debitn%>
                            </b></font>
                        </td>
                    </tr>
                </table>
            </asp:Panel>--%>
            <br />
           
            <asp:Panel ID="pnlcontra_CASH_WITHDRAWAL" runat="server" Visible="false" Width="934px">
                <table align="center" border="0" width="98%" bgcolor="#FFFFFF" cellspacing="1" cellpadding="2">
                    <tr>
                        <td width="25%" bgcolor="#FFFFFF">
                            <font face="Verdana" size="2">&nbsp;</font></td>
                        <td width="35%" bgcolor="#FFFFFF" align="center" valign="center">
                            <font face="Verdana" size="2"><b>CONTRA VOUCHER</b></font></td>
                        <td width="40%" bgcolor="#FFFFFF">
                            <table border="0" width="100%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Number :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vvno%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Date :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vdt%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF" valign="top">
                                        <font face="Verdana" size="2">Branch Code</font><br>
                                        <font face="Verdana" size="2"></font>
                                    </td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vbrcd%>
                                        </font>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table align="center" border="0" width="98%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                    <tr>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>Reason : </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" colspan="3">
                            <font size="2" face="Verdana">
                                <%=narrationbank%>
                                <br>
                                <%=narrationcash%>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="left" colspan="4">
                            <font size="2" face="Verdana"><b>WITHDRAWAL FROM :</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>CHEQUE NO</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>DATE</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>BANK A/C CODE & NAME</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>AMOUNT</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">
                                <%=chqno%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">
                                <%=chqdt%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana">
                                <%=accdescbank%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="right">
                            <font size="2" face="Verdana">
                                <%=creditbank%>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="left" colspan="4">
                            <font size="2" face="Verdana"><b>RECEIVED TO :</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>&nbsp;</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>DATE</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>CASH A/C CODE & NAME</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>AMOUNT</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center" style="height: 20px">
                            <font face="Verdana" size="2">&nbsp;</font></td>
                        <td bgcolor="#ffffff" align="center" style="height: 20px">
                            <font face="Verdana" size="2">
                                <%=vdt%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center" style="height: 20px">
                            <font size="2" face="Verdana">
                                <%=accdesccash%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="right" style="height: 20px">
                            <font size="2" face="Verdana">
                                <%=debitcash%>
                            </font>
                        </td>
                    </tr>
               
                    <tr>
                        <td bgcolor="#ffffff" align="left" colspan="2">
                            <font face="Verdana" size="2">PASSED BY :</font></td>
                        <td bgcolor="#ffffff" align="left">
                            <font face="Verdana" size="2">CERTIFIED BY :</font></td>
                        <td bgcolor="#ffffff" align="left">
                            <font size="2" face="Verdana">RECEIVER'S SIGNATURE :</font></td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_contra_CASH_DEPOSIT" Visible="false" runat="server" Width="934px">
                <table align="center" border="0" width="98%" bgcolor="#FFFFFF" cellspacing="1" cellpadding="2">
                    <tr>
                        <td width="25%" bgcolor="#FFFFFF">
                            <font face="Verdana" size="2">&nbsp;</font></td>
                        <td width="35%" bgcolor="#FFFFFF" align="center" valign="center">
                            <font face="Verdana" size="2"><b>CONTRA VOUCHER</b></font></td>
                        <td width="40%" bgcolor="#FFFFFF">
                            <table border="0" width="100%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Number :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vvno%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">Voucher Date :</font></td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vdt%>
                                        </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="25%" bgcolor="#FFFFFF" valign="top">
                                        <font face="Verdana" size="2">Branch Code</font><br>
                                        <font face="Verdana" size="2"></font>
                                    </td>
                                    <td width="25%" bgcolor="#FFFFFF">
                                        <font face="Verdana" size="2">
                                            <%=vbrcd%>
                                        </font>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table align="center" border="0" width="98%" bgcolor="#000000" cellspacing="1" cellpadding="2">
                    <tr>
                        <td bgcolor="#FFFFFF" align="Left" valign="top">
                            <font size="2" face="Verdana"><b>Reason : </b></font>
                        </td>
                        <td bgcolor="#FFFFFF" align="Left" colspan="3">
                            <font size="2" face="Verdana">
                                <%=narrationcash%>
                                <br>
                                <%=narrationbank%>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="left" colspan="4">
                            <font size="2" face="Verdana"><b>DEPOSIT FROM :</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>&nbsp;</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>DATE</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>CASH A/C CODE & NAME</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>AMOUNT</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">&nbsp;</font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">
                                <%=vdt%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana">
                                <%=accdesccash%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="right">
                            <font size="2" face="Verdana">
                                <%=creditcash%>
                            </font>
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#FFFFFF" align="left" colspan="4">
                            <font size="2" face="Verdana"><b>RECEIVED TO :</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>CHEQUE NO</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2"><b>DATE</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>BANK A/C CODE & NAME</b></font></td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana"><b>AMOUNT</b></font></td>
                    </tr>
                    <tr>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">
                                <%=chqno%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center">
                            <font face="Verdana" size="2">
                                <%=chqdt%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="center">
                            <font size="2" face="Verdana">
                                <%=accdescbank%>
                            </font>
                        </td>
                        <td bgcolor="#ffffff" align="right">
                            <font size="2" face="Verdana">
                                <%=debitbank%>
                            </font>
                        </td>
                    </tr>
                 
                    <tr>
                        <td bgcolor="#ffffff" align="left" colspan="2">
                            <font face="Verdana" size="2">PASSED BY :</font></td>
                        <td bgcolor="#ffffff" align="left">
                            <font face="Verdana" size="2">CERTIFIED BY :</font></td>
                        <td bgcolor="#ffffff" align="left">
                            <font size="2" face="Verdana">RECEIVER'S SIGNATURE : </font>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <%--   <asp:Panel ID="pnl_contra_INTER_BANK" runat="server" Width="934px">
             
             
          </asp:Panel>--%>
            <asp:Panel ID="pnldb_cr" runat="server" Visible="false">
            <center>
            <font class="blackfnt"><b> <%=typ%> </b></font></center>
            <br />
            <br />
                <table bgcolor="white" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2"
                    width="100%">
                    <tr bgcolor="white">
                        <td style="width: 1in" class="bgbluegrey">
                            <font class="blackfnt">Branch</font>
                        </td>
                        <td style="width: 5in">
                            <font class="blackfnt">
                                <%=vbrcd %>
                            </font>
                        </td>
                        <td style="width: 1in" class="bgbluegrey">
                            <font class="blackfnt">No.</font>
                        </td>
                        <td>
                            <font class="blackfnt">
                                <%=vvno%>
                            </font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td class="bgbluegrey">
                            <font class="blackfnt">Paid To</font>
                        </td>
                        <td>
                            <font class="blackfnt">
                                <%=vpayto %>
                            </font>
                        </td>
                        <td class="bgbluegrey">
                            <font class="blackfnt">Date</font>
                        </td>
                        <td>
                            <font class="blackfnt">
                                <%=vdt %>
                            </font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td class="bgbluegrey">
                            <font class="blackfnt">Narration</font>
                        </td>
                        <td colspan="3">
                            <font class="blackfnt">
                                <%=vnarr %>
                            </font>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <font class="blackfnt">A/c :  <%=acccode1 %></font>
                <br />
                <br />
                <table bgcolor="white" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2"
                    width="100%">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <font class="blackfnt">DESCRIPTION</font>
                        </td>
                        <td align="center">
                            <font class="blackfnt">Rs.</font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        
                        <td >
                            <font class="bluefnt">
                                <%=acccode%>
                            </font>
                        </td>
                          <td>
                            <font class="blackfnt">
                                <%=dbttot%>
                            </font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="right">
                            <font class="blackfnt">Total Rs.</font>
                        </td>
                        <td>
                            <font class="blackfnt">
                                <%=dbttot%>
                            </font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td colspan="2"> 
                            <font class="blackfnt"><b> <%=inwords%> </b></font>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
