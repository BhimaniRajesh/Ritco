<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProspectStatus3.aspx.cs" Inherits="REPORT_ProspectStatus3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="server">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Status Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
        
        
				<table border="0" cellpadding="3"cols="2" width="55%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
					
						<tr bgcolor="#ffffff">
							<td  align="left" width="45%">
								<font class="blackfnt"><b>Location</b></font>
							</td>
							<td  align="left">
								<font class="blackfnt">
                                    <asp:Label ID="lblLocation" runat="server" Text="Label"></asp:Label></font></td>
						</tr>
							
						
							<tr bgcolor="#ffffff">
								<td  align="left" width="45%">
									<font class="blackfnt"><b>Prospect Type</b></font>
								</td>
								<td  align="left">
									<font class="blackfnt">
                                        <asp:Label ID="lblProspectType" runat="server" Text="Label"></asp:Label></font></td>
							</tr>
						
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Prospects</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblProspect" runat="server" Text="Label"></asp:Label></font></td>
					</tr>				

					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Value</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblValue" runat="server" Text="Label"></asp:Label></font></td>
					</tr>				
					
					
					<%--<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Calls made</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label></font></td>
					</tr>		--%>				
					
					
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
                                                                
                                                                <asp:BoundField DataField="ProspectCode" HeaderText="Prospect Code" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="true"/>
                                                                <asp:BoundField DataField="CallMade" HeaderText="Call" ItemStyle-HorizontalAlign="Left"/>
                                                                <asp:BoundField DataField="OrderValue" HeaderText="Order Value" ItemStyle-HorizontalAlign="Center"/>
                                                                <asp:BoundField DataField="Empcd" HeaderText="Sales Person" ItemStyle-HorizontalAlign="Left"/>
                                                                
                                                                </Columns>
                                                                
    </asp:GridView>
   <br />
   </div>

</asp:Content>
