<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VendorMasterEdit.aspx.cs" Inherits="GUI_admin_Vendor_VendorMasterEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript"> 
     function nwOpen(mNo)
        {
            window.open("popup-Vendor.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
     function chkVal()
     {
     //debugger
        if(document.getElementById("ctl00$MyCPH1$ddVendorType").value == "--Select--")
                {
                    alert("Please select Customer Group");
                    document.getElementById("ctl00$MyCPH1$ddVendorType").focus();
                    return false; 
                }
                return true;
     }
     function chkCst()
     {
        if(document.getElementById("ctl00$MyCPH1$txtVendorCd").value == "")
           {
               alert("Please select Customer Code");
               document.getElementById("ctl00$MyCPH1$txtVendorCd").focus();
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
 <br />
  <table border="0" cellpadding="3" width="76%" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Quick Edit/Delete Vendor</b></font></p>
      </td>
    </tr>
   <tr bgcolor="#FFFFFF"> 
            <td  align="center" width="40%" style="height: 30px"> 
              <div align="right"><font class="blackfnt">Enter Vendor Code</font> 
                : </div>
            </td>
            <td bgcolor="#FFFFFF" align="left" style="height: 30px">
                <asp:TextBox ID="txtVendorCd" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label></td>
          </tr>
	<tr> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="22"><font class="blackfnt"><b><asp:Button ID="btnQckAdd" runat="server" Text="Add" OnClientClick="return chkVal()" OnClick="btnQckAdd_Click" />
            <asp:Button ID="btnQckEdit" runat="server" Text="Edit" OnClientClick="return chkCst()" OnClick="btnQckEdit_Click" />&nbsp;
            <asp:Button ID="btnQckDelete" runat="server" Text="Delete" OnClientClick="return del()" />
            <asp:Button ID="btnQckLstAll" runat="server" Text="ListAll" OnClick="btnQckLstAll_Click" /></b></font></td>
	</tr>
  </table>
  <br /><br />

  <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Select Vendor for Edit/Delete</b></font></p>
      </td>
    </tr>
   <tr bgcolor="#FFFFFF"> 
            <td  align="center" width="40%"> 
              <div align="right"><font class="blackfnt">Select Vendor Type</font> : </div>
            </td>
            <td bgcolor="#FFFFFF" align="left">
                <asp:UpdatePanel ID="up1" runat="server">
                    <ContentTemplate> 
                        <asp:DropDownList ID="ddVendorType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddVendorType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </ContentTemplate> 
                    
                </asp:UpdatePanel>    
             </td>
          </tr>

    <tr bgcolor="#FFFFFF"> 
      <td  align="center" valign="top"> 
        <div align="right"><font class="blackfnt">Select Vendor</font> 
          : </div>
      </td>
      <td bgcolor="#FFFFFF" align="left"> 
        <asp:UpdatePanel ID="up2" runat="server">
           <ContentTemplate>   
                <asp:DropDownList ID="ddVendor" runat="server">
                </asp:DropDownList>
           </ContentTemplate>
           <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ddVendorType" EventName="SelectedIndexChanged" />
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
            </table>
</asp:Content>

