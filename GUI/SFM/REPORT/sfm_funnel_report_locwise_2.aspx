<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="sfm_funnel_report_locwise_2.aspx.cs" Inherits="REPORT_sfm_funnel_report_locwise_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-Location Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        
<div align="center">
				<table border="0" cellpadding="3" colspan="2" width="55%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
					<tr bgcolor="#ffffff">
						<td  align="left" width="45%">
							<font class="blackfnt"><b>Location</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblLocation" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>

					<tr bgcolor="#ffffff">
						<td  align="left" width="30%" style="height: 25px">
							<font class="blackfnt"><b>Prospect Type</b></font>
						</td>
						<td  align="left" style="height: 25px">
							<font class="blackfnt">
							<asp:Label ID="lblprospectType" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>

					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Prospects</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblProspect" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>				

					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Value</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lblValue" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>				
					<tr bgcolor="#ffffff">
						<td  align="left" width="42%">
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
							<asp:Label ID="lbldate" runat="server" width="100%">
							</asp:Label>
							</font>
						</td>
					</tr>
					</table>
					
					<br />
					<table border="0"  cellpadding="3"  colspan="5"  width="100%"  bgcolor="#FFFFFF" cellspacing="1" class="boxbg">
					<tr class="bgbluegrey">
						<td align="center">
							<font class="blackfnt"><b>Prospect</b></font>
						</td>

						<td align="center">
							<font class="blackfnt"><b>Calls made</b></font>
						</td>

						

						<td align="center">
							<font class="blackfnt"><b>Order Value</b></font>
						</td>
						
						
						<td align="center">
							<font class="blackfnt"><b>Sales person</b></font>
						</td>
						
					</tr>

					
					<tr bgcolor="#FFFFFF">
						<td >
							
						</td>



						<td align="center">
							<font class="blackfnt"></font>
						</td>

						

						<td align="center">
							<font class="blackfnt"></font>
						</td>
						
						
						<td align="left">
							<font class="blackfnt"></font>
						</td>
						
					</tr>

</table>
</div>
</asp:Content>
