<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillNo_Popup.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Register_BillNo_Popup" EnableEventValidation="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <table id="tblxls" runat="server">
            <tr>
                <td>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <img id="imgLogo" src="../../../images/webxpress_logo.gif" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="TABLE2" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="100%">
                            <tr>
                                <td style="width: 619px" class="blackfnt">
                                    To,<br />
                                    <asp:Label ID="lblName" runat="server" CssClass="blackfnt" Width="380px"></asp:Label></td>
                                <td>
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 50%" class="blackfnt">
                                                <label class="blackfnt">
                                                    Bill No
                                                </label>
                                            </td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblBillNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt">
                                                Manual Bill No</td>
                                            <td>
                                                <asp:Label ID="lblManBillNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%" class="blackfnt">
                                                Bill Date</td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblBillDate" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%">
                                                <label class="blackfnt">
                                                    Customer Code
                                                </label>
                                            </td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblCustCode" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table id="TABLE1" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="100%">
                            <tr style="background-color: white">
                                <td style="width: 51%" valign="top">
                                    <label class="blackfnt">
                                        <span style="font-size: 8pt; font-family: Verdana">Cargo Courier Charges ( Details as
                                            per attachment )</span></label></td>
                                <td align="left" width="100%">
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 79%">
                                                <label class="blackfnt">
                                                </label>
                                            </td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <b>Total Amount(Rs.)</b></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Freight</td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <asp:Label ID="lblFreight" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Docket Chrages</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDocChrg" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <label class="blackfnt">
                                                    Door Collection Charges</label></td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblCollChrg" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Door Delivery Charges</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDevChrg" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                FOV</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblFOV" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Other Charges(+)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblOthChrg" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Deduction Charges(-)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDeduChrg" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Total</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblTot" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Service Tax @ 12%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblSvcTax" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                CESS @ 2%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblCess" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                High Education Cess @ 1%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblhigheducess" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <strong>Net Payable&nbsp;</strong>
                                                <br />
                                                <asp:Label ID="lbltotalinword" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblNetPay" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <font class="blackfnt">For WebXPress</font><br />
                    <table border="1" cellpadding="1" cellspacing="1" width="60%">
                        <tr style="background-color: white">
                            <td colspan="2" style="width: 723px" valign="top">
                                <br />
                                <asp:Label ID="lblsrvtax" runat="server" Width="420px"></asp:Label>
                                <br />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellpadding="1" cellspacing="2" width="100%">
                        <tr>
                            <td>
                                <font class="blackfnt"><b><u>TERMS OF PAYMENTS : </u>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; Authorised Signatory </b></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 18px">
                                <font class="blackfnt">1. Please pay by cheque/Draft only,favouring "WebXPress" &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <span style="font-size: 12pt; font-family: Times New Roman">
                                    </span></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 6px">
                                <font class="blackfnt">2. In case of any discrepency, please bring to our notice within
                                    7 days of receipt of this bill, failing which no claim will be entertained.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">3. Late payments are subjected to interest @ 24% per annum.</font></td>
                        </tr>
                        <tr>
                            <td style="height: 18px">
                                <font class="blackfnt">4. All disputes subject to Delhi Jurisdiction.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">5. PODs attached with the bill (Yes/No)</font></td>
                        </tr>
                    </table>
                    <br />
                    <center class="blackfnt">
                        <b>HO COPY</b></center>
                    <br />
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <img id="img1" src="../../../images/webxpress_logo.gif" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="TABLE3" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="100%">
                            <tr>
                                <td style="width: 619px" class="blackfnt">
                                    To,<br />
                                    <asp:Label ID="lblName1" runat="server" CssClass="blackfnt" Width="401px"></asp:Label></td>
                                <td>
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 50%; height: 18px;" class="blackfnt">
                                                <label class="blackfnt">
                                                    Bill No
                                                </label>
                                            </td>
                                            <td style="width: 50%; height: 18px;">
                                                <asp:Label ID="lblBillNo1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt">
                                                Manual Bill No</td>
                                            <td>
                                                <asp:Label ID="lblManBillNo1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%" class="blackfnt">
                                                Bill Date</td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblBillDate1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%">
                                                <label class="blackfnt">
                                                    Customer Code
                                                </label>
                                            </td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblCustCode1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table id="TABLE4" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            style="width: 100%">
                            <tr style="background-color: white">
                                <td style="width: 51%" valign="top">
                                    <label class="blackfnt">
                                        <span style="font-size: 8pt; font-family: Verdana">Cargo Courier Charges ( Details as
                                            per attachment )</span></label></td>
                                <td align="left" width="100%">
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 79%">
                                                <label class="blackfnt">
                                                </label>
                                            </td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <b>Total Amount(Rs.)</b></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Freight</td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <asp:Label ID="lblFreight1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Docket Chrages</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDocChrg1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <label class="blackfnt">
                                                    Door Collection Charges</label></td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblCollChrg1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Door Delivery Charges</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDevChrg1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                FOV</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblFOV1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Other Charges(+)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblOthChrg1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Deduction Charges(-)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDeduChrg1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Total</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblTot1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Service Tax @ 12%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblSvcTax1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%; height: 10px;">
                                                CESS @ 2%</td>
                                            <td align="right" style="width: 50%; height: 10px;">
                                                <asp:Label ID="lblCess1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                High Education Cess @ 1%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblhigheducess2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <strong>Net Payable&nbsp;</strong>
                                                <br />
                                                <asp:Label ID="lbltotalinword1" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblNetPay1" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <font class="blackfnt">For WebXPress</font><br />
                    <table border="1" cellpadding="1" cellspacing="1" width="60%">
                        <tr style="background-color: white">
                            <td colspan="2" style="width: 723px" valign="top">
                                <label class="blackfnt">
                                    <br />
                                    <asp:Label ID="lblsrvtax2" runat="server" Width="398px"></asp:Label><br />
                                </label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellpadding="1" cellspacing="2" width="100%">
                        <tr>
                            <td>
                                <font class="blackfnt"><b><u>TERMS OF PAYMENTS : </u>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; Authorised Signatory </b></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 18px">
                                <font class="blackfnt">1. Please pay by cheque/Draft only,favouring "WebXPress" &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <span style="font-size: 12pt; font-family: Times New Roman">
                                    </span></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 6px">
                                <font class="blackfnt">2. In case of any discrepency, please bring to our notice within
                                    7 days of receipt of this bill, failing which no claim will be entertained.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">3. Late payments are subjected to interest @ 24% per annum.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">4. All disputes subject to Delhi Jurisdiction.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">5. PODs attached with the bill (Yes/No)</font></td>
                        </tr>
                    </table>
                    <br />
                    <%--</form>--%>
                    <center class="blackfnt">
                        <b>CUSTOMER COPY</b></center>
                    <br />
                    <%--<form id="form3" runat="server">--%>
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <img id="img2" src="../../../images/webxpress_logo.gif" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <table id="TABLE5" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            style="width: 100%">
                            <tr>
                                <td style="width: 619px" class="blackfnt">
                                    To,<br />
                                    <asp:Label ID="lblName2" runat="server" CssClass="blackfnt" Width="430px"></asp:Label></td>
                                <td>
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 50%" class="blackfnt">
                                                <label class="blackfnt">
                                                    Bill No
                                                </label>
                                            </td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblBillNo2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt">
                                                Manual Bill No</td>
                                            <td>
                                                <asp:Label ID="lblManBillNo2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%" class="blackfnt">
                                                Bill Date</td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblBillDate2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td style="width: 50%">
                                                <label class="blackfnt">
                                                    Customer Code
                                                </label>
                                            </td>
                                            <td style="width: 50%">
                                                <asp:Label ID="lblCustCode2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table id="TABLE6" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="100%">
                            <tr style="background-color: white">
                                <td style="width: 51%" valign="top">
                                    <label class="blackfnt">
                                        <span style="font-size: 8pt; font-family: Verdana">Cargo Courier Charges ( Details as
                                            per attachment )</span></label></td>
                                <td align="left" width="100%">
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 79%">
                                                <label class="blackfnt">
                                                </label>
                                            </td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <b>Total Amount(Rs.)</b></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Freight</td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <asp:Label ID="lblFreight2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Docket Chrages</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDocChrg2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <label class="blackfnt">
                                                    Door Collection Charges</label></td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblCollChrg2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Door Delivery Charges</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDevChrg2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                FOV</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblFOV2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Other Charges(+)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblOthChrg2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Deduction Charges(-)</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblDeduChrg2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Total</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblTot2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Service Tax @ 12%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblSvcTax2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                CESS @ 2%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblCess2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                High Education Cess @ 1%</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblhigheducess3" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                <strong>Net Payable&nbsp;</strong>
                                                <br />
                                                <asp:Label ID="lbltotalinword2" runat="server"></asp:Label>
                                            </td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblNetPay2" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; <font class="blackfnt">For WebXPress</font><br />
                    <table border="1" cellpadding="1" cellspacing="1" width="60%">
                        <tr style="background-color: white">
                            <td colspan="2" style="width: 723px" valign="top">
                                <label class="blackfnt">
                                    <br />
                                    <asp:Label ID="lblsrvtax3" runat="server" Width="417px"></asp:Label><br />
                                </label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellpadding="1" cellspacing="2" width="100%">
                        <tr>
                            <td>
                                <font class="blackfnt"><b><u>TERMS OF PAYMENTS : </u>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; Authorised Signatory </b></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 18px">
                                <font class="blackfnt">1. Please pay by cheque/Draft only,favouring "WebXPress" &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <span style="font-size: 12pt; font-family: Times New Roman">
                                    </span></font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td style="height: 6px">
                                <font class="blackfnt">2. In case of any discrepency, please bring to our notice within
                                    7 days of receipt of this bill, failing which no claim will be entertained.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">3. Late payments are subjected to interest @ 24% per annum.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">4. All disputes subject to Delhi Jurisdiction.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">5. PODs attached with the bill (Yes/No)</font></td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
        </table>
        <table style="width: 918px">
            <tr>
                <td align="center">
                    <asp:Button ID="cmdexcel" Text="Export To Excel" runat="server" OnClick="cmdexcel_Click" />
                </td>
            </tr>
        </table>
    </form>
    <center class="blackfnt">
        <b>ACKNOWLEDGEMENT COPY</b></center>
</body>
</html>
