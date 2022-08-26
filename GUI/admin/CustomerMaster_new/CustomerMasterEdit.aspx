<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerMasterEdit.aspx.cs" Inherits="GUI_admin_CustomerMaster_CustomerMasterEdit" Title="Untitled Page"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
      function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
      function IsNumericDot(sText)
        {
           var ValidChars = "0123456789.";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        }
       function IsNumericWoDot(sText)
        {
           var ValidChars = "0123456789";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        } 
    
        function ValidateData()
        {  
       
        if(document.getElementById("ctl00$MyCPH1$txtCstPwd"))
            {
                if(document.getElementById("ctl00$MyCPH1$txtCstPwd").value == "")
                {
                    alert("Enter Password");
                    document.getElementById("ctl00$MyCPH1$txtCstPwd").focus();
                    return false;
                }
            } 
            
          if(document.getElementById("ctl00_MyCPH1_txtCstNm"))
            {
                if(document.getElementById("ctl00_MyCPH1_txtCstNm").value == "")
                {
                    alert("Enter Customer Name");
                    document.getElementById("ctl00_MyCPH1_txtCstNm").focus();
                    return false;
                }
            } 
           if(document.getElementById("ctl00_MyCPH1_ddCstCat"))
            {
                if(document.getElementById("ctl00_MyCPH1_ddCstCat").value == "")
                {
                    alert("Enter Customer Category");
                    document.getElementById("ctl00_MyCPH1_ddCstCat").focus();
                    return false;
                }
            }  
            
          if(document.getElementById("ctl00_MyCPH1_txtOpnDbt"))
            {
                if(IsNumericDot(document.getElementById("ctl00_MyCPH1_txtOpnDbt").value) == false)
                {
                    alert("Enter Open Debit in Postive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtOpnDbt").focus();
                    return false;
                }
            }
          if(document.getElementById("ctl00_MyCPH1_txtOpnCrdt"))
            {
                if(IsNumericDot(document.getElementById("ctl00_MyCPH1_txtOpnCrdt").value) == false)
                {
                    alert("Enter Open Credit in Postive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtOpnCrdt").focus();
                    return false;
                }
            }
          if(document.getElementById("ctl00_MyCPH1_txtMblNo"))
            {
                if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtMblNo").value) == false)
                {
                    alert("Enter Mobile Number in Postive Numeric Format");
                    document.getElementById("ctl00_MyCPH1_txtMblNo").focus();
                    return false;
                }
            }
            
            return true;
           
       }             
        

</script>  
        
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
    	<tr> 
          <td height="30"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
		  
	&gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>

&gt; <a href=""><font class="blklnkund"><strong>Business Partners</strong></font></a>

		  <font class="bluefnt"><strong> &gt; 
		  Customer Master</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>

<!--         <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr> -->
        
        <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
