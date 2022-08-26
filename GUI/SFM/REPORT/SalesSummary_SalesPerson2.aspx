<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SalesSummary_SalesPerson2.aspx.cs" Inherits="REPORT_SalesSummary_SalesPerson2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="VisitSummary-SalesPerson Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
						<td  align="left" width="36"%>
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblDate" runat="server" Text="Label"></asp:Label></font></td>

					</tr>
				</table>		
        
        <br />
        
        <asp:GridView ID="dgCallsummaryPerson" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false"
                            CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="100%" OnRowDataBound="dgCallsummaryPerson_RowDataBound">
                            <Columns>
                                <%--<asp:BoundField DataField="entryby" HeaderText="Sales Person" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:TemplateField HeaderText="Sales Person">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <asp:Label id ="lblsalesperson" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"entryby") %>'></asp:Label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="VISIT">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+"VISIT"+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "VISIT")%>'  ID="Hyperlink3"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                 
                                 
                                 <asp:TemplateField HeaderText="PHONE">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+"PHONE"+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "Phone")%>'  ID="Hyperlink4"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                               
                               <%-- <asp:BoundField DataField="PHONE" HeaderText="Phone" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:TemplateField HeaderText="CHAT">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+"CHAT"+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "CHAT")%>'  ID="Hyperlink5"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                
                                <%--<asp:BoundField DataField="CHAT" HeaderText="Mail" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:TemplateField HeaderText="SMS">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+"SMS"+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "SMS")%>'  ID="Hyperlink6"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                <%--<asp:BoundField DataField="SMS" HeaderText="Chat" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:TemplateField HeaderText="EMAIL">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+"E-MAIL"+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "EMAIL")%>'  ID="Hyperlink7"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                 
                                 
                                <%--<asp:BoundField DataField="EMAIL" HeaderText="SMS" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>--%>
                                    
                                    <asp:TemplateField HeaderText="ALLTYPE">
                                         <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="120" />
                                         <ItemStyle CssClass="blackfnt" />
                                         <ItemTemplate>
                                         <label class="blackfnt">
                                         <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"SalesSummary_SalesPerson3.aspx?callType="+""+"&entryby=" +DataBinder.Eval(Container.DataItem, "entryby") + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "ALLTYPE")%>'  ID="Hyperlink8"/>
                                         </label>
                                         </ItemTemplate>
                                 </asp:TemplateField>
                                 
                                 
                                    <%--<asp:BoundField DataField="ALLTYPE" HeaderText="All" HeaderStyle-CssClass ="bgbluegrey" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
        
        </asp:Content>
