<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_Operations_FM_FM_report_query" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	        cal.setCssPrefix("TEST");
	        cal.showNavigationDropdowns();
	
	    function Chk(obj)
	    {
            var txtcustcd=document.getElementById("ctl00_MyCPH1_txtcustcd");
	        if (document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true )
	        {
		        txtcustcd.disabled=true        		
	        }
	        else 
	        {
		        txtcustcd.disabled=false
	        }
	    }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>   
    <div align="left">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>View & Print</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="1" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" valign="top" width="104">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center" colspan="2">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Text="OR" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td width="100">
                                <asp:Label ID="lblFMNo" CssClass="blackfnt" runat="server" Text="Enter FM No"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtFMNo" runat="server"></asp:TextBox>
                                <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Text="(Enter No. Seprated by comma)"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return DateCheck();"
                                    runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
