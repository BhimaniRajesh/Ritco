<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ExpenseEntryDone.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_ExpenseEntryDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("../../View_N_Print/ViewExpenseEntryPP.aspx?expBillNo=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

 <div align="left">
 
        <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vendor Payment >> Vendor Bill Entry >> Fuel Expense</asp:Label>
 
            </td>
             <td align=left>
          </td>      
        </tr>
    </table>
    
  
    <hr align="center" size="1" color="#8ba0e5">
      
    <br />
    <table border="0" align="left"  cellspacing="1" bgcolor="#000000" cellpadding="2" class="boxbg" width="60%">
							  <tr class="bgbluegrey">
							    <td  align="center"   colspan="4">
							     <font class="blackfnt"></font> <font class="bluefnt"><b>Following Bill Successfully Generated!!!.
							      </b>&nbsp;</font></td>
							  </tr>
							  <tr>
							    <td  align="center" bgcolor="#FFFFFF"  colspan="2" ><font class="blackfnt" >Document name</font></td>
							    <td  align="center" bgcolor="#FFFFFF"  colspan="1" ><font class="blackfnt" >Document Number</font></td>
							    <td  align="center" bgcolor="#FFFFFF"  colspan="1"><font class="blackfnt">&nbsp;</font></td>
							  </tr>
							   <tr>
							    <td  align="center" bgcolor="#FFFFFF"  colspan="2"><font class="blackfnt" >Bill Number</font></td>
							    <td  align="center" bgcolor="#FFFFFF"  colspan="1"><font class="blackfnt" >
                                    <asp:Label ID="lblTHCNo" runat="server" Text="Label"></asp:Label></font></td>
							    <td  align="right" bgcolor="#FFFFFF"  colspan="1"><font class="blackfnt" ><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("BillNo")%>',0)"><font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("BillNo")%>',1)"><font class="blklnkund">Print </font></a></td>
							  </tr>
							  
							  <%-- <tr>
							        <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" ><font class="blackfnt">Payment Voucher</font></td>
								    <td align="center" bgcolor="#FFFFFF"><font class="blackfnt">
                                        <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></font></td>
								    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><font class="blklnkund">View</font> | <font class="blklnkund">Print </font>| <font class="blklnkund">Email </font></td>
							   </tr>--%>
							
							 
							  <tr>
							    <td  align="left" bgcolor="#FFFFFF"  colspan="4"><font class="blackfnt" ><b>Your Next Step:</b></font></td>
							  </tr>
							 
							  <%--<tr  bgcolor="#FFFFFF">
							    <td width="2%" height="25" bgcolor="#FFFFFF"> 
												                  <table border="0" cellspacing="0" cellpadding="0">
												                    <tr> 
												                      <td class="bullet"><img src="../../../../../images/clear.gif"  alt="" width="4" height="4" /></td>
												                    </tr>
												                  </table> </td> <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3">
							    
						<font class="blklnkund"></font>
						
						</td>
							  </tr>
							  --%>
							<tr  bgcolor="#FFFFFF">
							    <td width="2%" height="25" bgcolor="#FFFFFF"> 
												                  <table border="0" cellspacing="0" cellpadding="0">
												                    <tr> 
												                      <td class="bullet"><img src="../../../../images/clear.gif" alt="" width="4" height="4" /></td>
												                    </tr>
												                  </table> </td>
							    <td width="100%" align="left" bgcolor="#FFFFFF"  colspan="3"><a href="DieselExpenseNew.aspx"><font class="blackfnt" color="#0000FF"><font class="blklnkund">Generate more Vendor Bills</font></a></td>
							  </tr>

							 
							  <tr  bgcolor="#FFFFFF">
							    <td width="2%" height="25" bgcolor="#FFFFFF"> 
												                  <table border="0" cellspacing="0" cellpadding="0">
												                    <tr> 
												                      <td class="bullet"><img src="../../../../images/clear.gif" alt="" width="4" height="4" /></td>
												                    </tr>
												                  </table> </td>
							    <td width="100%" align="left" bgcolor="#FFFFFF"  colspan="3"><a href="../../View_N_Print/Billentry_step1.aspx"><font class="blackfnt" color="#0000FF"><font class="blklnkund">View & Print Vendor Bills</font></a></td>
							  </tr>
							</table>								

    
    </div>


</asp:Content>
