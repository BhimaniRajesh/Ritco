<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_InTransitStock_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="LHTO" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_to.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    
        function OnSub_DATACHECK()
             {
                if(!DateCheck())
                    return false;
             }
        function SelectRadio()
            {
                if(document.getElementById("ctl00_MyCPH1_RPT_0").checked ==true)
                {
                    document.getElementById('ctl00_MyCPH1_txtdaysfrom').disabled = true;
                    document.getElementById('ctl00_MyCPH1_txtdaysto').disabled = true;
                }
                else if(document.getElementById("ctl00_MyCPH1_RPT_1").checked ==true)
                {
                    document.getElementById('ctl00_MyCPH1_txtdaysfrom').disabled = false;
                    document.getElementById('ctl00_MyCPH1_txtdaysto').disabled = false;
                }
            }
     
    </script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                            class="blklnkund"><strong>Operation </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>InTransit Stock Report</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <%--<div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>--%>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Criteria</b></font>
                            </td>
                        </tr>
                         <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Booking Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>From</b></font>
                            </td>
                            <td align="center" colspan="2">
                                <font class="blackfnt"><b>To</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                            <td align="left" colspan="2">
                                <Location:LHTO ID="Tolc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="4">
                                <table cellspacing="1" align="center">
                                    <tr>
                                        <td>
                                            <asp:RadioButtonList ID="RPT" RepeatDirection="horizontal" OnClick="Javascript:return SelectRadio()"
                                                CssClass="blackfnt" runat="server">
                                                <asp:ListItem Text="Fixed Report" Selected="true" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Number of days in Transit" Value="2"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtdaysfrom" runat="server" Text="0" Enabled="false" Width="50px"></asp:TextBox><asp:TextBox
                                                ID="txtdaysto" runat="server" Text="20" Enabled="false" Width="50px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();"
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
