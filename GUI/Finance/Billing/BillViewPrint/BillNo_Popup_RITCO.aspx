<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillNo_Popup_RITCO.aspx.cs"
    Inherits="GUI_Finance_Billing_BillViewPrint_BillNo_Popup_RITCO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">div.break {page-break-before:always}</style>
    <%--<style type="text/css">div.break {page-break-after:always}</style>--%>
</head>
<body>
    <form id="form1" runat="server">
        <table id="tblxls" runat="server">
            <tr>
                <td>
                    <%for (int i = 1; i <= 2; i++)
                      {
                          string Copyname = "";
                          if (i == 1)
                          {
                              Copyname = "CUSTOMER COPY";
                          }
                          else if (i == 2)
                          {
                              Copyname = "ACKNOWLEDGEMENT COPY";
                          }
                          
                      
                    %>
                    <div>
                        <table border="0" cellpadding="1" cellspacing="1" width="90%">
                            <tr>
                                <td>
                                    <%if (i == 1)
                                      { %>
                                    <img id="imgLogo" runat="server" />
                                    <%} %>
                                    <%else if (i == 2)
                                        { %>
                                    <img id="img1" runat="server" />
                                    <%} %>
                                    
                                </td>
                                <td align="right" style="width: 384px">
                                    <label class="blackfnt" style="font-family:RENFREW">
                                        <font size="3"><b>RITCO LOGISTICS PVT. LTD.</b></font>
                                    </label>
                                    <br />
                                    <label class="blackfnt">
                                        Add : Corp. Office  :  ' Ritco House '
                                    </label>
                                    <br />
                                    <label class="blackfnt">
                                        336,Phase-II,Udyog Vihar,Gurgaon,Haryana,INDIA
                                    </label>
                                    <br />
                                    <label class="blackfnt">
                                        Phone : 0124-3917881 , 3919191
                                    </label>
                                    <br />
                                    <label class="blackfnt">
                                        Fax : 0124-3017777 , 3917854
                                    </label>
                                    <br />
                                    <label class="blackfnt">
                                        Web : www.ritcogroup.com
                                    </label>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="1" cellpadding="1" cellspacing="1" width="90%">
                                        <tr>
                                            <td class="blackfnt">
                                               
                                                <asp:Label ID="lblSvctx" runat="server" Text="Service Tax No : DL-11/ST/R-19/GTD/63/05"></asp:Label>
                                                    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="blackfnt">
                                            <asp:Label ID="lblPan_no" runat="server" Text="PAN No. : AACCRO305G"></asp:Label>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                <label class="blackfnt">
                                       <b>FREIGHT BILL</b>
                                    </label>
                                </td>
                            </tr>
                            
                        </table>
                        <table id="TABLE2" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="90%">
                            <tr>
                                <td class="blackfnt">
                                    To,<br />
                                    <asp:Label ID="lblName" runat="server" CssClass="blackfnt"></asp:Label><br />
                                    <asp:Label ID="lblAddress" runat="server" CssClass="blackfnt"></asp:Label>
                                </td>
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
                        <table id="TABLE1" border="1" cellpadding="1" cellspacing="1" language="javascript"
                            width="90%">
                            <tr style="background-color: white">
                                <td style="width: 30%" valign="top">
                                    <label class="blackfnt">
                                        <span style="font-size: 8pt; font-family: Verdana">Cargo Courier Charges (Details per attachment)
                                           </span></label></td>
                                <td align="left" width="100%">
                                    <table border="1" cellpadding="1" cellspacing="1" style="width: 100%">
                                        <tr style="background-color: white">
                                            <td style="width: 90%">
                                                <label class="blackfnt"><b>Bill Details</b>
                                                </label>
                                            </td>
                                            <td align="left" class="blackfnt" style="width: 90%">
                                                <b>TotalAmt</b></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                No. Of Docket</td>
                                            <td align="right" class="blackfnt" style="width: 50%">
                                                <asp:Label ID="lblNoOfDocket" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Basic Freight</td>
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
                                                FOV Charges</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblFOV" runat="server" CssClass="blackfnt"></asp:Label></td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td class="blackfnt" style="width: 79%">
                                                Other Charges</td>
                                            <td align="right" style="width: 50%">
                                                <asp:Label ID="lblMiscellaneous" runat="server" CssClass="blackfnt"></asp:Label></td>
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
                                                <strong>Net Payable : &nbsp;</strong>
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
                    <table cellpadding="1" cellspacing="2" width="90%">
                        <tr>
                            <td>
                                <table border="0" cellpadding="1" cellspacing="1" width="100%">
                                    <tr>
                                        <td align="left">
                                            <font class="blackfnt"><b><u>TERMS OF PAYMENTS : </u></b></font>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td>
                                <font class="blackfnt">1. The payment of the billshould be made only by an Account payee
                                    Cheque / Draft only , favouring " RITCO LOGISTICS PVT. LTD. Payable at Delhi.</font>
                            </td>
                        </tr>
                        <tr style="font-size: 12pt; font-family: Times New Roman">
                            <td>
                                <font class="blackfnt">2. In case of any discrepency , kindly bring to our notice within
                                    7 days of receipt of this bill , failing which no claim will be entertained.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">3. Payment to be released within 15 days of submission of the
                                    bill.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">4. Late payments are subject to interest @ 24 % per annum.</font></td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">5. Octroi / POD's attached with the bill ( Yes / No )</font></td>
                        </tr>
                    </table>
                    <table border="1" cellpadding="1" cellspacing="1" width="90%">
                        <tr>
                            <td>
                                <font class="blackfnt"><b>REMARKS :</b><asp:Label ID="lblRemarks111" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="1" cellspacing="1" width="90%">
                        <tr style="background-color: white">
                            <td colspan="2" nowrap valign="top">
                                <font class="blackfnt">For <b>Ritco Logistics Pvt. Ltd.</b></font>
                            </td>
                            <td colspan="2" nowrap valign="top" align="right">
                                <%if (i == 1)
                                  { %>
                                <img id="img6" runat="server" />
                                <%} %>
                                <%else if (i == 2)
                                    { %>
                                <img id="img7" runat="server" />
                                <%} %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <font class="blackfnt">Authorised Signatory</font>
                            </td>
                        </tr>
                    </table>
                    
                    <center class="blackfnt">
                        <b>
                            <%=Copyname %>
                        </b>
                    </center>
                    
                    <div class="break">
                    </div>
                    <%} %>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
