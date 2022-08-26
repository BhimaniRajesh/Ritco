<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillDetail_RITCO_new.aspx.cs"
    Inherits="GUI_Octroi_ViewOctroiBill_BillDetail_RITCO_new" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bill Details</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table border="0" style="width: 7.5in; height: 107px;" runat="server" id="tblMain"
                cellpadding="0" cellspacing="0">
                <tr class="blackfnt">
                    <td align="left" valign="top" style="width: 497px; height: 132px;">
                        <img alt="" src="http://123.108.47.70/ritco/GUI/images/Ritco_Bill_Logo.gif" align="top" />
                    </td>
                    <td>
                        <font class="blackfnt" size="3"><b>RITCO LOGISTICS PVT. LTD.</b></font><br />
                        <font class="blackfnt" size="2">Add : Corp. Office : ' Ritco House '</font><br />
                        <font class="blackfnt" size="2">336, Phase-II , Udyog Vihar , Gurgaon</font><br />
                        <font class="blackfnt" size="2">Haryana , INDIA</font><br />
                        <font class="blackfnt" size="2">Phone : 0124-3917881 , 3919191</font><br />
                        <font class="blackfnt" size="2">Fax : 0124-3017777 , 3917854</font><br />
                        <font class="blackfnt" size="2">Web : www.ritcogroup.com</font><br />
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" style="width: 7.5in" runat="server" cellpadding="0" cellspacing="0">
                <tr class="blackfnt">
                    <td align="left" colspan="2">
                        <font class="blackfnt">
                            <asp:Label ID="lblSvctx" runat="server" Text="Service Tax No : DL-11/ST/R-19/GTD/63/05"></asp:Label><br />
                            <asp:Label ID="lblPan_no" runat="server" Text="PAN No. : AACCRO305G"></asp:Label>
                        </font>
                    </td>
                </tr>
            </table>
            <br />
            <table id="Table1" border="0" style="width: 7.5in" runat="server" cellpadding="0" cellspacing="0">
                <tr class="blackfnt">
                    <td align="center" colspan="2">
            <label class="blackfnt">
                <b>OCTROI BILL</b>
            </label>
            </td>
            </tr>
            </table>
            <table border="0" style="width: 7.5in" runat="server" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="left">
                        <font class="blackfnt" size="3">To</font><font class="blackfnt" size="3"><br />
                            <font class="blackfnt" size="3"><b>M/s </b></font>
                            <asp:Label ID="lblCustName" runat="server"></asp:Label></font><br />
                        <font class="blackfnt" size="3"></font><font class="blackfnt" size="3">
                            <asp:Label ID="lblAddress" runat="server" Visible="false"></asp:Label></font><br />
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="Label7" runat="server" Font-Size="10" Text="Bill No :"></asp:Label></font>
                        <font class="blackfnt">
                            <asp:Label ID="lblBillNo" runat="server" Font-Size="10"></asp:Label></font><br />
                        <font class="blackfnt" size="3">
                            <asp:Label ID="Label9" runat="server" Font-Size="10" Text="Bill Date :"></asp:Label></font>
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lblBillDt" runat="server" Font-Size="10"></asp:Label></font><br />
                        <font class="blackfnt" size="3">
                            <asp:Label ID="Label14" runat="server" Font-Size="10" Text="Customer Code:"></asp:Label></font>
                        <font class="blackfnt" size="3">
                            <asp:Label ID="lblCustCode" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            <table border="0" style="width: 7.5in" runat="server" cellpadding="0"
                cellspacing="0">
                <tr class="blackfnt">
                    <td>
                        <asp:GridView ID="grvBill" runat="server" AutoGenerateColumns="False" CssClass="boxbg"
                            OnRowDataBound="GrdXLS1_RowDataBound" ShowFooter="true" Width="7.5in">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Docket No.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "DocketNo")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Origin.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Origin")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Dest
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Destination")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Octrio<br /> Amt
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "OctrioAmt")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Process<br />
                                        (%)
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ProcessingPercentage")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Process<br />
                                        Chrg.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ProcessCharge")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Other<br />
                                        Chrg.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "OtherCharge")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        S.Tax
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ServiceTax")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Cess
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Cess")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Higher<br />
                                        Edu.<br />
                                        Cess
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "HDUCess")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblFooTotal1" runat="server" Font-Bold="True" CssClass="blackfnt"
                                            Text="Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Total
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblFooTotal11" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"Total") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblFooTotal" runat="server" CssClass="blackfnt" Font-Bold="True" Text='<%# DataBinder.Eval( Container.DataItem,"NewTotal") %>'></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Reciept<br />
                                        No.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ReceiptNo")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        Reciept<br />
                                        Date
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "ReceiptDt")%>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" Font-Bold="True" HorizontalAlign="Center" />
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                </table>
                <br />
                 <table border="0" runat="server" cellpadding="0" cellspacing="0">
                <tr class="blackfnt">
                    <td colspan="8">
                        <strong>TOTAL : </strong>
                        <asp:Label ID="lblWordRs" runat="server" Font-Bold="True"></asp:Label><strong> Only</strong><br />
                        <font class="blackfnt"><b><u>TERMS OF PAYMENTS : </u></b></font>
                    </td>
                </tr>
                <tr class="blackfnt">
                    <td align="left">
                        <table border="0" runat="server" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <font class="blackfnt">1. The payment of the billshould be made only by an Account payee
                                        Cheque / Draft only ,
                                        <br />
                                        &nbsp; &nbsp; favouring " RITCO LOGISTICS PVT. LTD. Payable at Delhi. </font>
                                    <br />
                                    <font class="blackfnt">2. In case of any discrepency , kindly bring to our notice within
                                        7 days of receipt of this bill
                                        <br />
                                        &nbsp; &nbsp; failing which no claim will be entertained.
                                        <br />
                                        <font class="blackfnt">3. Payment to be released within 15 days of submission of the
                                            bill.</font><br />
                                        <font class="blackfnt">4. Late payments are subject to interest @ 24 % per annum.</font><br />
                                        <font class="blackfnt">5. Octroi attached with the bill ( Yes / No )</font>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td align="center">
                        <table border="0" runat="server" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center">
                                    <font class="blackfnt">For <b>Ritco Logistics Pvt. Ltd. </b></font>
                                    <br />
                                    <br />
                                    <br />
                                    <font class="blackfnt"><b>Authorised Signatory </b></font>
                                    <br />
                                    <img alt="" src="http://123.108.47.70/ritco/GUI/images/Ritco_Logo.gif" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
