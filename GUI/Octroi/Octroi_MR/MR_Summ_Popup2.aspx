<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_Summ_Popup2.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_DocketPrint_PaidMR_MR_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table bgcolor="white" border="0" cellpadding="3" cellspacing="1" class="boxbg" colspan="2"
                width="100%">
                <tr bgcolor="white">
                    <td align="left" rowspan="4" style="width: 62%">
                        <asp:Image ID="imgLogo" runat="server" ImageUrl="~/GUI/images/webxpress_logo.gif" /><br />
                        <br />
                        <strong><span style="font-size: 8pt; font-family: Verdana">MONEY RECEIPT</span></strong></td>
                    <td align="left" style="font-size: 12pt; font-family: Times New Roman">
                        <font class="blackfnt"><b><span>MR No</span></b></font></td>
                    <td align="left" style="font-size: 12pt; width: 210px; font-family: Times New Roman">
                        <font class="blackfnt"><strong><span style="font-size: 8pt">&nbsp;<asp:Label ID="lblMRNo"
                            runat="server" CssClass="blackfnt"></asp:Label></span></strong></font></td>
                </tr>
                <tr bgcolor="#ffffff" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <td align="left" style="width: 16%">
                        <font class="blackfnt"><b>Manual MR No</b></font></td>
                    <td align="left" style="width: 210px">
                        <font class="blackfnt">&nbsp;<asp:Label ID="Label1" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 16%">
                        <font class="blackfnt"><b>MR Type</b></font></td>
                    <td align="left" class="blackfnt">
                        &nbsp;<%=MRSTYPE%></td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td align="left" style="width: 16%">
                        <strong><span style="font-size: 8pt; font-family: Verdana">Party Code</span></strong></td>
                    <td align="left" class="blackfnt">
                        &nbsp;<%=PTCD%>
                        &nbsp;:&nbsp;<%=PTNAME%>
                    </td>
                </tr>
            </table>
            <br />
            <table bgcolor="white" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%">
                <tr bgcolor="white">
                    <td align="left" style="height: 39px">
                        <font class="blackfnt"><b><span>To<br />
                            <asp:Label ID="lblAdd" runat="server" CssClass="blackfnt" Height="57px" Width="180px"></asp:Label></span></b></font></td>
                </tr>
            </table>
            <br />
            <table bgcolor="white" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%">
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;Docket No</td>
                    <td align="right" class="blackfnt">
                        <%=DOCKNO%>
                        <%=DOCKSF%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Docket Date</td>
                    <td align="right" class="blackfnt">
                        <%=DOCKDT%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Origin Delivery</td>
                    <td align="right" class="blackfnt">
                        <%=Origin%>
                        &nbsp;
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;MR Date</td>
                    <td align="right" class="blackfnt">
                        <%=MRSDT%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Close Date</td>
                    <td align="right" class="blackfnt">
                       <%=finclosedt%></td>
                    <td align="left" class="blackfnt">
                        &nbsp;STATUS</td>
                    <td align="right" class="blackfnt">
                        <%=MRS_Close%>
                        &nbsp;
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;Freight</td>
                    <td align="right" class="blackfnt">
                        <%=FrightAmount%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Other Amount (+)</td>
                    <td align="right" class="blackfnt">
                        <%=OtherDedu%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;S Tax</td>
                    <td align="right" class="blackfnt">
                        <%=SerTad%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Deduction (-)</td>
                    <td align="right" class="blackfnt">
                        <%=Dedu%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;Cess</td>
                    <td align="right" class="blackfnt">
                        <%=Cess%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;TDS (-)</td>
                    <td align="right" class="blackfnt">
                        <%=TDSAmt%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                    <td align="left" class="blackfnt">
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;Higher Hdu Cess</td>
                    <td align="right" class="blackfnt">
                        <%=Hedu_Cess%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        <b>&nbsp;NET MR AMOUNT</b></td>
                    <td align="right" class="blackfnt">
                        <b>
                            <%=NetAmt%>
                            &nbsp; </b>
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;Payment Mode</td>
                    <td align="right" class="blackfnt">
                        <%=paymode%>
                        &nbsp;
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="blackfnt">
                        &nbsp;Docket Total</td>
                    <td align="right" class="blackfnt">
                        <%=DKT_Tot%>
                        &nbsp;
                    </td>
                    <td align="left" class="blackfnt">
                        <b>&nbsp;Collection Amount</b></td>
                    <td align="right" class="blackfnt">
                        <b>
                            <%=CollAmt%>
                            &nbsp; </b>
                    </td>
                    <td align="left" class="blackfnt">
                        &nbsp;UNADJUSTED</td>
                    <td align="right" class="blackfnt">
                    <%=UnAdj%>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <table bgcolor="white" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%"
            align="center">
            <tr bgcolor="white">
                <td align="center" class="blackfnt" colspan="5">
                    <b>Collection Details</b>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" class="blackfnt">
                    Cheque No</td>
                <td align="center" class="blackfnt">
                    Cheque Date</td>
                <td align="center" class="blackfnt">
                    Cheque Amount</td>
                <td align="center" class="blackfnt">
                    Amount to be Accounted</td>
                <td align="center" class="blackfnt">
                    Bank Name&nbsp; |&nbsp; Branch</td>
            </tr>
            <tr bgcolor="white">
                <td align="center" class="blackfnt">
                    <%=ChequeNo%>
                </td>
                <td align="center" class="blackfnt">
                    <%=ChequeDt%>
                </td>
                <td align="center" class="blackfnt">
                    <%=ChqueAmt%>
                </td>
                <td align="center" class="blackfnt">
                    <%=ChqueAcc%>
                </td>
                <td align="center" class="blackfnt">
                    <%=BankName%>
                    &nbsp; |&nbsp;
                    <%=BranchCode%>
                </td>
            </tr>
        </table>
        <br />
        <table bgcolor="white" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%">
            <tr bgcolor="white">
                <td align="left" style="height: 39px">
                    <font class="blackfnt"><b><span style="vertical-align: top">&nbsp;Remarks</span></b></font></td>
            </tr>
        </table>
        <br />
        <table bgcolor="white" border="0" cellpadding="2" cellspacing="1" class="boxbg" width="100%"
            align="center">
            <tr bgcolor="white">
                <td align="center" class="blackfnt">
                    <b>Prepared At - Date</b></td>
                <td align="center" class="blackfnt">
                    <b>Prepared by staff Name</b></td>
                <td align="center" class="blackfnt">
                    <b>Approval Sign</b></td>
                <td align="center" class="blackfnt">
                    <b>Entered At - Date</b></td>
                <td align="center" class="blackfnt">
                    <b>Entered by</b></td>
            </tr>
            <tr bgcolor="white">
                <td align="center" class="blackfnt">
              
                </td>
                <td align="center" class="blackfnt">
                </td>
                <td align="center" class="blackfnt">
                </td>
                <td align="center" class="blackfnt">  <%=PrepareBy%>
                </td>
                <td align="center" class="blackfnt">
                <%=EnterBy%>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
