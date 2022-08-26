<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="PDC_FIN_Updates_Done.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PDC_FIN_Edit_PDC_FIN_Updates_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("../preparevoucher/vendor/ViewTHCAdvance.aspx?advvoucher=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

<br />
 <div align="left">
    
    <table border="0" align="left" style="width:9.5in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
							  <tr class="bgbluegrey">
							    <td width="100%" align="center"  height="18" colspan="4">
							     <font class="blackfnt"></font> <font class="bluefnt"><b>PDC Financially Updated Successfully !!!.
							      </b>&nbsp;</font></td>
							  </tr>
							  <tr>
							    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" width="35%" ><font class="blackfnt" >Document name</font></td>
							    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1" ><font class="blackfnt" >Document Number</font></td>
							    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt">&nbsp;</font></td>
							  </tr>
							   <tr>
							    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2"><font class="blackfnt" >PDC NO</font></td>
							    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt" >
                                    <asp:Label ID="lblTHCNo" runat="server" Text="Label"></asp:Label></font></td>
							    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><%--<font class="blackfnt" ><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("voucherNo")%>',0)"><font class="blklnkund">View</font></a>  | <font class="blklnkund">Print </font>--%></td>
							  </tr>
							  
							  <%-- <tr>
							        <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" ><font class="blackfnt">Advance Payment Voucher</font></td>
								    <td align="center" bgcolor="#FFFFFF"><font class="blackfnt">
                                        <asp:Label ID="lblVoucherNo" runat="server" Text=""></asp:Label></font></td>
								    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt" ><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("voucherNo")%>',0)"><font class="blklnkund">View</font></a>  | <font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("voucherNo")%>',1)"><font class="blklnkund">Print </font></td>
							   </tr>--%>
							 <%-- <tr>
							        <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" ><font class="blackfnt">Balance Payment Voucher</font></td>
								    <td align="center" bgcolor="#FFFFFF"><font class="blackfnt">
                                        <asp:Label ID="lblBalancePayment" runat="server" Text=""></asp:Label></font></td>
								    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><font class="blklnkund">View</font> | <font class="blklnkund">Print </font>| <font class="blklnkund">Email </font></td>
							   </tr>--%>
							 
							 <%-- <tr>
							    <td  align="left" bgcolor="#FFFFFF" height="18" colspan="4"><font class="blackfnt" ><b>Your Next Step:</b></font></td>
							  </tr>
							 
							  <tr  bgcolor="#FFFFFF">
							    <td width="2%" height="25" bgcolor="#FFFFFF"> 
												                  <table border="0" cellspacing="0" cellpadding="0">
												                    <tr> 
												                      <td class="bullet"><img src="../../../images/clear.gif"  alt="" width="4" height="4" /></td>
												                    </tr>
												                  </table> </td> <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3">
							    
						<font class="blklnkund">Update More existing THCs</font>
						
						</td>
							  </tr>
							  --%>
							 
							<%--  <tr  bgcolor="#FFFFFF">
							    <td width="2%" height="25" bgcolor="#FFFFFF"> 
												                  <table border="0" cellspacing="0" cellpadding="0">
												                    <tr> 
												                      <td class="bullet"><img src="../../../images/clear.gif" alt="" width="4" height="4" /></td>
												                    </tr>
												                  </table> </td>
							    <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt" color="#0000FF"><font class="blklnkund">View & Print THCs</font></td>
							  </tr>--%>
							</table>								

    
    </div>


</asp:Content>
