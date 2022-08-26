<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VariableExpenseVoucherPrint.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_VariableExpenseVoucherPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Expense Voucher</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    
  
 <script language="javascript">
     function printme()
     {
     <%
    string PrintMode =Request.QueryString["PrintMode"].Trim();
   %>  
   var mPrintMode="<%=PrintMode%>"
   
     
       if(mPrintMode=="1")
       {
           window.print();
        }                      
      }
       
    
    </script>
    
  
       
    
 
</head>


<body  onload="printme()">

<br/>
<br/>
<br/>
    <form id="form1" runat="server">
    <div>
    
     <p align="center">
    <table  align="center" width="80%">
       <tr>
       <td>
       
           
 
 
      
      <table cellspacing="1" cellpadding="3" width="100%" class="boxbg" border="0">
            
           
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EXPENSE VOUCHER(FIXED) FORM"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
              
                <td align="left">
                <font class="blackfnt" ></font> <font class=bluefnt>Expense Voucher Date</font>
                </td>
                <td align="left" colspan="3">
               <asp:Label ID="lblDate"       runat="server"    CssClass="blackfnt"></asp:Label> 
         
                </td>
                <%--  <td align="left">
                  <font class="blackfnt" ></font> <font class=bluefnt>Enter Vehicle No.</font>
                </td>
                <td align="left">
            <asp:Label ID="lblVehicleNo"       runat="server"    CssClass="blackfnt"></asp:Label> 
                </td>--%>
                
            </tr>
           
               
     
                 <tr style="background-color: white">
                <td align="left" ><font class=bluefnt>Enter Manual Voucher No.</font></td>
                
                
                <td colspan="3"    align="left">
                <asp:Label ID="lblManfNo"       runat="server"  CssClass="blackfnt"></asp:Label> 
                </td>
                
                </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>ACCOUNT DETAILS-EXPENSE INCURRED</b></font></td>
            </tr>
                
                
          

 
                             
              <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>REPAIR & MAINTAINENCE EXPENSE</b></font></td>
            </tr>
                
                        
             <tr style="background-color: white">
                <td   colspan="4" align="left">
                                    
                                    <asp:DataGrid ID="dgExpense" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%"  >
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No." >
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:BoundColumn   DataField="NExpense"  HeaderText="Nature Of Expense"  ></asp:BoundColumn>
                                                        <asp:BoundColumn   DataField="VehicleNo"  HeaderText="Vehicle No."  ></asp:BoundColumn>
                                                        <asp:BoundColumn    DataField="Amt"  HeaderText="Amount Spent"  ></asp:BoundColumn>
                                                        <asp:BoundColumn  DataField="BillNo"  HeaderText="Bill/Receipt No. if any(Attach supportings)"  ></asp:BoundColumn>
                                                        <asp:BoundColumn  DataField="ExeAmt"  HeaderText="Amount Approved By Fleet Executive"  ></asp:BoundColumn>
                                                        <asp:BoundColumn   DataField="Remarks"  HeaderText="Remarks"  ></asp:BoundColumn>
                      
                                                        
                                                         
                                                      
                                               
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                      

                </td>
            </tr>
          
            
           </table>   
       <table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
        <tr style="background-color: white">
        <td width="30%" >
      <font class=blackfnt><b>Amount Spent Total</b></font>
        
        </td>
          
           <td align="left" width="10%">
     <asp:Label ID="lblTotalAmt" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
        </td>
           <td width="237px" >
      <font class=blackfnt><b>Aprroved Amount Total</b></font>
        
        </td>
         <td align="left" >
         <asp:Label ID="lblTotalExeAmt"  CssClass="blackfnt" Font-Bold="true"   runat="server"  ></asp:Label>
        </td>
        
      </tr>
      </table>
       
  <br/>
 
  
  <table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
  
  
             <tr class="bgbluegrey">
                <td colspan=4 align=center ><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
                            
                    <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Checked By Fleet Executive</font></td>
                        <td align="center"><font class=blackfnt>Verified By Branch Head</font></td>
                       
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align="center"><asp:Label ID="lblCheckedBy" runat="server"  CssClass="blackfnt"  ></asp:Label></td>
                        <td align="center"><asp:Label ID="lblVerifiedBy" runat="server" CssClass="blackfnt"   ></asp:Label></td>
           
                    </tr> 
                                        
                     <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Received By</font></td>
                        <td align="center"><font class=blackfnt>Approved & Accounted By Branch Commercial</font></td>

                    </tr> 
                     <tr style="background-color: white">
                        <td align="center"><asp:Label ID="lblReceivedBy" runat="server" CssClass="blackfnt"  ></asp:Label></td>
                        <td align="center"><asp:Label ID="lblApprovedBy" runat="server" CssClass="blackfnt"  ></asp:Label></td>
              
                    </tr> 
                    
                    
                    
   </table>
  
  <br>
   <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Payment Mode
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="ddlPayMode" runat=server CssClass="bluefnt"></asp:Label>
                            </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Amount Applicable
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtAmtApplA" runat=server CssClass="bluefnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtCashAmt" runat=server CssClass="bluefnt"></asp:Label></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Account
                        </td>
                        <td style="text-align: left" class="blackfnt"> 
                        &nbsp;<asp:Label ID="ddrCashcode" runat=server CssClass="bluefnt"></asp:Label>
                            &nbsp;</td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtChqAmt" runat=server CssClass="bluefnt"></asp:Label></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Bank Account
                        </td>
                        <td style="text-align: left" class="blackfnt">
                             &nbsp;<asp:Label ID="ddrBankaccode" runat=server CssClass="bluefnt"></asp:Label>
                       </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque No.
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtChqNo" runat=server CssClass="bluefnt"></asp:Label></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque date
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtChqDate" runat=server CssClass="bluefnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                        </td>
                        <td style="text-align: left" class="blackfnt">
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            <strong>&nbsp;NET PAYABLE </strong>
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:Label ID="txtNetPay" runat=server CssClass="bluefnt"></asp:Label>
                            </td>
                    </tr>
                </table>
  
  </td>
  </tr>
           </table>  
 </p>
    
    
    
    
    </div>
    </form>
</body>
</html>
