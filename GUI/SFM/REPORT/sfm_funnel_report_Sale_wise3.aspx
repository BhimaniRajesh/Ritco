<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="sfm_funnel_report_Sale_wise3.aspx.cs" Inherits="REPORT_sfm_funnel_report_Sale_wise3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="server">


<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-Sales Person Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
        
        <div align="left">
        
        
				<%--<table botder="0" cellpadding="3"cols="2" width="55%" bgcolor="#FFFFFF" cellspacing="1" class="boxbg">
					
						<tr bgcolor="#FFFFFF">
							<td  align="left" width="45%">
								<font class="blackfnt"><b>Location</b></font>
							</td>
							<td  align="left">
								<font class="blackfnt"></font>
							</td>
						</tr>
							
						
							<tr bgcolor="#FFFFFF">
								<td  align="left" width="45%">
									<font class="blackfnt"><b>Prospect Type</b></font>
								</td>
								<td  align="left">
									<font class="blackfnt"></font>
								</td>
							</tr>
						
					
					<tr bgcolor="#FFFFFF">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Prospects</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"></font>
						</td>
					</tr>				

					<tr bgcolor="#FFFFFF">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Value</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"></font>
						</td>
					</tr>				


					<tr bgcolor="#FFFFFF">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>ProspectID</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"></font>
						</td>
					</tr>						
					
					
					<tr bgcolor="#FFFFFF">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Calls made</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"></font>
						</td>
					</tr>						
					
					
					<tr bgcolor="#FFFFFF">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Sales person</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"></font>
						</td>
					</tr>						
					
					
					<tr bgcolor="#FFFFFF">
						<td  align="left" width="36%">
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
								
							</font>
						</td>

					</tr>
					</table>--%>
					
					
					<table botder="0" cellpadding="3"cols="2" width="55%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
					
						
							
						
					
						

								


					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>ProspectID</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblProspectId" runat="server" Text="Label"></asp:Label></font></td>
					</tr>						
					
					
					
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Sales person</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblSalesPerson" runat="server" Text="Label"></asp:Label></font></td>
					</tr>						
					
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="36%">
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>

					</tr>
					</table>
					</div>
					<br />
					
					<div align="center">
					<asp:GridView ID="GridView1" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="blackfnt" BackColor="white" FooterStyle-CssClass="boxbg"   
                                                             AllowPaging="true" PageSize="25"  Width="100%"
                                                       
                                                            OnPageIndexChanging="pgChange" AllowSorting="False"  RowStyle-HorizontalAlign="Right"
                                                            AutoGenerateColumns="false" 
                                                              
                                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom" />
                                                                <Columns>
                                                                
                                                                <asp:TemplateField HeaderText="SRNo."  HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                <ItemStyle CssClass="blackfnt" />
                                                                <ItemTemplate>
                                                                <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                                                </asp:Label>
                                                                </ItemTemplate>
                                                                </asp:TemplateField>
                                                                
                                                                <asp:BoundField DataField="callcode" HeaderText="Call Id" ItemStyle-HorizontalAlign="Left"/>
                                                                <asp:BoundField DataField="calldt" HeaderText="Date" ItemStyle-HorizontalAlign="Left"/>
                                                                <asp:BoundField DataField="calltime" HeaderText="Time" ItemStyle-HorizontalAlign="Center"/>
                                                                <asp:BoundField DataField="personcalled" HeaderText="Person Met" ItemStyle-HorizontalAlign="Left"/>
                                                                <asp:BoundField DataField="callduration" HeaderText="Duration in Min." ItemStyle-HorizontalAlign="Center"/>
                                                                <asp:BoundField DataField="discpoint" HeaderText="Discussion" ItemStyle-HorizontalAlign="Left"/>
                                                                <asp:BoundField DataField="acctcategory" HeaderText="Status" ItemStyle-HorizontalAlign="Left"/>
                                                                
                                                                </Columns>
                                                                
    </asp:GridView>
   <br />
        
        </div>


</asp:Content>
