<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillNo_Popup_TLL.aspx.cs"
    Inherits="GUI_Octroi_ViewOctroiBill_BillNo_Popup_TLL" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">div.break {page-break-before:always}</style>
    <script language="javascript" type="text/javascript">

function loadme()
{
window.print();
}
window.load =loadme()
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table id="tblMain" runat="server">
                <tr>
                    <td>
                    <%for (int i = 1; i < 4; i++)
                          {
                              string Copyname = "";
                              if (i == 1)
                              {
                                  Copyname = "HO COPY";
                              }
                              else if (i == 2)
                              {
                                  Copyname = "CUSTOMER COPY";
                              }
                              else if (i == 3)
                              {
                                  Copyname = "ACKNOWLEDGEMENT COPY";
                              }
                      
                        %>
                       
                        <center class="blackfnt">
                            <b>
                                <%=Copyname %>
                            </b>
                        </center>
                        <table border="1" cellpadding="0" width="610" style="border-left-color: #000000;
                            border-bottom-color: #000000; border-top-style: solid; border-top-color: #000000;
                            border-right-style: solid; border-left-style: solid; border-right-color: #000000;
                            border-bottom-style: solid">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="0" cellspacing="0" style="margin: 10px">
                                        <tr>
                                            <td>
                                                <table border="0" cellpadding="0" cellspacing="0">
                                                    <tr class="blackfnt">
                                                        <td style="text-align: left" valign="top">
                                                            <asp:Image ID="imgAgility" runat="server" Height="76px" ImageUrl="~/GUI/images/TLL_000046.JPG"
                                                                Width="212px" />
                                                        </td>
                                                        <td style="width: 400px; text-align: left" valign="top">
                                                            <span style="font-size: 10pt"><strong>&nbsp;TIMES LOGISTIC LTD<br />
                                                            </strong></span>
                                                            
                                                            &nbsp;TLL House :-D-35 Okhla Industrial Area,<br />
                                                            <label class="blackfnt">
                                                                &nbsp;Phase -1, New Delhi-110020</label><br />
                                                           
                                                            <label class="blackfnt">
                                                                &nbsp;Tel :- 011-30883771-85,Fax :- 26814377</label><br />
                                                            <label class="blackfnt">
                                                                &nbsp;E-mail : billing@tll.co.in,billingexport@tll.co.in &nbsp;
                                                                <br />
                                                                &nbsp;Website :www.tll.co.in</label><br />
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 10px">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="letter-spacing: 0.2pc; text-align: center">
                                                            <strong><span style="font-size: 15pt">OCTROI BILL</span></strong></td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="letter-spacing: 0.5pc; height: 5px; text-align: center">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: center">
                                                            <table border="1" cellpadding="0" cellspacing="1" style="border-left-color: #000000;
                                                                border-bottom-color: #000000; border-top-style: solid; border-top-color: #000000;
                                                                border-right-style: solid; border-left-style: solid; background-color: black;
                                                                border-right-color: #000000; border-bottom-style: solid" width="600">
                                                                <tr style="background-color: white">
                                                                    <td style="width: 250px; text-align: left" rowspan="4" valign="top">
                                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    <span style="font-size: 10pt">&nbsp;To </span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    &nbsp;<asp:Label ID="lblCompName" runat="server" Font-Size="10pt"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    &nbsp;<asp:Label ID="lblCompAddress" runat="server" Font-Size="9pt"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Bill No</td>
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;<asp:Label ID="lblBillNo" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Manual Bill No</td>
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;<asp:Label ID="lblManualBillNo" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Bill Date</td>
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;<asp:Label ID="lblBillDate" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Customer Code</td>
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;<asp:Label ID="lblCustCode" runat="server"></asp:Label></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: center; height: 15px;">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: center">
                                                            <table border="1" cellpadding="0" cellspacing="1" style="border-left-color: #000000;
                                                                border-bottom-color: #000000; border-top-style: solid; border-top-color: #000000;
                                                                border-right-style: solid; border-left-style: solid; height: 100%; background-color: black;
                                                                border-right-color: #000000; border-bottom-style: solid" width="600">
                                                                <tr style="background-color: white">
                                                                    <td rowspan="6" style="width: 250px; text-align: left" valign="top">
                                                                        <table border="0" cellpadding="0" cellspacing="0">
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    <strong><span style="font-size: 10pt">&nbsp; Other Charges</span></strong></td>
                                                                            </tr>
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    <span style="font-size: 10pt">&nbsp;( Details as per attachment )</span></td>
                                                                            </tr>
                                                                            <tr style="background-color: white">
                                                                                <td>
                                                                                    &nbsp;</td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="text-align: center">
                                                                        <strong style="width: 175px; text-align: left">Particulars</strong></td>
                                                                    <td style="text-align: center">
                                                                        <strong style="width: 175px; text-align: right">Amount(Rs.)</strong></td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Octroi Amount</td>
                                                                    <td style="width: 175px; text-align: right">
                                                                        <asp:Label ID="lblOAmt" runat="server"></asp:Label>&nbsp;</td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Octroi Charges</td>
                                                                    <td style="width: 175px; text-align: right">
                                                                        <asp:Label ID="lblOCharge" runat="server"></asp:Label>&nbsp;</td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Service Tax</td>
                                                                    <td style="width: 175px; text-align: right">
                                                                        <asp:Label ID="lblSerViceTax" runat="server"></asp:Label>&nbsp;</td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        &nbsp;Other Charges</td>
                                                                    <td style="width: 175px; text-align: right">
                                                                        <asp:Label ID="lblOthCharges" runat="server"></asp:Label>&nbsp;</td>
                                                                </tr>
                                                                <tr style="font-size: 8pt; background-color: white">
                                                                    <td style="width: 175px; text-align: left">
                                                                        <strong>&nbsp;Net Payable</strong></td>
                                                                    <td style="width: 175px; text-align: right">
                                                                        <asp:Label ID="lblNetPay" runat="server"></asp:Label>&nbsp;</td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 5px; text-align: left">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: left; height: 16px;">
                                                            &nbsp;Total Payable Amount in Rupees: (In Words) :
                                                            <asp:Label ID="lblWordRs" runat="server"></asp:Label>
                                                            Only</td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: center; height: 15px;">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: center">
                                                            <table border="1" cellpadding="0" cellspacing="1" style="border-left-color: #000000;
                                                                border-bottom-color: #000000; border-top-style: solid; border-top-color: #000000;
                                                                border-right-style: solid; border-left-style: solid; height: 100%; background-color: black;
                                                                border-right-color: #000000; border-bottom-style: solid" width="600">
                                                                <tr style="background-color: white;">
                                                                    <td style="text-align: right;" colspan="3">
                                                                        <strong>Authorised Singnatory&nbsp;</strong></td>
                                                                </tr>
                                                                <tr style="background-color: white">
                                                                    <td style="text-align: left; width:250px">
                                                                        <strong>&nbsp;Pan No- AACCT6034E</strong></td>
                                                                    <td  style="text-align: left; width:175px">
                                                                        <strong>&nbsp;Service Tax No- &nbsp;&nbsp;
                                                                            <br />
                                                                            &nbsp;AACCT6034EST001</strong></td>
                                                                    <td  style="text-align: left; width:175px">
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: left">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: left">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: left; height: 15px;">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: left">
                                                            <strong><span style="text-decoration: underline">TERMS OF PAYMENTS : </span></strong>
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: justify">
                                                            <strong>1.</strong>&nbsp; Please pay by cheque/Draft only,favouring Times Logistics
                                                            Ltd<span style="font-size: 8pt">.</span></td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 6px; text-align: justify">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: justify">
                                                            <strong>2.</strong>&nbsp; In case of any discrepency, please bring to our notice
                                                            within 7 days
                                                            of receipt of this bill, failing 
                                                            <br />
                                                            &nbsp; &nbsp;&nbsp; which no claim will be entertained.</td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 6px; text-align: justify">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: justify">
                                                            <strong>3.</strong>&nbsp; Late payments are subjected to interest
                                                            @ 24% per annum.</td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 6px; text-align: justify">
                                                        </td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="text-align: justify">
                                                            <strong>4.</strong>&nbsp; &nbsp;All disputes subject to Delhi Jurisdiction.</td>
                                                    </tr>
                                                    <tr class="blackfnt">
                                                        <td colspan="2" style="height: 6px; text-align: justify">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <div class="break"></div>
                        <%} %>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
