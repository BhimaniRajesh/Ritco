<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="cashbank.aspx.cs" Inherits="GUI_finance_cashbank" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Cash & Bank</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    

						<table border=0 cellpadding="5" width="35%" cellspacing="1" align="left" class=boxbg>
                            <TR class=bgbluegrey>
                              
                              <TD colspan=1 align="center" style="height: 1px; width: 335px;" >
                                <FONT class=blackfnt><strong>Transactions</strong></FONT>
                              </TD>
                            </tr>  
                            <tr bgcolor="#FFFFFF">
                                                     <td nowrap style="width: 335px" ><font class=blackfnt>
                                                         <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/GUI/finance/voucher/DebitVoucher.aspx">Debit Voucher</asp:HyperLink><a href="#"></a></font><font class=blackfnt>&nbsp;</font></td>   
                            </tr>	
							<tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt>
                                 <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/GUI/finance/voucher/CreditVoucher.aspx">Credit Voucher</asp:HyperLink><a href="#"></a></font></td>
                            </tr>	    
							
							
							<tr bgcolor="#FFFFFF">
                             
                             <td style="width: 335px" ><font class=blackfnt><a href="#"></a>
                                 <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/GUI/finance/voucher/ContraVoucher.aspx">Contra Entry</asp:HyperLink></font></td>  
						
                            </tr>	  
                            
							
							<tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt>
                                 <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/GUI/finance/chqMgt/onAccount.aspx">On Account Cheque Receipts</asp:HyperLink><a href="#"></a></font></td>  
                            </tr>	
                            <tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt>
                                 <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/GUI/finance/chqMgt/depositVoucher_step1.aspx">Prepare Cheque Deposit Voucher</asp:HyperLink><a href="#"></a><a href="#"></a></font></td>  
                             </tr>  
                             <tr bgcolor="#FFFFFF"> 
                          
                          <td style="width: 335px"><font class=blackfnt> Journal Voucher &nbsp;&nbsp;&nbsp;&nbsp;<asp:HyperLink ID="HyperLink1"
                                  runat="server" NavigateUrl="~/GUI/finance/voucher/JournalVoucher_OnetoMany.aspx">Single</asp:HyperLink>
                              <a href="#"></a>| 
                              <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/GUI/finance/voucher/JournalVoucher.aspx">Multiple</asp:HyperLink><a href="#"><u></u></a></font></td>
                        </tr>
                       <tr bgcolor="#FFFFFF"> 
                          
                          <td style="width: 335px"><font class=blackfnt><a href="#"><u> 
                            Vouchers Cancellation </u></a></font></td>
                        </tr>
                       
							 <TR bgcolor="#FFFFFF">
                              <TD colspan=2 align="center">
                                <FONT class=blackfnt><strong>View & Print</strong></FONT>
                              </TD>
                            </tr> 
                            <tr bgcolor="#FFFFFF">
                            
                               
                            <td style="width: 335px"><font class=blackfnt><a href="#"><u> Vouchers </u></a></font></td>
                             <tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt><a href="#"><u>Received Cheque Statement</u></a></font></td>  
                             </tr>
                           <tr bgcolor="#FFFFFF">
                           
                             <td style="width: 335px"><font class=blackfnt><a href="#"><u>Issued Cheque Statement</u></a></font></td>
                           </tr>
                           <tr bgcolor="#FFFFFF">
                           
                             <td style="width: 335px"><font class=blackfnt><a href="#"><u>Bank Account Statement</u></a></font></td>
                           </tr>  
                           <tr bgcolor="#FFFFFF">
                         
                             <td style="width: 335px"><font class=blackfnt><font class=blackfnt><a href="#"><u>Bank 
                            Reconciliation Statement</u></a></font></font></td>
                           </tr>
                           <tr bgcolor="#FFFFFF">
                             
                             <td style="width: 335px"><font class=blackfnt>Journal Vouchers</font></td>
                           </tr>
                           <tr bgcolor="#FFFFFF">
                            
                             <td style="width: 335px"><font class=blackfnt><a href="#"><u>CBS Statement</u></a></font></td>
                             </tr> 
                            </TABLE>
</asp:Content>

