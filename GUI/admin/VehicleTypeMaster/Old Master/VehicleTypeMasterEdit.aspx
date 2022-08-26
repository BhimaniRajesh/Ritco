<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VehicleTypeMasterEdit.aspx.cs" Inherits="GUI_admin_VehicleTypeMaster_VehicleTypeMasterEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

 

</script>   
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30">
            <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href="../operations.aspx"><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Vehicle Type Master</b></font>
            </td>
						</tr>
						<tr> 
						  <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
						</tr>
						<tr> 
							  <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
							</tr>

        					<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>
							 <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 

                          <table border="0" cellpadding="5" width="65%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
                            <tr class="bgbluegrey"> 
                              <td  align="center" colspan="5"> 
                                <p align="center"><font class="blackfnt"><b>Select Vehicle Type for Edit</b></font></p>
                              </td>
                            </tr>
	                        <tr> 
		                        <td height="25" bgcolor="#FFFFFF"> 
		                        <table border="0" align="center" cellspacing="0" cellpadding="0">
			                        <tr> 
			                        <td class="bullet"><img src="../../images/clear.gif" width="4" height="4" alt="" /></td>
			                        </tr>
		                        </table></td>
	                        <td bgcolor="#ffffff" colspan="4" ><font class="blackfnt"><a href="../VehicleTypeMaster/Listing.aspx"><u>Click here to list all records</u></a> </font></td>
	                        </tr>    
	                        <tr> 
		                        <td height="25" bgcolor="#FFFFFF"> 
		                        <table border="0" align="center" cellspacing="0" cellpadding="0">
			                        <tr> 
			                        <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"></td>
			                        </tr>
		                        </table></td>
                                <td bgcolor="#FFFFFF" width="35%"><font class="blackfnt">Select Vehicle Type</font></td>
		                        <td bgcolor="#FFFFFF" align="center" width="35%"> 
                                <div align="center"> 
                                    <asp:DropDownList ID="ddVehicleType" runat="server">
                                    </asp:DropDownList></div>
                              </td>
                           
	                        <!--<tr> -->
		                        <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                                    <asp:Button ID="btnEdit" runat="server" OnClick="btnEdit_Click" Text="Edit" /></td>
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

