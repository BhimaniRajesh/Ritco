<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DebitVoucherView.aspx.cs" Inherits="GUI_Finance_voucher_Print_DebitVoucherView" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WebXpress: Debit Voucher View</title>

        <link id="Link3" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />


</head>

<br />

<br /><br />

 <script language="javascript"> 
    
      function PrintMe()
      
      {
       if(document.form1.hdfldPrint_YN.value=="1")
       {
        window.print();
       }
      
      }
     </script> 
<body onload="PrintMe()">
    <form id="form1" runat="server">
    <div align="center">
    <asp:HiddenField ID="hdfldPrint_YN" runat="server" />
    <table bgcolor="#808080" border='1' cellpadding="3" cellspacing="1"  width="95%">
         <tr class="blackfnt" bgcolor="#ffffff">
         <td colspan="6">
         <asp:Label ID="lblvoucherheader"  Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>
         </td>
         </tr>
          <tr class="blackfnt">
          <td align="left" class='bgwhite'>Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherno" runat="server"></asp:Label></td>
              <td align="left" class='bgwhite'>Voucher Date</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblvoucherdate" runat="server"></asp:Label></td>
            
             <td align="left" class='bgwhite'>Manual Voucher No.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblManuavoucherno" runat="server"></asp:Label></td>
          </tr>
          
          <tr class="blackfnt">
           <td align="left" class='bgwhite'>Prepared at location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedLoc" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class='bgwhite'>Prepared by</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparedBY" CssClass="blackfnt" runat="server"></asp:Label></td>
           <td align="left" class='bgwhite'>Business Division</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="LblBusiness_type" runat="server"></asp:Label></td>
            
          
          </tr>
          <tr class="blackfnt">
            <td align="left" class='bgwhite'>Accounting location</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblAcctloc" runat="server"></asp:Label></td>
            
            <td align="left" class='bgwhite'>Prepared for</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblPreparefor" CssClass="blackfnt" runat="server"></asp:Label></td>
            <td align="left" class='bgwhite'>Reference no.</td>
            <td align="left" bgcolor="#ffffff"><asp:Label ID="lblRefno" runat="server"></asp:Label></td>
          </tr>
          
          <tr class="blackfnt">
            <td align="left" class='bgwhite'>Pay To</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lblPayto" runat="server"></asp:Label></td>
            
                    </tr>
           <tr class="blackfnt">
            <td align="left" class='bgwhite'>Narration</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="Lbl_Narration" runat="server"></asp:Label></td>
            
                    </tr>
                       </tr>
           <tr class="blackfnt">
            <td align="left" class='bgwhite'>Cheque No. & Date</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lbl_Cheque_Entry_Date" runat="server"></asp:Label></td>
            
                    </tr>
                    <tr class="blackfnt">
            <td align="left" class='bgwhite'>Trans Type</td>
            <td align="left" bgcolor="#ffffff" colspan="5"><asp:Label ID="lbl_Transtype" runat="server"></asp:Label></td>
            
                    </tr>
                    
    </table>
    <br />
    
    <br />
       <font class="blackfnt"><b>A/C : </b></font><asp:Label CssClass="blackfnt" ID="lblAccHead" runat="server" Font-Bold="true"></asp:Label>        
    <br /><br />
        <table bgcolor="#808080" border='1' cellpadding="3" cellspacing="1"   width="95%">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">
                <table border='1' cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1"  >
                    <tr  class='bgwhite'> 
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
                <asp:Repeater ID="rptrDebitVoucher" runat="server">
                    <ItemTemplate>
                        <table  border='1' cellpadding="3" width="100%"  >
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
                <table border='1' cellpadding="3" width="100%" bgcolor="#808080" cellspacing="1" >
                    <tr bgcolor="white"> 
                        <td align="right" class="blackfnt" width="40%"><strong>Total Rs.</strong></td>
                        <td align="right" class="blackfnt" width="15%"><asp:Label ID="lblTotalDebitAmount" runat="server"></asp:Label></td>
                        <td align="right" class="blackfnt" width="15%"><asp:Label ID="lblTotalCreditAmount" runat="server"></asp:Label></td>
                        <td width="35%"></td>
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
        <table bgcolor="#808080" border='1' cellpadding="3" cellspacing="1"  width="95%" >
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Passing Authority </td>
            <td align="center" class="blackfnt">Cashier/Acc</td>
            <td align="right" class="blackfnt">Manager/Director</td>
          </tr>
        </table>  

<br />
        <table  border="0" cellpadding="3" cellspacing="1" width="95%" >
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="right" class="blackfnt">Signature</td>
          </tr>
        </table>  


    
    </form>
</body>
</html>
