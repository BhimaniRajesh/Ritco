<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DisplayMFResult.aspx.cs" Inherits="GUI_Operations_LoadingSheet_DisplayMFResult" %>

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
        <input type="hidden" id="HidMFNo" runat="server" />
        <input type="hidden" id="HidMF" runat="server" />
        <input type="hidden" id="HidTHC" runat="server" />
        <input type="hidden" id="HidLS" runat="server" />
        <input type="hidden" id="HidManMFNo" runat="server" />
        <br />
        <br />
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <label class="blackfnt" id="lblHeader" runat="server">
                        <%--<b>
				            Manifest Generation Result
				        </b>--%>
                    </label>
                    <%--<hr align="center" size="1" color="#8ba0e5">  --%>
                </td>
            </tr>
        </table>
        <br style="font-size: 6px;" />
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <%--<tr class="bgbluegrey">
                <td align="center" colspan="3">
                    <label class="blackfnt">
                        <b>
                            Following document has been successfully generated:
                        </b>
                    </label>
                </td>
            </tr>--%>
            <tr style="background-color: White" class="bgbluegrey">
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
            </tr>
            <tr style="background-color: White">
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblMF" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblMFNo" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblManMFNo" runat="server">
                    </label>
                </td>
                <td align="center" style="width: 25%;">
                    <label class="blackfnt" id="lblVPMF" runat="server">
                    </label>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <label class="blackfnt">
                        <b>Your next step: </b>
                    </label>
                </td>
            </tr>
        </table>
        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="70%">
            <tr style="background-color: White" runat="server" id="trPrepareMF">
                <td align="center" valign="middle" style="width: 32px">
                    <img src="../../../GUI/images/clear.gif" />
                </td>
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblMoreMF" runat="server">
                    </label>
                </td>
            </tr>
            <tr style="background-color: White" runat="server" id="trPrepareTHC">
                <td align="center" valign="middle" style="width: 32px">
                    <img src="../../../GUI/images/clear.gif" />
                </td>
                <td colspan="4" align="left">
                    <label class="blackfnt" id="lblTHC" runat="server">
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
