<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerMaster.aspx.cs" Inherits="GUI_admin_CustomerMaster_CustomerMaster" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript"> 
     function nwOpen(mNo)
        {
            window.open("popup-CUST.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
     function chkVal()
     {
     //debugger
        if(document.getElementById("ctl00$MyCPH1$ddCstGrp").value == "--Select--")
        {
            alert("Please select Customer Group");
            document.getElementById("ctl00$MyCPH1$ddCstGrp").focus();
            return false; 
        }
        if(document.getElementById("ctl00$MyCPH1$ddCst").value == "" || document.getElementById("ctl00$MyCPH1$ddCst").value == "--Select-")
        {
            alert("Please select Customer");
            document.getElementById("ctl00$MyCPH1$ddCst").focus();
            return false; 
        }
        
        return true;
     }
     function IsText(sText)
    {
       var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
       var IsText=true;
       var Char;

       for (i = 0; i < sText.length && IsText == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
            IsText = false;
          }
       }
       
       return IsText;
    }
     function chkCst()
     {
            if(document.getElementById("ctl00$MyCPH1$txtCstCd").value == "")
            {
                alert("Please select Customer Code");
                document.getElementById("ctl00$MyCPH1$txtCstCd").focus();
                return false; 
            }
            else if(IsText(document.getElementById("ctl00_MyCPH1_txtCstCd").value) == false)
            {
                alert("Enter proper Customer Code");
                document.getElementById("ctl00_MyCPH1_txtCstCd").focus();
                return false;
            }  
         return true;
     }
     function del()
     {
        alert("Sorry, deletion of customer is not allowed !!!")
     }
     
     
     


     
     
 </script>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%; height: 228px">
    	<tr> 
          <td style="height: 36px"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
		  
	        &gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>

            &gt; <a href=""><font class="blklnkund"><strong>Business Partners</strong></font></a>

		  <font class="bluefnt"><strong> &gt; 
		  Customer Master</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>

        <tr> 
          <td align="right" style="height: 51px"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
          <tr>
              <td align="right">
              </td>
          </tr>
          <tr>
              <td align="right">
              </td>
          </tr>
        
        <tr> 
          <td>
<!--START--> 
 <table border="0" cellpadding="3" width="35%" cellspacing="1" align="center" class="boxbg">
   <tr class="bgbluegrey"> 
      <td style="width: 54px"><font class="blackfnt">
                 <asp:CheckBox ID="chk" runat="server" EnableViewState="true"  BackColor="#D4E0E7" AutoPostBack="true" BorderColor="#D4E0E7" BorderStyle="None" BorderWidth="0px" ForeColor="#D4E0E7" Width="21px" />
              
       </td>
      <td><font class="blackfnt"><b>Active Customer</b></font></td>
     
    </tr>
 </table>
 <br />
  <table border="0" cellpadding="3" width="76%" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Quick Edit/Delete Customer</b></font></p>
      </td>
    </tr>
   <tr bgcolor="#FFFFFF"> 
            <td  align="center" width="40%" style="height: 30px"> 
              <div align="right"><font class="blackfnt">Enter Customer Code</font> 
                : </div>
            </td>
            <td bgcolor="#FFFFFF" align="left" style="height: 30px">
                <asp:TextBox ID="txtCstCd" runat="server" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label></td>
          </tr>
	<tr> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="22"><font class="blackfnt"><b>
            <asp:Button ID="btnQckEdit" runat="server" Text="Edit" OnClientClick="return chkCst()" OnClick="btnQckEdit_Click" />&nbsp;
            <asp:Button ID="btnQckDelete" runat="server" Text="Delete" OnClientClick="return del()" />
            <asp:Button ID="btnQckLstAll" runat="server" Text="ListAll" OnClick="btnQckLstAll_Click" /></b></font></td>
	</tr>
  </table>
  <br /><br />

  <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Select Customers for Edit/Delete</b></font></p>
      </td>
    </tr>
   <tr bgcolor="#FFFFFF"> 
            <td  align="center" width="40%"> 
              <div align="right"><font class="blackfnt">Select Customer Group</font> 
                : </div>
            </td>
            <td bgcolor="#FFFFFF" align="left">
                <asp:UpdatePanel ID="up1" runat="server">
                    <ContentTemplate> 
                        <asp:DropDownList ID="ddCstGrp" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddCstGrp_SelectedIndexChanged">
                        </asp:DropDownList>
                    </ContentTemplate> 
                    
                </asp:UpdatePanel>    
             </td>
          </tr>

    <tr bgcolor="#FFFFFF"> 
      <td  align="center" valign="top"> 
        <div align="right"><font class="blackfnt">Select Customer</font> 
          : </div>
      </td>
      <td bgcolor="#FFFFFF" align="left"> 
        <asp:UpdatePanel ID="up2" runat="server">
           <ContentTemplate>   
                <asp:DropDownList ID="ddCst" runat="server">
                </asp:DropDownList>
           </ContentTemplate>
           <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddCstGrp" EventName="SelectedIndexChanged" />
           </Triggers>
         </asp:UpdatePanel>        
      </td>
    </tr>
	<tr> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
          <%--<asp:UpdatePanel ID="upAdd" runat="server">
           <ContentTemplate>--%> 
            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClientClick="return chkVal()" OnClick="btnAdd_Click" />
            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClientClick="return chkVal()" OnClick="btnEdit_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClientClick="return del()" />
            <asp:Button ID="btnListing" runat="server" OnClick="btnListing_Click" Text="Listing" /><%--</ContentTemplate>
            <Triggers>
              <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
              <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
              <asp:AsyncPostBackTrigger ControlID="btnDelete" EventName="Click" />
            </Triggers>
          </asp:UpdatePanel>--%></td>
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
            </table><%--</td>
        </tr>
      </table>
    </td>
  </tr>
</table>  --%>
</asp:Content>

