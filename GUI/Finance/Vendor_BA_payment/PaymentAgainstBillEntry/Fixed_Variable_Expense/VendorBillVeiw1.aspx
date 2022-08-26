<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorBillVeiw1.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_Vendor_VendorBillVeiw1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vendor Bill View</title>
    <link href="../../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <% string strGenerateBillNo = Request.QueryString.Get("strGenerateBillNo");
        string[] Split = strGenerateBillNo.Split(new Char[] { ',' });
        string GenerateBillNo = Convert.ToString(Split[0]);
        //Response.Write("GenerateBillNo : " + GenerateBillNo);
        string print_yn = Convert.ToString(Split[1]);
        string boxbg = "boxbg";
        string bgbluegrey = "bgbluegrey";
        string strborder = "border='0'";
              if (print_yn == "1")
              {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "border='1'";
              }

      %>
      <br />
<table border="0" cellpadding="3" cols="1" width="100%"  bgcolor="#808080" cellspacing="1" align="left" class='<%=boxbg%>'>
 <tr bgcolor="#ffffff"><td>      
      
                             <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" width="100%" align="left" class='<%=boxbg%>'>
                              <tr class='<%=bgbluegrey%>'> 
                                <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Payment Voucher Summary</b></font></b></td>
                              </tr>
                            </table>
     <br />
</td></tr>
<tr bgcolor="#ffffff"><td>                        
    <table border="0" width="100%"  bgcolor="#808080" cellpadding="2"  cellspacing="1" class='<%=boxbg%>'>
                                     <tr bgcolor="#FFFFFF">
										<td align="left" style="width:2in" ><font class="blackfnt">&nbsp;Payment Voucher No</font></td>
										<td align="left" ><font class="blackfnt">
										<asp:Label ID="lblVoucherNo" runat="server"></asp:Label>
										</font> </td>
                                    
										<td align="left" style="width:2in" ><font class="blackfnt">&nbsp;Voucher Date</font></td>
										<td align="left" ><font class="blackfnt">
										<asp:Label ID="lblVoucherDt" runat="server"></asp:Label>
										</font> </td>
                                        
                                     </tr>




                            <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Vendor</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%" colspan="3"> 
                                  <div align="left"><font class="blackfnt"><asp:Label ID="lblVendor" runat="server"></asp:Label> 
                                    </font></div>
                                  
                                </td>
                              </tr>
                              <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt"> 
                                  Vendor Service Tax no.</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt"><asp:Label ID="lblServiceTaxNo" runat="server"></font></asp:Label> 
                                  </td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">Vendor 
                                  PAN number</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">
                                <asp:Label ID="lblPANNo" runat="server"></asp:Label>
                                  </font></td>
                              </tr>
                              

            </table>

 <br />
</td></tr>
<tr  bgcolor="#ffffff"><td>   

<table border="0" cellspacing="1" cellpadding="4" width="100%"  align="left" class='<%=boxbg%>'>
                              <tr class='<%=bgbluegrey%>'> 
                                <td colspan="4" align="center"><font class="blackfnt"><b> 
                                  Vendor Bill Details</b> </font></td>
                              </tr>
                           
    <tr bgcolor="#FFFFFF"> 
  <td colspan="4" align="center">                         
<asp:GridView ID="dockdata"  runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass='<%=bgbluegrey%>'
AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" OnPageIndexChanging="dockdata_PageIndexChanging"
CssClass='<%=boxbg%>' BackColor="white" FooterStyle-CssClass='<%=bgbluegrey%>'  ShowFooter="True"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
EmptyDataText="No Records Found..." width="100%">
 
<Columns>
 
 
<asp:TemplateField HeaderText="SRNo." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
<ItemTemplate>
<asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
</asp:Label>
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField>
<HeaderTemplate >
              <asp:Label ID="hdrBillNo" CssClass="blackfnt" Text="Bill Entry Number" runat="server"></asp:Label>
              </HeaderTemplate>
