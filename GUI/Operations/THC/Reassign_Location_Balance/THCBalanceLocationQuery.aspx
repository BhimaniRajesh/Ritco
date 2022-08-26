<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCBalanceLocationQuery.aspx.cs" Inherits="GUI_Operations_THC_Reassign_Location_Balance_THCBalanceLocationQuery" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

    </script>

    <div align="left">
        <asp:UpdatePanel ID="up1" runat="server"  UpdateMode="Always">
            <ContentTemplate>
                <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="30">
                            <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                                class="blklnkund"><strong>Exception </strong></font><font class="bluefnt"><strong><font
                                    class="blklnkund"><strong>Reassign Balance Payable At</strong></font>
                        </td>
                    </tr>
                    
                    <tr>
                        <td align="right">
                            <div align="center">
                            <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                               
                                    <ProgressTemplate>
                                        <div id="progressArea">
                                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <font class="blackfnt"><b>Select THC Criteria</b></font>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" colspan="4">
                                        <Location:LH ID="Fromlc" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="blackfnt">Select THC Date</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <Date:DT ID="DT" runat="server" />
                                    </td>
                                </tr>
                                <tr align="center" bgcolor="white">
                                    <td align="left">
                                        <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter THC No. " runat="server"></asp:Label>
                                    </td>
                                    <td colspan="3" align="left">
                                        <asp:TextBox ID="txtDocno" Enabled="true" runat="server" Width="234"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr align="center" bgcolor="white">
                                    <td colspan="4">
                                        <asp:Button ID="btnShow"
                                            runat="server" Text="Show" Width="75px" onclick="btnShow_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
