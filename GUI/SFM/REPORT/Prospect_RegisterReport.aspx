<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Prospect_RegisterReport.aspx.cs" Inherits="REPORT_Prospect_RegisterReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Prospect Register Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
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
<br />

    <div align="center">
            <table border="0" cellpadding="3"  colspan="1" width="80%" bgcolor="808080" cellspacing="1" class="boxbg">
								<tr class="bgbluegrey">
									<td  align="center" colspan="2">
										<font class="blackfnt">Select Report Criteria </font>
									</td>
								</tr>
								
								<tr bgcolor="#FFFFFF"> 
								  <td  align="left" > 
								    <div align="left"><font class="blackfnt">Select Industry</font> 
								      : </div>
								  </td>
								  <td bgcolor="#FFFFFF" align="left">
								  <asp:DropDownList ID="industryCode" runat="server" Height="56px" Style="left: 0px; position: relative; top: 0px" Width="136px">
								  
                                  </asp:DropDownList> 
								  </td>
								</tr>


								
								
								
								<tr bgcolor="#FFFFFF"> 
								  <td  align="left" > 
								    <div align="left"><font class="blackfnt">Select RO</font> 
								      : </div>
								  </td>
								  <td bgcolor="#FFFFFF" align="left">
								  <asp:UpdatePanel ID="updatepanel2" runat="server">
                                                                <ContentTemplate>
                                                                    <asp:DropDownList ID="cboSelectRo" runat="server" AutoPostBack="true" Mode="Conditional"
                                                                         OnSelectedIndexChanged="cboSelectRo_SelectedIndexChanged">
                                                                    </asp:DropDownList>
                                                                </ContentTemplate>
                                                                
                                                            </asp:UpdatePanel> 
															  
								  </td>
								</tr>
							    		    
								<tr bgcolor="#FFFFFF"> 
								  <td  align="left" > 
								    <div align="left"><font class="blackfnt">Select Location</font> 
								      : </div>
								  </td>
								  <td bgcolor="#FFFFFF" align="left" > 
									<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cboSelectLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboSelectLocation_SelectedIndexChanged">
                                                                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectRo" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
								  </td>
								</tr>
								

								<tr bgcolor="#FFFFFF"> 
								  <td  align="left" > 
								    <div align="left"><font class="blackfnt">Select Employee</font> 
								      : </div>
								  </td>
								  <td bgcolor="#FFFFFF" align="left" >
									<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server">
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="cboSelectLocation" EventName="SelectedIndexChanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
								  </td>
								</tr>

								<%--<tr class="bgbluegrey">
									<td  align="center" colspan="2">
									<font class="blackfnt">OR </font>
									</td>
								</tr>
			
								<tr bgcolor="#FFFFFF">	
								    <td align="left"><font class="blackfnt">Enter Employee Code</font></td>
									<td valign="top" align="left">
										<asp:TextBox ID="txtEmp" runat="server" Width="60px"></asp:TextBox>
										<input id="btnCust" type="button" name="" runat="server"/>
									</td>
								 </tr>	--%>

							</table>
							<br />
							<table  border="0" cellpadding="3" cellspacing="1" width="71%">
                                                    <tr >
                                                        <td align ="center" colspan="3">
                                                        <asp:Button ID="btnShowReport" runat="server" Text="Show Report" Width="96px" OnClick="btnShowReport_Click" /></td>
                                                    </tr>
                                                    </table>
                                                    
                                                   <%-- <asp:UpdatePanel ID="u1"   UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                   <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"
                        <asp:GridView ID="dgPropsect" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="122px">
                            <Columns>
                                
                                    
                               <asp:BoundField DataField="Empcd" HeaderText="Sales Person" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="HotKount" HeaderText="Hot Prospect" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="HotWalue" HeaderText="Hot Value" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="WarmKount" HeaderText="Warm Prospect" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="WarmWalue" HeaderText="Warm Value" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ColdKount" HeaderText="Cold Prospect" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ColdWalue" HeaderText="Cold Value" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AllKount" HeaderText="All Prospect" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AllWalue" HeaderText="All Value" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                       
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowReport" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>--%>
                
                <%--------------------------  Change 27 July 2007 -----------------------%>
                
                <%--<asp:UpdatePanel ID="u1"   UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        
                         
                  <asp:DataGrid ID="dgProspectRegister" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle"
                                BorderColor="#8ba0e5" AllowPaging="true" CssClass="blackfnt"  AlternatingItemStyle-BorderColor="ActiveBorder" >
                                
                  </asp:DataGrid>--%>
                       
                       <%-- <asp:Button ID="btnPrint" runat="server" Text="Print"  Visible="false" style="left: 227px; position: relative; top: 0px"  Width="75px" />
                        <asp:Button ID="btnXLS" runat="server" Text="XLS" Visible="false" style="left: 225px; position: relative; top: 0px"  Width="75px" OnClick="btnXLS_Click" />
                       --%>
                   <%-- </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowReport" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>--%>
   </asp:Content>
