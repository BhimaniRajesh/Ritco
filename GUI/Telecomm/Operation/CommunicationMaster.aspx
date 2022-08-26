<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CommunicationMaster.aspx.cs" Inherits="_Default" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Communication Master</title>
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
												<td valign="top" align="left" style="width: 29px"><img src="./images/LOGO.gif" border="0"></td>
												<td valign="top" align="left"><img height="19" src="../include/images/blank_top.gif" width="0" border="0"></td>
												
											</tr>
										</table>
									</td>
									<td style="height: 49px; width: 209px;">&nbsp;</td>
									<td align="right" style="height: 49px; width: 189px;">
                                        <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="False" NavigateUrl="~/Home.aspx" style="left: -14px; position: relative; top: 0px">Home</asp:HyperLink>
                                        
                                        <asp:HyperLink ID="HyperLink2" runat="server" Font-Bold="False" style="left: -14px; position: relative; top: 0px">| Help</asp:HyperLink>
                                        
                                        <asp:HyperLink ID="HyperLink7" runat="server" Font-Bold="False" NavigateUrl="" style="left: -14px; position: relative; top: 0px">| Profile |</asp:HyperLink>&nbsp;<asp:HyperLink
                                            ID="HyperLink3" runat="server" Font-Bold="False" NavigateUrl="~/Home.aspx"
                                            Style="left: -14px; position: relative; top: 0px">Logout</asp:HyperLink></td>
						</tr>
				<tr>
					<td valign="top" width="343" background="./Image1/topband1.jpg" style="height: 39px">
						<table cellspacing="0" cellpadding="0" width="100%" border="0" >
							<tr>
								<td><img height="7" src="../include/images/clear.gif" width="10"></td>
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
           </td>
         </tr>
		</table>
          
          
         
       </div>
      

    <script type="text/xml-script">
        <page xmlns:script="http://schemas.microsoft.com/xml-script/2005">
            <references>
            </references>
            <components>
            </components>
        </page>
    </script>
    <br />
        <table align="center" border="1" cellpadding="0" cellspacing="0" style="width: 764px">
            <tr >
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Communication Master</strong></font></td>
            </tr>
        </table>
    <br />
        
        
        <table align="center" bgcolor="#000000" border="0" cellpadding="4" cellspacing="1" class="boxbg" style="font-size: 12pt; font-family: Times New Roman; left: 0px; width: 80%; position: relative; top: 0px; height: 48px;">
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Phone No.</font>
                </td>
                <td align="left"  colspan="3" width="90%">
                <asp:TextBox ID="txtPhoneNo" runat="server" Width="88px"></asp:TextBox>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Phone Type</font>
                </td>
                <td align="left"  colspan="3" width="90%">
                <asp:DropDownList ID="cboPhoneType" runat="server" Width="88px">
                <asp:ListItem Text="----Select----"></asp:ListItem>
                <asp:ListItem Value="1" Text="Mobile"></asp:ListItem>
                <asp:ListItem Value="2" Text="LandLine"></asp:ListItem>
                <asp:ListItem Value="3" Text="FWT"></asp:ListItem>
                <asp:ListItem Value="4" Text="Internet-Dialup"></asp:ListItem>
                <asp:ListItem Value="5" Text="Internet-DSL"></asp:ListItem>
                <asp:ListItem Value="6" Text="Internet-RF"></asp:ListItem>
                                
                </asp:DropDownList>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Vendor</font>
                </td>
                <td align="left"  colspan="3" width="90%">
                <asp:DropDownList ID="cboVendor" runat="server" Width="100px">
                <asp:ListItem Value="" Text="----Select----"></asp:ListItem>
                </asp:DropDownList> 
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Employee</font>
                </td>
                <td align="left" colspan="3" width="90%">
                <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" runat="server">
                <ContentTemplate> 
                <asp:DropDownList ID="cboEmployee" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="cboEmployee_SelectedIndexChanged">
                <asp:ListItem Value="" Text="----Select----"></asp:ListItem>
                </asp:DropDownList>
                </ContentTemplate> 
                 </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td  style="height: 25px; width: 31%;">
                <font class="blackfnt">Location</font>
                </td>
                <td align="left"  colspan="3" width="90%">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                <ContentTemplate>
                <asp:TextBox ID="txtLocation" runat="server" Width="88px"></asp:TextBox>
                </ContentTemplate>
                        <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboEmployee" EventName="cboEmployee_SelectedIndexChanged" />
                         </Triggers>
                </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" colspan="5" width="90%" style="height: 27px">
                <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClick="cmdSubmit_Click" />
                </td>
            </tr>
            
        </table>
        </form>
</body>
</html>
