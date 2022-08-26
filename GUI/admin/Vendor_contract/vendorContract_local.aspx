<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_local.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_local" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
function  Check_num(obj,arg){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      		obj.value="0.00";
      	return false;
    	}
	}
</script>
<table width="80%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong></strong></font>
          
		<strong> &gt; </strong><strong>Administrator </strong>

<strong> &gt; </strong> <strong>Finance & Accounts</strong>

<strong> &gt; </strong><font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class="bluefnt"><strong> &gt; </strong>
		  <strong>Charge Matrices :Local Vendor </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"></td>
        </tr>
        <tr> 
          <td></td>
        </tr>

   
        
        <tr> 
          <td align="right"></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 

<br /><br />
<table align="center" border="0" cellpadding="7" cellspacing="1" style="width: 9.0in;" class="boxbg">
 
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>VENDOR CONTRACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  border="0" align="center" cellspacing="1" cellpadding="6 " style="width: 8.5in;" class="boxbg">
<tr >
<td colspan="4" class="bgbluegrey"><font class="blackfnt"><strong><U>Step : 3</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Charge Matrices : Local Vendor </b> </strong></font></td>
</tr><tr >
<td colspan="4" bgcolor="#ffffff"><p align ="left" ><font class="blackfnt"><b>Fixed Charges</b></font></p>
<table  border="0" align="center" cellspacing="1" cellpadding="6" width="100%" class="boxbg">
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Fixed charges Rs. </font></td>
<td width="25%"><font class="blackfnt" >
<asp:TextBox ID="txtminchrg" MaxLength="10"  runat="server" width="56px"></asp:TextBox>
<asp:HiddenField id="txtchrgbasis"   runat="server"/>   
</font></td>
</tr> 


<tr bgcolor="#ffffff">

<td  align="center" colspan="2"><asp:Button ID="Submit" OnClick="Submit_Click"    runat="server" Text="Submit" TabIndex="9"  /></td>
</tr>
</table>
</td>
</tr>



</table>
<!--END-->
					  </td>
                    </tr>
                   
                   
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    

</asp:Content>


