<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_mileagebasis.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_mileagebasis" Title="Untitled Page" %>
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
<br />
<br />
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
		  <strong>Charge Matrices : Mileage matrix </strong> </font></td>
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


<table align="center" border="0" cellpadding="7" cellspacing="1" style="width: 9.0in;" class="boxbg">
 
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>VENDOR CONtrACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  border="0" align="center" cellspacing="1" cellpadding="6 "style="width: 9.0in;"class="boxbg">
<tr >
<td colspan="4" class="bgbluegrey"><font class="blackfnt"><strong><U>Step : 3</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Charge Matrices : Mileage matrix </b> </strong></font></td>
</tr><tr >
<td colspan="4" bgcolor="#ffffff">
<table  border="0" align="center" cellspacing="1" cellpadding="6" width="50%" class="boxbg">

<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class="blackfnt">Applicable transaction</font></td>
<td width="25%"><font class="blackfnt" >
    <asp:DropDownList ID="cboapptrans" runat="server">
    <asp:ListItem Value="All" Text="All"></asp:ListItem>
    <asp:ListItem Value="THC" Text="THC"></asp:ListItem>
    <asp:ListItem Value="PRS" Text="PRS"></asp:ListItem>
    <asp:ListItem Value="DRS" Text="DRS"></asp:ListItem>
    </asp:DropDownList></font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class="blackfnt">Fixed charges - Minimum</font></td>
<td width="25%"><font class="blackfnt" ></font>
<font>
    <asp:TextBox ID="txtminchrg" MaxLength="10"  runat="server" width="56px"></asp:TextBox>
    <%--<asp:DropDownList ID="cbokmrs" runat="server" width="40px">
    <asp:ListItem Value="RS" Text="Rs."></asp:ListItem>
    <asp:ListItem Value="KM" Text="Km."></asp:ListItem>
    </asp:DropDownList>--%></td>
</tr> 
<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class="blackfnt">Fixed charges - Maximum</font></td>
<td width="25%"><font class="blackfnt" >
    <asp:TextBox ID="txtmaxchrg" MaxLength="10"  runat="server" width="56px"></asp:TextBox></td>
</tr> 
<%--<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class=blackfnt>Charge basis</font></td>
<td width="25%"><font class=blackfnt >
    <asp:DropDownList ID="DropDownList3" runat="server">
    <asp:ListItem Value="" Text="Select"></asp:ListItem>
    <asp:ListItem Value="Per trip" Text="Per trip"></asp:ListItem>
     <asp:ListItem Value="Per Month" Text="Per Month"></asp:ListItem>   
    
    </asp:DropDownList></td>
</tr>--%>
<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class="blackfnt">Charge basis</font></td>
<td width="25%"><font class="blackfnt "><asp:HiddenField  ID="txtchrgbasis" Value="Per Month"  runat="server"/>
    <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Text="Per Month "></asp:Label></font></td>
</tr>
<tr bgcolor="#ffffff">
<td  colspan="2" ></td>
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