<table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>CUSTOMER MASTER SCREEN</b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table border="0" cellspacing="0" cellpadding="3" width="100%" >
                                  <tr> 
                                    <td><font class="blackfnt">Group Code</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td><font class="blackfnt">
                                        <asp:Label ID="lblGrpCd" runat="server"></asp:Label></font></td>
                                    <%--<td></td>--%>
                                    <td><font class="blackfnt"></font> 
                                    </td>
                                   <%--</tr>--%>  
                                    <td valign="top"><font class="blackfnt">Customer 
                                      Code</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td>
                                        <asp:Label ID="lblCst" runat="server" ForeColor="#FF8080" CssClass="blackfnt"></asp:Label></td>
                                    <td><font class="blackfnt" color="red"></font> 
                                    </td>
                                   </tr> 
                                   <tr> 
                                    <td><font class="blackfnt">Customer Name</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td>
                                        <asp:TextBox ID="txtCstNm" runat="server" CssClass="input" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox></td>
                                    <%--<td></td>--%>
                                    <td><font class="blackfnt"></font></td>
                                    <td><font class="blackfnt">Customer Password</font></td>
                                    <td>
                                        :</td>
                                    <td> &nbsp;
                                    <asp:TextBox ID="txtCstPwd" TextMode="Password" runat="server" MaxLength="10"></asp:TextBox>
                                        <%--<input type="password" id="txtCstPwd" runat="server" />--%></td>
                                  </tr>
                                  <tr> 
                                    <td><font class="blackfnt">Customer Category</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td> 
                                        <asp:DropDownList ID="ddCstCat" runat="server" CssClass="input">
                                            <asp:ListItem>--Select--</asp:ListItem>
                                            <asp:ListItem>TBB</asp:ListItem>
                                            <asp:ListItem>BOD</asp:ListItem>
                                            <asp:ListItem>TRIAL TBB</asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td></td>
                                    <td><font class="blackfnt">Active Flag</font></td>
                                    <td>
                                        :</td>
                                    <td>
                                        <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                            <ContentTemplate>
                                                <asp:CheckBox ID="c1" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="c1_CheckedChanged"
                                                    Width="10px" />
                                                <asp:TextBox ID="txtActFlag" Enabled="false" runat="server" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();">Y</asp:TextBox>&nbsp;
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="c1" EventName="CheckedChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td><font class="blackfnt">Mobile Service</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:CheckBox ID="c2" runat="server" AutoPostBack="True" OnCheckedChanged="c2_CheckedChanged"
                                                    Width="19px" />
                                                <asp:TextBox ID="txtMblSer" runat="server" Enabled="false" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();">N</asp:TextBox>&nbsp;
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="c2" EventName="CheckedChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td></td>
                                    <td><font class="blackfnt">Mobile Number</font></td>
                                    <td>
                                        :</td>
                                    <td>
                                        <asp:TextBox ID="txtMblNo" MaxLength="10" runat="server"></asp:TextBox></td>
                                  </tr>
                                  <tr> 
                                    <td><font class="blackfnt">ST Number</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td>
                                        <asp:TextBox ID="txtStNo" runat="server"></asp:TextBox></td>
                                    <td></td>
                                    <td><font class="blackfnt">CST Number</font></td>
                                    <td>
                                        :</td>
                                    <td>
                                        <asp:TextBox ID="txtCstNo" runat="server"></asp:TextBox></td>
                                  </tr>
                                  <tr> 
                                    <td><font class="blackfnt">Open Debit</font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td>
                                        <asp:TextBox ID="txtOpnDbt" runat="server"></asp:TextBox></td>
                                    <td></td>
                                    <td><font class="blackfnt">Open Credit</font></td>
                                    <td>
                                        :</td>
                                    <td>
                                        <asp:TextBox ID="txtOpnCrdt" runat="server"></asp:TextBox></td>
                                  </tr>
                                  <tr>
                                    <td><font class="blackfnt">Customer Locations 
                                      <font size="1">(Separated by commas)</font></font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td colspan="4">
                                        <asp:TextBox ID="txtCstLoc" runat="server" Width="381px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox></td>
                                  </tr>
                                  <tr> 
                                    <td><font class="blackfnt">Customer Address 
                                      </font></td>
                                    <td><font class="blackfnt">:</font></td>
                                    <td colspan="4">
                                        <asp:TextBox ID="txtCstAddress" runat="server" Height="43px" TextMode="MultiLine"
                                            Width="222px"></asp:TextBox></td>
                                  </tr>
                                </table>
</td>
</tr>
</table>

<br />
<table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
<tr align="center" bgcolor="#FFFFFF">
<td colspan="5">
<table border="0" cellspacing="2" cellpadding="4">
<tr>
<td>
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" /></td>
<td>
    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
</td>
<td>
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" /></td>
</tr>


</table>
</td>
</tr>
</table>


<br />

<table align="center" border="0" cellpadding="0" cellspacing="1" width="100%" class="boxbg">
<tr bgcolor="#FFFFFF">
<td colspan="8" style="height: 93px">
</td>
</tr>
</table>
   					  <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>  
</asp:Content>

