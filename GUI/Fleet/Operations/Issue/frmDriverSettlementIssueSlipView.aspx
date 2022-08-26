<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmDriverSettlementIssueSlipView.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlipView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <link id="Link3" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    
    

    <table cellspacing="1" cellpadding="3" width="80%"  class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="left">
    
              
              
              
              
              
              
                
                
                                        <asp:Label ID="lblError1"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="TRIP SHEET DRIVER SETTLEMENT "></asp:Label></td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
            
              <td colspan=4 align="left" style="background-color: white">   
            <table     border="1" cellpadding="3" cellspacing="1" class="boxbg" width="72%">
            
             <tr style="background-color: white">
            
                <td align="left" >
                  <font class="bluefnt">Issue Slip Id</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueNo" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>Issue Slip Date</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblIssueDt" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
             <tr style="background-color: white" >
              <td align="left"  >
                  <font class=bluefnt>Vehicle No.</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblVehno" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>Driver</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblDriverName" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class=bluefnt>Driver License No.</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                        <asp:Label ID="lblLicno" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
                <td align="left" >
                  <font class=bluefnt>License Valid upto</font>
                </td>
                <td align="left">
                   <font class=blackfnt >
                   <asp:Label ID="lblValidDt" runat=server CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
            </tr>
            
            
            
            
            
             <tr style="background-color: white">
                <td align="left" >
                  <font class="bluefnt">Starting Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblStartLoc" runat=server CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
                <font class=bluefnt>End Location</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblEndLoc" runat=server CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            
            
            
              <tr style="background-color: white">
                <td align="left" >
                  <font class="bluefnt">Category</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left">
             <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt"  Text="Customer Code/Name"  Visible="false"></asp:Label>
                <asp:Label ID="lblMarketHead" runat="server" CssClass="bluefnt"  Text="Market/Own"  Visible="false"></asp:Label>
                </td>
                <td align="left">
                  <asp:Label ID="lblCustcodeMarket" runat="server" CssClass="blackfnt"></asp:Label>
                  
                </td>
            </tr>
            
             <tr style="background-color: white">
             
             <td align="left" >
                  <font class="bluefnt">Financial Close date</font>
                </td>
                <td align="left">
                <asp:Label ID="lblFinCloseDt" runat="server" CssClass="blackfnt"></asp:Label>
                  
                </td>
                
                <td align="left" >
                  <font class="bluefnt">Driver Settlement date</font>
                </td>
                <td align="left">
                <asp:Label ID="LblSettleDate" runat="server" CssClass="blackfnt"></asp:Label>
                
                  
                  
                                
                </td>
                </tr>
            
              </table>
              
              
        </td>
            </tr>
            
             <tr style="background-color: white">
                <td colspan=4 align=center>
                                                            <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>

                <table cellspacing="1" cellpadding="3" style="width: 100%" align="center" class="boxbg"
                                    border="0">
                                    
                                    <tr class="bgbluegrey">
                                        <td align="Left"><font class="blackfnt"><b>Head</b></font></td>
                                        <td align="Left"><font class="blackfnt"><b>Amount</b></font></td>
                                        <td align="Left"><font class="blackfnt"><b>Approved Amount</b></font></td>
                                        <td align="Left">&nbsp;</td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="Left">
                                            <font class="blackfnt"><b>Total Advance Paid</b></font></td>
                                        <td align="right"><asp:Label ID="LblTotAdvancePaid" CssClass="blackfnt"  ForeColor=blue runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotAdvancePaidAppr" CssClass="blackfnt" ForeColor=blue runat="server"></asp:Label></td>
                                        <td align="Left">
                                            <font class="blackfnt"><b>Amount paid to driver </b></font></td>
                                        <td align="Left"><asp:Label ID="LblAmtPaidToDriver" CssClass="blackfnt" ForeColor=blue runat="server"  ></asp:Label></td>
                                    </tr>
                                    
                                     <tr style="background-color: white">
                                        <td align="Left">
                                            <font class="blackfnt"><b>Total Expenses</b></font></td>
                                        <td align="right"><asp:Label ID="LblTotExpense" Text="0.00" CssClass="blackfnt" ForeColor=blue  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotExpenseAppr" Text="0.00" CssClass="blackfnt" ForeColor=blue  runat="server"></asp:Label></td>
                                        <td align="Left">
                                            <font class="blackfnt"><b>Amount received from driver </b></font></td>
                                        <td align="Left"><asp:Label ID="LblAmtRecvdFromDriver"  CssClass="blackfnt" ForeColor=blue runat="server" ></asp:Label>
                                        
                                        </td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="left"><font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Diesel expense against cash&nbsp;</font></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCashExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCashExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left">
                                            <font class="blackfnt"><asp:Label ID="LblDriverLedger" CssClass="blackfnt" Text="Trip Sheet balance to driver ledger"  runat="server" Font-Bold=true></asp:Label> </font></td>
                                        <td align="Left"><asp:Label ID="LblBalToDriverLedger" CssClass="blackfnt" ForeColor=blue runat="server"></asp:Label></td>

                                    </tr>
                                    
                                      
                                    
                                    
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Repair Expense </font></td>
                                        <td align="right"><asp:Label ID="LblTotRepairExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotRepairExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Spare Expense </font></td>
                                        <td align="right"><asp:Label ID="LblTotSpareExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotSpareExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Incidental Deduction Expense </font></td>
                                        <td align="right"><asp:Label ID="LblTotIncDedExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                         <td align="right"><asp:Label ID="LblTotIncDedExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                     <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Claims Expense </font></td>
                                        <td align="right"><asp:Label ID="LblTotClaimExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotClaimExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                     <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Enroute Expense </font></td>
                                        <td align="right"><asp:Label ID="LblTotEnrouteExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotEnrouteExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt"><b>Diesel expense against card</b>&nbsp;</font></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCardExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCardExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left">
                                            <font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="blackfnt"><b>Diesel expense against credit</b></font></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCreditExp" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblTotDieselCreditExpAppr" Text="0.00" CssClass="blackfnt"  runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt">&nbsp;</font></td>
                                        <td align="Left">&nbsp;</td>
                                    </tr>
                                    
                                    
                                     <tr style="background-color: white">
                                        <td align="Left">
                                            <font class="blackfnt"><b>Net amount</b></font></td>
                                        <td align="right"><asp:Label ID="LblNetExpAmt"  Text="0.00" CssClass="blackfnt" ForeColor=blue runat="server"></asp:Label></td>
                                        <td align="right"><asp:Label ID="LblNetExpAmtAppr" Text="0.00"  CssClass="blackfnt"  ForeColor=blue runat="server"></asp:Label></td>
                                        <td align="Left"><font class="blackfnt"><b>Trip Sheet net balance</b></font></td>
                                        <td align="Left"><asp:Label ID="LblNetBalance"  CssClass="blackfnt"  ForeColor=blue runat="server"></asp:Label></td>
                                    </tr>
                                </table>  
                                
                                  <br>
                                  
                                  <table align=left width="100%"  border="0" cellspacing="1" cellpadding="3" bgcolor="#808080" class=boxbg>
                                <tr class=bgbluegrey> 
                                    <td colspan="4" align="center"><font class="blackfnt"><b><asp:Label ID="LblPayRecHead" runat="server" ></asp:Label> Details</b></td>
                                </tr>
  
						        <tr bgcolor="#FFFFFF">
						            <td align=left> <font class="blackfnt">Mode Of Transaction  </font></td>
				                    <td align=left> <font class="blackfnt">
				                    <asp:Label ID="lblMode" runat="server" ></asp:Label></font>
				                    </td>
				                    <td align=left> <font class="blackfnt"><asp:Label ID="LblPayRecAcc" runat="server" ></asp:Label> Account</font></td>
                                    <td align=left> <font class="blackfnt">
                                     <asp:Label ID="lblPaymentAcc" runat="server" ></asp:Label></font>
                                    </td>
				                </tr>
								<tr bgcolor="#FFFFFF">
								    <td align=left><font class="blackfnt">Cheque No </font></td>
                                    <td align=left><font class="blackfnt">
                                     <asp:Label ID="lblChequeNo" runat="server" ></asp:Label></font>
                                    </td>
                                    <td align=left><font class="blackfnt">Cheque Date</font></td>
                                    <td align=left><font class="blackfnt">
                                     <asp:Label ID="lblChequeDt" runat="server" ></asp:Label></font>
                                    </td>
                                 </tr>
        
                                 <tr bgcolor="#ffffff"> 
                                    <td align=left><font class="blackfnt">Amount (in Rs.)</font></td>
                                    <td align=left><font class="blackfnt">
                                     <asp:Label ID="lblPaymentAmt" runat="server" ></asp:Label></font>
                                    </td>  
								    <td colspan="2"></td>
                                 </tr>
                                 <tr bgcolor="#ffffff">
			                        <td colspan="4" align=left><font class="blackfnt"><b>Rs. (in words):</b>&nbsp;&nbsp;<asp:Label ID="lblWords" runat="server" ></asp:Label></font></td>
                                 </tr>
						 </table> 
    
    </td>
    </tr>
    </table>
    
    
    </div>
    </form>
</body>
</html>
