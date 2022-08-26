<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HierarchyListing.aspx.cs" Inherits="GUI_admin_HierarchyMaster_HierarchyListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <div>
        <%--<table width="80%" border="0" cellpadding="2" cellspacing="1" align="center" class="boxbg">
		 
    
	
	 <tr bgcolor="#FFFFFF"> 
		
		 <td colspan="3"><font class="blackfnt">&nbsp;</td>
		  <td colspan="3" ><font class="blackfnt"></td>
	    <td  align="left" ><font class="blackfnt"></font></td>
	  </tr>
	 
		 <tr class="bgbluegrey">
		    <td width="3%" align="center"></td>
			<td width="3%" align="center"><font class="blackfnt"><b>Level</b></font></TD>
			<td width="20%" nowrap><font class="blackfnt"><b>Location Type</b></font></TD>
			<td width="3%" nowrap><font class="blackfnt"><b>Edit</b></font></TD>
		 </tr>
			
	  <tr >
		<td valign="top" align="center" width="3%"></td>
		<td valign="top" align="center" width="3%"><font class="blackfnt"></font></td>
		<td valign="top"><font class="blackfnt"></font></td>
		<td valign="top" width="3%"><font class="blackfnt">Edit</font></td>
	 </tr>	
	 
	   
	
	 
	 <tr bgcolor="#FFFFFF"> 
	    
		 <td colspan="3"><font class="blackfnt">&nbsp;</td>
		     
		  <td colspan="3" ><font class="blackfnt"></font></td>
		
		<td  align="left"><font class="blackfnt"></font></td>
	 </tr>	
	 
	  </table>--%>
	  
	  <br />
	  <div align="center">
	  <asp:GridView ID="HierarchyList" runat="server" AllowPaging="True" AllowSorting="True" OnSorting="GridView1_Sorting"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" DataKeyNames="Level_No" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric"
                            PagerStyle-HorizontalAlign="left" PageSize="50" OnPageIndexChanging="pgChange" OnRowCommand="dg_RowCommand" Width="50%">
                            
                            <Columns>
                                
                                <asp:BoundField DataField="Level_No" HeaderText="Level No" />
                                <asp:BoundField DataField="Level_Type" HeaderText="Level Type">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:HyperLinkField DataNavigateUrlFields="Level_No" DataNavigateUrlFormatString="~/admin/taxdet.aspx?id={0}"
                                    DataTextField="Level_No" DataTextFormatString="--Edit--">
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                                
                                <asp:TemplateField><ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                    Text="--Delete--" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                </asp:LinkButton>
                                 </ItemTemplate></asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        </div>
    </div>
    </asp:Content>
