<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContraView.aspx.cs"
    Inherits="GUI_Finance_voucher_Print_ContraVoucherView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebXpress: Contra Voucher View</title>
</head>
<body style="font-size: 12pt; font-family: Times New Roman" runat="server" id="formbody">
<form id="form1" runat="server">
<div align="left" style="width:6.5in;">
    <br />
    <br />
    <table bgcolor="#808080" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
         <tr class="blackfnt" bgcolor="#ffffff">
            <td colspan="4" align="left">
                <asp:Label ID="lblvoucherheader"  Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>
            </td>
         </tr>
         <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherno" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Voucher Date</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblVoucherdate" runat="server"></asp:Label></td>
         </tr>
         <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Manual Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblManuavoucherno" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Reference no.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblRefno" runat="server"></asp:Label></td>
         </tr> 
         <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Prepared at location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedAt" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Prepared by</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedBY" CssClass="blackfnt" runat="server"></asp:Label></td>
         </tr>
         <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Narration</td>
            <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="LblNarration" runat="server"></asp:Label></td>
         </tr>
         <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Trans Type</td>
            <td align="left" bgcolor="#ffffff" colspan="3"><asp:Label ID="lbl_Transtype" runat="server"></asp:Label></td>
         </tr>
         <tr class="blackfnt">
            <td align="left" colspan="4" bgcolor="#ffffff">
                <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" ID="grvcontrols"
                Width="100%" AutoGenerateColumns="false" EmptyDataText="No Records Found...">
                <Columns>
                    <asp:TemplateField HeaderText="Description" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="left"/>
                        <ItemTemplate>
                            <asp:Label ID="lblDesc" Text='<%# DataBinder.Eval(Container.DataItem,"AccountDescription") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Debit Amount" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                        <ItemTemplate>
                            <asp:Label ID="lblDebitAmt" Text='<%# DataBinder.Eval(Container.DataItem,"DebitAmount") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Credit Amount" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="right" />
                        <ItemTemplate>
                            <asp:Label ID="lblCreditAmt"  Text='<%# DataBinder.Eval(Container.DataItem,"CreditAmount") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Chque/Ref. No"  HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" Wrap="true"/>                        
                        <ItemTemplate>
                            <asp:Label ID="lblChqno" Text='<%# DataBinder.Eval(Container.DataItem,"Chqno") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cheque/Ref. Date" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white"/>
                        <ItemTemplate>
                            <asp:Label ID="lblChqdate" Text='<%# DataBinder.Eval(Container.DataItem,"Chqdate") %>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                </asp:GridView>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" colspan="4" class="blackfnt"><b>In Words :</b>&nbsp;
                <asp:Label ID="lblinwords" runat="server"></asp:Label>
            </td>
          </tr>
    </table>
    <br />
    <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Passing Authority </td>
            <td align="center" class="blackfnt">Cashier/Acc</td>
            <td align="right" class="blackfnt">Manager/Director</td>
        </tr>
    </table>
    <br />
    <div style="width:6.5in;" align="left"> <font class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</font></div><br />
    <asp:Label ID="lbltotalmoney" Font-Bold="true" runat="server"></asp:Label>
    <br /><br />
    <div style="width:6.5in;" align="right"> <font class="blackfnt">Authorised Signatory</font></div><br />
    </div>
    </form>
</body>
</html>
