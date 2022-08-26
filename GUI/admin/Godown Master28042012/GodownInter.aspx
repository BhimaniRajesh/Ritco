<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GodownInter.aspx.cs" Inherits="GUI_admin_Godown_Master_GodownInter" %>

<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table border=0 cellpadding=3 width="76%" bgcolor="#808080" cellspacing="1" align="center" class=boxbg>
						  <tr class="bgbluegrey"> 
						    <td  align="center" colspan="2"> 
						      <p align="center"><font class="blackfnt"><b>Select Godown for Edit/Inactivation</b></font></p>
						    </td>
						  </tr>
							<tr bgcolor="#ffffff"> 
						          <td  align="center" width="40%"> 
						            <div align="right"><font class="blackfnt">Select Hierarchy</font> 
						              : </div>
						          </td>
						          <td bgcolor="#ffffff" align="left"> 
						            <asp:UpdatePanel ID="upRptLoc" runat="server">
   	                                <ContentTemplate>
   	                                <asp:DropDownList ID="cboHierarchy" runat="server" Width="175px" TabIndex="3">
                                    </asp:DropDownList>                 
   	                                 </ContentTemplate>
   	                                 </asp:UpdatePanel>
						          </td>
						        </tr>


								<tr bgcolor="#ffffff"> 
								  <td  align="center" valign="top"> 
								    <div align="right"><font class=blackfnt>Select Location</font> 
								      : </div>
								  </td>
								  <td bgcolor="#ffffff"> 
						  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
   	                                <ContentTemplate>
   	                                <asp:DropDownList ID="DropDownList1" runat="server" Width="175px" TabIndex="3">
                                    </asp:DropDownList>                 
   	                                 </ContentTemplate>
   	                                     <Triggers>
                                         <asp:AsyncPostBackTrigger ControlID="cboHierarchy" EventName="SelectedIndexChanged" />
                                         </Triggers>
   	                                 </asp:UpdatePanel>
								   		
								  </td>
								</tr>

								<tr bgcolor="#ffffff">
									<td colspan="2" align="center"><font class="blackfnt"><b>OR</b></font></td>
								</tr>
						  
								<tr bgcolor="#ffffff">
									<td align="right">
									    <font class=blackfnt>Enter Godown Location Code</font> 
									</td>
									<td align="left">
									    <asp:TextBox ID="txtLocCode" runat="server" Width="38px"></asp:TextBox>&nbsp;
									    <input type="button" runat="server" style="width: 25px"/>
									</td>    
								</tr>
						  
								<tr> 
									<td bgcolor="#ffffff" align="center" colspan="2" height="22">
									<asp:Button ID="btnAdd" runat="server" Text="Add" />&nbsp;
									<asp:Button ID="btnEdit" runat="server" Text="Edit" />&nbsp;
									<asp:Button ID="btnDelete" runat="server" Text="Delete" />&nbsp;
									<asp:Button ID="btnListing" runat="server" Text="Listing" />
									</td>
								</tr>
						</table>

</asp:Content>
