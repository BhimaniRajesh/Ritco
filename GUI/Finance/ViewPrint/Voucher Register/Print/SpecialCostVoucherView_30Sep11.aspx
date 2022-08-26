<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SpecialCostVoucherView.aspx.cs" Inherits="GUI_Finance_voucher_Print_DebitVoucherView" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WebXpress: Special Cost Voucher View</title>
<% 
   if (Request.QueryString["printyn"].ToString() == "N")
   {   
       border = "0";
       %>    
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
<% } %>
<% else if (Request.QueryString["printyn"].ToString() == "Y")
   {
       border = "1";
       %>    
        <link id="Link2" href="~/GUI/images/style_print.css" rel="Stylesheet" type="text/css" runat="server" />
<% } %>    
</head>
<% if (Request.QueryString["printyn"].ToString() == "N")
   { %>
        <body style="font-size: 12pt; font-family: Times New Roman">
<% } %>
<% else if (Request.QueryString["printyn"].ToString() == "Y")
   { %>
        <body style="font-size: 12pt; font-family: Times New Roman" onload="javascript:window.print();">    
<% } %>
    <form id="form1" runat="server">
    <div align="left">
<br />
<br /><br />

    <table bgcolor="#808080" border="1" cellpadding="3" cellspacing="1" class="boxbg" style="width:7.5in;">
         <tr class="blackfnt" bgcolor="#ffffff">
         <td colspan="6">
         <asp:Label ID="lblvoucherheader"  Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>
         </td>
         </tr>
          <tr class="blackfnt">
          <td align="left" class="bgbluegrey">Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherno" runat="server"></asp:Label></td>
              <td align="left" class="bgbluegrey">Voucher Date</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherdate" runat="server"></asp:Label></td>
            
             <td align="left" class="bgbluegrey">Manual Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblManuavoucherno" runat="server"></asp:Label></td>
          </tr>
          
          <tr class="blackfnt">
           <td align="left" class="bgbluegrey">Prepared at location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedLoc" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Prepared by</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedBY" CssClass="blackfnt" runat="server"></asp:Label></td>
           <td align="left" class="bgbluegrey">Business Division</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblBusiness_type" runat="server"></asp:Label></td>
            
          
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Accounting location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblAcctloc" runat="server"></asp:Label></td>
            
            <td align="left" class="bgbluegrey">Prepared for</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparefor" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class="bgbluegrey">Reference no.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblRefno" runat="server"></asp:Label></td>
          </tr>
          
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Pay To</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lblPayto" runat="server"></asp:Label></td>
            
                    </tr>
           <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Narration</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="Lbl_Narration" runat="server"></asp:Label></td>
            
                    </tr>
                       </tr>
           <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Cheque No. & Date</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lbl_Cheque_Entry_Date" runat="server"></asp:Label></td>
            
                    </tr>
                    <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Trans Type</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lbl_Transtype" runat="server"></asp:Label></td>
            
                    </tr>
                    
    </table>
    <br />
       <font class="blackfnt"><b>A/C : </b></font><asp:Label CssClass="blackfnt" ID="lblAccHead" runat="server" Font-Bold="true"></asp:Label>        
    <br /><br />
        <table bgcolor="#808080" border="1" cellpadding="3" cellspacing="1" class="boxbg" style="width:7.5in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr  class="bgbluegrey"> 
                        <td align="center" class="blackfnt" width="35%">Description</td>
                        <td align="center" class="blackfnt" width="10%">Document Type</td>
                        <td align="center" class="blackfnt" width="10%">Document No</td>
                        <td align="center" class="blackfnt" width="10%">Debit Amount</td>
                        <td align="center" class="blackfnt" width="10%">Credit Amount</td>
                        <td align="center" class="blackfnt" width="25%">Narration</td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <asp:Repeater ID="rptrDebitVoucher" runat="server" >
                    <ItemTemplate>
                        <table border="1" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                            <tr bgcolor="white"> 
                                <td align="left" width="35%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "AccountDescription")%></font></td>
                                <td align="right" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "DocType")%></font></td>
                                <td align="right" width="10%" style="word-wrap:normal"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "DocNo")%></font></td>
                                <td align="right" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "DebitAmount")%></font></td>
                                <td align="right" width="10%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "CreditAmount")%></font></td>
                                <td align="left" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Narration")%></font></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="1" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr bgcolor="white"> 
                        <td align="right" class="blackfnt" width="55%"><strong>Total Rs.</strong></td>
                        <td align="right" class="blackfnt" width="10%"><asp:Label ID="lblTotalDebitAmount" runat="server"></asp:Label></td>
                        <td align="right" class="blackfnt" width="10%"><asp:Label ID="lblTotalCreditAmount" runat="server"></asp:Label></td>
                        <td width="30%"></td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <asp:Label ID="lblinwords" runat="server"></asp:Label>
            </td>
          </tr>
        </table>  
          
        
        <br />
        <table bgcolor="#808080" border="1" cellpadding="3" cellspacing="1" class="boxbg" style="width:7.5in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Passing Authority </td>
            <td align="center" class="blackfnt">Cashier/Acc</td>
            <td align="right" class="blackfnt">Manager/Director</td>
          </tr>
        </table>  

<br />
 <div style="width:7.5in;" align="left"> <font class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</font></div><br />
 <asp:Label ID="lbltotalmoney" Font-Bold="true" runat="server"></asp:Label>
 <br /><br />
 <div style="width:7.5in;" align="right"> <font class="blackfnt">Signature</font></div><br />
 </div>
    
    
    </form>
</body>
</html>
