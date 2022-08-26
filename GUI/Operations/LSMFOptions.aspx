<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="LSMFOptions.aspx.cs" Inherits="GUI_Operations_LSMFOptions" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        function disableenter()
        {
        
        }
    </script>
    
    <input type="hidden" id="HidDocket" runat="server" />
    <input type="hidden" id="HidLS" runat="server" />
    <input type="hidden" id="HidMF" runat="server" />
    <input type="hidden" id="HidTHC" runat="server" />
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
		
		<tr>
		    <td>
			    <label class="blackfnt" id="lblHeader" runat="server">
			        <%--<b>
			            Loading Sheet & Manifest Operations
			        </b>--%>
			    </label>    
			    <hr align="center" size="1" color="#8ba0e5">
		    </td>
	    </tr>
	</table>
        
		<%--<tr> 
			<td> 
				<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">--%>
					<%--<tr> 
						<td style="height: 30">
							<a href="#">
							    <label class="blklnkund">
							        <b>--%>
							            <%--<%=session("Level_Type")%>--%> <%--Module
							        </b>
							    </label>
							</a>
							
							<b> &gt; </b>
							
							<a href="#">
							    <label class="blklnkund">
							        <b>
							            Operations
							        </b>
							    </label>
							</a>
							
							<b> &gt; </b>
							
							<a href="#">
							    <label class="blklnkund">
							        <b>
							            Booking Operations
							        </b>
							    </label>
							</a>
							
							<b> &gt; </b>
							
							<label class=bluefnt>
							    <b>
							        
							    </b>
							</label>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue">
						    <img src="../../GUI/images/clear.gif" width="2" height="1">
						</td>
					</tr>
					
					<tr> 
						<td>
						    <img src="../../GUI/images/clear.gif" width="15" height="10">
						</td>
					</tr>

					<tr> 
						<td align=right>
							<a href="javascript:window.history.go(-1)" title="back">
							    <img src="../../GUI/images/back.gif" border=0>
							</a>
						</td>
					</tr>--%>

					<%--<tr> 
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td style="width: 39%" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
										    <tr>
											    <td style="height: 300" valign="top">
												    <table border="0" cellspacing="1" cellpadding="1" width="100%">
													    <tr style="background-color: White">
														    <td style="width: 50%" valign="top">--%>
															    <table border="0" cellspacing="0" cellpadding="2" width="50%">
																    <tr class="bgbluegrey">
																	    <td align="center">
																		    <label class="blackfnt" id="lblTitle" runat="server">
																		        <%--<b>
																		            LS & MF Process
																		        </b>--%>
																		    </label>
																	    </td>
																    </tr>
															    </table>
															    
															    <table width="50%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                                                                    <tr style="background: #FFFFFF">
                                                                        <td align="center" valign="middle" style="width: 32px">
                                                                            <font class="bluefnt" size="25">
                                                                                <b>
                                                                                    .
                                                                                </b>
                                                                            </font>
                                                                        </td>
                                                                        
                                                                        <td align="left" colspan="5">
                                                                            <asp:LinkButton ID="lnkNewLS" CssClass="bluefnt" runat="server" Font-Bold="false" Font-Underline="false" PostBackUrl="~/GUI/Operations/LoadingSheet/LSMain.aspx" />
                                                                        </td>
                                                                    </tr>
    									  
                                                                    <tr style="background: #FFFFFF"> 
                                                                        <td align="center" valign="middle" style="width: 32px">
                                                                            <font class="bluefnt" size="25">
                                                                                <b>
                                                                                    .
                                                                                </b>
                                                                            </font>
                                                                        </td>
                                                                        
                                                                        <td>
	                                                                        <asp:LinkButton ID="lnkUpLSPrepMF" CssClass="bluefnt" runat="server" PostBackUrl="~/GUI/Operations/LoadingSheet/ListLoadingSheet.aspx" />
                                                                        </td>
                                                                    </tr>

                                                                    <tr style="background: #FFFFFF"> 
                                                                        <td align="center" valign="middle" style="width: 32px">
                                                                            <font class="bluefnt" size="25">
                                                                                <b>
                                                                                    .
                                                                                </b>
                                                                            </font>
                                                                        </td>
                                                                        
                                                                        <td>
	                                                                        <asp:LinkButton ID="lnkNewMF" CssClass="bluefnt" runat="server" PostBackUrl="~/GUI/Operations/ManiFest/MFMain.aspx" />
                                                                        </td>
                                                                    </tr>

                                                                    <tr style="background: #FFFFFF">
                                                                        <td align="center" valign="middle" style="width: 32px">
                                                                            <font class="bluefnt" size="25">
                                                                                <b>
                                                                                    .
                                                                                </b>
                                                                            </font>
                                                                        </td>
                                                                        
                                                                        <td>
	                                                                        <asp:LinkButton ID="lnkUpdatePackagesWeightInMF" CssClass="bluefnt" runat="server" PostBackUrl="~/GUI/Operations/Manifest/SearchMFToUpdatePackagesWeight.aspx" />
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background: #FFFFFF"> 
                                                                        <td align="center" valign="middle" style="width: 32px">
                                                                            <font class="bluefnt" size="25">
                                                                                <b>
                                                                                    .
                                                                                </b>
                                                                            </font>
                                                                        </td>
                                                                        
                                                                        <td>
	                                                                        <asp:LinkButton ID="lnkViewPrintMF" CssClass="bluefnt" runat="server" PostBackUrl="~/GUI/Operations/Manifest/SearchMFToViewPrint.aspx" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
														    <%--</td>

														    <td valign="top">
														        &nbsp;
														    </td>
													    </tr>--%>
													
													    <%--<tr style="background-color: White">
														    <td colspan="2">
														        <label class="blackfnt">
														            &nbsp;
														        </label>
														    </td>
														</tr>	
												     </table>--%>
					<%--						    </td>
										    </tr>
										    
										    <tr>
											    <td>
											        &nbsp;
											    </td>
										    </tr>
									    </table>
									</td>
								</tr>
							</table>
						</td>
					</tr>--%>
			    <%--</table>
	        </td>
	    </tr>--%>
	<%--</table>--%>
    
</asp:Content>
