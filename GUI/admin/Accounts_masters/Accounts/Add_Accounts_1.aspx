<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Add_Accounts_1.aspx.cs" Inherits="GUI_admin_Accounts_masters_Accounts_Add_Accounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
Form_name="ctl00$MyCPH1$"

function Chk_Text_YN(obj,txtObj)
{
   
   if(obj.checked)
   {
   document.getElementById(txtObj).value="Yes"
   }
   else
   {
   document.getElementById(txtObj).value="No"
   }
       accessinStr=""
        if(document.getElementById(Form_name+"chkpay_YN").checked)
        {
             if(accessinStr=="")
             {
                 accessinStr="P"
             }
             else
             {
                accessinStr=accessinStr+",P"
             }
        }
        if(document.getElementById(Form_name+"chkrec_YN").checked)
        {
             if(accessinStr=="")
             {
                 accessinStr="R"
             }
             else
             {
                accessinStr=accessinStr+",R"
             }
        }
        document.getElementById(Form_name+"AccountAccessIn").value=accessinStr
   
}
function Chk_Text_YN_1(obj,txtObj)
{
   
   if(obj.checked)
   {
   //alert(Form_name+"Txt_"+txtObj)
   document.getElementById("Txt_"+txtObj).value="Yes"
   document.getElementById(Form_name+"H_Chk_"+txtObj).value="Y"
  //alert( document.getElementById(Form_name+"H_Chk_"+txtObj).value)
  
   }
   else
   {
    document.getElementById("Txt_"+txtObj).value="No"
    document.getElementById(Form_name+"H_Chk_"+txtObj).value="N"
   }
   accessbyStr=""
   for (i=1;i<7;i++)
   {
        //alert(accessinStr)
        if(document.getElementById("Chk_"+i).checked)
        {
             if(accessbyStr=="")
             {
                 accessbyStr=i
             }
             else
             {
                accessbyStr=accessbyStr+","+i
             }
        }
        document.getElementById(Form_name+"AccountAccessBy").value=accessbyStr
   }
}
function Pin_Email_val(obj,type)
{

        //   alert(type)
            if(type=="Pin")
            {
                   if(obj.value!="")
					{
						if (isNaN(obj.value)) 
						{
							alert ("Please enter a Proper PIN.");
							obj.focus();				
							return false;
						}
						if (obj.value.length!=6)
						{
							alert ("PIN Should be Six digit long");
							obj.focus();				
							return false;
						}
						
					}
						
			}
			else
			{						
					if(obj.value!="")
					{
						if (obj.value.indexOf("@")==-1 || obj.value.indexOf(".")==-1)
						{
						alert ("Please enter a correct Email address.");
						obj.focus();				
						return false;
						}
					}
			}
}

	function ADDme()
		{
				
				if (document.getElementById(Form_name+"txtAccDesc").value=="")
				{
							alert("Please enter Account Description!!!");
							document.getElementById(Form_name+"txtAccDesc").focus();
							return false;
					
				}		
				
				else if ((document.getElementById(Form_name+"cmbGroup").options[document.getElementById(Form_name+"cmbGroup").selectedIndex].value==""))
				{
							alert("Please select Group!!!");
							document.getElementById(Form_name+"cmbGroup").focus();
							return false;
				
				}
				else if ((document.getElementById(Form_name+"cmbAccCategory").options[document.getElementById(Form_name+"cmbAccCategory").selectedIndex].value==""))
				{
							alert("Please select account category!!!");
							document.getElementById(Form_name+"cmbAccCategory").focus();
							return false;
				
				}
				
				else if (document.getElementById(Form_name+"cmbAccCategory").options[document.getElementById(Form_name+"cmbAccCategory").selectedIndex].value=="BANK")
				{
				
					Var_bkAcctNo= document.getElementById(Form_name+"bkAcctNo").value
					
					Var_bkLocCode=document.getElementById(Form_name+"bkLocCode").value.toUpperCase();
					document.getElementById(Form_name+"bkLocCode").value=Var_bkLocCode
					
					if (Var_bkAcctNo=="")
					{
							alert("Please Enter Bank Account No");
							document.getElementById(Form_name+"bkAcctNo").focus();
							return false;
					}
					
					if (document.getElementById(Form_name+"bkLocCode").value=="")
					{
							alert("Please Select Bank applies for Branches");
							document.getElementById(Form_name+"bkLocCode").focus();
							return false;
					}
					
					var str = new String(Var_bkLocCode)
					
				}
				               
//				else
//				{	 
							
					
					if(document.getElementById(Form_name+"txtPin").value!="")
					{
						if (isNaN(document.getElementById(Form_name+"txtPin").value)) 
						{
							alert ("Please enter a Proper PIN.");
							document.getElementById(Form_name+"txtPin").focus();				
							return false;
						}
						if (document.getElementById(Form_name+"txtPin").value.length!=6)
						{
							alert ("PIN Should be Six digit long");
							document.getElementById(Form_name+"txtPin").focus();				
							return false;
						}
						
					}
						
									
					if(document.getElementById(Form_name+"txtEmail").value!="")
					{
						if (document.getElementById(Form_name+"txtEmail").value.indexOf("@")==-1 || document.getElementById(Form_name+"txtEmail").value.indexOf(".")==-1)
						{
						alert ("Please enter a correct Email address.");
						document.getElementById(Form_name+"txtEmail").focus();				
						return false;
						}
					}
//				}	
//					// ----- start new 27-Nov-06
					 if (document.getElementById(Form_name+"cmbAccCategory").options[document.getElementById(Form_name+"cmbAccCategory").selectedIndex].value=="FIXED ASSETS")
					 {
					 	if (document.getElementById(Form_name+"deprate").value == "" || document.getElementById(Form_name+"deprate").value == 0)
						{
							alert("Depreciation Rate is mandatory for Fixed Assets!")
							document.getElementById(Form_name+"deprate").focus();				
							return false;
						}
						
						if(document.getElementById(Form_name+"deprate").value != "") 
						{
							if(isNaN(document.getElementById(Form_name+"deprate").value))
							{
								alert("Please enter Numeric Value ")
								document.getElementById(Form_name+"deprate").focus();
								return false;
							}
						
							if(parseFloat(document.getElementById(Form_name+"deprate").value) < 0)
							{
								alert("Depreciation Rate cannot be Negative.")
								document.getElementById(Form_name+"deprate").focus();
								return false;
							}	
						}
						
						if(document.getElementById(Form_name+"depmethod").value == "")
						{
							alert("Depreciation Method is mandatory for Fixed Assets!")
							document.getElementById(Form_name+"depmethod").focus();
							return false;
						}					 
					}	
					//alert("hi..")
				              //  return false;
//					// ----/- end new 27-Nov-06
//				}
				
			
		}
