<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AppointmentSchedule2.aspx.cs" Inherits="REPORT_AppointmentSchedule2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "pros_reg_detail.aspx?prospectcode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
</script>


<div align="center">
    
    
<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
            <div align="left">
            <table border="0" cellpadding="3"  cols="2" width="35%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
					<tr bgcolor="#ffffff">
						<td  align="left" width="36"%>
							<font class="blackfnt"><b>Region</b></font>
						</td>
						<td width="64%"  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblRegion" runat="server" Text="Label"></asp:Label></font></td>
					</tr>
					
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="36%">
							<font class="blackfnt"><b>Location</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblLocation" runat="server" Text="Label"></asp:Label></font></td>

					</tr>
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="36%">
							<font class="blackfnt"><b>Employee</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblEmployee" runat="server" Text="Label"></asp:Label></font></td>

					</tr>
					
					
					<tr bgcolor="#ffffff">
						<td  align="left" width="36"%>
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>

					</tr>
				</table>		
        </div>
        <br />
            
            
            <asp:GridView ID="dgAppointment" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false"
                            CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="100%">
                            <Columns>
                                
                                <asp:TemplateField HeaderText="SRNo." >
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                                </ItemTemplate>
                                </asp:TemplateField>   
                                
                                <asp:BoundField DataField="AppointmentDt" HeaderText="Appointment Date" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                              
                              
                              <asp:BoundField DataField="AppTime" HeaderText="Time" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                                                
                                <asp:TemplateField HeaderText="ProspectCode">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                                     <ItemStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="left" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "Prospect")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:BoundField DataField="status" HeaderText="Prospect Status" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                    <asp:BoundField DataField="PersonToMet" HeaderText="Person to be Met" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Department" HeaderText="Department" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Designation" HeaderText="Designation" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Purpose" HeaderText="Purpose Of Visit" HeaderStyle-CssClass ="bgbluegrey" ItemStyle-HorizontalAlign="Left"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Remarks" HeaderText="Remarks" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                
                                <%--<asp:BoundField DataField="AppTime" HeaderText="CallCode" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="callDt" HeaderText="CallDate" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CallTime" HeaderText="CallTime" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                    
                                <asp:BoundField DataField="PersonCalled" HeaderText="PersonCalled" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:TemplateField HeaderText="ProspectId">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                                     <ItemStyle CssClass="blackfnt" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "prospectcode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "prospectcode")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                
                                <%--<asp:BoundField DataField="prospectcode" HeaderText="ProspectId" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="callduration" HeaderText="Duration in Min" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="discPoint" HeaderText="DiscPoint" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AcctCategory" HeaderText="AccCategory" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
            </div>
            </asp:Content>
