<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommunicationExpenseBillEntry.aspx.cs" Inherits="CommunicationExpenseBill_Entry" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Communication Expenses Bill Entry</title>
    <link href="Images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <atlas:ScriptManager ID="ScriptManager1" runat="server" />
    <div>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" style="height: 130px">
				<tr>
					<td style="height: 135px; width: 853px;"><!--background="images/top_bg.gif"-->
						<table cellspacing="0" cellpadding="0" width="778" border="0">
							<tbody>
								<tr>
									<td style="height: 49px"><!--<img src="images/toplogo.gif" width="121" height="40">-->
										<table cellspacing="0" cellpadding="0" border="0">
											<tr>
												<td valign="top" align="left" style="width: 29px"><img alt="" src="./images/LOGO.gif" border="0" /></td>
												<td valign="top" align="left"><img height="19" alt="" src="../include/images/blank_top.gif" width="0" border="0" /></td>
												
											</tr>
										</table>
									</td>
									<td style="height: 49px; width: 209px;">&nbsp;</td>
									<td align="right" style="height: 49px; width: 189px;">
                                        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="False" NavigateUrl="" style="left: -14px; position: relative; top: 0px">Home</asp:HyperLink>
                                        
                                        <asp:HyperLink ID="HyperLink2" runat="server" Font-Bold="False" style="left: -14px; position: relative; top: 0px">| Help</asp:HyperLink>
                                        
                                        <asp:HyperLink ID="HyperLink7" runat="server" Font-Bold="False" NavigateUrl="" style="left: -14px; position: relative; top: 0px">| Profile |</asp:HyperLink>&nbsp;<asp:HyperLink
                                            ID="HyperLink3" runat="server" Font-Bold="False" NavigateUrl=""
                                            Style="left: -14px; position: relative; top: 0px">Logout</asp:HyperLink></td>
						</tr>
				<tr>
					<td valign="top" width="343" background="./Image1/topband1.jpg" style="height: 39px">
						<table cellspacing="0" cellpadding="0" width="100%" border="0" >
							<tr>
								<td><img height="7" alt="" src="../include/images/clear.gif" width="10" /></td>
							</tr>
							<tr>
								<td background="../include/images/band_strip.gif" style="height: 14px"><font class="bandstrip"><em>&nbsp;&nbsp;<strong>Telecomm Expenses Module- 
                                    Head Office</strong></em></font></td>
							</tr>
							<tr>
								<td style="height: 14px">&nbsp;</td>
							</tr>
							<tr>
								<%
                                DateTime dtNow=new DateTime();
                                dtNow = DateTime.Now;
                                %>
								<td style="height: 19px">&nbsp;&nbsp;</td>
							</tr>
						</table>
						</td>
					<td valign="top" style="height: 39px; width: 209px;"><img src="./Image1/topband2.jpg" width="246" style="height: 82px"></td>
					 
					<td background="./Image1/topband3.jpg" valign="top" style="height: 39px; width: 189px;">&nbsp;<br />
                        </td>
				</tr>
				
           </tbody>
          </table>
         </tr>
		</table>
       <br /> 
 
    <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Bill Entry for Communication Expenses - Summary</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table id="Table2" align="center" cellspacing="1" cellpadding="1" width="85%" border="1" class="boxbg" style="text-align: left">

               
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                        <font class="blackfnt"> Bill Entry number</font>
                    </td>
                    <td align="left" style="width: 138px">
                        &nbsp;<strong><span style="font-size: 8pt; color: #ff0000; font-family: Verdana">System
                            Genarated... </span></strong>
                    </td>
                    <td class="field1" style="width: 148px">
                         <font class="blackfnt">Bill Entry date</font>
                    </td>
                    <td align="left" style="width: 214px">
                        <asp:TextBox ID="txtbill_entry_date" runat="server"></asp:TextBox><%-- <SControls:DateSelector ID="dtCal" runat="server" Visible="true" Text="End Date:"
                            style="border-top-style: groove; border-right-style: groove; border-left-style: groove;
                            border-bottom-style: groove"></SControls:DateSelector>--%><%--<asp:TextBox ID="dtp_bill" runat="server" Width="105px"></asp:TextBox>
                        <script runat="server">
                            dtp_bill.text= now
                        </script>--%></td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                         <font class="blackfnt">Vendor</font>
                    </td>
                    <td align="left" style="width: 138px">
                        <asp:DropDownList ID="cboVendor" runat="server" Width="100px">
                        </asp:DropDownList> 
                        <asp:Label ID="lblvendor" runat="server"></asp:Label>
                   
                    </td>
                    
                    
                    <td class="field1" style="width: 148px">
                         <font class="blackfnt">Other Charges(+)</font>
                    </td>
                    <td align="left" style="width: 214px">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txtOtherCharges" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label3" runat="server" Width="105px">0</asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px; height: 23px">
                         <font class="blackfnt">Total amount</font>
                    </td>
                    <td align="left" style="height: 23px; width: 138px;">
                        <asp:UpdatePanel ID="update_amount" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttot_amount" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label3" runat="server" Width="105px">0</asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                    <td class="field1" style="width: 148px; height: 23px">
                         <font class="blackfnt">Deductions (-)</font>
                    </td>
                    <td align="left" style="height: 23px">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txtDeduction" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label3" runat="server" Width="105px">0</asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                         <font class="blackfnt">Total Service Tax</font>
                    </td>
                    <td align="left" style="width: 138px">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttot_service_tax" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label4" runat="server" Width="105px">0 </asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        
                    </td>
                    
                    <td class="field1" style="width: 148px">
                        <font class="blackfnt">TDS Rate</font>
                    </td>
                    <td >
                         <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttds_rate"  runat="server" Width="105px">0</asp:TextBox>
                            <label id="Label1" runat="Server" ><font class="blackfnt">%</font></label>
                            </ContentTemplate>

                        </asp:UpdatePanel>
                        
                    </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                    <font class="blackfnt">Total Cess</font>
                       
                    </td>
                    <td align="left" style="width: 138px">
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttot_cess" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label5" runat="server" Width="105px">0</asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txttds_rate" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                        
                    </td>
                    <td style="width: 148px"><font class="blackfnt">TDS (-)</font></td>
                    <td>
                    <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttds" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label6" runat="server" Width="105px">0</asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 186px">
                        <font class="blackfnt">Total</font>
                    </td>
                    <td align="left" style="width: 138px">
                        <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <ContentTemplate>
                            <asp:TextBox ID="txttotal" runat="Server" Text="0" ReadOnly="True"></asp:TextBox>
                            <%--<asp:Label ID="label7" runat="server" Width="105px">0 </asp:Label>--%>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                        
                    </td>
                    <td style="width: 148px">
                        <font class="blackfnt">Net Payable</font>
                   </td>
                   <td>
                     <asp:UpdatePanel ID="update_net_pay" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtnet_amount" runat="server" ReadOnly="True">0</asp:TextBox></td>
                        </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                </tr>
          </table><br />
        <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Bill Details</strong></font></td>
            </tr>
        </table>
        <br />
        
        <table class="bgbluegrey" style="width: 964px">
                <tr>
                    <td style="width: 134px">
                        <font class="blackfnt">Device No</font>
                    </td>
                    <td style="width: 128px">
                        <font class="blackfnt">Bill  No</font>
                    </td>
                    <td style="width: 106px">
                        <font class="blackfnt">Billing Period</font>
                    </td>
                    <td style="width: 111px">
                        <font class="blackfnt">Bill Date</font>
                    </td>
                    <td style="width: 97px">
                        <font class="blackfnt">Due Date</font>
                    </td>
                    <td style="width: 96px">
                        <font class="blackfnt">Amount</font>
                    </td>
                    <td style="width: 120px">
                        <font class="blackfnt">Service Tax</font>
                    </td>
                    <td>
                        <font class="blackfnt">Cess</font>
                    </td>
                    <td>
                        <font class="blackfnt">Total</font>
                    </td>
                </tr>
            </table>
        
        <asp:UpdatePanel ID="update_txtamount" runat="Server">
            <ContentTemplate>
             <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddldevice_no" runat="server" Width="100px" ></asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox ID="txtbill_no" runat="server" EnableViewState="False"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtbilling_period" runat="server" EnableViewState="False"></asp:TextBox>							                                
                        </td>
                        <td>
                            <asp:TextBox id="txtbill_date" runat="server" Width="90px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox id="txtdue_date" runat="server" Width="90px"></asp:TextBox>
                        </td>
                        <td>                            
                            <asp:TextBox id="txtamount" runat="server" Width="90px">0</asp:TextBox>                                                    
                        </td>
                        <td>
                            <asp:TextBox id="txtservice_tax" runat="server" Width="90px">0</asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox id="txtcess" runat="server" Width="90px">0</asp:TextBox>
                        </td>
                         <td>
                            <asp:TextBox id="txttot_amount1" runat="server" Width="90px" ReadOnly="true" >0</asp:TextBox>
                        </td>
                    </tr>
                </table>
                </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="grid1" EventName="RowCommand" />                            
        </Triggers>
    </asp:UpdatePanel>
    <div align="center">
    <asp:UpdatePanel ID="update_add" runat="server">
        <ContentTemplate>
            <asp:Button ID="cmdAdd" runat="server" Text="Add" OnClick="cmdAdd_Click" />
        </ContentTemplate>
     </asp:UpdatePanel>
     </div>
    
    
    <div align="center">
    <asp:UpdatePanel ID="UpdatePanel8" runat="server"  UpdateMode="Conditional" RenderMode="Inline">               
            <ContentTemplate>		
                <asp:GridView ID="grid1" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" class="bgbluegrey" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AllowPaging="true" PageSize="5" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" CssClass="dgRowStyle" BorderColor="#8ba0e5" OnRowCommand="grid1_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                            Text="X"  >
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                                            Text="Edit"  >
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="cmdAdd" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
 </div>
    </div>
    <br />
        <center>
            <asp:LinkButton ID="fsubmit" runat="Server"  Text="Submit" OnClick="fsubmit_Click">
            </asp:LinkButton>
        </center>
    </form>
</body>
</html>
