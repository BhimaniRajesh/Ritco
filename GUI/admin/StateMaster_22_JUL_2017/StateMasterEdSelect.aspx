<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StateMasterEdSelect.aspx.cs" Inherits="GUI_admin_StateMaster_StateMasterEdSelect" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
    function chkVal()
    {
        if(document.getElementById("ctl00_MyCPH1_ddState"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddState").value == "-1")
                    {
                        alert("Select State");
                        document.getElementById("ctl00_MyCPH1_ddState").focus();
                        return false;
                    }
                }
    }

</script> 
<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr> 
			<td>&nbsp;</td>
		</tr>

		<tr> 
			<td> 
				<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr> 
						<td height="30">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>State Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
					</tr>

					<tr> 
						<td align="right">
							<a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>

					<tr> 
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="39%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr> 
											<td height="300" valign="top">
											<!--START-->
												<br />
												<center>
                                                    <table border="0" class="boxbg" cellspacing="1" cellpadding="2" width="70%">
                                                        <tr class="bgbluegrey">
                                                        <td align="center" colspan="2">
                                                        <font class="blackfnt"><b>Query State Master for Edit</b></font>
                                                        </td>
                                                        </tr>


                                                        <tr bgcolor="#FFFFFF">
                                                        <td align="left" width="30%">
                                                        <font class="blackfnt">Select State:</font>
                                                        </td>

                                                        <td align="left">
                                                            <asp:DropDownList ID="ddState" runat="server">
                                                            </asp:DropDownList></td>
                                                        </tr>

                                                        <tr bgcolor="#FFFFFF">
                                                        <td align="center" colspan="2" style="height: 28px">
                                                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return chkVal()" OnClick="btnSubmit_Click" /></td>
                                                        </tr>
                                                    </table>
												
												</center>
												
											<!--END-->
											</td>
										</tr>

										<tr> 
											<td>&nbsp;</td>
										</tr>
										
										<tr>
											<td></td>
										</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
	</td>
	</tr>
	</table>		

</asp:Content>

