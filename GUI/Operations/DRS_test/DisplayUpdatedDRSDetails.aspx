<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DisplayUpdatedDRSDetails.aspx.cs" Inherits="GUI_Operations_DRS_DisplayUpdatedDRSDetails" %>
<%@ OutputCache Location="none" %>

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
        
        <input type="hidden" id="HidDRS" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        <input type="hidden" id="HidDocket" runat="server" />
        <input type="hidden" id="HidTHC" runat="server" />
        
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
            <tr style="background-color: White" runat="server" id="trUpdateDRSErrorMsg" visible="false">
                <td colspan="3" align="left">
                    <label runat="server" class="blackfnt" style="color: Red;" id="lblUpdateDRSErrorMsg">
                    </label>
                </td>
            </tr>
            
            <tr class="bgbluegrey">
                <td align="center" style="width: 37%;">
                    <label class="blackfnt">
                        Document Name
                    </label>
                </td>
                
                <td align="center" style="width: 29%;">
                    <label class="blackfnt">
                        System Number
                    </label>
                </td>
                
                <td align="center" style="width: 34%;">
                    <label class="blackfnt">
                        View & Print
                    </label>
                </td>
            </tr>
            
            <tr style="background-color: White">
                <td align="center" style="width: 37%;">
                    <label class="blackfnt" id="lblDRSCaption" runat="server">
                    </label>
                </td>
                
                <td align="center" style="width: 29%;">
                    <label class="blackfnt">
                        <%=strDRSCode %>
                    </label>
                </td>
                
                <td align="center" style="width: 34%;">
                    <label class="blackfnt" id="lblVP" runat="server">
                    </label>
                </td>
            </tr>
            
            <tr class="bgbluegrey">
                <td colspan="3" align="left">
                    <label class="blackfnt">
                        Your next step
                    </label>    
                </td>
            </tr>
        </table>
           
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">  
            <tr style="background-color: White">
                <td align="center" valign="middle" style="width: 32px">
                    <font class="bluefnt" size="25">
                        <b>
                            .
                        </b>
                    </font>
                </td>
                <td align="left">
                    <label class="blackfnt" id="lblMoreDRS" runat="server">
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
                <td align="left">
                    <label class="blackfnt" id="lblUpdateDRS" runat="server">
                    </label>
                </td>
            </tr>                                                                
        </table>
	</div>
    
</asp:Content>

