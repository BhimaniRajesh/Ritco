<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FMMain.aspx.cs" Inherits="GUI_Operations_FM_FMMain" Title="FM Main Menu" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        
        function disableenter()
        {
        
        }
        
    </script>
    
    <div>
        
        <table style="width: 9.0in" border="0" cellpadding="0" cellspacing="0">
		    
		    <tr>
			    <td>
				    <label class="blackfnt">
				        <b>
				            Documents Forwarding Operations
				        </b>
				        <hr align="center" size="1" color="#8ba0e5">
				    </label>    
			    </td>
		    </tr>

		    <tr> 
			    <td> 
				    <table style="width: 9.0in"  border="0" align="center" cellpadding="0" cellspacing="0">
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
							                Documents Forwarding Operations
							            </b>
							        </label>
							    </a>
						    </td>
					    </tr>
    				        
					    <tr> 
						    <td class="horzblue">
						        <img src="../../../GUI/images/clear.gif" width="2" height="1">
						    </td>
					    </tr>
    					
					    <tr> 
						    <td>
						        <img src="../../../GUI/images/clear.gif" width="15" height="10">
						    </td>
					    </tr>

					    <tr> 
						    <td align=right>
							    <a href="javascript:window.history.go(-1)" title="back">
							        <img src="../../../GUI/images/back.gif" border=0>
							    </a>
						    </td>
					    </tr>--%>

					    <tr> 
						    <td>
							    <table style="width: 9.0in"  border="0" cellspacing="0" cellpadding="0">
								    <tr>
									    <td style="width: 39%" valign="top">
										    <table width="100%" border="0" cellspacing="0" cellpadding="0">
										        <tr>
											        <td style="height: 300" valign="top">
												        <table border="0" cellspacing="2" cellpadding="3" width="100%">
													        <tr style="background-color: White">
														        <td style="width: 50%" valign="top">
															        <table border="0" cellspacing="0" cellpadding="2" width="100%">
																        <tr class="bgbluegrey">
																	        <td align="center">
																		        <label class="blackfnt">
																		            <b>
																		                Documents Forwarding Module Options
																		            </b>
																		        </label>
																	        </td>
																        </tr>
															        </table>
    															    
															        <table width="100%" border="0" cellpadding="5" cellspacing="1" class="boxbg">
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                        
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
                                                                                <asp:LinkButton ID="lnkScanFMDocuments" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Scan A Document" PostBackUrl="~/GUI/Operations/FM/ScanFMDocuments.aspx" />
                                                                            </td>
                                                                        </tr>
        									  
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkForwardFMDocuments" CssClass="bluefnt" runat="server" Text="Forward Documents" PostBackUrl="~/GUI/Operations/FM/ForwardFMDocumentsMain_new.aspx" />
                                                                            </td>
                                                                        </tr>

                                                               <%--         <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkAcknowledgeFMDocuments" CssClass="bluefnt" runat="server" Text="Acknowledge Documents" PostBackUrl="~/GUI/Operations/FM/AcknowledgeFMDocumentsMain.aspx" />
                                                                            </td>
                                                                        </tr>--%>
                                                                        
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Text="Acknowledge Documents " PostBackUrl="~/GUI/Operations/FM/AcknowledgeFMDocumentsMain_new.aspx" />
                                                                            </td>
                                                                        </tr>

                                                                      <%--  <tr>
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkViewPrintFMNotes" CssClass="bluefnt" runat="server" Text="View & Print Forwarding Notes" PostBackUrl="~/GUI/Operations/FM/ViewPrintFMNotes.aspx" />
                                                                            </td>
                                                                        </tr>
                                                                        
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkTrackFMDocuments" CssClass="bluefnt" runat="server" Text="Track Documents" PostBackUrl="~/GUI/Operations/FM/FMRegisterMain.aspx" />
                                                                            </td>
                                                                        </tr>--%>
                                                                        <tr>
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkViewPrintFMNotes" CssClass="bluefnt" runat="server" Text="View & Print Forwarding Notes" PostBackUrl="~/GUI/Operations/FM/FM_Report/Query.aspx" />
                                                                            </td>
                                                                        </tr>
                                                                        
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="lnkTrackFMDocuments" CssClass="bluefnt" runat="server" Text="Track Documents" PostBackUrl="~/GUI/Operations/FM/Track_POD.aspx" />
                                                                            </td>
                                                                        </tr>
                                                                         <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Text="Documents Yet To Scan" PostBackUrl="~/GUI/Operations/FM/PendingScanReport/Query.aspx" />
                                                                            </td>
                                                                        </tr>
                                                                        <tr> 
                                                                            <td align="center" valign="middle" bgcolor="white">
                                                                                <font class="bluefnt" size="25">
                                                                                    <b>
                                                                                        <img src="../../images/bullet-2.gif" alt="."/>
                                                                                    </b>
                                                                                </font>                                                                                
                                                                            </td>
                                                                            
                                                                            <td style="width: 98%; background-color: #FFFFFF;">
	                                                                            <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Text="Documents Scaned" PostBackUrl="~/GUI/Operations/FM/Scan_Report/Query.aspx" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
														        </td>

														        <td valign="top">
														            &nbsp;
														        </td>
													        </tr>
    													
													        <tr style="background-color: White">
														        <td colspan="2">
														            <label class="blackfnt">
														                &nbsp;
														            </label>
														        </td>
														    </tr>	
												         </table>
											        </td>
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
					    </tr>
			        </table>
	            </td>
	        </tr>
	    </table>
	
	</div>
    
</asp:Content>

