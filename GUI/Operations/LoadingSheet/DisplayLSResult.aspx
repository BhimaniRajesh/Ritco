<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DisplayLSResult.aspx.cs" Inherits="GUI_Operations_LoadingSheet_DisplayLSResult" %>

<%@ OutputCache Location="None" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

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
        <input type="hidden" id="HidLSNo" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        <input type="hidden" id="HidManLSNo" runat="server" />
        <input type="hidden" id="HidTHC" runat="server" />
        <br />
        <br />
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <label class="blackfnt" id="lblHeader" runat="server">
                        <%--<b>
				            Loading Sheet Generation Result				            
				        </b>--%>
                    </label>
                    <%--<hr align="center" size="1" color="#8ba0e5">--%>
                </td>
            </tr>
        </table>
        <br style="font-size: 6px;" />
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <tr style="background-color: White" class="bgbluegrey">
                <td align="center" style="width: 128px;">
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
            </tr>
            <tr style="background-color: White">
                <td align="center" style="width: 128px;">
                    <label class="blackfnt" id="lblLS" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblLSNo" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblManualLSNo" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblVPLS" runat="server">
                    </label>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td colspan="4" align="left" >
                    <label class="blackfnt">
                        Your next step:
                    </label>
                </td>
            </tr>
        </table>
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <tr style="background-color: White" runat="server" id="trPrepareMoreLS">
                <td align="center" valign="middle" style="width: 32px" class="bullet">
                    <img src="../../../GUI/images/clear.gif" />
                </td>
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblMoreLS" runat="server">
                    </label>
                </td>
            </tr>
            <tr style="background-color: White" runat="server" id="tr1">
                <td align="center" valign="middle" style="width: 32px" class="bullet">
                    <img src="../../../GUI/images/clear.gif" />
                </td>
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblPrepMF" runat="server">
                    </label>
                </td>
            </tr>
            <tr style="background-color: White" runat="server" id="tr2">
                <td align="center" valign="middle" style="width: 32px" class="bullet">
                    <img src="../../../GUI/images/clear.gif" />
                </td>
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblPrepTHC" runat="server">
                    </label>
                </td>
            </tr>
            <%--<tr style="background-color: White" runat="server" id="trViewPrintLS">
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblLSMFOptions" runat="server">
                    </label>
                </td>
            </tr>--%>
        </table>
    </div>
</asp:Content>
