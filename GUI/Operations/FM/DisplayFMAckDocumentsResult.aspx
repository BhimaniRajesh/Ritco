<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DisplayFMAckDocumentsResult.aspx.cs" Inherits="GUI_Operations_FM_DisplayFMAckDocumentsResult" Title="FM - Acknowledge Forwarded Documents - Result" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
        
    <script language="javascript" type="text/javascript">
        
        function disableenter()
        {
        
        }
        
        function OpenInNewWindow()
        {
            window.open("../../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + "", "_blank")
        }
        function ViewPrint(arg1,arg2,arg3)
{
window.open("../PFM/pfm_print.aspx?strPFMNo=" + arg1 + "," + arg2 + "," + arg3 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
}
    </script>
    
    <div>
        
        <input type="hidden" id="HidFMNo" runat="server" />
        <input type="hidden" id="HidFMID" runat="server" />
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
		    
		    <tr>
			    <td>
				    <label class="blackfnt">
				        <b>
				            Acknowledge Forwarded Document(s)				            
				        </b>
				        <hr align="center" size="1" color="#8ba0e5">
				    </label>    
			    </td>
		    </tr>

		    <tr> 
			    <td> 
				    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
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
							                Document Forwarding Operations
							            </b>
							        </label>
							    </a>
							    
							    <b> &gt; </b>
								
								<label class="bluefnt">
							        <b>
							            Acknowledge Forwarded Document(s)
							        </b>
							    </label>
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
							    <table width="100%" border="0" cellspacing="0" cellpadding="0">
								    <tr>
									    <td style="width: 39%" valign="top">
										    <table width="100%" border="0" cellspacing="0" cellpadding="0">
										        <tr> 
											        <td valign="top">
												        <br />
												        
										                <center>
								                            <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
                                                                <tr class="bgbluegrey">
                                                                    <td align="left" colspan="3">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Following document is generated:
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td align="center" style="width: 37%;">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Document Type
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                    
                                                                    <td align="center" style="width: 29%;">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Document Number
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                    
                                                                    <td align="center" style="width: 34%;">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                View
                                                                            </b>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td align="center" style="width: 37%;">
                                                                        <label class="blackfnt">
                                                                            Forwarding memo
                                                                        </label>
                                                                    </td>
                                                                    
                                                                    <td align="center" style="width: 29%;">
                                                                        <label class="blackfnt">
                                                                            <%=strFMNo %>
                                                                        </label>
                                                                    </td>
                                                                    
                                                                    <td align="center" style="width: 34%;">
                                                                        <%--<label class="blackfnt">
                                                                            <a href="JavaScript:alert('Yet to be implemented!');">
                                                                                <u>
                                                                                    View
                                                                                </u>
                                                                            </a>
                                                                        </label>--%>
                                                                        <a href="Javascript:ViewPrint('<%=strFMNo %>','<%=strFMID %>',0)"><font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=strFMNo %>','<%=strFMID %>',1)"><font class="blklnkund">Print</font></a> 
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td colspan="3" align="left">
                                                                        &nbsp; 
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr class="bgbluegrey">
                                                                    <td colspan="3" align="left">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Your next step:
                                                                            </b>
                                                                        </label>    
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td colspan="3" align="left">
                                                                        <label class="blackfnt">
                                                                            <a href="../../../GUI/Operations/FM/AcknowledgeFMDocumentsMain_new.aspx">
                                                                                <u>
                                                                                    Acknowledge more documents
                                                                                </u>
                                                                            </a>
                                                                        </label>    
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td colspan="3" align="left">
                                                                        <label class="blackfnt">
                                                                            <a href="../../../GUI/Operations/FM/ForwardFMDocumentsMain_new.aspx">
                                                                                <u>
                                                                                    Forward more documents
                                                                                </u>
                                                                            </a>
                                                                        </label>    
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td colspan="3" align="left">
                                                                        <label class="blackfnt">
                                                                            <a href="../../../GUI/Operations/FM/ScanFMDocuments.aspx">
                                                                                <u>
                                                                                    Scan documents
                                                                                </u>
                                                                            </a>
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                
                                                                <tr style="background-color: White">
                                                                    <td colspan="3" align="left">
                                                                        <label class="blackfnt">
                                                                            <a href="../../../GUI/Operations/FM/FMMain.aspx">
                                                                                <u>
                                                                                    Forwarding Module Main Page
                                                                                </u>
                                                                            </a>
                                                                        </label>
                                                                    </td>
                                                                </tr>    
                                                            </table>
										                </center>
											        </td>
										        </tr>

										        <tr>
											        <td>
											            &nbsp;
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

