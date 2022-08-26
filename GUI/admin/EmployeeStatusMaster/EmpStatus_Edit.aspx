<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EmpStatus_Edit.aspx.cs" Inherits="GUI_admin_EmployeeStatusMaster_EmpStatus_Edit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr> 
						<td height="30">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Employee Status Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
					</tr>

					<tr> 
						<td align="right" style="height: 33px">
							<a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>
			   </table>
	      </td>      
	   </tr> 
 </table> 

<table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Select Employee Status for Edit/Inactivation</b></font></p>
      </td>
    </tr>

   <tr bgcolor="#FFFFFF"> 
      <td  align="right"  valign="middle"  style="width: 274px; height: 37px;"> 
        <font class="blackfnt">Select Employee Status :</font>          
      </td>
      <td align="left"  valign="middle"  style="width: 274px; height: 37px;">
            <asp:DropDownList ID="ddEmpSt" runat="server">
            </asp:DropDownList>
      </td>
    </tr>
        
	<tr bgcolor="#FFFFFF"> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" style="height: 32px">
		    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
            <asp:Button ID="btnInactivate" runat="server" Text="Inactivate" OnClick="btnInactivate_Click" />
            <asp:Button ID="btnListing" runat="server" Text="Listing" OnClick="btnListing_Click" /></td>
	</tr>
  </table>
</asp:Content>

