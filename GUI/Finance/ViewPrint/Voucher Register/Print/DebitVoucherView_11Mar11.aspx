<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DebitVoucherView.aspx.cs" Inherits="GUI_Finance_voucher_Print_DebitVoucherView" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WebXpress: Debit Voucher View</title>
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
<table id="CompanyHdr" style="width:6.5in;" runat="server" visible="false">
    <tr>
        <td style="text-align: center">
            <span style="font-family: Verdana"><strong>VARUNA&nbsp;<?xml namespace="" ns="urn:schemas-microsoft-com:office:powerpoint"
                prefix="p" ?><p:colorscheme colors="#ffffff,#000000,#808080,#000000,#bbe0e3,#333399,#009999,#99cc00"></p:colorscheme>
                ROAD LINE Pvt. Ltd.</strong></span>
        </td>
    </tr>
</table>
<br /><br />
<table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">    
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
                    <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Entry By</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lbl_Entryby" runat="server"></asp:Label></td>
            
                    </tr>
                    
    </table>
    <br />
    <asp:Panel ID="voption" runat="server" Visible="false">
        <font class="blackfnt"><b>Voucher Type : </b></font> 
            <asp:Label CssClass="blackfnt" ID="vtype" runat="server"></asp:Label>
        <br />
    </asp:Panel>        
    <asp:Panel ID="Tripsheet" runat="server" Visible="false">
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
              <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                        <tr  class="bgbluegrey"> 
                            <td align="center" class="blackfnt" width="25%">TripSheet No.</td>
                            <td align="center" class="blackfnt" width="25%">Vehicle No.</td>
                            <td align="center" class="blackfnt" width="25%">From</td>
                            <td align="center" class="blackfnt" width="25%">To</td>
                        </tr>
                    </table>
                </td>
              </tr>
              <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <table cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                                <tr bgcolor="white"> 
                                    <td align="center" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Docno")%></font></td>
                                    <td align="center" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "VehNo")%></font></td>
                                    <td align="center" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "From_loc")%></font></td>
                                    <td align="center" width="25%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "To_Loc")%></font></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </td>
              </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="PartPO" runat="server" Visible="false">
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
              <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                        <tr  class="bgbluegrey"> 
                            <td align="center" class="blackfnt" width="16%">PO/ Challan No.</td>
                            <td align="center" class="blackfnt" width="16%">Vehicle No.</td>
                            <td align="center" class="blackfnt" width="16%">Broker name</td>
                            <td align="center" class="blackfnt" width="16%">Hire amount for TDS</td>
                            <td align="center" class="blackfnt" width="16%">From</td>
                            <td align="center" class="blackfnt" width="16%">To</td>
                        </tr>
                    </table>
                </td>
              </tr>
              <tr bgcolor="#ffffff">
                <td align="left" class="blackfnt">
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                                <tr bgcolor="white"> 
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Docno")%></font></td>
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "VehNo")%></font></td>
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "BrokerName")%></font></td>
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Hire_AMt_TDS")%></font></td>
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "From_loc")%></font></td>
                                    <td align="center" width="16%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "To_Loc")%></font></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </td>
              </tr>
        </table>
    </asp:Panel>
    <br />
       <font class="blackfnt"><b>A/C : </b></font><asp:Label CssClass="blackfnt" ID="lblAccHead" runat="server" Font-Bold="true"></asp:Label>        
    <br /><br />
        <table bgcolor="#808080" border="<%=border%>" cellpadding="3" cellspacing="1" class="boxbg" style="width:6.5in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr  class="bgbluegrey"> 
                        <td align="center" class="blackfnt" width="40%">Description</td>
                        <td align="center" class="blackfnt" width="15%">Debit Amount</td>
                        <td align="center" class="blackfnt" width="15%">Credit Amount</td>
                        <td align="center" class="blackfnt" width="30%">Narration</td>
                    </tr>
                </table>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <asp:Repeater ID="rptrDebitVoucher" runat="server" >
                    <ItemTemplate>
                        <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                            <tr bgcolor="white"> 
                                <td align="left" width="40%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "AccountDescription")%></font></td>
                                <td align="right" width="15%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "DebitAmount")%></font></td>
                                <td align="right" width="15%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "CreditAmount")%></font></td>
                                <td align="left" width="30%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Narration")%></font></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border="<%=border%>" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" class=boxbg>
                    <tr bgcolor="white"> 
                        <td align="right" class="blackfnt" width="40%"><strong>Total Rs.</strong></td>
                        <td align="right" class="blackfnt" width="15%"><asp:Label ID="lblTotalDebitAmount" runat="server"></asp:Label></td>
                        <td align="right" class="blackfnt" width="15%"><asp:Label ID="lblTotalCreditAmount" runat="server"></asp:Label></td>
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
 <div style="width:6.5in;" align="right"> <font class="blackfnt">Signature</font></div><br />
 </div>
    
    
    </form>
</body>
</html>