<ItemTemplate>
<asp:Label ID="lblBillNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>'></asp:Label>  
</ItemTemplate> 
</asp:TemplateField> 
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="hdrVendorBillNo" style="text-align:center" CssClass="blackfnt" Text="Vendor Bill Number" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                    <asp:Label ID="lblVendorBillNo" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"vendorBILLNO") %>'></asp:Label>  
                   
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="hdrVendorBillDt"    style="text-align:center" CssClass="blackfnt" Text="Vendor Bill date" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                    <asp:Label ID="lblVendorBillDt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"VendorBill_DT") %>'></asp:Label>  
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="hdrDueDt"    style="text-align:center" CssClass="blackfnt" Text="Due Date" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                     <asp:Label ID="lblDueDt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Due_DT") %>'></asp:Label>  
                    </center>
                </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField HeaderStyle-HorizontalAlign=right ItemStyle-HorizontalAlign=right>
              <HeaderTemplate>
              <asp:Label ID="hdrNetPayable"   style="text-align:center"  CssClass="blackfnt" Text="Net Payable" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                   
                      <asp:Label ID="lblNetPayment" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"netamt") %>'></asp:Label>  
                   
                </ItemTemplate>
 </asp:TemplateField>
 
 <asp:TemplateField HeaderStyle-HorizontalAlign=right ItemStyle-HorizontalAlign=right>
              <HeaderTemplate >
              <asp:Label ID="hdrAmountPaid"    style="text-align:center" CssClass="blackfnt" Text="Amount Paid" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                  
                    <asp:Label ID="lblAmountPaid" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>'></asp:Label>  
                   
                </ItemTemplate>
 </asp:TemplateField>
 <%--<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="hdrCurrentPayment"   style="text-align:center"  CssClass="blackfnt" Text="Current Payment" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                     <asp:Label ID="lblCurrentPayment" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"pendamt") %>'></asp:Label>  
                    </center>
                </ItemTemplate>
 </asp:TemplateField>--%>

 
 
 


</Columns>
<RowStyle />
<PagerStyle HorizontalAlign="Center" CssClass='<%=bgbluegrey%>' />
<HeaderStyle CssClass='<%=bgbluegrey%>' />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass='<%=bgbluegrey%>' />
</asp:GridView>

 </div>
 <br />
 </table>
</td></tr>
<tr  bgcolor="#ffffff"><td>   
<table align=left width="100%"  border="0" cellspacing="1" cellpadding="3" bgcolor="#808080" class='<%=boxbg%>'>
                                <tr class='<%=bgbluegrey%>'> 
                                    <td colspan="4" align="center"><font class="blackfnt">Payment Details</td>
                                </tr>
  
						        <tr bgcolor="#FFFFFF">
						            <td> <font class="blackfnt">Mode Of Transaction  </font></td>
				                    <td> <font class="blackfnt">
				                    <asp:Label ID="lblMode" runat="server" ></asp:Label></font>
				                    </td>
				                    <td> <font class="blackfnt">Payment Account</font></td>
                                    <td> <font class="blackfnt">
                                     <asp:Label ID="lblPaymentAcc" runat="server" ></asp:Label></font>
                                    </td>
				                </tr>
								<tr bgcolor="#FFFFFF">
								    <td><font class="blackfnt">Cheque No </font></td>
                                    <td><font class="blackfnt">
                                     <asp:Label ID="lblChequeNo" runat="server" ></asp:Label></font>
                                    </td>
                                    <td><font class="blackfnt">Cheque Date</font></td>
                                    <td><font class="blackfnt">
                                     <asp:Label ID="lblChequeDt" runat="server" ></asp:Label></font>
                                    </td>
                                 </tr>
        
                                 <tr bgcolor="#ffffff"> 
                                    <td><font class="blackfnt">Payment Amount (in Rs.)</font></td>
                                    <td><font class="blackfnt">
                                     <asp:Label ID="lblPaymentAmt" runat="server" ></asp:Label></font>
                                    </td>  
								    <td colspan="2"></td>
                                 </tr>
                                 <tr bgcolor="#ffffff">
			                        <td colspan="4"><font class="blackfnt"><b>Rs. (in words):</b>&nbsp;&nbsp;<asp:Label ID="lblWords" runat="server" ></asp:Label></font></td>
                                 </tr>
						 </table> 
    <br />
</td></tr>
            

								     <br />
								      <%
         if (print_yn == "1")
       {
         
       %>
        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
        </script>
       <%} %>  
    
    </div>
    </form>
</body>
</html>