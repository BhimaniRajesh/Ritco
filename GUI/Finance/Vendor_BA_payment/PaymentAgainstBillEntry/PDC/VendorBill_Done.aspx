<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorBill_Done.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_Vendor_VendorBill_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2) 
        { 
        window.open("./vendorbill_xls.aspx?strGenerateBillNo=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

    <div>
    
    <table border="0" align="left" style="width:6in" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
  <tr class="bgbluegrey">
    <td width="100%" align="center"  height="18" colspan="4">
     <font class="blackfnt"> <font class="bluefnt"><b>Following document has been successfully
     generated
      </b>&nbsp;</font></font></td>
  </tr>
  <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" width="25%" nowrap><font class="blackfnt" >Document name</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1" nowrap><font class="blackfnt" >Document Number</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt">&nbsp;</font></td>
  </tr>
   <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2"><font class="blackfnt" >Bill Entry</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt" >
        <asp:Label ID="lblBillNo" runat="server" Text="Label"></asp:Label></font></td>
    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("GenerateBillNo")%>',0)"><font class="blklnkund">View</font></a> |<a href="Javascript:ViewPrint('<%=Request.QueryString.Get("GenerateBillNo")%>',1)"><font class="blklnkund">Print </font></a></td>
  </tr>
  <tr>
    <td  align="left" bgcolor="#FFFFFF" height="18" colspan="4"><font class="blackfnt" ><b>Your Next Step:</b></font></td>
  </tr>
  <tr  bgcolor="#FFFFFF">
    <td width="2%" height="25" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../../images/clear.gif" width="4" height="4" alt="" /></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt" color="#0000FF"><a href="VendorBills.aspx"><font class="blklnkund">Enter more Vendor Bills</font></a></font></td>
  </tr>
 <tr  bgcolor="#FFFFFF">
	<td width="2%" height="25" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../../images/clear.gif" alt="" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt" color="#0000FF"><a href=""><font class="blklnkund">Prepare Vendor Payment Voucher</font></a></font></td>
  </tr>
  <tr  bgcolor="#FFFFFF">
	<td width="2%" height="25" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../../images/clear.gif" alt="" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt" color="#0000FF"><a href="vendorBill_vpstep1.aspx"><font class="blklnkund">View & Print Bill Entries</font></a></font></td>
  </tr>
 
  
</table>
    
    </div>
    </asp:Content>