</script>

<div>
     <table style="width:10in" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
 <a href="#"><font class="blklnkund"><strong>Admin</strong> </font></a>
  <strong> &gt; </strong>
   <a href="../../finance_accounts.aspx"><font class="blklnkund"><strong>Finance & Accounts</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		   <asp:Label ID="mastertype"  Font-Bold="true"  CssClass="bluefnt" Text="Add Accounts"  runat="server"></asp:Label>  
		   
		  </strong> </font>
   </td></tr>
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
   <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    <tr>
    <td>
        <Table  border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:9in"  align="Center" >
       <tr  class="bgbluegrey" >
       <td align="center" colspan="4" class="blackfnt" ><b><asp:Label ID="mastertype1"  Font-Bold="true"  CssClass="bluefnt" Text="Add Accounts Group"  runat="server"></asp:Label>  
		   </b> </td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Account Code </td>
        <td align="Left" class="blackfnt"  colspan="2"  >  <asp:Label ID="lblGroupcode"  Font-Bold="true"  CssClass="blackfnt" Text="System Generated" ForeColor="red" runat="server"></asp:Label>   </td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Account Description  </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:TextBox ID="txtAccDesc"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="50" MaxLength="50" ></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" colspan="2"  >Under Group </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:DropDownList ID="cmbGroup" runat="server"  Width="4in"></asp:DropDownList> </td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" style="height: 24px" >Account Category  </td>
        <td align="Left" class="blackfnt" colspan="2" style="height: 24px"  > 
        <asp:DropDownList ID="cmbAccCategory"  CssClass="blackfnt" runat="server"  Width="1.5in">
        <asp:ListItem Value="">---Select---</asp:ListItem>
        <asp:ListItem Value="PARTY">PARTY</asp:ListItem>
        <asp:ListItem Value="TAX">TAX</asp:ListItem>
        <asp:ListItem Value="ASSET">ASSET</asp:ListItem>
        <asp:ListItem Value="FIXED ASSETS">FIXED ASSETS</asp:ListItem>
        <asp:ListItem Value="BANK">BANK</asp:ListItem>
        <asp:ListItem Value="CASH">CASH</asp:ListItem>
        <asp:ListItem Value="DEBTOR">DEBTOR</asp:ListItem>
         <asp:ListItem Value="LIABILITIES">LIABILITIES</asp:ListItem>
        <asp:ListItem Value="CREDITOR">CREDITOR</asp:ListItem>
        <asp:ListItem Value="CREDITOR EXPENSES">CREDITOR EXPENSES</asp:ListItem>
         <asp:ListItem Value="DEBTOR & CREDITOR">DEBTOR & CREDITOR</asp:ListItem>
        <asp:ListItem Value="EXPENSES">EXPENSES</asp:ListItem>
        <asp:ListItem Value="PURCHASE">PURCHASE</asp:ListItem>
         <asp:ListItem Value="P & L">P & L</asp:ListItem>
        <asp:ListItem Value="INCOME">INCOME</asp:ListItem>
        <asp:ListItem Value="SALE">SALE</asp:ListItem>
        <asp:ListItem Value="EXPORT SALE">EXPORT SALE</asp:ListItem>
        </asp:DropDownList> </td>
       </tr>
       
      <%-- <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" >Account Access By   </td>
        <td align="Left" class="blackfnt" ><asp:TextBox ID="TextBox1"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="50" MaxLength="50" ></asp:TextBox></td>
       </tr>--%>
         <%=strContractChargesTemp %>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Applied For Manual Voucher </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="chk_manual_voucher"  Checked="true" runat="server"  CssClass="input"/><asp:TextBox ID="Manual_voucher_yn" runat="server"  CssClass="blackfnt" Columns="3"  Enabled="false" Text="Yes"></asp:TextBox> </td>
       </tr>
     
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Access In   </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="chkpay_YN" runat="server"  CssClass="input"/><asp:TextBox ID="Txtpay_YN" runat="server" Columns="3"   CssClass="blackfnt" Enabled="false" Text="No"></asp:TextBox> Payment Vouchers </td>
        </tr>
        <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >  </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="chkrec_YN" runat="server"  CssClass="input"/><asp:TextBox ID="Txtrec_YN" runat="server" Columns="3"   CssClass="blackfnt" Enabled="false" Text="No"></asp:TextBox> Receipt  Vouchers</td>
       </tr>
       
        <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Sub group    </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="Chk_subgroup" runat="server"  CssClass="input"/><asp:TextBox ID="Txtsubgroup" runat="server" Columns="3"   CssClass="blackfnt" Enabled="false" Text="No"></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Active Flag </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="Chk_activeflag" runat="server"  Checked="true" CssClass="input"/><asp:TextBox ID="Txtactiveflag"  runat="server" Columns="3"   CssClass="blackfnt" Enabled="false" Text="Yes"></asp:TextBox> </td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" ><b>Provide Location detail for a Bank account...</b>  </td>
        <td align="Left" class="blackfnt"  colspan="2" > </td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Account Number    </td>
        <td align="Left" class="blackfnt" colspan="2"  ><asp:TextBox ID="bkAcctNo"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="20" MaxLength="50" ></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Applicable to Locations <br />(If applicable to All Specify All else branches should be seperated by comma(,))  </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:TextBox ID="bkLocCode"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="20" MaxLength="200" ></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Deposit Facility </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:CheckBox ID="Chk_deposit" runat="server"  CssClass="input"/><asp:TextBox ID="Txt_deposit" runat="server" Columns="3"  Enabled="false" Text="No"></asp:TextBox></td>
       </tr>
        <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" colspan="2"  ><b>Provide Additional detail for a accounts...</b>  </td>
        <td align="Left" class="blackfnt"  colspan="2" > </td>
       </tr>
       
       
        <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt"  colspan="2" >Contact Person  </td>
        <td align="Left" class="blackfnt"  colspan="2" > <asp:TextBox ID="txtContPerson"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="20" MaxLength="30" ></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" colspan="2"  >Address </td>
        <td align="Left" class="blackfnt"  colspan="2" ><asp:TextBox ID="txtAddress"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server"  MaxLength="250"   Rows="4" Columns="40" TextMode="MultiLine"></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" >State  </td>
        <td align="Left" class="blackfnt" ><asp:TextBox ID="txtState"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server"  MaxLength="50"   Rows="4" Columns="20" ></asp:TextBox> </td>
        <td align="Left" class="blackfnt" >City  </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="txtCity"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="25" MaxLength="50" ></asp:TextBox></td>
       </tr>
        <tr  bgcolor="#ffffff"   >
          <td align="Left" class="blackfnt" >Pin  </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="txtPin"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="6" MaxLength="6" ></asp:TextBox></td>

       <td align="Left" class="blackfnt" >Tel  </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="TxtTel"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="25" MaxLength="25" ></asp:TextBox></td>
      
            </tr>
        <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" >Fax </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="txtFax"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="25" MaxLength="25" ></asp:TextBox></td>
     
       <td align="Left" class="blackfnt" >Email </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="Txtemail"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="25" MaxLength="25" ></asp:TextBox></td>
       </tr>
       <tr  bgcolor="#ffffff"   >
       <td align="Left" class="blackfnt" >Rate of Depreciation (%)  </td>
        <td align="Left" class="blackfnt" > <asp:TextBox ID="deprate"  onChange="javascript:this.value=this.value.toUpperCase();" CssClass="input" runat="server" Columns="6" MaxLength="6" ></asp:TextBox> </td>
       
       <td align="Left" class="blackfnt" >Depreciation Method  </td>
        <td align="Left" class="blackfnt" > <asp:DropDownList ID="depmethod" runat="server"   CssClass="blackfnt" Width="0.5in">
         <asp:ListItem Value="" Selected="True">Select</asp:ListItem>
        <asp:ListItem Value="1">SLM</asp:ListItem>
        <asp:ListItem Value="2">WDV</asp:ListItem>
        </asp:DropDownList></td>
       </tr>
      
       <tr bgcolor="#ffffff" > 
          <td colspan="4"><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr  class="bgbluegrey" >
       <td align="center" colspan="4" class="blackfnt" ><b><asp:Button ID="Submit" Text="Submit" runat="server" OnClick="Submit_Click" /></b> </td>
       </tr>
       </Table>
       <asp:HiddenField ID="H_Chk_1" runat="server" Value="Y" />
       <asp:HiddenField ID="H_Chk_2" runat="server" Value="Y" />
       <asp:HiddenField ID="H_Chk_3" runat="server" Value="Y" />
       <asp:HiddenField ID="H_Chk_4" runat="server" Value="Y" />
       <asp:HiddenField ID="H_Chk_5" runat="server" Value="Y" />
       <asp:HiddenField ID="H_Chk_6" runat="server" Value="Y" />
       <asp:HiddenField ID="AccountAccessBy" runat="server" Value="1,2,3,4,5,6" />
       <asp:HiddenField ID="AccountAccessIn" runat="server" Value="" />
   <%--<asp:TextBox ID="AccountAccessIn" runat="server" Text="1,2,3,4,5,6"></asp:TextBox>--%>
       </td>
        </tr>
        </table>
        </div>
</asp:Content>
