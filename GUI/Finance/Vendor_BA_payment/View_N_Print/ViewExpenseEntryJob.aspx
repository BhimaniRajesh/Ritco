<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewExpenseEntryJob.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_View_N_Print_ViewExpenseEntryJob" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Job Expense View</title>
     <link href="../../../images/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
   <div>
            <table border="0" cellspacing="1" width="95%" cellpadding="4" align="center" border=1>
                <tr bgcolor="#FFFFFF">
                    <td align="center">
                        <font class="blackfnt"><b>Job Order Entry Summary
                            <asp:Label ID="lblCancel" runat="server" ForeColor="Red"></asp:Label></b></font></td>
                </tr>
            </table>
            <br />
            <table border="1" cellspacing="1" cellpadding="4" width="95%" align="center" >
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <div align="left">
                            <font class="blackfnt">Bill Entry No</font>
                        </div>
                    </td>
                    <td>
                        <font class="blackfnt"><asp:Label ID="lblBillNo" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <div align="left">
                            <font class="blackfnt">Bill Entry Date</font>
                        </div>
                    </td>
                    <td>
                        <font class="blackfnt"><asp:Label ID="lblBillEntryDt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <div align="left">
                            <font class="blackfnt">Vendor Name </font>
                        </div>
                    </td>
                    <td width="30%">
                        <font class="blackfnt"><asp:Label ID="lblVendorName" runat="server"></asp:Label></font>
                    </td>
                    <td align="left">
                        <div align="left">
                            <font class="blackfnt">Vendor Accounted to</font>
                        </div>
                    </td>
                    <td nowrap>
                        <font class="blackfnt"><asp:Label ID="lblVendorAccTo" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="blackfnt">Vendor Bill Number</font></div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="blackfnt"><asp:Label ID="lblVendorBillNo" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt">Vendor Bill Amount</font>
                        </div>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><asp:Label ID="lblVendorBillAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="blackfnt">Vendor Bill Date</font>
                        </div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="blackfnt"><asp:Label ID="lblVendorBillDt" runat="server"></asp:Label></font>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                        <div align="left">
                            <font class="blackfnt">Due Date</font>
                        </div>
                    </td>
                    <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                        <font class="blackfnt"><asp:Label ID="lblDueDt" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <div align="left">
                            <font class="blackfnt">Ref. No.</font>
                        </div>
                    </td>
                    <td>
                        <font class="blackfnt"><asp:Label ID="lblRefNo" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt">Remark</font>
                        </div>
                    </td>
                    <td>
                        <font class="blackfnt"><asp:Label ID="lblRemarks" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <%--<tr bgcolor="#FFFFFF">
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Other Deduction</font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="bluefnt"><asp:Label ID="lblOtherDeduction" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="bluefnt">Discount Received</font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="bluefnt"><asp:Label ID="lblDiscountRecvd" runat="server"></asp:Label></font>
                    </td>
                </tr>--%>
                <tr bgcolor="#FFFFFF">
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt"></font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="blackfnt"> </font>
                    </td>
                    <td valign="top">
                        <div align="left">
                            <font class="blackfnt"><strong>Net Amount</strong></font>
                        </div>
                    </td>
                    <td valign="top">
                        <font class="blackfnt"><asp:Label ID="lblNetAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>
            
            
            <!----  EXPENSE HEADS STARTS HERE ---->
            <br>
            
            
            
            
            
          <table border="0" cellspacing="1" width="95%" cellpadding="4" align="center" >  
                    
                            <tr bgcolor="#FFFFFF">
                <td colspan=4 align="center"><font class=blackfnt><b>Job Order Details</b></font></td>
            </tr>
                
                
          

 
                             
                            
                
                        
             <tr style="background-color: white">
                <td   colspan="4" align="left">
                                    
                  <asp:DataGrid ID="dgExpense" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" ShowFooter="true" OnItemDataBound="dgExpense_ItemDataBound" FooterStyle-HorizontalAlign="Right" FooterStyle-ForeColor="black">
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
                                                           <asp:BoundColumn     DataField="JOB_ORDER_NO"  HeaderText="Job Order Number"  ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="JOB_ORDER_DT"  HeaderText="Job Order date"  ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="JOB_ORDER_CLOSEDT"  HeaderText="Job Order Close date"  ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="JobCardType"  HeaderText="Job Card Type"  ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="VEHNO"  HeaderText="Vehicle No."  ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="TOT_ACT_LABOUR_COST"  HeaderText="Total Labour Cost" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="TOT_ACT_PART_COST"  HeaderText="Total Part Cost"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></asp:BoundColumn>
                                                           <asp:BoundColumn     DataField="TOT_JOB_COST"  HeaderText="Total Job Cost"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></asp:BoundColumn>
                                                            
                                                        </Columns>
                                                        
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#000000" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000000" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>                  
                      

                </td>
            </tr>
          
                           
            
            </table>
            
            <br>
           <!----  EXPENSE HEADS ENDS HERE ---->
              
            
            <table border="1" cellspacing="1" cellpadding="4" width="95%" align="center" >
            <tr bgcolor="#FFFFFF">
                    <td align="left" colspan=3>
                     <font class="blackfnt"><b>VAT Details</b></font>
                    </td>
             </tr>       
                <tr bgcolor="#FFFFFF">
                    <td align="right">
                        <font class="blackfnt">Amount Applicable</font></td>
                    <td align="right">
                        <font class="blackfnt">VAT Rate</font></td>
                    <td align="right">
                        <font class="blackfnt">VAT amount</font></td>
                </tr>
                
                 <tr bgcolor="#FFFFFF">
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblVATApplAmt" runat="server" Text="" ></asp:Label> </font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblVATRate" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblVATAmt" runat="server" Text="" ></asp:Label></font></td>
                </tr>
             </table>  
             
             <br> 
            
            
            
            
             <table border="1" cellspacing="1" cellpadding="4" width="95%" align="center" >
            <tr bgcolor="#FFFFFF">
                    <td align="left" colspan=5>
                     <font class="blackfnt"><b>Service Tax & TDS Details</font>
                    </td>
             </tr>       
                <tr bgcolor="#FFFFFF">
                    <td align="left" colspan=3>
                        <font class="blackfnt" ><b>Service Tax</font></td>
                    <td align="left" colspan=2>
                        <font class="blackfnt"><b>TDS</font></td>
                </tr>
                
                 <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Amount Applicable</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblSTAXApplAmt" runat="server" Text="" ></asp:Label> </font></td>
                    <td align="right">
                        <font class="blackfnt">&nbsp;</font></td>
                      <td align="left">
                        <font class="blackfnt">Amount Applicable</font></td>  
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblTDSApplAmt" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                
                 <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>
                    <td align="right">
                        <font class="blackfnt">Rate</font></td>
                    <td align="right">
                        <font class="blackfnt">&nbsp;</font></td>
                      <td align="left">
                        <font class="blackfnt">TDS Section</font></td>  
                        <td align="left">
                        <font class="blackfnt"><asp:Label  ID="LblTDSSection" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Service Tax(+)</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblSVCTAXRate" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblSVCTAXAmt" runat="server" Text="" ></asp:Label></font></td>
                      <td align="left">
                        <font class="blackfnt">TDS Rate</font></td>  
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblTDSRate" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Education Cess(+)</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblEduCessRate" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblEduCessAmt" runat="server" Text="" ></asp:Label></font></td>
                      <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>  
                        <td align="right">
                        <font class="blackfnt">&nbsp;</font></td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Higher Education Cess(+)</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblHEduCessRate" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblHEduCessAmt" runat="server" Text="" ></asp:Label></font></td>
                      <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>  
                        <td align="right">
                        <font class="blackfnt">&nbsp;</font></td>
                </tr>
                 <%--// Added By Anupam--%>
                 <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Swachh Bharat Cess(+)</font>
                </td>
                <td align="right">
                    <font class="blackfnt">
                        <asp:Label ID="LblSBCessRate" runat="server" Text=""></asp:Label></font>
                </td>
                <td align="right">
                    <font class="blackfnt">
                        <asp:Label ID="LblSBCessAmt" runat="server" Text=""></asp:Label></font>
                </td>
                <td align="left">
                    <font class="blackfnt">&nbsp;</font>
                </td>
                <td align="right">
                    <font class="blackfnt">&nbsp;</font>
                </td>
            </tr>

                 <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt">Krishi Kalyan Cess(+)</font>
                </td>
                <td align="right">
                    <font class="blackfnt">
                        <asp:Label ID="LblKKCessRate" runat="server" Text=""></asp:Label></font>
                </td>
                <td align="right">
                    <font class="blackfnt">
                        <asp:Label ID="LblKKCessAmt" runat="server" Text=""></asp:Label></font>
                </td>
                <td align="left">
                    <font class="blackfnt">&nbsp;</font>
                </td>
                <td align="right">
                    <font class="blackfnt">&nbsp;</font>
                </td>
            </tr>
                <%--// Added By Anupam--%>
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Total Tax</font></td>
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblTotalTAX" runat="server" Text="" ></asp:Label></font></td>
                      <td align="left">
                        <font class="blackfnt">TDS Amount (-)</font></td>  
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblTDSAmt" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                
             </table>  
             
             <br> 
             
             <table border="1" cellspacing="1" cellpadding="4" width="95%" align="center" >
            <tr bgcolor="#FFFFFF">
                    <td align="left" colspan=5>
                     <font class="blackfnt"><b>Net Payable</font>
                    </td>
             </tr> 
             
             <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>
                    <td align="right">
                        <font class="blackfnt">Amount Applicable</font></td>
                    <td align="right">
                        <font class="blackfnt">Tax (+)</font></td>
                      <td align="right">
                        <font class="blackfnt">TDS (-)</font></td>  
                        <td align="right">
                        <font class="blackfnt">Total</font></td>
                </tr>
             
             
              <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Labour</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblLabourApplAmt" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblLabourTaxAmt" runat="server" Text="" ></asp:Label></font></td>
                      <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblLabourTDSAmt" runat="server" Text="" ></asp:Label></font></td>  
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblLabourTotAmt" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt">Parts</font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblPartsApplAmt" runat="server" Text="" ></asp:Label></font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblPartsTaxAmt" runat="server" Text="" ></asp:Label></font></td>
                      <td align="left">
                        <font class="blackfnt">&nbsp;</font></td>  
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblPartsTotAmt" runat="server" Text="" ></asp:Label></font></td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td align="right" colspan=4>
                        <font class="blackfnt"><b>Net Payable</b></font></td>
                    
                        <td align="right">
                        <font class="blackfnt"><asp:Label  ID="LblNetPayable" Font-Bold="true" runat="server" Text="" ></asp:Label></font></td>
                </tr>
             
             </table>
             
             <br>
            
            
            
            <%--<table border="1" cellspacing="1" cellpadding="4" width="95%" align="center" >
                <tr bgcolor="#FFFFFF">
                    <td align="left">
                        <font class="blackfnt"><b>Tax</font></td>
                    <td align="left">
                        <font class="blackfnt"><b>Account Head</font></td>
                    <td align="right">
                        <font class="blackfnt"><b>Approved Rate (%)</font></td>
                    <td align="right">
                        <font class="blackfnt"><b>Value (in Rs.)</font></td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Service Tax</font></td>
                    <td>
                        <font class="blackfnt">SERVICE TAX ( CENVET ) </font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblServiceTaxRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblServiceTaxValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Education Cess</font></td>
                    <td>
                        <font class="blackfnt"><font class="blackfnt">Cenvat (Education Cess) Receivable A/c </font></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblEduCessRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblEduCessValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">Higher Education Cess</font></td>
                    <td>
                        <font class="blackfnt"><font class="blackfnt">Cenvat (Higher Edu Cess) Receivable A/c </font></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblHigherEduRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblHigherEduValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                
                <tr bgcolor="#FFFFFF">
                    <td>
                        <font class="blackfnt">TDS</td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDS" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDSRate" runat="server"></asp:Label></font>
                    </td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblTDSValue" runat="server"></asp:Label></font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="4" >
                        <font class="blackfnt"><b>Net Payable Amount</b> </font></td>
                    <td align="right">
                        <font class="blackfnt"><asp:Label ID="lblNetPayableAmt" runat="server"></asp:Label></font>
                    </td>
                </tr>
            </table>--%>
        </div>
    </form>
</body>
</html>
