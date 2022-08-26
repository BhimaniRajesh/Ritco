<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DisplayIncomingTHCResult.aspx.cs" Inherits="GUI_Operations_LoadingSheet_DisplayIncomingTHCResult" %>
<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="javascript" type="text/javascript">
        
        function disableenter()
        {
        
        }
        
        function OpenInWindow(windURL, h, w, l, t)
        {
		    var winOpts = "scrollbars=yes,resizable=yes,width="+w+",height="+h+"";
		    
		    window.open(windURL, "", winOpts);
	    }
        
    </script>
    
    <div>
    
        <input type="hidden" id="HidTHCNo" runat="server" />
        <input type="hidden" id="HidDocket" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        <input type="hidden" id="HidTHC" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidManTHCNo" runat="server" />
        
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
			    <td>
				    <label class="blackfnt" id="lblHeader" runat="server">
				    </label>
			    </td>
		    </tr>
        </table>
        
        <br style="font-size: 6px;" />
        
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <%--<tr class="bgbluegrey">
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        Document Name
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        System Number
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        Manual Number
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt">
                        View & Print
                    </label>
                </td>
            </tr>--%>
            
            <%--<tr style="background-color: White">
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblTHC" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblTHCNo" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblManTHCNo" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 25%;">
                    &nbsp;
                </td>
            </tr>--%>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <label class="blackfnt">
                        Your next step
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td colspan="4">
                    <table border="0" class="boxbg" cellspacing="1" cellpadding="0" width="100%">
                        <tr style="background-color: White">
                            <td align="center" valign="middle" style="width: 32px">
                                <font class="bluefnt" size="25">
                                    <b>
                                        .
                                    </b>
                                </font>
                            </td>
                            
                            <td>            
                                <label class="blackfnt" id="lblUpdateTHC" runat="server">
                                </label>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White">
                            <td align="center" valign="middle" style="width: 32px">
                                <font class="bluefnt" size="25">
                                    <b>
                                        .
                                    </b>
                                </font>
                            </td>
                            
                            <td>
                                <label class="blackfnt" id="lblUpdateDocketStatus" runat="server">
                                </label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
    </div>
    
</asp:Content>

