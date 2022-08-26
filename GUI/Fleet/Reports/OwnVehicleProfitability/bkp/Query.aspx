<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Trip_Profitablility_Report_Query" %>

<%@ Register Src="~/GUI/Common_UserControls/RPT_Date.ascx" TagName="RPT_Date" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	
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
    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Finance </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Own Vehicle Profitablity Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                            </td>
                        </tr>                        
                        <tr style="background-color: white">
                            <td align="left" valign="top">                                
                                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Select Date :" Width="102px"></asp:Label>                               
                            </td>
                            <td valign="top">
                                <uc1:RPT_Date ID="dtFromTo" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Profitability Status :"></asp:Label>                               
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlProfStatus" runat="server">
                                    <asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Profitable" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Loss Making" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="Margin Range :"></asp:Label>  
                            </td>
                            <td align="left">
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="From "></asp:Label>  
                                        </td>
                                        <td><%--onkeypress="Javascript:return validFlot(event,this.getAttribute('id')); "--%>
                                            <asp:TextBox ID="txtMRFrom" runat="server" Columns="3" ></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                        <td style="width:10px;"></td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="To " ></asp:Label>  
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMRTo" runat="server" Columns="3" ></asp:TextBox><label class="blackfnt">%</label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                            </td>
                        </tr>
                        <tr class="blackfnt" bgcolor="white">
                            <td colspan="2" align="center"><b>OR</b></td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="Select Document :"></asp:Label>                               
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlVHModel" runat="server">                                    
                                    <asp:ListItem Text="ALL" Value="0"></asp:ListItem>                                    
                                </asp:DropDownList>
                            </td>
                        </tr>                        
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:Button ID="btnShow2"  runat="server" Text="Show" Width="75px" OnClick="btnShow2_Click" />
                            </td>
                        </tr>
                    </table>
                </div>               
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

