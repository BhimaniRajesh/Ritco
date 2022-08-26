<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ListLoadingSheet.aspx.cs" Inherits="GUI_Operations_LoadingSheet_ListLoadingSheet" EnableEventValidation="false" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        
        function OpenInWindow(windURL, h, w, l, t)
        {
		    var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
		    
		    window.open(windURL, "", winOpts);
	    }
	    
        function disableenter()
        {
        
        }
        
    </script>
    
    <div>
        
        <input type="hidden" id="HidDocket" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    
		    <tr>
			    <td>
				    <label class="blackfnt" id="lblHeader" runat="server">
				        <%--<b>
				            Update Loading Sheet & Prepare Menifest			            
				        </b>--%>
				    </label>
				    <hr align="center" size="1" color="#8ba0e5">    
			    </td>
		    </tr>
		    
		    <tr> 
			    <td>
				    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
					    <%--<tr>
						    <td style="height: 30">
							    <a href="../../../GUI/Operations/LSMFOptions.aspx">
							        <label class="blklnkund">
							            <b>--%>
							                <%--<%=session("Level_Type")%>--%><%-- Module
							            </b>
							        </label>
							    </a>
							    
							    <b>
							        &gt;
							    </b>
							    
							    <a href="../../../GUI/Operations/LSMFOptions.aspx">
							        <label class="blklnkund">
							            <b>
							                Operations
							            </b>
							        </label>
							    </a>
							    
							    <b>
							        &gt;
							    </b>
							    
								<asp:LinkButton ID="lnkBookOper" CssClass="blklnkund" runat="server" Text="Booking Operations" Font-Bold="true" PostBackUrl="../../../GUI/Operations/LSMFOptions.aspx" />
								<b> &gt; </b>
								<asp:LinkButton ID="lnkLSMF" CssClass="blklnkund" runat="server" Text="Loading Sheet & Manifest" Font-Bold="true" PostBackUrl="../../../GUI/Operations/LSMFOptions.aspx" />
								<b> &gt; </b>
							
							    <label class="bluefnt">
							        <b>
							            Update Loading Sheet & Prepare Menifest
							        </b>
							    </label>
						    </td>
					    </tr>
				        
					    <tr> 
						    <td align="right">
							    <a href="javascript:window.history.go(-1)" title="back">
							        <img src="../../../GUI/images/back.gif" border="0" />
							    </a>
						    </td>
					    </tr>--%>
					    
					    <tr>
					        <%--List of Loading Sheet--%>
					        <td>
					            <table border="0" cellspacing="1" cellpadding="1" width="100%" class="boxbg">
					                <tr class="bgbluegrey">
					                    <td align="center">
                                            <label class="blackfnt">
                                                <b>
                                                    Sr. No.
                                                </b>
                                            </label>
                                        </td>
					                    
                                        <td align="left">
                                            <label class="blackfnt" id="lblLSNo" runat="server">
                                                <%--<b>
                                                    Loading Sheet No.
                                                </b>--%>
                                            </label>
                                        </td>
                                        
                                        <td align="left">
                                            <label class="blackfnt" id="lblManualLSNo" runat="server">
                                                <%--<b>
                                                    Manual Loading Sheet No.
                                                </b>--%>
                                            </label> 
                                        </td>
                                        
                                        <td align="left">
                                            <label class="blackfnt" id="lblLSDate" runat="server">
                                                <%--<b>
                                                    Loading Sheet Date
                                                </b>--%>
                                            </label> 
                                        </td>
                                        
                                        <td align="left">
                                            <label class="blackfnt">
                                                <b>
                                                    Location Code
                                                </b>
                                            </label> 
                                        </td>
      
                                        <td align="left">
                                            <label class="blackfnt">
                                                <b>
                                                    Route Code
                                                </b>
                                            </label> 
                                        </td>
                                        
                                        <td align="right">
                                            <label class="blackfnt" id="lblTotDockets" runat="server">
                                                <%--<b>
                                                    Total <%=Session["DocketCalledAs"].ToString() %>s
                                                    &nbsp;
                                                </b>--%>
                                            </label>
                                        </td>
                                        
                                        <td align="right">
                                            <label class="blackfnt">
                                                <b>
                                                    Packages
                                                    &nbsp;
                                                </b>
                                            </label> 
                                        </td>
                                        
                                        <td align="right">
                                            <label class="blackfnt">
                                                <b>
                                                    Weight
                                                    &nbsp;
                                                </b>
                                            </label> 
                                        </td>
                                        
                                        <td align="center">
                                            <label class="blackfnt">
                                                <b>
                                                    Print
                                                </b>
                                            </label> 
                                        </td>
                                    </tr>
                                    
                                    <asp:UpdatePanel ID="upLSList" runat="server">
                                        <ContentTemplate>
                                            <asp:Repeater ID="rptLoadingSheetList" runat="server">
                                                <ItemTemplate>
                                                    <tr style="background-color: White">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "SrNo")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <asp:LinkButton ID="lnkbtnForLSNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "LSNo")%>' 
                                                                 CssClass="blackfnt" Font-Underline="true" 
                                                                ToolTip='<%#DataBinder.Eval(Container.DataItem, "LSNoLinkToolTip")%>' 
                                                                PostBackUrl='<%#DataBinder.Eval(Container.DataItem, "LSNoPostBackURL")%>' 
                                                                >
	                                                        </asp:LinkButton>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <asp:LinkButton ID="lnkbtnForManualLSNo" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ManualLSNo")%>' 
                                                                 CssClass="blackfnt" Font-Underline="true" 
                                                                ToolTip='<%#DataBinder.Eval(Container.DataItem, "ManualLSNoLinkToolTip")%>' 
                                                                PostBackUrl='<%#DataBinder.Eval(Container.DataItem, "LSNoPostBackURL")%>' >
	                                                        </asp:LinkButton>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "LSDate")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "LocationCode")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="left">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "RouteCode")%>
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="right">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "TotalDockets")%>
                                                                &nbsp;
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="right">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "Packages")%>
                                                                &nbsp;
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="right">
                                                            <label class="blackfnt">
                                                                <%#DataBinder.Eval(Container.DataItem, "Weight")%>
                                                                &nbsp;
                                                            </label>
                                                        </td>
                                                        
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <a href="Javascript:OpenInWindow('../TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=<%#DataBinder.Eval(Container.DataItem, "LSNo")%>',400,600,10,10)">
                                                                    <u>
                                                                        Print
                                                                    </u>
                                                                </a>
                                                            </label>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>        
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    
                                    <tr style="background-color: White" runat="server" id="trErrorMsgForLS" visible="false">
                                        <td colspan="10" align="left">
                                            <label runat="server" class="blackfnt" style="color: Red;" id="lblErrorMsgForLS">
                                            </label>
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

